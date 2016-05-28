From: Eric Wong <e@80x24.org>
Subject: Re: [RFC] fast-import: invalidate pack_id references after loosening
Date: Sat, 28 May 2016 00:20:48 +0000
Message-ID: <20160528002048.GA31463@dcvr.yhbt.net>
References: <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
 <20160517121330.GA7346@sigill.intra.peff.net>
 <20160525224907.GA18894@dcvr.yhbt.net>
 <20160525225402.GB18894@dcvr.yhbt.net>
 <20160525230913.GB2634@sigill.intra.peff.net>
 <20160526080236.GA27652@dcvr.yhbt.net>
 <20160526141644.GA15836@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 28 02:20:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6RzV-00023K-9e
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 02:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbcE1AU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 20:20:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58190 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051AbcE1AUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 20:20:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280791FCC6;
	Sat, 28 May 2016 00:20:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160526141644.GA15836@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295799>

Jeff King <peff@peff.net> wrote:
> On Thu, May 26, 2016 at 08:02:36AM +0000, Eric Wong wrote:
> 
> > > That's probably OK in practice, as I think the actual pack-write already
> > > does a linear walk of the object table to generate the pack index. So
> > > presumably nobody checkpoints often enough for it to be a problem. And
> > > the solution would be to keep a separate list of pointers to objects for
> > > the current pack-id, which would trivially fix both this case and the
> > > one in create_index().  So we can punt on it until somebody actually
> > > runs into it, I think.
> > 
> > I might checkpoint that much and run into the problem soon :)
> > Too tired now; maybe in a day or two I'll be able to make sense
> > of C again :x

OK, I guess I was too tired and not thinking clearly.

I now figure it's not worth it to checkpoint frequently and have
a very-long-lived fast-import process.  The object table and
marks set will grow indefinitely, so forking off another gfi
with a new set of marks is better for my case[1], anyways.


Junio: I think my RFC can go into pu as-is and replace
Jeff's object_table discarding patch.


[1] inotify watching a Maildir + fast-import

> In theory the list of objects in the allocation pool are contiguous for
> a particular pack. So you could break out of the double-loop at the
> first non-matching object you see:
> 
> diff --git a/fast-import.c b/fast-import.c
> index 83558dc..f214bd3 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -900,10 +900,13 @@ static const char *create_index(void)
>  	c = idx;
>  	for (o = blocks; o; o = o->next_pool)
>  		for (e = o->next_free; e-- != o->entries;)
>  			if (pack_id == e->pack_id)
>  				*c++ = &e->idx;
> +			else
> +				goto done;
> +done:
>  	last = idx + object_count;
>  	if (c != last)
>  		die("internal consistency error creating the index");
>  
>  	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts, pack_data->sha1);
> 
> But that seems to break some of the tests, so I think there is some case
> which does not match my theory. :)

Yes, it's probably because duplicate objects from the object
store will create entries with e->pack_id == MAX_PACK_ID

> Another strategy is to note that we cross-check against object_count
> here. So you could simply break out of the loop when we have found
> object_count matches.

I'm worried that could fail to detect bugs which should've led
us to die of the internal consistency error.


What we could probably do more safely is limit the scan to only
recent object pools (new ones since the previous create_index call
and the last one scanned).

This passes tests, but I could be missing something:

--- a/fast-import.c
+++ b/fast-import.c
@@ -926,14 +926,16 @@ static const char *create_index(void)
 	struct pack_idx_entry **idx, **c, **last;
 	struct object_entry *e;
 	struct object_entry_pool *o;
+	static struct object_entry_pool *last_seen;
 
 	/* Build the table of object IDs. */
 	ALLOC_ARRAY(idx, object_count);
 	c = idx;
-	for (o = blocks; o; o = o->next_pool)
+	for (o = blocks; o; o = (o == last_seen) ? NULL : o->next_pool)
 		for (e = o->next_free; e-- != o->entries;)
 			if (pack_id == e->pack_id)
 				*c++ = &e->idx;
+	last_seen = blocks;
 	last = idx + object_count;
 	if (c != last)
 		die("internal consistency error creating the index");
