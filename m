From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] alias: add functions to do param substitution and alias running
Date: Fri, 24 Dec 2010 21:07:45 +0700
Message-ID: <1293199669-19016-2-git-send-email-pclouds@gmail.com>
References: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kevin@sb.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 15:09:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW8Kk-0006tf-3R
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 15:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab0LXOJR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 09:09:17 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48182 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0LXOJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 09:09:16 -0500
Received: by pwj3 with SMTP id 3so610264pwj.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 06:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oUleGjA+edboXxzKSn8LRrofDhgsTYXO4vEgz0kvrDI=;
        b=SSfYdLOr3OsTKjx5e5tcDXSWLbPG8nRgVXMgc+XZCBrhM7wfaJCE3EGpZlS4aKgwW6
         AMXnAW92+kHIJCJYtQAOhTPKAPgooQfY3EwAwZ3m1fB/RUALleNfWRI4d2WlSV/EbEYu
         jM/kQzHQ6EP4h6TIL3FJU35NT8GoVI1y/phqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WaOSx2fHq1c5Oo6KZZKe2iDKFJh9NJ6Z9amlaFtYyZiiKga2Veu0lrYOVuil8f1j9B
         aomFytECi91YTLlUf765WCzicuoBNLvhEgtx1WDnI1kU5DYpOXTBPZEsbh6pFAppT3VS
         yZKTHoos6JliuPbRzM5gHw1klbIWdgHoyahPs=
Received: by 10.142.115.6 with SMTP id n6mr7440423wfc.169.1293199755866;
        Fri, 24 Dec 2010 06:09:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id f5sm12365228wfg.14.2010.12.24.06.09.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 06:09:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Dec 2010 21:07:58 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164154>

These functions help substitute %foo% in an alias command to real
values, then run the alias and return the first line from stdout.

The normal use case is:

    /* extract all %xxx% from cmd to params */
    extract_alias_params(cmd, params);
    param =3D lookup_alias_param(params, "%foo%");
    if (param)
        param->value =3D "value for %foo%";
    param =3D lookup_alias_param(params, "%bar%");
    if (param)
        param->value =3D "value for %bar%";
    /* substitute %foo% and %bar% */
    expand_alias_params(cmd, params);
    free_alias_params(params);
    if (!get_alias_oneline(alias, cmd, output))
        /* do something with output->buf here */

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 alias.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 cache.h |   11 +++++
 2 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/alias.c b/alias.c
index eb9f08b..6626bb0 100644
--- a/alias.c
+++ b/alias.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "run-command.h"
=20
 static const char *alias_key;
 static char *alias_val;
@@ -85,3 +86,141 @@ int split_cmdline(char *cmdline, const char ***argv=
)
 const char *split_cmdline_strerror(int split_cmdline_errno) {
 	return split_cmdline_errors[-split_cmdline_errno-1];
 }
