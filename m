From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCHv2 1/3] Add a new option 'core.askpass'.
Date: Mon, 30 Aug 2010 15:38:38 +0200
Organization: science + computing ag
Message-ID: <201008301538.39784.k.franke@science-computing.de>
References: <201008301536.20414.k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 15:38:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4Zc-0006u8-4M
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab0H3Nin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 09:38:43 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:37828 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729Ab0H3Nim convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 09:38:42 -0400
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp1.belwue.de with ESMTP id o7UDcfqV015730
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 15:38:41 +0200 (MEST)
	env-from (prvs=851ee50e4=k.franke@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 04D28AC00A;
	Mon, 30 Aug 2010 15:38:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L0MqBcM1352l; Mon, 30 Aug 2010 15:38:40 +0200 (CEST)
Received: from sirmione.science-computing.de (sirmione.science-computing.de [10.10.24.2])
	by scmail.science-computing.de (Postfix) with ESMTP id 6B167AC001;
	Mon, 30 Aug 2010 15:38:40 +0200 (CEST)
Received: from sirmione.localnet (localhost [127.0.0.1])
	by sirmione.science-computing.de (Postfix) with ESMTP id 5A50AAE3C9;
	Mon, 30 Aug 2010 15:38:40 +0200 (CEST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.29-0.1-pae; KDE/4.1.3; i686; ; )
In-Reply-To: <201008301536.20414.k.franke@science-computing.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154798>

From: Anselm Kruis <a.kruis@science-computing.de>

Setting this option has the same effect as setting the environment variable
'GIT_ASKPASS'.

Signed-off-by: Knut Franke <k.franke@science-computing.de>
---
 Documentation/config.txt |    6 ++++++
 cache.h                  |    1 +
 config.c                 |    3 +++
 connect.c                |    4 +++-
 environment.c            |    1 +
 5 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 05ec3fe..38678db 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -450,6 +450,12 @@ core.excludesfile::
 	to the value of `$HOME` and "{tilde}user/" to the specified user's
 	home directory.  See linkgit:gitignore[5].
 
+core.askpass::
+	Some commands (e.g. svn and http interfaces) that interactively
+	ask for a password can be told to use an external program given
+	via the value of this variable when it is set, and the
+	environment variable `GIT_ASKPASS` is not set.
+
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
diff --git a/cache.h b/cache.h
index eb77e1d..608d20a 100644
--- a/cache.h
+++ b/cache.h
@@ -1032,6 +1032,7 @@ extern int pager_in_use(void);
 extern int pager_use_color;
 
 extern const char *editor_program;
+extern const char *askpass_program;
 extern const char *excludes_file;
 
 /* base85 */
diff --git a/config.c b/config.c
index cdcf583..ac55730 100644
--- a/config.c
+++ b/config.c
@@ -560,6 +560,9 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
+	if (!strcmp(var, "core.askpass"))
+		return git_config_string(&askpass_program, var, value);
+
 	if (!strcmp(var, "core.excludesfile"))
 		return git_config_pathname(&excludes_file, var, value);
 
diff --git a/connect.c b/connect.c
index 02e738a..e296bfc 100644
--- a/connect.c
+++ b/connect.c
@@ -621,12 +621,14 @@ int finish_connect(struct child_process *conn)
 
 char *git_getpass(const char *prompt)
 {
-	char *askpass;
+	const char *askpass;
 	struct child_process pass;
 	const char *args[3];
 	static struct strbuf buffer = STRBUF_INIT;
 
 	askpass = getenv("GIT_ASKPASS");
+	if (!askpass)
+		askpass = askpass_program;
 
 	if (!askpass || !(*askpass))
 		return getpass(prompt);
diff --git a/environment.c b/environment.c
index 83d38d3..e7760d8 100644
--- a/environment.c
+++ b/environment.c
@@ -37,6 +37,7 @@ size_t delta_base_cache_limit = 16 * 1024 * 1024;
 const char *pager_program;
 int pager_use_color = 1;
 const char *editor_program;
+const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int read_replace_refs = 1;
-- 
1.7.2.1

-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 
