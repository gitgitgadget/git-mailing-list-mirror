From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove duplicate pathspecs from ls-files command line
Date: Wed, 29 Aug 2007 13:44:22 -0700
Message-ID: <7v4piioyu1.fsf@gitster.siamese.dyndns.org>
References: <20070829081122.GA604@piper.oerlikon.madduck.net>
	<20070829194410.GA11824@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>,
	439992-quiet@bugs.debian.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 22:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQUOu-0004BX-H5
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 22:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbXH2Uo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 16:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbXH2Uo3
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 16:44:29 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbXH2Uo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 16:44:28 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2970012AA81;
	Wed, 29 Aug 2007 16:44:46 -0400 (EDT)
In-Reply-To: <20070829194410.GA11824@steel.home> (Alex Riesen's message of
	"Wed, 29 Aug 2007 21:44:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56980>

Alex Riesen <raa.lkml@gmail.com> writes:

> The first entry wins, all the subsequent entries will be discarded.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> martin f krafft, Wed, Aug 29, 2007 10:11:22 +0200:
>> when using git-add from a script, the following fails:
>> 
>>   $ git commit -m. foo foo
>>   error: pathspec 'foo' did not match any file(s) known to git.
>>   Did you forget to 'git add'?
>> 
>> I am bringing this up in the context of
>> http://bugs.debian.org/439992, where debcommit.pl would duplicate
>> a file argument under certain conditions. It's since been fixed, but
>> I wonder whether git-commit could be made more robust in the
>> presence of duplicate arguments? Or is this behaviour by choice?
>
> Don't think so. Looks like accident. The patch below fixes it,
> by introducing a costly argument duplication check. Shouldn't
> be a problem for a normal use (git-ls-files expects globs, not
> pathnames).

Thanks both for your attention to the detail.  It was to catch

	git commit Makefiel

and did not mean to warn about listing the same thing twice (it
is still a mistaken usage in the sense that it is unnecessary to
list things twice, not in the sense that it instructs the
command to commit the same file twice).

The patch is not wrong per-se from correctness standpoint, but I
must say that it is a horrible thing to do from both performance
and principle point of view.

That loop is plain old O(n^2) that penalizes everybody.

Please do not penalize sane callers when you try to improve
support of mistaken usage.  Move expensive error recovery in the
error path when possible, and have _only_ mistaken users pay the
price.

Like this perhaps.

---
 builtin-ls-files.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index d36181a..cce17b5 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -511,8 +511,28 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		 */
 		int num, errors = 0;
 		for (num = 0; pathspec[num]; num++) {
+			int other, found_dup;
+
 			if (ps_matched[num])
 				continue;
+			/*
+			 * The caller might have fed identical pathspec
+			 * twice.  Do not barf on such a mistake.
+			 */
+			for (found_dup = other = 0;
+			     !found_dup && pathspec[other];
+			     other++) {
+				if (other == num || !ps_matched[other])
+					continue;
+				if (!strcmp(pathspec[other], pathspec[num]))
+					/*
+					 * Ok, we have a match already.
+					 */
+					found_dup = 1;
+			}
+			if (found_dup)
+				continue;
+
 			error("pathspec '%s' did not match any file(s) known to git.",
 			      pathspec[num] + prefix_offset);
 			errors++;
