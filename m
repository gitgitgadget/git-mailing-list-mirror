From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] clone: use child_process for recursive checkouts
Date: Wed, 23 Dec 2015 12:30:12 +0100
Message-ID: <c21eb4a5d3a3a4886c45da0abe307fe1772e932e.1450869637.git.mhagger@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com> <1449102921-7707-14-git-send-email-dturner@twopensource.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 12:37:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBhjU-0008ER-LY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 12:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbbLWLhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 06:37:24 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57366 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752345AbbLWLhX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 06:37:23 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2015 06:37:23 EST
X-AuditID: 12074411-f797e6d000007df3-99-567a85ccbd51
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 81.B2.32243.CC58A765; Wed, 23 Dec 2015 06:30:20 -0500 (EST)
Received: from michael.fritz.box (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBNBUHqT020398
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Dec 2015 06:30:19 -0500
X-Mailer: git-send-email 2.6.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqHumtSrMYFqXgsX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j2e9exg9Ll5S9ljw/D67x+dNcgFs
	Udw2SYklZcGZ6Xn6dgncGZ2989gKFnBX7Gs4zdLA2M/ZxcjJISFgIrHh8l5GCFtM4sK99Wxd
	jFwcQgKXGSX2zVrNDuGcZJJ4e24HK0gVm4CuxKKeZiYQW0RAW2L2kR5WkCJmgY2MEu2bP4CN
	EhZwlOjcs5kNxGYRUJWY/W0ymM0rECUx/8J6oAYOoHVyEpMmOEAsaGGU2Nw1kXUCI88CRoZV
	jHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCEhJbiDccZJuUOMAhyMSjy8Dm2V
	YUKsiWXFlbmHGCU5mJREeaOrqsKE+JLyUyozEosz4otKc1KLDzFKcDArifCmvwMq501JrKxK
	LcqHSUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2CycpwcChJ8B5vARoqWJSanlqRlplTgpBm4uAE
	Gc4lJVKcmpeSWpRYWpIRD4qC+GJgHICkeID2rgVp5y0uSMwFikK0nmJUlBLnnQWSEABJZJTm
	wY2FJYpXjOJAXwrzuoJU8QCTDFz3K6DBTECD/6wrBxlckoiQkmpgLDPk8dBZ+HTGgU8xDZkP
	qnfsczdfn+cS8a62Lr5phvDh7I0uhx42vFminfPE6MydBZninRxXcrYHf5XQYv31/Kv7Mp3q
	+fdz/6ww/fE/ysZ9ZalbYfrzG+ec868oVuaeeS5w7tKn5i3eG7c5rDedcjFs7iRN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282933>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
David, I think if you insert this patch before your

  13/16 refs: allow ref backend to be set for clone

, then the hunk in builtin/clone.c:checkout() of your patch becomes
trivial:

	if (refs_backend_type)
		argv_array_pushf(&cmd.args, "--refs-backend-type=%s",
				 refs_backend_type);

 builtin/clone.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index caae43e..53c2834 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -95,10 +95,6 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
-};
-
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -724,8 +720,14 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+
+		cmd.git_cmd = 1;
+		argv_array_pushl(&cmd.args, "submodule", "update",
+				 "--init", "--recursive", NULL);
+		err = run_command(&cmd);
+	}
 
 	return err;
 }
-- 
2.6.4
