From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Mon, 02 Sep 2013 22:11:26 +0200
Message-ID: <5224F0EE.1080205@kdbg.org>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com> <7vhae7k7t1.fsf@alter.siamese.dyndns.org> <CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com> <CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com> <CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com> <xmqqeh9b15x6.fsf@gitster.dls.corp.google.com> <xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 22:11:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGaTJ-0007hF-0f
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 22:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab3IBULb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 16:11:31 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:15378 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756110Ab3IBULa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 16:11:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D1CBA1300AD;
	Mon,  2 Sep 2013 22:11:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B42B719F3F8;
	Mon,  2 Sep 2013 22:11:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233656>

Am 31.08.2013 01:55, schrieb Junio C Hamano:
> People often find "git log --branches" etc. that includes _all_
> branches is cumbersome to use when they want to grab most but except
> some.  The same applies to --tags, --all and --glob.
> 
> Teach the revision machinery to remember patterns, and then upon the
> next such a globbing option, exclude those that match the pattern.
> 
> With this, I can view only my integration branches (e.g. maint,
> master, etc.) without topic branches, which are named after two
> letters from primary authors' names, slash and topic name.
> 
>     git rev-list --no-walk --exclude=??/* --branches |
>     git name-rev --refs refs/heads/* --stdin
> 
> This one shows things reachable from local and remote branches that
> have not been merged to the integration branches.
> 
>     git log --remotes --branches --not --exclude=??/* --branches
> 
> It may be a bit rough around the edges, in that the pattern to give
> the exclude option depends on what globbing option follows.  In
> these examples, the pattern "??/*" is used, not "refs/heads/??/*",
> because the globbing option that follows the -"-exclude=<pattern>"
> is "--branches".  As each use of globbing option resets previously
> set "--exclude", this may not be such a bad thing, though.

I argued "--except should trump everything" earlier, but the case
involving --not

  --branches --except maint --not master

to mean the same as

  --branches --except maint master

just does not make sense.

An alternative would be that --not would divide the command line
arguments into ranges within which one --except would subtract
subsequent refs from earlier globbing arguments in the same range.
That's not simpler to explain than your current proposal.

So I like the relative simplicity of this approach. Here is a bit of
documentation.

--- 8< ---
Subject: [PATCH] document --exclude option

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Documentation/rev-list-options.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5bdfb42..650c252 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -174,6 +174,21 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	is automatically prepended if missing. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
 
+--exclude=<glob-pattern>::
+
+	Do not include refs matching '<glob-pattern>' that the next `--all`,
+	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
+	consider. Repetitions of this option accumulate exclusion patterns
+	up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
+	`--glob` option (other options or arguments do not clear
+	accumlated patterns).
++
+The patterns given should not begin with `refs/heads`, `refs/tags`, or
+`refs/remotes` when applied to `--branches`, `--tags`, or `--remotes`,
+restrictively, and they must begin with `refs/` when applied to `--glob`
+or `--all`. If a trailing '/{asterisk}' is intended, it must be given
+explicitly.
+
 --ignore-missing::
 
 	Upon seeing an invalid object name in the input, pretend as if
-- 
1.8.4.33.gd68f7e8
