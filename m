From: "Philipp A. Hartmann" <pah@qo.cx>
Subject: [PATCH 5/4 v2] wincred: port to generic credential helper (UNTESTED)
Date: Mon, 27 Aug 2012 00:45:11 +0200
Message-ID: <1346021111-3824-1-git-send-email-pah@qo.cx>
References: <1346018649-3002-1-git-send-email-pah@qo.cx>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Philipp A. Hartmann" <pah@qo.cx>
To: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 00:45:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5laA-0008Lv-0r
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 00:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab2HZWpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 18:45:19 -0400
Received: from offis4.offis.uni-oldenburg.de ([134.106.51.109]:43426 "EHLO
	offis4.offis.uni-oldenburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751174Ab2HZWpS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2012 18:45:18 -0400
Received: by offis4.offis.uni-oldenburg.de (Postfix, from userid 1003)
	id A827B741166; Mon, 27 Aug 2012 00:45:16 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	offis4.offis.uni-oldenburg.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.3.2
X-Spam-DCC: dcc1.aftenposten.no: offis4 1215; Body=2 Fuz1=2 Fuz2=2
X-Spam-score: -1.7 ()
X-Spam-hits: -1.7
Received: from localhost (ritchie.offis.uni-oldenburg.de [134.106.53.254])
	by offis4.offis.uni-oldenburg.de (Postfix) with ESMTP id 9E368741053;
	Mon, 27 Aug 2012 00:45:13 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1346018649-3002-1-git-send-email-pah@qo.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204317>

From: "Philipp A. Hartmann" <pah@qo.cx>

This patch is an experiment to port the wincred helper
to the generic implementation.  As of know, it is
completely untested.

In addition to porting the helper to the generic API,
this patch clears up all passwords from memory, which
reduces the total amount to saved lines.

This version adds the missing xmalloc() implementation.

Signed-off-by: Philipp A. Hartmann <pah@qo.cx>
---

The previous version of the patch somehow lacked the xmalloc
implementation moved to credential_helper.h.  Sorry for the
inconvenience.

Apart from being still untested, this version at least matches
my tree at git://github.com/pah/git-credential-helper.git.

 contrib/credential/helper/credential_helper.c      |   41 ++-
 contrib/credential/helper/credential_helper.h      |   14 +-
 contrib/credential/wincred/.gitignore              |    1 +
 contrib/credential/wincred/Makefile                |   19 +-
 .../credential/wincred/git-credential-wincred.c    |  310 +++++++++-----------
 5 files changed, 210 insertions(+), 175 deletions(-)
 create mode 100644 contrib/credential/wincred/.gitignore

diff --git a/contrib/credential/helper/credential_helper.c b/contrib/credential/helper/credential_helper.c
index e99c2ec..5ddf5a5 100644
--- a/contrib/credential/helper/credential_helper.c
+++ b/contrib/credential/helper/credential_helper.c
@@ -11,6 +11,11 @@
 
 #include <credential_helper.h>
 
+#ifdef WIN32
+#include <fcntl.h>
+#include <io.h>
+#endif
+
 void credential_init(struct credential *c)
 {
 	memset(c, 0, sizeof(*c));
@@ -23,6 +28,7 @@ void credential_clear(struct credential *c)
 	free(c->path);
 	free(c->username);
 	free_password(c->password);
+	free(c->uri);
 
 	credential_init(c);
 }
@@ -79,6 +85,29 @@ int credential_read(struct credential *c)
 		 * learn new lines, and the helpers are updated to match.
 		 */
 	}
+
+	/* Rebuild URI from parts */
+	*buf = '\0';
+	if (c->protocol) {
+		strncat(buf, c->protocol, sizeof(buf));
+		strncat(buf, "://", sizeof(buf));
+	}
+	if (c->username) {
+		strncat(buf, c->username, sizeof(buf));
+		strncat(buf, "@", sizeof(buf));
+	}
+	if (c->host)
+		strncat(buf, c->host, sizeof(buf));
+	if (c->port) {
+		value = buf + strlen(buf);
+		snprintf(value, sizeof(buf)-(value-buf), ":%hd", c->port);
+	}
+	if (c->path) {
+		strncat(buf, "/", sizeof(buf));
+		strncat(buf, c->path, sizeof(buf));
+	}
+	c->uri = xstrdup(buf);
+
 	return 0;
 }
 
