From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is a given file known to git?
Date: Tue, 11 Mar 2008 02:45:08 -0700
Message-ID: <7vy78pbnmj.fsf@gitster.siamese.dyndns.org>
References: <47D6317D.7030700@melosgmbh.de> <47D636FC.2060203@viscovery.net>
 <47D65074.4000505@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:46:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ141-0001A6-6t
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbYCKJpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYCKJpS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:45:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYCKJpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:45:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0DCAB2697;
	Tue, 11 Mar 2008 05:45:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 478DC2696; Tue, 11 Mar 2008 05:45:10 -0400 (EDT)
In-Reply-To: <47D65074.4000505@melosgmbh.de> (Christoph Duelli's message of
 "Tue, 11 Mar 2008 10:27:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76824>

Christoph Duelli <duelli@melosgmbh.de> writes:

> Yes, thank you, Johannes and Shawn, this works.
> (A bit slow, though: with this test enabled my script takes 77 secs;
> without it it takes 0.3 secs. The time is spent in 9000 calls to the
> above test (the rev-parse version). (ok, the fact that there is a Perl
> system call around it might take some time, too).)
>
> [For the record:
> Shawn's ls-files variant takes: 148 secs
> Shawn's cat-file variant takes: 251 secs
> Time taken by time; roughly half user, half system.
> ]
>
> As this script won't run often, that not too big a deal.

I suspect that you asked a wrong question.  If the original question were
"I have a git managed project whose tip has about 8000 paths in it, and I
have 9000 paths that may or may not belong to the tip.  How do I find the
paths that are not part of the tip" (or "How do I find the ones that are
part of the tip"), the answer would have been quite different.

	git ls-files | sort >known
        	(or "git ls-tree --name-only -r HEAD | sort >known")
        $list_your_paths_one_per_line | sort | comm known -

would compare the set of paths in the index (or HEAD) and the set of the
paths you are interested in, and give you the list of ones that are only
present in one side, the other, or both.  Say "comm -13" instead of "comm"
if you are only interested in untracked ones, and say "comm -12" if you
are only interested in tracked ones.  Since you are working inside Perl,
probably you would not pipe to sort/comm but do the comm part yourself, I
would imagine.

It is as if you asked "how do I add one to a given number", without saying
that "I have 9000 paths and I want to repeatedly add one for each path I
have", people taught you the answer to your original question, and you
ended up looping "n := n + 1" 9000 times.  If you told them the real
problem you were trying to solve upfront, they would have taught you how
to multiply instead ;-).
