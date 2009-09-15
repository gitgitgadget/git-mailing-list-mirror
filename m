From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 05/14] Fix __stdcall placement and function prototype
Date: Tue, 15 Sep 2009 15:44:08 +0200
Message-ID: <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com>
 <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com>
 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com>
 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com>
 <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Sep 15 15:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYKx-0007Be-Uh
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbZIONop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 09:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbZIONoo
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:44:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:49262 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbZIONok (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 09:44:40 -0400
Received: by ey-out-2122.google.com with SMTP id 25so789017eya.19
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=d1U/nbPQGutCNl8YSVd1zhEpZPBISbpR8tZoqjGLCIg=;
        b=o24dO/d/pKMir0NHFvhycS1EOBMAdpB3D6wVeBCMMDsooIxs5hMwozlB7Ir99Bh8JF
         OGJ64xc/MnUVbk5sba5efGMojyDX4p6Gek+/UxMTEleejvGvn8BGqwusYTGQTFeuV7Ol
         Eqo5sqWFtNriNJBopjwsXJkP/umhSJ7K2Qhhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oL5ygN2Ofof9Bn2u/q9+reTQ1ngwC+PfDuexJOD3NBCOtRNeQ40rE9TMw5OY0NGTjl
         dWG4dUcy8Ee/udG4YMNQi37SlO+cuIlvyBMxWDHnDijlqsj6mjmPln+f8ThaXdEbk+0T
         H9mKtrYbRzq/mZccLCRAnkbtJUtn3QGoiVIxI=
Received: by 10.211.154.17 with SMTP id g17mr839091ebo.32.1253022283633;
        Tue, 15 Sep 2009 06:44:43 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 06:44:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128547>

From: Frank Li <lznuaa@gmail.com>

MSVC requires __stdcall to be between the functions return value and
the function name, and that the function pointer type is in the form
of
    return_type (WINAPI *function_name)(arguments...)

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |    4 ++--
 run-command.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5a8fae8..34ee427 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1027,7 +1027,7 @@ static sig_handler_t timer_fn = SIG_DFL;
  * length to call the signal handler.
  */
 
-static __stdcall unsigned ticktack(void *dummy)
+static unsigned __stdcall ticktack(void *dummy)
 {
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
 		if (timer_fn == SIG_DFL)
@@ -1154,7 +1154,7 @@ void mingw_open_html(const char *unixpath)
 
 int link(const char *oldpath, const char *newpath)
 {
-	typedef BOOL WINAPI (*T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
+	typedef BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
 	static T create_hard_link = NULL;
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
diff --git a/run-command.c b/run-command.c
index 02aaedf..bb76750 100644
--- a/run-command.c
+++ b/run-command.c
@@ -316,7 +316,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 }
 
 #ifdef __MINGW32__
-static __stdcall unsigned run_thread(void *data)
+static unsigned __stdcall run_thread(void *data)
 {
 	struct async *async = data;
 	return async->proc(async->fd_for_proc, async->data);
-- 
1.6.2.1.418.g33d56.dirty
