From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] transport: simplify fetch_objs_via_rsync() using argv_array
Date: Fri, 18 Jul 2014 17:12:34 +0200
Message-ID: <53C93962.6020904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 17:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X89qQ-0000QU-J4
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 17:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761987AbaGRPNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 11:13:06 -0400
Received: from mout.web.de ([212.227.15.3]:52022 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760629AbaGRPND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 11:13:03 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lp7Lg-1WeaJm1m7g-00eqiS; Fri, 18 Jul 2014 17:12:46
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:tGAkhpELMwMppBdXbetLUTTOjxPSYmUt8jQ4i0IEtUe40ClSFnm
 JySfi7toiOoIqYS9aoKE4nTV1Lrqx6suH9mi+7oL/K5V833oip3OJ8WXz4zrhm/GnGj3nav
 2Vc32Uzas1MWfrOuN9A+CgyavVncSzNa6iBc4e9oqlLgc5/xeMmfNr34tDyXTpdM7DHLekW
 ek83Rz2ntfjOiWBHa7/AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253822>

Use the existing argv_array member instead of building the arguments
list using a string array and a strbuf.  This way we don't need magic
number constants and allocations are cleaned up for us automatically
by run_command().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 transport.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/transport.c b/transport.c
index 59c9727..3e42570 100644
--- a/transport.c
+++ b/transport.c
@@ -263,32 +263,20 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 static int fetch_objs_via_rsync(struct transport *transport,
 				int nr_objs, struct ref **to_fetch)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct child_process rsync;
-	const char *args[8];
-	int result;
-
-	strbuf_addstr(&buf, rsync_url(transport->url));
-	strbuf_addstr(&buf, "/objects/");
 
 	memset(&rsync, 0, sizeof(rsync));
-	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
-	args[0] = "rsync";
-	args[1] = (transport->verbose > 1) ? "-rv" : "-r";
-	args[2] = "--ignore-existing";
-	args[3] = "--exclude";
-	args[4] = "info";
-	args[5] = buf.buf;
-	args[6] = get_object_directory();
-	args[7] = NULL;
+	argv_array_push(&rsync.args, "rsync");
+	argv_array_push(&rsync.args, (transport->verbose > 1) ? "-rv" : "-r");
+	argv_array_push(&rsync.args, "--ignore-existing");
+	argv_array_push(&rsync.args, "--exclude");
+	argv_array_push(&rsync.args, "info");
+	argv_array_pushf(&rsync.args, "%s/objects/", rsync_url(transport->url));
+	argv_array_push(&rsync.args, get_object_directory());
 
 	/* NEEDSWORK: handle one level of alternates */
-	result = run_command(&rsync);
-
-	strbuf_release(&buf);
-
-	return result;
+	return run_command(&rsync);
 }
 
 static int write_one_ref(const char *name, const unsigned char *sha1,
-- 
2.0.0
