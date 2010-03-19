From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow passing of configuration parameters in the command line
Date: Fri, 19 Mar 2010 15:42:09 +0100
Message-ID: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151743f7b623012a0482285afb
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsdP3-0002En-6r
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab0CSOmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 10:42:13 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:39378 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab0CSOmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 10:42:11 -0400
Received: by bwz1 with SMTP id 1so92172bwz.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=mhfAJFgnP4S+rxxfQIcFaguEdv5XVUoT9KUv9nxUr1Y=;
        b=E6p31K1vLJU9LkWYjNVr9Xp7x6ub5o56hwdAysztD4NEynll8/M2X0y+ilYKcSpEuX
         XokhFa6rxfNiH9vcHiJ4ocnNTgVVwTIVD0BNZsX8QbGsUAq+LrQBOdiSoRUISte6v8kU
         cDEATztqxR/VCYf865gmCa64OJeHMsSzbpvBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=VD8xG6ayR8QUOcXD77O/XiqJDtv/8mnXZXas7DBRsGZzSAQi9k8hqFxWIwMrnUWm0j
         uzuW7V7bPciU5cf4J4guPUvC9xXS+fEzU9mWBYi0nfZYZSP0lem58pcGDniW0wzBX6PD
         wetWg/f3rtERSaqqaw/UsSFMS9cK1JCbYJ/3U=
Received: by 10.204.156.199 with SMTP id y7mr285114bkw.108.1269009729388; Fri, 
	19 Mar 2010 07:42:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142606>

--00151743f7b623012a0482285afb
Content-Type: text/plain; charset=UTF-8

The values passed this way will override whatever is defined
in the config files.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Someone wanted to have this once. I accidentally remembered
that when I wanted to temporarily set some config parameter
(format.suffix?). From looking at code it seemed simple enough,
so I did it.

I have to say that the feature is not very friendly: there are
some values in .git/config which may not like to be changed
(like core.fileMode, ...ignoreCase or ...repositoryFormatVersion).

 Documentation/git.txt  |    7 +++++
 builtin/config.c       |    6 +++-
 cache.h                |    2 +
 config.c               |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
 git.c                  |    9 ++++++
 t/t1300-repo-config.sh |    7 +++++
 6 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 35c0c79..755fa4d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]
     [-p|--paginate|--no-pager] [--no-replace-objects]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
+    [-c name=value]
     [--help] COMMAND [ARGS]

 DESCRIPTION
@@ -219,6 +220,12 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.

+-c <name>=<value>::
+	Pass a configuration parameter to the command. The value
+	given will override values from configuration files.
+	The <name> is expected in the same format as listed by
+	'git config' (subkeys separated by dots).
+
 --exec-path::
 	Path to wherever your core git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
diff --git a/builtin/config.c b/builtin/config.c
index 4bc46b1..f3d1660 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -197,7 +197,11 @@ static int get_value(const char *key_, const char *regex_)
 		git_config_from_file(show_config, system_wide, NULL);
 	if (do_all && global)
 		git_config_from_file(show_config, global, NULL);
-	git_config_from_file(show_config, local, NULL);
+	if (do_all)
+		git_config_from_file(show_config, local, NULL);
+	git_config_from_parameters(show_config, NULL);
+	if (!do_all && !seen)
+		git_config_from_file(show_config, local, NULL);
 	if (!do_all && !seen && global)
 		git_config_from_file(show_config, global, NULL);
 	if (!do_all && !seen && system_wide)
