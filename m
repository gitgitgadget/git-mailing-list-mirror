From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 9/10] Remove cmd_usage() routine and re-organize the help/usage code.
Date: Wed, 2 Aug 2006 02:03:44 +0100
Message-ID: <00c201c6b5cf$8089a580$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00C3_01C6B5D7.E24E0D80"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8595-00073c-B0
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWHBBD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWHBBD3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:03:29 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:62473 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750917AbWHBBD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:03:28 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858u-000C1I-HM
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:03:27 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24629>

This is a multi-part message in MIME format.

------=_NextPart_000_00C3_01C6B5D7.E24E0D80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The cmd_usage() routine was causing warning messages due to a NULL
format parameter being passed in three out of four calls. This is a
problem if you want to compile with -Werror. A simple solution is to
simply remove the GNU __attribute__ format pragma from the cmd_usage()
declaration in the header file. The function interface was somewhat
muddled anyway, so re-write the code to finesse the problem.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin-help.c |   54
+++++++++++++++++++++++-------------------------------
 builtin.h      |    7 ++-----
 git.c          |    7 +++++--
 3 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index 7470faa..006da05 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -9,8 +9,6 @@ #include "builtin.h"
 #include "exec_cmd.h"
 #include "common-cmds.h"

-static const char git_usage[] =
-	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND
 ARGS ]";

 /* most gui terms set COLUMNS (although some don't export it) */
 static int term_columns(void)
@@ -178,31 +176,6 @@ static void list_common_cmds_help(void)
 	puts("(use 'git help -a' to get a list of all installed git commands)");
 }

