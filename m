From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] index-pack: always zero-initialize object_entry list
Date: Tue, 19 Mar 2013 17:27:01 +0100
Message-ID: <87ehfb2w4q.fsf@pctrast.inf.ethz.ch>
References: <20130319102422.GB6341@sigill.intra.peff.net>
	<20130319105852.GA15182@sigill.intra.peff.net>
	<8738vr5rqh.fsf@pctrast.inf.ethz.ch>
	<20130319154353.GA10010@sigill.intra.peff.net>
	<20130319155244.GA16532@sigill.intra.peff.net>
	<20130319161722.GA17445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 17:27:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHzNt-0003uy-I7
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 17:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab3CSQ1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 12:27:05 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:43831 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480Ab3CSQ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 12:27:04 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 17:26:57 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.171.78) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 17:27:01 +0100
In-Reply-To: <20130319161722.GA17445@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Mar 2013 12:17:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.171.78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218538>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 19, 2013 at 11:52:44AM -0400, Jeff King wrote:
>
>> > > > Commit 38a4556 (index-pack: start learning to emulate
>> > > > "verify-pack -v", 2011-06-03) added a "delta_depth" counter
>> > > > to each "struct object_entry". Initially, all object entries
>> > > > have their depth set to 0; in resolve_delta, we then set the
>> > > > depth of each delta to "base + 1". Base entries never have
>> > > > their depth touched, and remain at 0.
>> > > 
>> > > This patch causes index-pack to fail on the pack that triggered the
>> > > whole discussion.  More in a minute in another side thread, but
>> > > meanwhile: NAK until we understand what is really going on here.
>> > 
>> > Odd; that's what I was testing with, and it worked fine.
>> 
>> Ah, interesting. I built the fix on top of d1a0ed1, the first commit
>> that shows the problem. And it works fine there. But when it is
>> forward-ported to the current master, it breaks as you saw.
>> 
>> More bisection fun.
>
> So after bisecting, I realize that it is indeed broken on top of
> d1a0ed1. I have no idea why I didn't notice that before; I'm guessing it
> was because I was running it under valgrind and paying attention only to
> valgrind errors.
>
> Anyway, the problem is simple and stupid. The original object array is
> not nr_objects item long; it is (nr_objects + 1) long, though I'm not
> clear why (1-indexing?).

It apparently relates to the use of .idx.offset to compute the "next"
offset, cf. append_obj_to_pack():

	struct object_entry *obj = &objects[nr_objects++];
   ...
	obj[1].idx.offset = obj[0].idx.offset + n;
	obj[1].idx.offset += write_compressed(f, buf, size);

So you trashed the offset of the first object after all the objects that
are actually *in* the patch.

And with that: ACK.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
