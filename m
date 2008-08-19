From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 23:47:44 -0700
Message-ID: <7vmyj9h567.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181839390.19665@iabervon.org>
 <7vy72tit90.fsf@gitster.siamese.dyndns.org> <48AA4430.3060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <neoeinstein@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 08:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVL1Y-0007uJ-3o
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 08:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbYHSGr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 02:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYHSGr4
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 02:47:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYHSGrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 02:47:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6779C5F165;
	Tue, 19 Aug 2008 02:47:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EE9765F164; Tue, 19 Aug 2008 02:47:47 -0400 (EDT)
In-Reply-To: <48AA4430.3060207@gmail.com> (Marcus Griep's message of "Mon, 18
 Aug 2008 23:55:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF6FE26E-6DBA-11DD-B680-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92815>

Marcus Griep <neoeinstein@gmail.com> writes:

> Junio C Hamano wrote:
>
>> This implements Daniel's idea to indicate what are compared by using
>> prefix different from the traditional a/ and b/ in the textual diff
>> header:
>> 
>>     "git diff" compares the (i)ndex and the (w)ork tree;
>>     "git diff HEAD" compares a (c)ommit and the (w)ork tree;
>>     "git diff --cached" compares a (c)ommit and the (i)ndex;
>>     "git diff HEAD:f /tmp/f" compares an (o)bject and (w)ork tree.
>> 
>> Because these mnemonics now have meanings, they are swapped when reverse
>> diff is in effect.
>
> I like this proposal-ish; making the prefixes more intuitive could be
> useful when looking at a bare diff from git too.  I'd put some time in
> to help implement this.

What I did not bother in the patch is --no-index codepath, but with the
recent refactoring of it to separate it out from the normal "index vs work
tree" codepath, I would expect it to be trivial to use "1/" vs "2/" (or
"old/" and "new/") prefixes for them.  I didn't actually look, though.

I also left "-c" and "--cc" unmodified.  Daniel's "have many patches to
apply, but cannot readily tell in which direction they were generated"
use-case won't involve them, and reverse diff won't make sense with --cc,
so that should be Ok.

And obviously I didn't adjust the test vectors and documentation, which is
needed if somebody is serious enough about actually making this part of
the official system.

But be warned that this has two downsides, one minor, and one rather
major:

 * Using non-standard prefix affects git-patch-id output.  This would not
   affect "git-format-patch --ignore-if-in-upstream", "git-cherry",
   "git-rebase" because they all use internal patch-id generation, but
   third party scripts that feed patches to "git-patch-id" and compare its
   output with precomputed patch-id database to cull duplicates will be
   affected.

 * Similarly, scripts that assume more about "git diff" output than that
   they are meant to be applied with depth 1 may break.

   I think gitweb would be Ok, because I do not think it would try parsing
   a textual diff, stripping out a/ (or b/), to figure out the paths being
   affected.  Even if it did, it would be doing two-tree form (iow, it
   does not use working tree at all) which I deliberately kept to use a/
   vs b/ with my patch, so it should be fine.  I do not offhand recall how
   cvsserver generates its diff output, but it would also be fine as the
   server side would do two-tree form and nothing else.

   But nobody knows what third-party scripts are assuming.  They may be
   parsing the pathnames, stripping a/ and b/ away.
