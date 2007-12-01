From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] use typechange as rename source
Date: Fri, 30 Nov 2007 18:36:56 -0800
Message-ID: <7vsl2n87jr.fsf@gitster.siamese.dyndns.org>
References: <20071121171235.GA32233@sigill.intra.peff.net>
	<7vir3l2a1i.fsf@gitster.siamese.dyndns.org>
	<20071129141452.GA32670@coredump.intra.peff.net>
	<7vmyswsfl6.fsf@gitster.siamese.dyndns.org>
	<20071130015716.GA15224@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIEg-0003qY-2i
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758648AbXLAChE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758636AbXLAChD
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:37:03 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40327 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616AbXLAChA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:37:00 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 633632F0;
	Fri, 30 Nov 2007 21:37:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D2B3A9B9F0;
	Fri, 30 Nov 2007 21:37:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66687>

Jeff King <peff@peff.net> writes:

> I have always been a bit confused about diffcore-break, so I am probably
> misunderstanding what you mean. But are you saying that
> diffcore-break.c:should_break should return 1 for typechanges?

What I had in mind was to do something like that in spirit, but instead
break such a filepair inside diffcore-rename (iow, even when the user
did not say -B) early on.

But after re-reading your patch and the surrounding code, that is
more or less what you are doing (without actually recording the extra
broken pair to be merged back later).

If we did the "automatic break of typechange" early, instead of your
patch, when we come to the register_rename_src() loop, one half of the
broken pair (i.e. "create a new symlink here") will be processed
in this part of the loop:

		if (!DIFF_FILE_VALID(p->one)) {
			if (!DIFF_FILE_VALID(p->two))
				continue; /* unmerged */
			else if (options->single_follow &&
				 strcmp(options->single_follow, p->two->path))
				continue; /* not interested */
			else
				locate_rename_dst(p->two, 1);
		}

and rename_dst is registered here.  The other half (i.e. "remove the
regular file") will be caught by this part in the loop:

		else if (!DIFF_FILE_VALID(p->two)) {
			/*
			 * If the source is a broken "delete", and
			 * they did not really want to get broken,
			 * that means the source actually stays.
			 * So we increment the "rename_used" score
			 * by one, to indicate ourselves as a user
			 */
			if (p->broken_pair && !p->score)
				p->one->rename_used++;
			register_rename_src(p->one, p->score);
		}

to register a source candidate.

Instead your patch does that with a single:

+		else if (DIFF_PAIR_TYPE_CHANGED(p)) {
+			p->one->rename_used++;
+			register_rename_src(p->one, p->score);
+		}

which is essentially doing the same thing but only for the "remove the
regular file" half.  One has to wonder how the lack of handling the
other half affects the outcome and still produce a result more intuitive
than the current code.

In your test case, the "new" symlink won't have any similar symlink that
is removed from the preimage, so registering it as a rename destination
would not make a difference (it will say "no match found, so create this
as usual"), but I am not convinced if that would work well in general.