-void cmd_usage(int show_all, const char *exec_path, const char *fmt, ...)
-{
-	if (fmt) {
-		va_list ap;
-
-		va_start(ap, fmt);
-		printf("git: ");
-		vprintf(fmt, ap);
-		va_end(ap);
-		putchar('\n');
-	}
-	else
-		puts(git_usage);
-
-	if (exec_path) {
-		putchar('\n');
-		if (show_all)
-			list_commands(exec_path, "git-*");
-		else
-			list_common_cmds_help();
-        }
-
-	exit(1);
-}
-
 static void show_man_page(const char *git_cmd)
 {
 	const char *page;
@@ -221,6 +194,13 @@ static void show_man_page(const char *gi
 	execlp("man", "man", page, NULL);
 }

+void help_unknown_cmd(const char *cmd)
+{
+	printf("git: '%s' is not a git-command\n\n", cmd);
+	list_common_cmds_help();
+	exit(1);
+}
+
 int cmd_version(int argc, const char **argv, char **envp)
 {
 	printf("git version %s\n", git_version_string);
@@ -230,12 +210,24 @@ int cmd_version(int argc, const char **a
 int cmd_help(int argc, const char **argv, char **envp)
 {
 	const char *help_cmd = argv[1];
-	if (!help_cmd)
-		cmd_usage(0, git_exec_path(), NULL);
-	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a"))
-		cmd_usage(1, git_exec_path(), NULL);
+	const char *exec_path = git_exec_path();
+
+	if (!help_cmd) {
+		printf("usage: %s\n\n", git_usage_string);
+		list_common_cmds_help();
+		exit(1);
+	}
+
+	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
+		printf("usage: %s\n\n", git_usage_string);
+		if(exec_path)
+			list_commands(exec_path, "git-*");
+		exit(1);
+	}
+
 	else
 		show_man_page(help_cmd);
+
 	return 0;
 }

diff --git a/builtin.h b/builtin.h
index 7bfff11..b6cf5be 100644
--- a/builtin.h
+++ b/builtin.h
@@ -5,12 +5,9 @@ #include <stdio.h>
 #include <limits.h>

 extern const char git_version_string[];
+extern const char git_usage_string[];

-void cmd_usage(int show_all, const char *exec_path, const char *fmt, ...)
-#ifdef __GNUC__
-	__attribute__((__format__(__printf__, 3, 4), __noreturn__))
-#endif
-	;
+extern void help_unknown_cmd(const char *cmd);

 extern int cmd_help(int argc, const char **argv, char **envp);
 extern int cmd_version(int argc, const char **argv, char **envp);
diff --git a/git.c b/git.c
index ca8961f..f414df9 100644
--- a/git.c
+++ b/git.c
@@ -14,6 +14,9 @@ #include "cache.h"

 #include "builtin.h"

+const char git_usage_string[] =
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
+
 static void prepend_to_path(const char *dir, int len)
 {
 	const char *old_path = getenv("PATH");
@@ -279,7 +282,7 @@ int main(int argc, const char **argv, ch
 			puts(git_exec_path());
 			exit(0);
 		}
-		cmd_usage(0, NULL, NULL);
+		usage(git_usage_string);
 	}
 	argv[0] = cmd;

@@ -312,7 +315,7 @@ int main(int argc, const char **argv, ch
 	}

 	if (errno == ENOENT)
-		cmd_usage(0, exec_path, "'%s' is not a git-command", cmd);
+		help_unknown_cmd(cmd);

 	fprintf(stderr, "Failed to run command '%s': %s\n",
 		cmd, strerror(errno));
--
1.4.1

------=_NextPart_000_00C3_01C6B5D7.E24E0D80
Content-Type: text/plain;
	name="P0009.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0009.TXT"

RnJvbSAxY2U0MmUyYjViNjViMDM2NTdiM2NhOWEzYjA2ZGM5N2NjNjY1NzNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTdW4sIDMwIEp1bCAyMDA2IDIyOjQyOjI1ICswMTAwClN1YmplY3Q6
IFtQQVRDSCA5LzEwXSBSZW1vdmUgY21kX3VzYWdlKCkgcm91dGluZSBhbmQgcmUtb3JnYW5pemUg
dGhlIGhlbHAvdXNhZ2UgY29kZS4KClRoZSBjbWRfdXNhZ2UoKSByb3V0aW5lIHdhcyBjYXVzaW5n
IHdhcm5pbmcgbWVzc2FnZXMgZHVlIHRvIGEgTlVMTApmb3JtYXQgcGFyYW1ldGVyIGJlaW5nIHBh
c3NlZCBpbiB0aHJlZSBvdXQgb2YgZm91ciBjYWxscy4gVGhpcyBpcyBhCnByb2JsZW0gaWYgeW91
IHdhbnQgdG8gY29tcGlsZSB3aXRoIC1XZXJyb3IuIEEgc2ltcGxlIHNvbHV0aW9uIGlzIHRvCnNp
bXBseSByZW1vdmUgdGhlIEdOVSBfX2F0dHJpYnV0ZV9fIGZvcm1hdCBwcmFnbWEgZnJvbSB0aGUg
Y21kX3VzYWdlKCkKZGVjbGFyYXRpb24gaW4gdGhlIGhlYWRlciBmaWxlLiBUaGUgZnVuY3Rpb24g
aW50ZXJmYWNlIHdhcyBzb21ld2hhdAptdWRkbGVkIGFueXdheSwgc28gcmUtd3JpdGUgdGhlIGNv
ZGUgdG8gZmluZXNzZSB0aGUgcHJvYmxlbS4KClNpZ25lZC1vZmYtYnk6IFJhbXNheSBBbGxhbiBK
b25lcyA8cmFtc2F5QHJhbXNheTEuZGVtb24uY28udWs+Ci0tLQogYnVpbHRpbi1oZWxwLmMgfCAg
IDU0ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogYnVpbHRpbi5oICAgICAgfCAgICA3ICsrLS0tLS0KIGdpdC5jICAgICAgICAgIHwgICAgNyAr
KysrKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4taGVscC5jIGIvYnVpbHRpbi1oZWxwLmMKaW5kZXggNzQ3
MGZhYS4uMDA2ZGEwNSAxMDA2NDQKLS0tIGEvYnVpbHRpbi1oZWxwLmMKKysrIGIvYnVpbHRpbi1o
ZWxwLmMKQEAgLTksOCArOSw2IEBAICNpbmNsdWRlICJidWlsdGluLmgiCiAjaW5jbHVkZSAiZXhl
Y19jbWQuaCIKICNpbmNsdWRlICJjb21tb24tY21kcy5oIgogCi1zdGF0aWMgY29uc3QgY2hhciBn
aXRfdXNhZ2VbXSA9Ci0JIlVzYWdlOiBnaXQgWy0tdmVyc2lvbl0gWy0tZXhlYy1wYXRoWz1HSVRf
RVhFQ19QQVRIXV0gWy0taGVscF0gQ09NTUFORCBbIEFSR1MgXSI7CiAKIC8qIG1vc3QgZ3VpIHRl
cm1zIHNldCBDT0xVTU5TIChhbHRob3VnaCBzb21lIGRvbid0IGV4cG9ydCBpdCkgKi8KIHN0YXRp
YyBpbnQgdGVybV9jb2x1bW5zKHZvaWQpCkBAIC0xNzgsMzEgKzE3Niw2IEBAIHN0YXRpYyB2b2lk
IGxpc3RfY29tbW9uX2NtZHNfaGVscCh2b2lkKQogCXB1dHMoIih1c2UgJ2dpdCBoZWxwIC1hJyB0
byBnZXQgYSBsaXN0IG9mIGFsbCBpbnN0YWxsZWQgZ2l0IGNvbW1hbmRzKSIpOwogfQogCi12b2lk
IGNtZF91c2FnZShpbnQgc2hvd19hbGwsIGNvbnN0IGNoYXIgKmV4ZWNfcGF0aCwgY29uc3QgY2hh
ciAqZm10LCAuLi4pCi17Ci0JaWYgKGZtdCkgewotCQl2YV9saXN0IGFwOwotCi0JCXZhX3N0YXJ0
KGFwLCBmbXQpOwotCQlwcmludGYoImdpdDogIik7Ci0JCXZwcmludGYoZm10LCBhcCk7Ci0JCXZh
X2VuZChhcCk7Ci0JCXB1dGNoYXIoJ1xuJyk7Ci0JfQotCWVsc2UKLQkJcHV0cyhnaXRfdXNhZ2Up
OwotCi0JaWYgKGV4ZWNfcGF0aCkgewotCQlwdXRjaGFyKCdcbicpOwotCQlpZiAoc2hvd19hbGwp
Ci0JCQlsaXN0X2NvbW1hbmRzKGV4ZWNfcGF0aCwgImdpdC0qIik7Ci0JCWVsc2UKLQkJCWxpc3Rf
Y29tbW9uX2NtZHNfaGVscCgpOwotICAgICAgICB9Ci0KLQlleGl0KDEpOwotfQotCiBzdGF0aWMg
dm9pZCBzaG93X21hbl9wYWdlKGNvbnN0IGNoYXIgKmdpdF9jbWQpCiB7CiAJY29uc3QgY2hhciAq
cGFnZTsKQEAgLTIyMSw2ICsxOTQsMTMgQEAgc3RhdGljIHZvaWQgc2hvd19tYW5fcGFnZShjb25z
dCBjaGFyICpnaQogCWV4ZWNscCgibWFuIiwgIm1hbiIsIHBhZ2UsIE5VTEwpOwogfQogCit2b2lk
IGhlbHBfdW5rbm93bl9jbWQoY29uc3QgY2hhciAqY21kKQoreworCXByaW50ZigiZ2l0OiAnJXMn
IGlzIG5vdCBhIGdpdC1jb21tYW5kXG5cbiIsIGNtZCk7CisJbGlzdF9jb21tb25fY21kc19oZWxw
KCk7CisJZXhpdCgxKTsKK30KKwogaW50IGNtZF92ZXJzaW9uKGludCBhcmdjLCBjb25zdCBjaGFy
ICoqYXJndiwgY2hhciAqKmVudnApCiB7CiAJcHJpbnRmKCJnaXQgdmVyc2lvbiAlc1xuIiwgZ2l0
X3ZlcnNpb25fc3RyaW5nKTsKQEAgLTIzMCwxMiArMjEwLDI0IEBAIGludCBjbWRfdmVyc2lvbihp
bnQgYXJnYywgY29uc3QgY2hhciAqKmEKIGludCBjbWRfaGVscChpbnQgYXJnYywgY29uc3QgY2hh
ciAqKmFyZ3YsIGNoYXIgKiplbnZwKQogewogCWNvbnN0IGNoYXIgKmhlbHBfY21kID0gYXJndlsx
XTsKLQlpZiAoIWhlbHBfY21kKQotCQljbWRfdXNhZ2UoMCwgZ2l0X2V4ZWNfcGF0aCgpLCBOVUxM
KTsKLQllbHNlIGlmICghc3RyY21wKGhlbHBfY21kLCAiLS1hbGwiKSB8fCAhc3RyY21wKGhlbHBf
Y21kLCAiLWEiKSkKLQkJY21kX3VzYWdlKDEsIGdpdF9leGVjX3BhdGgoKSwgTlVMTCk7CisJY29u
c3QgY2hhciAqZXhlY19wYXRoID0gZ2l0X2V4ZWNfcGF0aCgpOworCisJaWYgKCFoZWxwX2NtZCkg
eworCQlwcmludGYoInVzYWdlOiAlc1xuXG4iLCBnaXRfdXNhZ2Vfc3RyaW5nKTsKKwkJbGlzdF9j
b21tb25fY21kc19oZWxwKCk7CisJCWV4aXQoMSk7CisJfQorCisJZWxzZSBpZiAoIXN0cmNtcCho
ZWxwX2NtZCwgIi0tYWxsIikgfHwgIXN0cmNtcChoZWxwX2NtZCwgIi1hIikpIHsKKwkJcHJpbnRm
KCJ1c2FnZTogJXNcblxuIiwgZ2l0X3VzYWdlX3N0cmluZyk7CisJCWlmKGV4ZWNfcGF0aCkKKwkJ
CWxpc3RfY29tbWFuZHMoZXhlY19wYXRoLCAiZ2l0LSoiKTsKKwkJZXhpdCgxKTsKKwl9CisKIAll
bHNlCiAJCXNob3dfbWFuX3BhZ2UoaGVscF9jbWQpOworCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAt
LWdpdCBhL2J1aWx0aW4uaCBiL2J1aWx0aW4uaAppbmRleCA3YmZmZjExLi5iNmNmNWJlIDEwMDY0
NAotLS0gYS9idWlsdGluLmgKKysrIGIvYnVpbHRpbi5oCkBAIC01LDEyICs1LDkgQEAgI2luY2x1
ZGUgPHN0ZGlvLmg+CiAjaW5jbHVkZSA8bGltaXRzLmg+CiAKIGV4dGVybiBjb25zdCBjaGFyIGdp
dF92ZXJzaW9uX3N0cmluZ1tdOworZXh0ZXJuIGNvbnN0IGNoYXIgZ2l0X3VzYWdlX3N0cmluZ1td
OwogCi12b2lkIGNtZF91c2FnZShpbnQgc2hvd19hbGwsIGNvbnN0IGNoYXIgKmV4ZWNfcGF0aCwg
Y29uc3QgY2hhciAqZm10LCAuLi4pCi0jaWZkZWYgX19HTlVDX18KLQlfX2F0dHJpYnV0ZV9fKChf
X2Zvcm1hdF9fKF9fcHJpbnRmX18sIDMsIDQpLCBfX25vcmV0dXJuX18pKQotI2VuZGlmCi0JOwor
ZXh0ZXJuIHZvaWQgaGVscF91bmtub3duX2NtZChjb25zdCBjaGFyICpjbWQpOwogCiBleHRlcm4g
aW50IGNtZF9oZWxwKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY2hhciAqKmVudnApOwog
ZXh0ZXJuIGludCBjbWRfdmVyc2lvbihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNoYXIg
KiplbnZwKTsKZGlmZiAtLWdpdCBhL2dpdC5jIGIvZ2l0LmMKaW5kZXggY2E4OTYxZi4uZjQxNGRm
OSAxMDA2NDQKLS0tIGEvZ2l0LmMKKysrIGIvZ2l0LmMKQEAgLTE0LDYgKzE0LDkgQEAgI2luY2x1
ZGUgImNhY2hlLmgiCiAKICNpbmNsdWRlICJidWlsdGluLmgiCiAKK2NvbnN0IGNoYXIgZ2l0X3Vz
YWdlX3N0cmluZ1tdID0KKwkiZ2l0IFstLXZlcnNpb25dIFstLWV4ZWMtcGF0aFs9R0lUX0VYRUNf
UEFUSF1dIFstLWhlbHBdIENPTU1BTkQgWyBBUkdTIF0iOworCiBzdGF0aWMgdm9pZCBwcmVwZW5k
X3RvX3BhdGgoY29uc3QgY2hhciAqZGlyLCBpbnQgbGVuKQogewogCWNvbnN0IGNoYXIgKm9sZF9w
YXRoID0gZ2V0ZW52KCJQQVRIIik7CkBAIC0yNzksNyArMjgyLDcgQEAgaW50IG1haW4oaW50IGFy
Z2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjaAogCQkJcHV0cyhnaXRfZXhlY19wYXRoKCkpOwogCQkJ
ZXhpdCgwKTsKIAkJfQotCQljbWRfdXNhZ2UoMCwgTlVMTCwgTlVMTCk7CisJCXVzYWdlKGdpdF91
c2FnZV9zdHJpbmcpOwogCX0KIAlhcmd2WzBdID0gY21kOwogCkBAIC0zMTIsNyArMzE1LDcgQEAg
aW50IG1haW4oaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjaAogCX0KIAogCWlmIChlcnJu
byA9PSBFTk9FTlQpCi0JCWNtZF91c2FnZSgwLCBleGVjX3BhdGgsICInJXMnIGlzIG5vdCBhIGdp
dC1jb21tYW5kIiwgY21kKTsKKwkJaGVscF91bmtub3duX2NtZChjbWQpOwogCiAJZnByaW50Zihz
dGRlcnIsICJGYWlsZWQgdG8gcnVuIGNvbW1hbmQgJyVzJzogJXNcbiIsCiAJCWNtZCwgc3RyZXJy
b3IoZXJybm8pKTsKLS0gCjEuNC4xCgo=

------=_NextPart_000_00C3_01C6B5D7.E24E0D80--