diff --git a/cache.h b/cache.h
index 89f6a40..4a0c75d 100644
--- a/cache.h
+++ b/cache.h
@@ -932,6 +932,8 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_parse_parameter(const char *text);
+extern int git_config_from_parameters();
 extern int git_config(config_fn_t fn, void *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 6963fbe..2376ae9 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,62 @@ static int zlib_compression_seen;

 const char *config_exclusive_filename = NULL;

+struct config_item
+{
+	struct config_item *next;
+	char *value;
+	char name[1];
+};
+static struct config_item *config_parameters;
+static struct config_item **config_parametes_tail = &config_parameters;
+
+static void lowercase(char *p)
+{
+	for (; *p; ++p)
+		*p = tolower(*p);
+}
+static char *skip_space(const char *p)
+{
+	for (; *p; ++p)
+		if (!isspace(*p))
+			break;
+	return (char *)p;
+}
+static char *trailing_space(const char *begin, const char *p)
+{
+	while (p-- > begin)
+		if (!isspace(*p))
+			break;
+	return (char *)p + 1;
+}
+
+int git_config_parse_parameter(const char *text)
+{
+	struct config_item *ct;
+	const char *name;
+	const char *val;
+	name = skip_space(text);
+	text = val = strchr(name, '=');
+	if (!text)
+		text = name + strlen(name);
+	text = trailing_space(name, text);
+	if (text <= name)
+		return -1;
+	ct = calloc(1, sizeof(struct config_item) + (text - name));
+	memcpy(ct->name, name, text - name);
+	lowercase(ct->name);
+	if (!val)
+		ct->value = NULL;
+	else {
+		val = skip_space(++val /* skip "=" */);
+		text = trailing_space(val, val + strlen(val));
+		ct->value = strndup(val, text - val);
+	}
+	*config_parametes_tail = ct;
+	config_parametes_tail = &ct->next;
+	return 0;
+}
+
 static int get_next_char(void)
 {
 	int c;
@@ -699,6 +755,15 @@ int git_config_global(void)
 	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
 }

+int git_config_from_parameters(config_fn_t fn, void *data)
+{
+	const struct config_item *ct;
+	for (ct = config_parameters; ct; ct = ct->next)
+		if (fn(ct->name, ct->value, data) < 0)
+			return -1;
+	return 0;
+}
+
 int git_config(config_fn_t fn, void *data)
 {
 	int ret = 0, found = 0;
@@ -730,6 +795,12 @@ int git_config(config_fn_t fn, void *data)
 		found += 1;
 	}
 	free(repo_config);
+
+	if (config_parameters) {
+		ret += git_config_from_parameters(fn, data);
+		found += 1;
+	}
+
 	if (found == 0)
 		return -1;
 	return ret;
diff --git a/git.c b/git.c
index 6bae305..99f0363 100644
--- a/git.c
+++ b/git.c
@@ -8,6 +8,7 @@ const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects]\n"
 	"           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]\n"
+	"           [-c name=value\n"
 	"           [--help] COMMAND [ARGS]";

 const char git_more_info_string[] =
