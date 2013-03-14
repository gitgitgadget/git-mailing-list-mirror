From: John Keeping <john@keeping.me.uk>
Subject: Re: difftool -d symlinks, under what conditions
Date: Thu, 14 Mar 2013 17:25:15 +0000
Message-ID: <20130314172515.GB4256@serenity.lan>
References: <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org>
 <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
 <7vtxof48sg.fsf@alter.siamese.dyndns.org>
 <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
 <20130314094300.GN2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 18:25:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGBub-0008Pz-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 18:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab3CNRZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 13:25:27 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52364 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab3CNRZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 13:25:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id ADCE66064EC;
	Thu, 14 Mar 2013 17:25:25 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FqTHgEv3jaTs; Thu, 14 Mar 2013 17:25:25 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 10251198021;
	Thu, 14 Mar 2013 17:25:17 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130314094300.GN2317@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218154>

On Thu, Mar 14, 2013 at 09:43:00AM +0000, John Keeping wrote:
> On Wed, Mar 13, 2013 at 09:45:47AM -0700, Junio C Hamano wrote:
> > Does the temporary checkout correctly apply the smudge filter and
> > crlf conversion, by the way?  If not, regardless of the topic in
> > this thread, that may want to be fixed as well.  I didn't check.
> 
> What git-difftool does is to create a temporary index containing only
> the files that have changed (using git-update-index --index-info) and
> then check this out with "git checkout-index --prefix=...".  So I think
> this question boils down to: does git-checkout-index still read
> .gitattributes from the working tree if given --prefix?

Having looked at this a bit more, I think it does mostly do the right
thing, but there is bug in write_entry() that means it won't handle
.gitattributes correctly when using a streaming filter.

The path passed to get_stream_filter is only used to decide what filters
apply to the file, so shouldn't it be using "ce->name" and not "path"
for the same reason that the call to convert_to_working_tree() further
down the same function does?

-- >8 --
diff --git a/entry.c b/entry.c
index 17a6bcc..63c52ed 100644
--- a/entry.c
+++ b/entry.c
@@ -145,7 +145,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	struct stat st;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(path, ce->sha1);
+		struct stream_filter *filter = get_stream_filter(ce->name, ce->sha1);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
