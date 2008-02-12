From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] pack-objects: Allow setting the #threads equal to #cpus
 automatically
Date: Mon, 11 Feb 2008 20:55:25 -0600
Message-ID: <47B10A9D.7000702@nrlssc.navy.mil>
References: <47B01FE7.8010207@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: ae@op5.se
X-From: git-owner@vger.kernel.org Tue Feb 12 03:56:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOlJl-0003to-Sc
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 03:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbYBLCzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 21:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbYBLCzr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 21:55:47 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58067 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135AbYBLCzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 21:55:45 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1C2tQtt022391;
	Mon, 11 Feb 2008 20:55:26 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Feb 2008 20:55:26 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47B01FE7.8010207@op5.se>
X-OriginalArrivalTime: 12 Feb 2008 02:55:26.0231 (UTC) FILETIME=[B7EFA270:01C86D22]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15722001
X-TM-AS-Result: : Yes--3.434300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTEwNTA0MC03MTA1?=
	=?us-ascii?B?NzEtNzA1MTAyLTcwNzQ1MS03MDE1OTQtNzA2NDU0LTcwMDg2NS03?=
	=?us-ascii?B?MDM3MTItNzAwMTYwLTcwMzc4OC03MDIwMjAtNzAwNjE4LTcwMTQ1?=
	=?us-ascii?B?NS03MDg3OTctNzAyOTk5LTcwMjA0NC03MDY0ODMtNzAzMTc2LTcw?=
	=?us-ascii?B?MDc1Ni03MTEzODUtNzAwOTcxLTcwMTAwNS03MDQyNTctNzA0OTI3?=
	=?us-ascii?B?LTE4ODAxOS03MDYyOTAtNzA0NzQ3LTcwMzk2NS03MDIzNzktNzAy?=
	=?us-ascii?B?OTAwLTcwNTU4MS03MDMxNzktNzAyMTE4LTE4ODE5OS03MDI5MjAt?=
	=?us-ascii?B?NzAzMzc4LTcwODU1OC0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73620>

Allow pack.threads config option and --threads command line option to
accept '0' as an argument and set the number of created threads equal
to the number of online processors in this case.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I was preparing this patch when I saw your email. I looked up your
the old email you were talking about. Your function is better since
it is cross platform.

When you redo your patch, you may want to adopt one aspect of this
one. I used a setting of zero to imply "set number of threads to
number of cpus". This allows the user to specifically set pack.threads
in the config file to zero with the above mentioned meaning, or to
override a setting in the config file from the command line with
--threads=0. This is rather than having to delete the option from the
config file.

-brandon


 builtin-pack-objects.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 692a761..5c55c11 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1852,11 +1852,11 @@ static int git_pack_config(const char *k, const char *v)
 	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
-		if (delta_search_threads < 1)
+		if (delta_search_threads < 0)
 			die("invalid number of threads specified (%d)",
 			    delta_search_threads);
 #ifndef THREADED_DELTA_SEARCH
-		if (delta_search_threads > 1)
+		if (delta_search_threads != 1)
 			warning("no threads support, ignoring %s", k);
 #endif
 		return 0;
@@ -2121,10 +2121,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		if (!prefixcmp(arg, "--threads=")) {
 			char *end;
 			delta_search_threads = strtoul(arg+10, &end, 0);
-			if (!arg[10] || *end || delta_search_threads < 1)
+			if (!arg[10] || *end || delta_search_threads < 0)
 				usage(pack_usage);
 #ifndef THREADED_DELTA_SEARCH
-			if (delta_search_threads > 1)
+			if (delta_search_threads != 1)
 				warning("no threads support, "
 					"ignoring %s", arg);
 #endif
@@ -2234,6 +2234,20 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
 
+#ifdef THREADED_DELTA_SEARCH
+	if (!delta_search_threads) {
+#if defined _SC_NPROCESSORS_ONLN
+		delta_search_threads = sysconf(_SC_NPROCESSORS_ONLN);
+#elif defined _SC_NPROC_ONLN
+		delta_search_threads = sysconf(_SC_NPROC_ONLN);
+#endif
+		if (delta_search_threads == -1)
+			perror("Could not detect number of processors");
+		if (delta_search_threads <= 0)
+			delta_search_threads = 1;
+	}
+#endif
+
 	prepare_packed_git();
 
 	if (progress)
-- 
1.5.4.1.40.gdb90