@@ -130,6 +131,14 @@ static int handle_options(const char ***argv, int
*argc, int *envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "-c")) {
+			if (*argc < 2) {
+				fprintf(stderr, "-c expects a configuration string\n" );
+				usage(git_usage_string);
+			}
+			git_config_parse_parameter((*argv)[1]);
+			(*argv)++;
+			(*argc)--;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f11f98c..d7c5501 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -824,4 +824,11 @@ test_expect_success 'check split_cmdline return' "
 	test_must_fail git merge master
 	"

+test_expect_success 'git -c "key=value" support' '
+	test "z$(git -c name=value config name)" = zvalue &&
+	test "z$(git -c core.name=value config core.name)" = zvalue &&
+	test "z$(git -c flag config --bool flag)" = ztrue &&
+	test_must_fail git -c core.name=value config name
+'
+
 test_done
-- 
1.7.0.2.318.g49250

--00151743f7b623012a0482285afb
Content-Type: application/octet-stream; 
	name="0001-Allow-passing-of-configuration-parameters-in-the-comm.diff"
Content-Disposition: attachment; 
	filename="0001-Allow-passing-of-configuration-parameters-in-the-comm.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6z3ecoh0

RnJvbSA5OWZlYmYwODU4ZmRlMTQ5MDA5Y2ZmN2QwMzFmMjI5ZWZmOGE5MmUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBGcmksIDE5IE1hciAyMDEwIDE1OjE5OjI0ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQWxsb3cg
cGFzc2luZyBvZiBjb25maWd1cmF0aW9uIHBhcmFtZXRlcnMgaW4gdGhlIGNvbW1hbmQgbGluZQoK
VGhlIHZhbHVlcyBwYXNzZWQgdGhpcyB3YXkgd2lsbCBvdmVycmlkZSB3aGF0ZXZlciBpcyBkZWZp
bmVkCmluIHRoZSBjb25maWcgZmlsZXMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFh
LmxrbWxAZ21haWwuY29tPgotLS0KIERvY3VtZW50YXRpb24vZ2l0LnR4dCAgfCAgICA3ICsrKysr
CiBidWlsdGluL2NvbmZpZy5jICAgICAgIHwgICAgNiArKystCiBjYWNoZS5oICAgICAgICAgICAg
ICAgIHwgICAgMiArCiBjb25maWcuYyAgICAgICAgICAgICAgIHwgICA3MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGdpdC5jICAgICAgICAgICAgICAg
ICAgfCAgICA5ICsrKysrKwogdC90MTMwMC1yZXBvLWNvbmZpZy5zaCB8ICAgIDcgKysrKysKIDYg
ZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9naXQudHh0IGIvRG9jdW1lbnRhdGlvbi9naXQudHh0CmluZGV4
IDM1YzBjNzkuLjc1NWZhNGQgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZ2l0LnR4dAorKysg
Yi9Eb2N1bWVudGF0aW9uL2dpdC50eHQKQEAgLTEyLDYgKzEyLDcgQEAgU1lOT1BTSVMKICdnaXQn
IFstLXZlcnNpb25dIFstLWV4ZWMtcGF0aFs9R0lUX0VYRUNfUEFUSF1dIFstLWh0bWwtcGF0aF0K
ICAgICBbLXB8LS1wYWdpbmF0ZXwtLW5vLXBhZ2VyXSBbLS1uby1yZXBsYWNlLW9iamVjdHNdCiAg
ICAgWy0tYmFyZV0gWy0tZ2l0LWRpcj1HSVRfRElSXSBbLS13b3JrLXRyZWU9R0lUX1dPUktfVFJF
RV0KKyAgICBbLWMgbmFtZT12YWx1ZV0KICAgICBbLS1oZWxwXSBDT01NQU5EIFtBUkdTXQogCiBE
RVNDUklQVElPTgpAQCAtMjE5LDYgKzIyMCwxMiBAQCBkaXNwbGF5ZWQuIFNlZSBsaW5rZ2l0Omdp
dC1oZWxwWzFdIGZvciBtb3JlIGluZm9ybWF0aW9uLAogYmVjYXVzZSBgZ2l0IC0taGVscCAuLi5g
IGlzIGNvbnZlcnRlZCBpbnRlcm5hbGx5IGludG8gYGdpdAogaGVscCAuLi5gLgogCistYyA8bmFt
ZT49PHZhbHVlPjo6CisJUGFzcyBhIGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVyIHRvIHRoZSBjb21t
YW5kLiBUaGUgdmFsdWUKKwlnaXZlbiB3aWxsIG92ZXJyaWRlIHZhbHVlcyBmcm9tIGNvbmZpZ3Vy
YXRpb24gZmlsZXMuCisJVGhlIDxuYW1lPiBpcyBleHBlY3RlZCBpbiB0aGUgc2FtZSBmb3JtYXQg
YXMgbGlzdGVkIGJ5CisJJ2dpdCBjb25maWcnIChzdWJrZXlzIHNlcGFyYXRlZCBieSBkb3RzKS4K
KwogLS1leGVjLXBhdGg6OgogCVBhdGggdG8gd2hlcmV2ZXIgeW91ciBjb3JlIGdpdCBwcm9ncmFt
cyBhcmUgaW5zdGFsbGVkLgogCVRoaXMgY2FuIGFsc28gYmUgY29udHJvbGxlZCBieSBzZXR0aW5n
IHRoZSBHSVRfRVhFQ19QQVRICmRpZmYgLS1naXQgYS9idWlsdGluL2NvbmZpZy5jIGIvYnVpbHRp
bi9jb25maWcuYwppbmRleCA0YmM0NmIxLi5mM2QxNjYwIDEwMDY0NAotLS0gYS9idWlsdGluL2Nv
bmZpZy5jCisrKyBiL2J1aWx0aW4vY29uZmlnLmMKQEAgLTE5Nyw3ICsxOTcsMTEgQEAgc3RhdGlj
IGludCBnZXRfdmFsdWUoY29uc3QgY2hhciAqa2V5XywgY29uc3QgY2hhciAqcmVnZXhfKQogCQln
aXRfY29uZmlnX2Zyb21fZmlsZShzaG93X2NvbmZpZywgc3lzdGVtX3dpZGUsIE5VTEwpOwogCWlm
IChkb19hbGwgJiYgZ2xvYmFsKQogCQlnaXRfY29uZmlnX2Zyb21fZmlsZShzaG93X2NvbmZpZywg
Z2xvYmFsLCBOVUxMKTsKLQlnaXRfY29uZmlnX2Zyb21fZmlsZShzaG93X2NvbmZpZywgbG9jYWws
IE5VTEwpOworCWlmIChkb19hbGwpCisJCWdpdF9jb25maWdfZnJvbV9maWxlKHNob3dfY29uZmln
LCBsb2NhbCwgTlVMTCk7CisJZ2l0X2NvbmZpZ19mcm9tX3BhcmFtZXRlcnMoc2hvd19jb25maWcs
IE5VTEwpOworCWlmICghZG9fYWxsICYmICFzZWVuKQorCQlnaXRfY29uZmlnX2Zyb21fZmlsZShz
aG93X2NvbmZpZywgbG9jYWwsIE5VTEwpOwogCWlmICghZG9fYWxsICYmICFzZWVuICYmIGdsb2Jh
bCkKIAkJZ2l0X2NvbmZpZ19mcm9tX2ZpbGUoc2hvd19jb25maWcsIGdsb2JhbCwgTlVMTCk7CiAJ
aWYgKCFkb19hbGwgJiYgIXNlZW4gJiYgc3lzdGVtX3dpZGUpCmRpZmYgLS1naXQgYS9jYWNoZS5o
IGIvY2FjaGUuaAppbmRleCA4OWY2YTQwLi40YTBjNzVkIDEwMDY0NAotLS0gYS9jYWNoZS5oCisr
KyBiL2NhY2hlLmgKQEAgLTkzMiw2ICs5MzIsOCBAQCBleHRlcm4gaW50IHVwZGF0ZV9zZXJ2ZXJf
aW5mbyhpbnQpOwogdHlwZWRlZiBpbnQgKCpjb25maWdfZm5fdCkoY29uc3QgY2hhciAqLCBjb25z
dCBjaGFyICosIHZvaWQgKik7CiBleHRlcm4gaW50IGdpdF9kZWZhdWx0X2NvbmZpZyhjb25zdCBj
aGFyICosIGNvbnN0IGNoYXIgKiwgdm9pZCAqKTsKIGV4dGVybiBpbnQgZ2l0X2NvbmZpZ19mcm9t
X2ZpbGUoY29uZmlnX2ZuX3QgZm4sIGNvbnN0IGNoYXIgKiwgdm9pZCAqKTsKK2V4dGVybiBpbnQg
Z2l0X2NvbmZpZ19wYXJzZV9wYXJhbWV0ZXIoY29uc3QgY2hhciAqdGV4dCk7CitleHRlcm4gaW50
IGdpdF9jb25maWdfZnJvbV9wYXJhbWV0ZXJzKCk7CiBleHRlcm4gaW50IGdpdF9jb25maWcoY29u
ZmlnX2ZuX3QgZm4sIHZvaWQgKik7CiBleHRlcm4gaW50IGdpdF9wYXJzZV91bG9uZyhjb25zdCBj
aGFyICosIHVuc2lnbmVkIGxvbmcgKik7CiBleHRlcm4gaW50IGdpdF9jb25maWdfaW50KGNvbnN0
IGNoYXIgKiwgY29uc3QgY2hhciAqKTsKZGlmZiAtLWdpdCBhL2NvbmZpZy5jIGIvY29uZmlnLmMK
aW5kZXggNjk2M2ZiZS4uMjM3NmFlOSAxMDA2NDQKLS0tIGEvY29uZmlnLmMKKysrIGIvY29uZmln
LmMKQEAgLTE4LDYgKzE4LDYyIEBAIHN0YXRpYyBpbnQgemxpYl9jb21wcmVzc2lvbl9zZWVuOwog
CiBjb25zdCBjaGFyICpjb25maWdfZXhjbHVzaXZlX2ZpbGVuYW1lID0gTlVMTDsKIAorc3RydWN0
IGNvbmZpZ19pdGVtCit7CisJc3RydWN0IGNvbmZpZ19pdGVtICpuZXh0OworCWNoYXIgKnZhbHVl
OworCWNoYXIgbmFtZVsxXTsKK307CitzdGF0aWMgc3RydWN0IGNvbmZpZ19pdGVtICpjb25maWdf
cGFyYW1ldGVyczsKK3N0YXRpYyBzdHJ1Y3QgY29uZmlnX2l0ZW0gKipjb25maWdfcGFyYW1ldGVz
X3RhaWwgPSAmY29uZmlnX3BhcmFtZXRlcnM7CisKK3N0YXRpYyB2b2lkIGxvd2VyY2FzZShjaGFy
ICpwKQoreworCWZvciAoOyAqcDsgKytwKQorCQkqcCA9IHRvbG93ZXIoKnApOworfQorc3RhdGlj
IGNoYXIgKnNraXBfc3BhY2UoY29uc3QgY2hhciAqcCkKK3sKKwlmb3IgKDsgKnA7ICsrcCkKKwkJ
aWYgKCFpc3NwYWNlKCpwKSkKKwkJCWJyZWFrOworCXJldHVybiAoY2hhciAqKXA7Cit9CitzdGF0
aWMgY2hhciAqdHJhaWxpbmdfc3BhY2UoY29uc3QgY2hhciAqYmVnaW4sIGNvbnN0IGNoYXIgKnAp
Cit7CisJd2hpbGUgKHAtLSA+IGJlZ2luKQorCQlpZiAoIWlzc3BhY2UoKnApKQorCQkJYnJlYWs7
CisJcmV0dXJuIChjaGFyICopcCArIDE7Cit9CisKK2ludCBnaXRfY29uZmlnX3BhcnNlX3BhcmFt
ZXRlcihjb25zdCBjaGFyICp0ZXh0KQoreworCXN0cnVjdCBjb25maWdfaXRlbSAqY3Q7CisJY29u
c3QgY2hhciAqbmFtZTsKKwljb25zdCBjaGFyICp2YWw7CisJbmFtZSA9IHNraXBfc3BhY2UodGV4
dCk7CisJdGV4dCA9IHZhbCA9IHN0cmNocihuYW1lLCAnPScpOworCWlmICghdGV4dCkKKwkJdGV4
dCA9IG5hbWUgKyBzdHJsZW4obmFtZSk7CisJdGV4dCA9IHRyYWlsaW5nX3NwYWNlKG5hbWUsIHRl
eHQpOworCWlmICh0ZXh0IDw9IG5hbWUpCisJCXJldHVybiAtMTsKKwljdCA9IGNhbGxvYygxLCBz
aXplb2Yoc3RydWN0IGNvbmZpZ19pdGVtKSArICh0ZXh0IC0gbmFtZSkpOworCW1lbWNweShjdC0+
bmFtZSwgbmFtZSwgdGV4dCAtIG5hbWUpOworCWxvd2VyY2FzZShjdC0+bmFtZSk7CisJaWYgKCF2
YWwpCisJCWN0LT52YWx1ZSA9IE5VTEw7CisJZWxzZSB7CisJCXZhbCA9IHNraXBfc3BhY2UoKyt2
YWwgLyogc2tpcCAiPSIgKi8pOworCQl0ZXh0ID0gdHJhaWxpbmdfc3BhY2UodmFsLCB2YWwgKyBz
dHJsZW4odmFsKSk7CisJCWN0LT52YWx1ZSA9IHN0cm5kdXAodmFsLCB0ZXh0IC0gdmFsKTsKKwl9
CisJKmNvbmZpZ19wYXJhbWV0ZXNfdGFpbCA9IGN0OworCWNvbmZpZ19wYXJhbWV0ZXNfdGFpbCA9
ICZjdC0+bmV4dDsKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGludCBnZXRfbmV4dF9jaGFyKHZv
aWQpCiB7CiAJaW50IGM7CkBAIC02OTksNiArNzU1LDE1IEBAIGludCBnaXRfY29uZmlnX2dsb2Jh
bCh2b2lkKQogCXJldHVybiAhZ2l0X2Vudl9ib29sKCJHSVRfQ09ORklHX05PR0xPQkFMIiwgMCk7
CiB9CiAKK2ludCBnaXRfY29uZmlnX2Zyb21fcGFyYW1ldGVycyhjb25maWdfZm5fdCBmbiwgdm9p
ZCAqZGF0YSkKK3sKKwljb25zdCBzdHJ1Y3QgY29uZmlnX2l0ZW0gKmN0OworCWZvciAoY3QgPSBj
b25maWdfcGFyYW1ldGVyczsgY3Q7IGN0ID0gY3QtPm5leHQpCisJCWlmIChmbihjdC0+bmFtZSwg
Y3QtPnZhbHVlLCBkYXRhKSA8IDApCisJCQlyZXR1cm4gLTE7CisJcmV0dXJuIDA7Cit9CisKIGlu
dCBnaXRfY29uZmlnKGNvbmZpZ19mbl90IGZuLCB2b2lkICpkYXRhKQogewogCWludCByZXQgPSAw
LCBmb3VuZCA9IDA7CkBAIC03MzAsNiArNzk1LDEyIEBAIGludCBnaXRfY29uZmlnKGNvbmZpZ19m
bl90IGZuLCB2b2lkICpkYXRhKQogCQlmb3VuZCArPSAxOwogCX0KIAlmcmVlKHJlcG9fY29uZmln
KTsKKworCWlmIChjb25maWdfcGFyYW1ldGVycykgeworCQlyZXQgKz0gZ2l0X2NvbmZpZ19mcm9t
X3BhcmFtZXRlcnMoZm4sIGRhdGEpOworCQlmb3VuZCArPSAxOworCX0KKwogCWlmIChmb3VuZCA9
PSAwKQogCQlyZXR1cm4gLTE7CiAJcmV0dXJuIHJldDsKZGlmZiAtLWdpdCBhL2dpdC5jIGIvZ2l0
LmMKaW5kZXggNmJhZTMwNS4uOTlmMDM2MyAxMDA2NDQKLS0tIGEvZ2l0LmMKKysrIGIvZ2l0LmMK
QEAgLTgsNiArOCw3IEBAIGNvbnN0IGNoYXIgZ2l0X3VzYWdlX3N0cmluZ1tdID0KIAkiZ2l0IFst
LXZlcnNpb25dIFstLWV4ZWMtcGF0aFs9R0lUX0VYRUNfUEFUSF1dIFstLWh0bWwtcGF0aF1cbiIK
IAkiICAgICAgICAgICBbLXB8LS1wYWdpbmF0ZXwtLW5vLXBhZ2VyXSBbLS1uby1yZXBsYWNlLW9i
amVjdHNdXG4iCiAJIiAgICAgICAgICAgWy0tYmFyZV0gWy0tZ2l0LWRpcj1HSVRfRElSXSBbLS13
b3JrLXRyZWU9R0lUX1dPUktfVFJFRV1cbiIKKwkiICAgICAgICAgICBbLWMgbmFtZT12YWx1ZVxu
IgogCSIgICAgICAgICAgIFstLWhlbHBdIENPTU1BTkQgW0FSR1NdIjsKIAogY29uc3QgY2hhciBn
aXRfbW9yZV9pbmZvX3N0cmluZ1tdID0KQEAgLTEzMCw2ICsxMzEsMTQgQEAgc3RhdGljIGludCBo
YW5kbGVfb3B0aW9ucyhjb25zdCBjaGFyICoqKmFyZ3YsIGludCAqYXJnYywgaW50ICplbnZjaGFu
Z2VkKQogCQkJc2V0ZW52KEdJVF9ESVJfRU5WSVJPTk1FTlQsIGdldGN3ZChnaXRfZGlyLCBzaXpl
b2YoZ2l0X2RpcikpLCAwKTsKIAkJCWlmIChlbnZjaGFuZ2VkKQogCQkJCSplbnZjaGFuZ2VkID0g
MTsKKwkJfSBlbHNlIGlmICghc3RyY21wKGNtZCwgIi1jIikpIHsKKwkJCWlmICgqYXJnYyA8IDIp
IHsKKwkJCQlmcHJpbnRmKHN0ZGVyciwgIi1jIGV4cGVjdHMgYSBjb25maWd1cmF0aW9uIHN0cmlu
Z1xuIiApOworCQkJCXVzYWdlKGdpdF91c2FnZV9zdHJpbmcpOworCQkJfQorCQkJZ2l0X2NvbmZp
Z19wYXJzZV9wYXJhbWV0ZXIoKCphcmd2KVsxXSk7CisJCQkoKmFyZ3YpKys7CisJCQkoKmFyZ2Mp
LS07CiAJCX0gZWxzZSB7CiAJCQlmcHJpbnRmKHN0ZGVyciwgIlVua25vd24gb3B0aW9uOiAlc1xu
IiwgY21kKTsKIAkJCXVzYWdlKGdpdF91c2FnZV9zdHJpbmcpOwpkaWZmIC0tZ2l0IGEvdC90MTMw
MC1yZXBvLWNvbmZpZy5zaCBiL3QvdDEzMDAtcmVwby1jb25maWcuc2gKaW5kZXggZjExZjk4Yy4u
ZDdjNTUwMSAxMDA3NTUKLS0tIGEvdC90MTMwMC1yZXBvLWNvbmZpZy5zaAorKysgYi90L3QxMzAw
LXJlcG8tY29uZmlnLnNoCkBAIC04MjQsNCArODI0LDExIEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3Mg
J2NoZWNrIHNwbGl0X2NtZGxpbmUgcmV0dXJuJyAiCiAJdGVzdF9tdXN0X2ZhaWwgZ2l0IG1lcmdl
IG1hc3RlcgogCSIKIAordGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0IC1jICJrZXk9dmFsdWUiIHN1
cHBvcnQnICcKKwl0ZXN0ICJ6JChnaXQgLWMgbmFtZT12YWx1ZSBjb25maWcgbmFtZSkiID0genZh
bHVlICYmCisJdGVzdCAieiQoZ2l0IC1jIGNvcmUubmFtZT12YWx1ZSBjb25maWcgY29yZS5uYW1l
KSIgPSB6dmFsdWUgJiYKKwl0ZXN0ICJ6JChnaXQgLWMgZmxhZyBjb25maWcgLS1ib29sIGZsYWcp
IiA9IHp0cnVlICYmCisJdGVzdF9tdXN0X2ZhaWwgZ2l0IC1jIGNvcmUubmFtZT12YWx1ZSBjb25m
aWcgbmFtZQorJworCiB0ZXN0X2RvbmUKLS0gCjEuNy4wLjIuMzE4Lmc0OTI1MAoK
--00151743f7b623012a0482285afb--
