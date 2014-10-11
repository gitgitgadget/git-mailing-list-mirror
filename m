From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] receive-pack: plug minor memory leak in unpack()
Date: Sat, 11 Oct 2014 13:00:16 +0200
Message-ID: <54390DC0.8060302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 13:01:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcuQp-0005Dt-GV
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 13:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbaJKLBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 07:01:47 -0400
Received: from mout.web.de ([212.227.17.11]:51826 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbaJKLBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 07:01:46 -0400
Received: from [192.168.178.27] ([79.253.188.51]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MduAD-1Xoo8p0Ord-00Peky; Sat, 11 Oct 2014 13:01:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Provags-ID: V03:K0:PcUP3fVI+3S267dCAL+jOAa9pPuNCHoXRqgGYsT8/hksZuMR2cL
 LsV4XIXRVRdERA4l+e32cuxUCGpsD9lZj1xWs0XU4gRFU6ShqGyppuVclvJspxw4sDyWl0X
 32Y+S/XYFfiWmluGFrhKTdFu4gdTlBnQPu8AjqDhEWO30MbjlG6HVSpu13NR0vrlKQjD552
 5snWNHk4IizX+f5vewYlw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argv_array used in unpack() is never freed.  Instead of adding
explicit calls to argv_array_clear() use the args member of struct
child_process and let run_command() and friends clean up for us.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/receive-pack.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a51846c..443dd37 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1220,7 +1220,6 @@ static const char *pack_lockfile;
 static const char *unpack(int err_fd, struct shallow_info *si)
 {
 	struct pack_header hdr;
-	struct argv_array av = ARGV_ARRAY_INIT;
 	const char *hdr_err;
 	int status;
 	char hdr_arg[38];
@@ -1243,16 +1242,16 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 
 	if (si->nr_ours || si->nr_theirs) {
 		alt_shallow_file = setup_temporary_shallow(si->shallow);
-		argv_array_pushl(&av, "--shallow-file", alt_shallow_file, NULL);
+		argv_array_push(&child.args, "--shallow-file");
+		argv_array_push(&child.args, alt_shallow_file);
 	}
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		argv_array_pushl(&av, "unpack-objects", hdr_arg, NULL);
+		argv_array_pushl(&child.args, "unpack-objects", hdr_arg, NULL);
 		if (quiet)
-			argv_array_push(&av, "-q");
+			argv_array_push(&child.args, "-q");
 		if (fsck_objects)
-			argv_array_push(&av, "--strict");
-		child.argv = av.argv;
+			argv_array_push(&child.args, "--strict");
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1267,13 +1266,12 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 			strcpy(keep_arg + s, "localhost");
 
-		argv_array_pushl(&av, "index-pack",
+		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects)
-			argv_array_push(&av, "--strict");
+			argv_array_push(&child.args, "--strict");
 		if (fix_thin)
-			argv_array_push(&av, "--fix-thin");
-		child.argv = av.argv;
+			argv_array_push(&child.args, "--fix-thin");
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
-- 
2.1.2
