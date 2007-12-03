From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: Allow to amend a merge commit that does not change the tree
Date: Sun, 02 Dec 2007 23:51:58 -0800
Message-ID: <7vtzn0md0h.fsf@gitster.siamese.dyndns.org>
References: <1196666690-22187-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: krh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Dec 03 08:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz68B-00017z-JX
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 08:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbXLCHwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 02:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbXLCHwG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 02:52:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40027 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXLCHwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 02:52:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AC8132F0;
	Mon,  3 Dec 2007 02:52:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 258379A45F;
	Mon,  3 Dec 2007 02:52:22 -0500 (EST)
In-Reply-To: <1196666690-22187-1-git-send-email-johannes.sixt@telecom.at>
	(Johannes Sixt's message of "Mon, 3 Dec 2007 08:24:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66885>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> 	I haven't gotten around to write a test case for this scenario,
> 	so I'm sending out the fix alone, in order to draw attention
> 	to the issue and have builtin-commit fixed by its authors, if
> 	necessary ;)

Untested but something like this ought to do.

 builtin-commit.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index f37a90f..6c2dc39 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -676,6 +676,14 @@ int git_commit_config(const char *k, const char *v)
 	return git_status_config(k, v);
 }
 
+static int is_a_merge(const unsigned char *sha1)
+{
+	struct commit *commit = lookup_commit(sha1);
+	if (!commit || parse_commit(commit))
+		die("could not parse HEAD commit");
+	return !!(commit->parents && commit->parents->next);
+}
+
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
@@ -701,7 +709,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		return 1;
 	}
 
-	if (!prepare_log_message(index_file, prefix) && !in_merge) {
+	if (!prepare_log_message(index_file, prefix) && !in_merge &&
+	    !(amend && is_a_merge(head_sha1))) {
 		run_status(stdout, index_file, prefix);
 		rollback_index_files();
 		unlink(commit_editmsg);
