From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep -An -Bm: fix invocation of external grep command
Date: Sat, 17 Nov 2007 21:18:14 -0800
Message-ID: <7vk5ogxhbd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 06:18:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItcYJ-0000sJ-OM
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 06:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbXKRFST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 00:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbXKRFST
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 00:18:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56738 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbXKRFST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 00:18:19 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CBDA02EF;
	Sun, 18 Nov 2007 00:18:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C63A94BF8;
	Sun, 18 Nov 2007 00:18:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65340>

When building command line to invoke external grep, the
arguments to -A/-B/-C options were placd in randarg[] buffer,
but the code forgot that snprintf() does not count terminating
NUL in its return value.  This caused "git grep -A1 -B2" to
invoke external grep with "-B21 -A1".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This bug was present since mid May, 2006.

 builtin-grep.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 185876b..bbf747f 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -294,7 +294,7 @@ static int external_grep(struct grep_opt *opt, const char
 			if (opt->pre_context) {
 				push_arg("-B");
 				len += snprintf(argptr, sizeof(randarg)-len,
-						"%u", opt->pre_context);
+						"%u", opt->pre_context) + 1;
 				if (sizeof(randarg) <= len)
 					die("maximum length of args exceeded");
 				push_arg(argptr);
@@ -303,7 +303,7 @@ static int external_grep(struct grep_opt *opt, const char
 			if (opt->post_context) {
 				push_arg("-A");
 				len += snprintf(argptr, sizeof(randarg)-len,
-						"%u", opt->post_context);
+						"%u", opt->post_context) + 1;
 				if (sizeof(randarg) <= len)
 					die("maximum length of args exceeded");
 				push_arg(argptr);
@@ -313,7 +313,7 @@ static int external_grep(struct grep_opt *opt, const char
 		else {
 			push_arg("-C");
 			len += snprintf(argptr, sizeof(randarg)-len,
-					"%u", opt->post_context);
+					"%u", opt->post_context) + 1;
 			if (sizeof(randarg) <= len)
 				die("maximum length of args exceeded");
 			push_arg(argptr);