@@ -126,6 +155,12 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+#ifdef WIN32
+	/* git on Windows uses binary pipes to avoid CRLF-issues */
+	_setmode(_fileno(stdin), _O_BINARY);
+	_setmode(_fileno(stdout), _O_BINARY);
+#endif
+
 	/* lookup operation callback */
 	while(try_op->name && strcmp(argv[1], try_op->name))
 		try_op++;
@@ -138,11 +173,15 @@ int main(int argc, char *argv[])
 	if(ret)
 		goto out;
 
+	if (!cred.protocol || !(cred.host || cred.path)) {
+		ret = EXIT_FAILURE;
+		goto out;
+	}
+
 	/* perform credential operation */
 	ret = (*try_op->op)(&cred);
 
 	credential_write(&cred);
-
 out:
 	credential_clear(&cred);
 	return ret;
diff --git a/contrib/credential/helper/credential_helper.h b/contrib/credential/helper/credential_helper.h
index 76b6e50..7e73fc6 100644
--- a/contrib/credential/helper/credential_helper.h
+++ b/contrib/credential/helper/credential_helper.h
@@ -25,10 +25,11 @@ struct credential
 	char          *path;
 	char          *username;
 	char          *password;
+	char          *uri;     /* <protocol>://[username@][host[:port]][/path] */
 };
 
 #define CREDENTIAL_INIT \
-  { NULL,NULL,0,NULL,NULL,NULL }
+  { NULL,NULL,0,NULL,NULL,NULL,NULL }
 
 void credential_init(struct credential *c);
 void credential_clear(struct credential *c);
@@ -104,6 +105,17 @@ static inline void die_errno(int err)
 	exit(EXIT_FAILURE);
 }
 
+static inline void *xmalloc(size_t size)
+{
+  void *ret = malloc(size);
+	if (!ret && !size)
+		ret = malloc(1);
+	if (!ret)
+		 die_errno(errno);
+
+	return ret;
+}
+
 static inline char *xstrdup(const char *str)
 {
 	char *ret = strdup(str);
diff --git a/contrib/credential/wincred/.gitignore b/contrib/credential/wincred/.gitignore
new file mode 100644
index 0000000..4780e4e
--- /dev/null
+++ b/contrib/credential/wincred/.gitignore
@@ -0,0 +1 @@
+git-credential-wincred.exe
diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
index bad45ca..ee7a8ef 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -1,4 +1,5 @@
-all: git-credential-wincred.exe
+MAIN:=git-credential-wincred
+all:: $(MAIN)
 
 CC = gcc
 RM = rm -f
@@ -7,8 +8,18 @@ CFLAGS = -O2 -Wall
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
-git-credential-wincred.exe : git-credential-wincred.c
-	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
+HELPER:=../helper
+VPATH +=$(HELPER)
+
+SRCS:=$(MAIN).c
+SRCS+=credential_helper.c
+OBJS:=$(SRCS:.c=.o)
+
+%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) -I$(HELPER) -o $@ -c $<
+
+$(MAIN).exe: $(OBJS)
+	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@
 
 clean:
-	$(RM) git-credential-wincred.exe
+	$(RM) $(MAIN).exe $(OBJS)
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index cbaec5f..721e59f 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -7,37 +7,6 @@
 #include <io.h>
 #include <fcntl.h>
 
