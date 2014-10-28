From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] receive-pack: avoid minor leak in case start_async() fails
Date: Tue, 28 Oct 2014 21:27:54 +0100
Message-ID: <544FFC4A.4010109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 21:28:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjDNF-0006sH-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 21:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbaJ1U2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 16:28:09 -0400
Received: from mout.web.de ([212.227.15.3]:50819 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbaJ1U2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 16:28:08 -0400
Received: from [192.168.178.27] ([79.253.156.206]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M24rL-1XxZrU483H-00u2mK; Tue, 28 Oct 2014 21:28:04
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:aNegfxS+hG/OZELSsc/2LLupPMAgIfgM47ByZ366ZnkELLIC/yA
 cwI3VD9UiZZoZGHgpR8PfyIhG571I3Nc+Ho3PwrgF4vrCMB34lvMc1OEquUueoyCBwcxmw1
 B+5T3RDS/Vo1TiYlbP8E5CaTfXkVYskMym3VZKI4rkYYSJcO0e637lyiFO1HAwZPYs/9Ixf
 pT0g+e7KHD07pKLtAaSfg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the asynchronous start of copy_to_sideband() fails, then any
env_array entries added to struct child_process proc by
prepare_push_cert_sha1() are leaked.  Call the latter function only
after start_async() succeeded so that the allocated entries are
cleaned up automatically by start_command() or finish_command().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fc03937..32fc540 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -527,8 +527,6 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 
-	prepare_push_cert_sha1(&proc);
-
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
 		muxer.proc = copy_to_sideband;
@@ -539,6 +537,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 		proc.err = muxer.in;
 	}
 
+	prepare_push_cert_sha1(&proc);
+
 	code = start_command(&proc);
 	if (code) {
 		if (use_sideband)
-- 
2.1.2
