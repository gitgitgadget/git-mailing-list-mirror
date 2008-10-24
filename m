From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Only update the cygwin-related configuration during
 state auto-setup
Date: Thu, 23 Oct 2008 22:54:09 -0700
Message-ID: <7viqri35dq.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0810230607sfea05ddm62bd03f837fc922e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mark Levedahl" <mlevedahl@gmail.com>, spearce@spearce.org,
	dpotapov@gmail.com, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 07:55:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtFeB-0004sD-Ma
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 07:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbYJXFya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 01:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYJXFy3
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 01:54:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYJXFy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 01:54:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 64DFB73EA7;
	Fri, 24 Oct 2008 01:54:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AF85873EA5; Fri, 24 Oct 2008 01:54:16 -0400 (EDT)
In-Reply-To: <81b0412b0810230607sfea05ddm62bd03f837fc922e@mail.gmail.com>
 (Alex Riesen's message of "Thu, 23 Oct 2008 15:07:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37C51258-A190-11DD-B23D-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99010>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Otherwise the other global settings which were already read and set up will
> be overwritten ...

This is the answer to the question I asked in:

 http://thread.gmane.org/gmane.comp.version-control.git/97986/focus=98066

Perhaps we should use a separate variable as the original patch did, in:

  http://article.gmane.org/gmane.comp.version-control.git/97987

How about doing it like this instead?


diff --git i/compat/cygwin.c w/compat/cygwin.c
index f196753..ebac148 100644
--- i/compat/cygwin.c
+++ w/compat/cygwin.c
@@ -91,26 +91,32 @@ static int cygwin_stat(const char *path, struct stat *buf)
  * functions should be used. The choice is determined by core.ignorecygwinfstricks.
  * Reading this option is not always possible immediately as git_dir may be
  * not be set yet. So until it is set, use cygwin lstat/stat functions.
- * However, if the trust_executable_bit is set, we must use the Cygwin posix
+ * However, if core.filemode is set, we must use the Cygwin posix
  * stat/lstat as the Windows stat fuctions do not determine posix filemode.
+ *
+ * Note that git_cygwin_config() does NOT call git_default_config() and this
+ * is deliberate.  Many commands read from config to establish initial
+ * values in variables and later tweak them from elsewhere (e.g. command line).
+ * init_stat() is called lazily on demand, typically much late in the program,
+ * and calling git_default_config() from here would break such variables.
  */
 static int native_stat = 1;
-extern int trust_executable_bit;
+static int core_filemode;
 
 static int git_cygwin_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "core.ignorecygwinfstricks")) {
+	if (!strcmp(var, "core.ignorecygwinfstricks"))
 		native_stat = git_config_bool(var, value);
-		return 0;
-	}
-	return git_default_config(var, value, cb);
+	else if (!strcmp(var, "core.filemode"))
+		core_filemode = git_config_bool(var, value);
+	return 0;
 }
 
 static int init_stat(void)
 {
 	if (have_git_dir()) {
 		git_config(git_cygwin_config, NULL);
-		if (!trust_executable_bit && native_stat) {
+		if (!core_filemode && native_stat) {
 			cygwin_stat_fn = cygwin_stat;
 			cygwin_lstat_fn = cygwin_lstat;
 		} else {
