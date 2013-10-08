From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] clone: do not segfault when specifying a nonexistent branch
Date: Tue,  8 Oct 2013 12:06:05 +0200
Message-ID: <1381226765-19390-1-git-send-email-stefanbeller@googlemail.com>
References: <CACsJy8D+a=agXppSRT0C_w_9a5nGwomDp=8tiN5GPWtrpCKHRQ@mail.gmail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, ralf.thielow@gmail.com,
	robert.mitwicki@opensoftware.pl, git@vger.kernel.org,
	pclouds@gmail.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 08 12:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTUBE-0005UM-4H
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 12:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab3JHKGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 06:06:11 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:47388 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab3JHKGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 06:06:10 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so3932712eek.12
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2KpSPw80KEkyaMQem8Rd5Lj/oHfK4iyuB2YUcH3B9o=;
        b=UZC04PSoCq46dLBBJ0iZbNmM9h/8LaJYB8x6VqXof85IPzAfYSumVKGuM5bfOvEBNu
         ENQ1BK2V0n2ARTs7dv16Ap18VPyxt9H6UZJQzA3Zg7vTuObVIUeJGDS1wyNgaAwngaQy
         WCZXQ9Z6tusr/HRON4KlBYb6g4bIIbCGiO9zylZL1nkcBanEr5biTrbaTRHh6X7P5+q2
         HEgqxg5O1hqnFw9Hsfapj47gxC3FHDCDysu3wFjWzGqd6/Sikk6E0OLgXFx/fm4k2VdE
         x2vMmCQBLn5z8L/uXKRj7Twvo534THDGehJl+fkKubv8MJKjzr+rpjH+1PQRbbGRC+CZ
         elxA==
X-Received: by 10.14.115.133 with SMTP id e5mr1123656eeh.27.1381226769226;
        Tue, 08 Oct 2013 03:06:09 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id b45sm73958005eef.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 03:06:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.469.gb38b9db
In-Reply-To: <CACsJy8D+a=agXppSRT0C_w_9a5nGwomDp=8tiN5GPWtrpCKHRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235768>

Actually I only wanted to change one line to prevent a crash, when you
specify a non existing branch when cloning:
-			if (option_branch) {
+			if (option_branch && our_head_points_at) {

However it turns out this is not a good idea as we still want to setup
'remote.*.fetch', which previously depended the string buffer 'value'
being non empty.
Therefore I added a local variable 'set_remote', which determines whether
we want to setup 'remote.*.fetch'.


While staring at the code, I also think it is a good idea to restructure
the if clauses a little as previously we had
	if (option_mirror || !option_bare) {
		if (option_single_branch && !option_mirror) {
The 'option_mirror' is part of both ifs, but opposing each other.
This is not yet done in this patch, as it still needs some thinking how to
remove the nesting of the if clauses in a nice way.

Reported-by: Robert Mitwicki <robert.mitwicki@opensoftware.pl>
Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/clone.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0aff974..8b9a78a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -686,40 +686,46 @@ static void write_refspec_config(const char* src_ref_prefix,
 	struct strbuf key = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
 
+	int set_remote = 0;
 	if (option_mirror || !option_bare) {
+		set_remote = 1;
 		if (option_single_branch && !option_mirror) {
 			if (option_branch) {
-				if (strstr(our_head_points_at->name, "refs/tags/"))
-					strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
-						our_head_points_at->name);
-				else
-					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
-						branch_top->buf, option_branch);
+				if (our_head_points_at) {
+					if (strstr(our_head_points_at->name, "refs/tags/"))
+						strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
+							our_head_points_at->name);
+					else
+						strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
+							branch_top->buf, option_branch);
+				}
 			} else if (remote_head_points_at) {
 				strbuf_addf(&value, "+%s:%s%s", remote_head_points_at->name,
 						branch_top->buf,
 						skip_prefix(remote_head_points_at->name, "refs/heads/"));
+			} else {
+				/*
+				 * otherwise, the next "git fetch" will
+				 * simply fetch from HEAD without updating
+				 * any remote-tracking branch, which is what
+				 * we want.
+				 */
+				set_remote = 0;
 			}
-			/*
-			 * otherwise, the next "git fetch" will
-			 * simply fetch from HEAD without updating
-			 * any remote-tracking branch, which is what
-			 * we want.
-			 */
 		} else {
 			strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top->buf);
 		}
-		/* Configure the remote */
-		if (value.len) {
-			strbuf_addf(&key, "remote.%s.fetch", option_origin);
-			git_config_set_multivar(key.buf, value.buf, "^$", 0);
-			strbuf_reset(&key);
+	}
+	/* Configure the remote */
+	if (set_remote) {
+		strbuf_addf(&key, "remote.%s.fetch", option_origin);
+		git_config_set_multivar(key.buf, value.buf, "^$", 0);
+		strbuf_reset(&key);
 
-			if (option_mirror) {
-				strbuf_addf(&key, "remote.%s.mirror", option_origin);
-				git_config_set(key.buf, "true");
-				strbuf_reset(&key);
-			}
+		if (option_mirror) {
+			strbuf_addf(&key, "remote.%s.mirror", option_origin);
+			git_config_set(key.buf, "true");
+			strbuf_reset(&key);
 		}
 	}
 
-- 
1.8.4.1.469.gb38b9db