+
+int extract_alias_params(const char *cmd, struct alias_param **params)
+{
+	const char *s =3D cmd;
+	int nr_param =3D 0;
+
+	*params =3D NULL;
+	while (s && (s =3D strchr(s, '%')) !=3D NULL) {
+		int len =3D strcspn(s+1, "% ")+2;
+		if (len < 2 || s[len-1] !=3D '%')
+			return error("malformed parameter at %s", s);
+		nr_param++;
+		*params =3D xrealloc(*params, sizeof(struct alias_param)*nr_param);
+		(*params)[nr_param-1].param =3D xstrndup(s, len);
+		(*params)[nr_param-1].pos =3D s - cmd;
+		(*params)[nr_param-1].value =3D NULL;
+		s +=3D len;
+	}
+
+	nr_param++;
+	*params =3D xrealloc(*params, sizeof(struct alias_param)*nr_param);
+	(*params)[nr_param-1].param =3D NULL;
+	(*params)[nr_param-1].value =3D NULL;
+	return 0;
+}
+
+struct alias_param *lookup_alias_param(struct alias_param *params, con=
st char *param)
+{
+	int i;
+	for (i =3D 0; params[i].param; i++)
+		if (!strcmp(params[i].param, param))
+			return params+i;
+	return NULL;
+}
+
+int expand_alias_params(struct strbuf *cmd, const struct alias_param *=
params)
+{
+	int i, offset =3D 0;
+
+	/* TODO: quote for '!' commands */
+	for (i =3D 0; params[i].param; i++) {
+		if (!params[i].value)
+			return error("param %s not substituted", params[i].param);
+		strbuf_splice(cmd,
+			      params[i].pos + offset, strlen(params[i].param),
+			      params[i].value, strlen(params[i].value));
+		offset +=3D strlen(params[i].value) - strlen(params[i].param);
+	}
+
+	return 0;
+}
+
+void free_alias_params(struct alias_param *params)
+{
+	int i;
+	for (i =3D 0; params[i].param; i++) {
+		free(params[i].param);
+		free(params[i].value);
+	}
+	free(params);
+}
+
+static void *wait_and_finish(void *arg)
+{
+	struct child_process *cp =3D arg;
+	char buf[1024];
+	while (xread(cp->out, buf, 1024) > 0)
+		;
+	close(cp->out);
+	finish_command(cp);
+	free(cp->argv);
+	free(cp);
+	return (void *) (intptr_t) 0;
+}
+
+static int start_support_alias(const char *alias, char *cmd, struct ch=
ild_process **cpp)
+{
+	struct child_process *cp;
+	const char **argv;
+	int count;
+
+	cp =3D xmalloc(sizeof(struct child_process));
+	memset(cp, 0, sizeof(struct child_process));
+	cp->in =3D 0;
+	cp->out =3D -1;
+
+	if (cmd[0] =3D=3D '!') {
+		argv =3D xmalloc(sizeof(*argv)*4);
+		argv[0] =3D "/bin/sh";
+		argv[1] =3D "-c";
+		argv[2] =3D cmd+1;
+		argv[3] =3D NULL;
+	}
+	else {
+		count =3D split_cmdline(cmd, &argv);
+		if (count < 0) {
+			free(cp);
+			return error("Bad alias %s: %s", cmd, split_cmdline_strerror(count)=
);
+		}
+		cp->git_cmd =3D 1;
+	}
+
+	cp->argv =3D argv;
+	if (start_command(cp)) {
+		error("Failed to run %s", cmd);
+		free(cp);
+		free(argv);
+		return -1;
+	}
+	*cpp =3D cp;
+	return 0;
+}
+
+int get_alias_oneline(const char *alias, char *cmd, struct strbuf *ref=
)
+{
+	struct child_process *cp;
+	FILE *fp;
+	int ret;
+
+	ret =3D start_support_alias(alias, cmd, &cp);
+	if (ret)
+		return ret;
+
+	fp =3D fdopen(cp->out, "r");
+	ret =3D strbuf_getline(ref, fp, '\n');
+	if (!ret) {
+		/* let it finish, if there's error, users should know */
+#ifdef NO_PTHREADS
+		wait_and_finish(cp);
+#else
+		pthread_t thread;
+		pthread_create(&thread, NULL, wait_and_finish, cp);
+#endif
+		return 0;
+	}
+	wait_and_finish(cp);
+	return -1;
+}
diff --git a/cache.h b/cache.h
index e83bc2d..20a37ff 100644
--- a/cache.h
+++ b/cache.h
@@ -1113,10 +1113,21 @@ extern int ws_blank_line(const char *line, int =
len, unsigned ws_rule);
 int report_path_error(const char *ps_matched, const char **pathspec, i=
nt prefix_offset);
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
=20
+struct alias_param {
+	char *param;
+	int pos;
+	char *value;
+};
+
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
 /* Takes a negative value returned by split_cmdline */
 const char *split_cmdline_strerror(int cmdline_errno);
+int extract_alias_params(const char *cmd, struct alias_param **params)=
;
+struct alias_param *lookup_alias_param(struct alias_param *params, con=
st char *param);
+int expand_alias_params(struct strbuf *cmd, const struct alias_param *=
params);
+void free_alias_params(struct alias_param *params);
+int get_alias_oneline(const char *alias, char *cmd, struct strbuf *res=
ult);
=20
 /* git.c */
 struct startup_info {
--=20
1.7.3.3.476.g10a82
