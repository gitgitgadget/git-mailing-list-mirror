From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command
 given is junk
Date: Tue, 15 Dec 2009 08:57:18 +0100
Message-ID: <4B27415E.1090107@viscovery.net>
References: <4B263797.5070808@viscovery.net> <7v7hspjp3q.fsf@alter.siamese.dyndns.org> <200912142255.36949.j.sixt@viscovery.net> <7vaaxlcehw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 08:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKSHh-0004XC-Va
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 08:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbZLOH5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 02:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZLOH5X
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 02:57:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3812 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751487AbZLOH5X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 02:57:23 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NKSHX-0004sP-F6; Tue, 15 Dec 2009 08:57:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 314251660F;
	Tue, 15 Dec 2009 08:57:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vaaxlcehw.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135278>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> On Montag, 14. Dezember 2009, Junio C Hamano wrote:
>>> In the meantime, I think squashing the following in would help us keep the
>>> two magic numbers in sync.
>> I do not think that keeping the numbers in sync is necessary. For example, the 
>> similarity requirement for commands that run automatically could be stricter 
>> than for the list of suggestions. Then it would be possible that a unique 
>> best candidate is not good enough to be run automatically; there would only 
>> be a list of suggestions.
> 
> Well thought out.  Would you want to reroll a patch with two symbolic
> constants then?

I briefly looked into it, but, no, I don't want to reroll the patch. Not
only would the change be larger than I first thought, but I would also
have to find a mis-typed command where a stricter limit makes a difference
*and* where it makes sense that the guessed command is not run
automatically. Moreover, I would also have to *find* a suitable new
similarity limit. Not something I want to do now.

Please take my original patch and squash in your suggested changes. Here
it is for your convenience with an updated commit message (only the
last paragraph changed).

-- Hannes

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] help.autocorrect: do not run a command if the command given is junk

If a given command is not found, then help.c tries to guess which one the
user could have meant. If help.autocorrect is 0 or unset, then a list of
suggestions is given as long as the dissimilarity between the given command
and the candidates is not excessively high. But if help.autocorrect was
non-zero (i.e., a delay after which the command is run automatically), the
latter restriction on dissimilarity was not obeyed.

In my case, this happened:

 $ git ..daab02
 WARNING: You called a Git command named '..daab02', which does not exist.
 Continuing under the assumption that you meant 'read-tree'
 in 4.0 seconds automatically...

The patch reuses the similarity limit that is also applied when the list of
suggested commands is printed.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 help.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index e8db31f..9da97d7 100644
--- a/help.c
+++ b/help.c
@@ -297,6 +297,9 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	old->names = NULL;
 }

+/* An empirically derived magic number */
+#define SIMILAR_ENOUGH(x) ((x) < 6)
+
 const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
@@ -331,7 +334,7 @@ const char *help_unknown_cmd(const char *cmd)
 	n = 1;
 	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
 		++n;
-	if (autocorrect && n == 1) {
+	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		clean_cmdnames(&main_cmds);
@@ -349,7 +352,7 @@ const char *help_unknown_cmd(const char *cmd)

 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);

-	if (best_similarity < 6) {
+	if (SIMILAR_ENOUGH(best_similarity)) {
 		fprintf(stderr, "\nDid you mean %s?\n",
 			n < 2 ? "this": "one of these");

-- 
1.6.6.rc1.46.g1635