-/* common helpers */
-
-static void die(const char *err, ...)
-{
-	char msg[4096];
-	va_list params;
-	va_start(params, err);
-	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s\n", msg);
-	va_end(params);
-	exit(1);
-}
-
-static void *xmalloc(size_t size)
-{
-	void *ret = malloc(size);
-	if (!ret && !size)
-		ret = malloc(1);
-	if (!ret)
-		 die("Out of memory");
-	return ret;
-}
-
-static char *xstrdup(const char *str)
-{
-	char *ret = strdup(str);
-	if (!ret)
-		die("Out of memory");
-	return ret;
-}
-
 /* MinGW doesn't have wincred.h, so we need to define stuff */
 
 typedef struct _CREDENTIAL_ATTRIBUTEW {
@@ -84,13 +53,16 @@ static CredPackAuthenticationBufferWT CredPackAuthenticationBufferW;
 static CredFreeT CredFree;
 static CredDeleteWT CredDeleteW;
 
-static void load_cred_funcs(void)
+
+static int load_cred_funcs(void)
 {
 	/* load DLLs */
 	advapi = LoadLibrary("advapi32.dll");
 	credui = LoadLibrary("credui.dll");
-	if (!advapi || !credui)
-		die("failed to load DLLs");
+	if (!advapi || !credui) {
+		error("failed to load DLLs");
+		return EXIT_FAILURE;
+	}
 
 	/* get function pointers */
 	CredWriteW = (CredWriteWT)GetProcAddress(advapi, "CredWriteW");
@@ -104,28 +76,58 @@ static void load_cred_funcs(void)
 	CredDeleteW = (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
 	if (!CredWriteW || !CredUnPackAuthenticationBufferW ||
 	    !CredEnumerateW || !CredPackAuthenticationBufferW || !CredFree ||
-	    !CredDeleteW)
-		die("failed to load functions");
+	    !CredDeleteW) {
+		error("failed to load functions");
+		return EXIT_FAILURE;
+	}
+	return EXIT_SUCCESS;
 }
 
 static char target_buf[1024];
-static char *protocol, *host, *path, *username;
-static WCHAR *wusername, *password, *target;
+static char port_buf[8];
+static WCHAR *wusername, *wpassword;
 
-static void write_item(const char *what, WCHAR *wbuf)
+static WCHAR *utf8_to_utf16_dup(const char *str)
 {
-	char *buf;
-	int len = WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, NULL, 0, NULL,
-	    FALSE);
-	buf = xmalloc(len);
-
-	if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, buf, len, NULL, FALSE))
-		die("WideCharToMultiByte failed!");
-
-	printf("%s=", what);
-	fwrite(buf, 1, len - 1, stdout);
-	putchar('\n');
-	free(buf);
+	int wlen = MultiByteToWideChar(CP_UTF8, 0, str, -1, NULL, 0);
+	WCHAR *wstr = xmalloc(sizeof(WCHAR) * wlen);
+	if (!MultiByteToWideChar(CP_UTF8, 0, str, -1, wstr, wlen))
+		die("MultiByteToWideChar failed");
+	return wstr;
+}
+
+static char *utf16_to_utf8_dup(const WCHAR *wstr)
+{
+	int len = WideCharToMultiByte(CP_UTF8, 0, wstr, -1, NULL, 0, NULL,
+		FALSE);
+	char *str = xmalloc(len);
+	if (!WideCharToMultiByte(CP_UTF8, 0, wstr, -1, str, len, NULL, FALSE))
+		die("WideCharToMultiByte failed");
+	return str;
+}
+
+static void free_wpassword(WCHAR *pass)
+{
+	WCHAR *w = pass;
+	if(!pass)
+		return;
+	while(*w) *w++ = L'\0';
+	free(pass);
+}
+
+static int prepare_credential(struct credential *c)
+{
+	if (load_cred_funcs() )
+		return EXIT_FAILURE;
+
+	if (c->username)
+		wusername = utf8_to_utf16_dup(c->username);
+	if (c->password)
+		wpassword = utf8_to_utf16_dup(c->password);
+	if (c->port) {
+		snprintf(port_buf,"%hd",c->port);
+	}
+	return EXIT_SUCCESS;
 }
 
 static int match_attr(const CREDENTIALW *cred, const WCHAR *keyword,
@@ -143,24 +145,28 @@ static int match_attr(const CREDENTIALW *cred, const WCHAR *keyword,
 	return 0; /* not found */
 }
 
-static int match_cred(const CREDENTIALW *cred)
+static int match_cred(const CREDENTIALW *cred, const struct credential *c)
 {
 	return (!wusername || !wcscmp(wusername, cred->UserName)) &&
-	    match_attr(cred, L"git_protocol", protocol) &&
-	    match_attr(cred, L"git_host", host) &&
-	    match_attr(cred, L"git_path", path);
+	    match_attr(cred, L"git_protocol", c->protocol) &&
+	    match_attr(cred, L"git_host", c->host) &&
+	    (c->port && match_attr(cred, L"git_port", port_buf)) &&
+	    match_attr(cred, L"git_path", c->path);
 }
 
-static void get_credential(void)
+static int get_credential(struct credential *c)
 {
-	WCHAR *user_buf, *pass_buf;
+	WCHAR *user_buf = NULL, *pass_buf = NULL;
 	DWORD user_buf_size = 0, pass_buf_size = 0;
 	CREDENTIALW **creds, *cred = NULL;
 	DWORD num_creds;
-	int i;
+	int i, ret = EXIT_SUCCESS;
+
+	if (prepare_credential(c))
+		return EXIT_FAILURE;
 
 	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
-		return;
+		return EXIT_FAILURE;
 
 	/* search for the first credential that matches username */
 	for (i = 0; i < num_creds; ++i)
@@ -169,7 +175,7 @@ static void get_credential(void)
 			break;
 		}
 	if (!cred)
-		return;
+		goto out;
 
 	CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
 	    cred->CredentialBlobSize, NULL, &user_buf_size, NULL, NULL,
@@ -180,20 +186,29 @@ static void get_credential(void)
 
 	if (!CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
 	    cred->CredentialBlobSize, user_buf, &user_buf_size, NULL, NULL,
-	    pass_buf, &pass_buf_size))
-		die("CredUnPackAuthenticationBuffer failed");
-
-	CredFree(creds);
+	    pass_buf, &pass_buf_size)) {
+		error("CredUnPackAuthenticationBuffer failed");
+		ret = EXIT_FAILURE;
+		goto out;
+	}
 
 	/* zero-terminate (sizes include zero-termination) */
 	user_buf[user_buf_size - 1] = L'\0';
 	pass_buf[pass_buf_size - 1] = L'\0';
 
