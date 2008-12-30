From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH,RESEND] objects to be pruned immediately don't have to be
 loosened
Date: Tue, 30 Dec 2008 14:45:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812301441540.30266@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 20:46:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHkY4-000680-Cx
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 20:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbYL3TpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 14:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbYL3TpT
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 14:45:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55276 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbYL3TpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 14:45:18 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KCP00HZ5G7BY8B0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Dec 2008 14:45:11 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104199>


When there is no grace period before pruning unreferenced objects, it is
pointless to push those objects in their loose form just to delete them
right away.

Also be more explicit about the possibility of using "now" in the
gc.pruneexpire config variable (needed for the above behavior to
happen).

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7408bb2..ea0cd97 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -702,7 +702,9 @@ gc.packrefs::
 
 gc.pruneexpire::
 	When 'git-gc' is run, it will call 'prune --expire 2.weeks.ago'.
-	Override the grace period with this config variable.
+	Override the grace period with this config variable.  The value
+	"now" may be used to disable this  grace period and always prune
+	unreachable objects immediately.
 
 gc.reflogexpire::
 	'git-reflog expire' removes reflog entries older than
diff --git a/builtin-gc.c b/builtin-gc.c
index 781df60..f8eae4a 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -188,7 +188,9 @@ static int need_to_gc(void)
 	 * there is no need.
 	 */
 	if (too_many_packs())
-		append_option(argv_repack, "-A", MAX_ADD);
+		append_option(argv_repack,
+			      !strcmp(prune_expire, "now") ? "-a" : "-A",
+			      MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
 
@@ -243,7 +245,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			"run \"git gc\" manually. See "
 			"\"git help gc\" for more information.\n");
 	} else
-		append_option(argv_repack, "-A", MAX_ADD);
+		append_option(argv_repack,
+			      !strcmp(prune_expire, "now") ? "-a" : "-A",
+			      MAX_ADD);
 
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_pack_refs[0]);