-	write_item("username", user_buf);
-	write_item("password", pass_buf);
+	if (!c->username)
+		c->username = utf16_to_utf8_dup(user_buf);
+	free_password(c->password);
+	c->password = utf16_to_utf8_dup(pass_buf);
+
+out:
+	CredFree(creds);
 
 	free(user_buf);
-	free(pass_buf);
+	free(wusername);
+	free_wpassword(pass_buf);
+
+	return ret;
 }
 
 static void write_attr(CREDENTIAL_ATTRIBUTEW *attr, const WCHAR *keyword,
@@ -205,29 +220,42 @@ static void write_attr(CREDENTIAL_ATTRIBUTEW *attr, const WCHAR *keyword,
 	attr->Value = (LPBYTE)value;
 }
 
-static void store_credential(void)
+static int store_credential(struct credential *c)
 {
 	CREDENTIALW cred;
 	BYTE *auth_buf;
 	DWORD auth_buf_size = 0;
 	CREDENTIAL_ATTRIBUTEW attrs[CRED_MAX_ATTRIBUTES];
+	WCHAR *wtarget;
+	int ret = EXIT_SUCCESS;
 
-	if (!wusername || !password)
-		return;
+	if (prepare_credential(c))
+		return EXIT_FAILURE;
+
+	/* prepare 'target', the unique key for the credential */
+	strncat(target_buf,"git:",sizeof(target_buf));
+	strncat(target_buf,c->uri,sizeof(target_buf));
+	wtarget = utf8_to_utf16_dup(target_buf);
+
+	if (!wusername || !wpassword)
+		return EXIT_FAILURE;
 
 	/* query buffer size */
-	CredPackAuthenticationBufferW(0, wusername, password,
+	CredPackAuthenticationBufferW(0, wusername, wpassword,
 	    NULL, &auth_buf_size);
 
 	auth_buf = xmalloc(auth_buf_size);
 
-	if (!CredPackAuthenticationBufferW(0, wusername, password,
-	    auth_buf, &auth_buf_size))
-		die("CredPackAuthenticationBuffer failed");
+	if (!CredPackAuthenticationBufferW(0, wusername, wpassword,
+	    auth_buf, &auth_buf_size)) {
+		error("CredPackAuthenticationBuffer failed");
+		ret = EXIT_FAILURE;
+		goto out;
+	}
 
 	cred.Flags = 0;
 	cred.Type = CRED_TYPE_GENERIC;
-	cred.TargetName = target;
+	cred.TargetName = wtarget;
 	cred.Comment = L"saved by git-credential-wincred";
 	cred.CredentialBlobSize = auth_buf_size;
 	cred.CredentialBlob = auth_buf;
@@ -237,121 +265,65 @@ static void store_credential(void)
 	cred.TargetAlias = NULL;
 	cred.UserName = wusername;
 
-	write_attr(attrs, L"git_protocol", protocol);
+	write_attr(attrs, L"git_protocol", c->protocol);
 
-	if (host) {
-		write_attr(attrs + cred.AttributeCount, L"git_host", host);
+	if (c->host) {
+		write_attr(attrs + cred.AttributeCount, L"git_host", c->host);
 		cred.AttributeCount++;
 	}
 
-	if (path) {
-		write_attr(attrs + cred.AttributeCount, L"git_path", path);
+	if (c->port) {
+		write_attr(attrs + cred.AttributeCount, L"git_port", port_buf);
 		cred.AttributeCount++;
 	}
 
-	if (!CredWriteW(&cred, 0))
-		die("CredWrite failed");
+	if (c->path) {
+		write_attr(attrs + cred.AttributeCount, L"git_path", c->path);
+		cred.AttributeCount++;
+	}
+
+	if (!CredWriteW(&cred, 0)) {
+		error("CredWrite failed");
+		ret = EXIT_FAILURE;
+	}
+
+out:
+	free(auth_buf);
+	free(wusername);
+	free_wpassword(wpassword);
+	free(wtarget);
+	return ret;
 }
 
-static void erase_credential(void)
+static int erase_credential(struct credential *c)
 {
 	CREDENTIALW **creds;
 	DWORD num_creds;
 	int i;
 
+	if (prepare_credential(c))
+		return EXIT_FAILURE;
+
 	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
-		return;
+		return EXIT_FAILURE;
 
 	for (i = 0; i < num_creds; ++i) {
-		if (match_cred(creds[i]))
+		if (match_cred(creds[i],c))
 			CredDeleteW(creds[i]->TargetName, creds[i]->Type, 0);
 	}
 
 	CredFree(creds);
+	return EXIT_SUCCESS;
 }
 
-static WCHAR *utf8_to_utf16_dup(const char *str)
-{
-	int wlen = MultiByteToWideChar(CP_UTF8, 0, str, -1, NULL, 0);
-	WCHAR *wstr = xmalloc(sizeof(WCHAR) * wlen);
-	MultiByteToWideChar(CP_UTF8, 0, str, -1, wstr, wlen);
-	return wstr;
-}
-
-static void read_credential(void)
-{
-	char buf[1024];
-
-	while (fgets(buf, sizeof(buf), stdin)) {
-		char *v;
-
-		if (!strcmp(buf, "\n"))
-			break;
-		buf[strlen(buf)-1] = '\0';
-
-		v = strchr(buf, '=');
-		if (!v)
-			die("bad input: %s", buf);
-		*v++ = '\0';
-
-		if (!strcmp(buf, "protocol"))
-			protocol = xstrdup(v);
-		else if (!strcmp(buf, "host"))
-			host = xstrdup(v);
-		else if (!strcmp(buf, "path"))
-			path = xstrdup(v);
-		else if (!strcmp(buf, "username")) {
-			username = xstrdup(v);
-			wusername = utf8_to_utf16_dup(v);
-		} else if (!strcmp(buf, "password"))
-			password = utf8_to_utf16_dup(v);
-		else
-			die("unrecognized input");
-	}
-}
-
-int main(int argc, char *argv[])
+/*
+ * Table with helper operation callbacks, used by generic
+ * credential helper main function.
+ */
+struct credential_operation const credential_helper_ops[] =
 {
-	const char *usage =
-	    "Usage: git credential-wincred <get|store|erase>\n";
-
-	if (!argv[1])
-		die(usage);
-
-	/* git use binary pipes to avoid CRLF-issues */
-	_setmode(_fileno(stdin), _O_BINARY);
-	_setmode(_fileno(stdout), _O_BINARY);
-
-	read_credential();
-
-	load_cred_funcs();
-
-	if (!protocol || !(host || path))
-		return 0;
-
-	/* prepare 'target', the unique key for the credential */
-	strncat(target_buf, "git:", sizeof(target_buf));
-	strncat(target_buf, protocol, sizeof(target_buf));
-	strncat(target_buf, "://", sizeof(target_buf));
-	if (username) {
-		strncat(target_buf, username, sizeof(target_buf));
-		strncat(target_buf, "@", sizeof(target_buf));
-	}
-	if (host)
-		strncat(target_buf, host, sizeof(target_buf));
-	if (path) {
-		strncat(target_buf, "/", sizeof(target_buf));
-		strncat(target_buf, path, sizeof(target_buf));
-	}
-
-	target = utf8_to_utf16_dup(target_buf);
-
-	if (!strcmp(argv[1], "get"))
-		get_credential();
-	else if (!strcmp(argv[1], "store"))
-		store_credential();
-	else if (!strcmp(argv[1], "erase"))
-		erase_credential();
-	/* otherwise, ignore unknown action */
-	return 0;
-}
+	{ "get",   get_credential   },
+	{ "store", store_credential },
+	{ "erase", erase_credential },
+	CREDENTIAL_OP_END
+};
-- 
1.7.10.4
