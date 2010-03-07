From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/4] format-patch: use a string_list for headers
Date: Sun,  7 Mar 2010 13:33:16 -0800
Message-ID: <1267997598-20815-3-git-send-email-bebarino@gmail.com>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 22:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoO6d-0004xa-JA
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904Ab0CGVd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:33:29 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63945 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab0CGVd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:33:28 -0500
Received: by mail-gw0-f46.google.com with SMTP id 15so2693575gwb.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PeQxfwGe1RT/O0sWp+P6lwTDN2Nkc6JyIKQcY0ss0Pw=;
        b=nmSv93SDTkJunDh2Q7zig39nvOHQU1ALLNcYQ3i525pCbG5e8UdSA5A0Efto2yBVjp
         gRbgXwuBFsCLnhIlBOfC0nxOFDJojVdFVkbSTJCW2wb5JImh5DJm6kpvr5k7UUCAEvOn
         QacdCURbPdvuMMl+I4yXaaEUckHk5VlDUbdFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vwRxsjgmFw7aSTCwDDXfEl7NPkDE8DlwgJv2dFqWCKdMRlFBST8yqsDcm9C8nSTiXE
         p702SYIsUwcYx4b5KxMSIt5OJRHX17w0aWXYOpELjltCHyJPzfikan5hnU17jlK/3w2Z
         KTYyIpqa7Y26RA/Y2TA4AHlWI7VRhsNaYV9wY=
Received: by 10.101.90.7 with SMTP id s7mr3062746anl.176.1267997607106;
        Sun, 07 Mar 2010 13:33:27 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 15sm3047607gxk.14.2010.03.07.13.33.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 13:33:26 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.171.geb5ee
In-Reply-To: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141732>

In the next patch we'll need to clear the header lists if the user
specifies --no-add-headers or --no-to or --no-cc. This actually cuts
down on the code a bit too.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I had a patch like this but using strbuf's instead. I couldn't find it...

 builtin-log.c |   70 +++++++++++++++++++++++++-------------------------------
 1 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5d23a67..dd8369f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -458,35 +458,28 @@ static int auto_number = 1;
 
 static char *default_attach = NULL;
 
-static char **extra_hdr;
-static int extra_hdr_nr;
-static int extra_hdr_alloc;
-
-static char **extra_to;
-static int extra_to_nr;
-static int extra_to_alloc;
-
-static char **extra_cc;
-static int extra_cc_nr;
-static int extra_cc_alloc;
+static struct string_list extra_hdr = { .strdup_strings = 1 };
+static struct string_list extra_to = { .strdup_strings = 1 };
+static struct string_list extra_cc = { .strdup_strings = 1 };
 
 static void add_header(const char *value)
 {
+	struct string_list_item *i;
 	int len = strlen(value);
 	while (len && value[len - 1] == '\n')
 		len--;
+
 	if (!strncasecmp(value, "to: ", 4)) {
-		ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
-		extra_to[extra_to_nr++] = xstrndup(value + 4, len - 4);
-		return;
+		i = string_list_append(value + 4, &extra_to);
+		len -= 4;
+	} else if (!strncasecmp(value, "cc: ", 4)) {
+		i = string_list_append(value + 4, &extra_cc);
+		len -= 4;
+	} else {
+		i =string_list_append(value, &extra_hdr);
 	}
-	if (!strncasecmp(value, "cc: ", 4)) {
-		ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
-		extra_cc[extra_cc_nr++] = xstrndup(value + 4, len - 4);
-		return;
-	}
-	ALLOC_GROW(extra_hdr, extra_hdr_nr + 1, extra_hdr_alloc);
-	extra_hdr[extra_hdr_nr++] = xstrndup(value, len);
+
+	i->string[len] = '\0';
 }
 
 #define THREAD_SHALLOW 1
@@ -507,15 +500,13 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "format.to")) {
 		if (!value)
 			return config_error_nonbool(var);
-		ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
-		extra_to[extra_to_nr++] = xstrdup(value);
+		string_list_append(value, &extra_to);
 		return 0;
 	}
 	if (!strcmp(var, "format.cc")) {
 		if (!value)
 			return config_error_nonbool(var);
-		ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
-		extra_cc[extra_cc_nr++] = xstrdup(value);
+		string_list_append(value, &extra_cc);
 		return 0;
 	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
@@ -884,15 +875,13 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 
 static int to_callback(const struct option *opt, const char *arg, int unset)
 {
-	ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
-	extra_to[extra_to_nr++] = xstrdup(arg);
+	string_list_append(arg, &extra_to);
 	return 0;
 }
 
 static int cc_callback(const struct option *opt, const char *arg, int unset)
 {
-	ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
-	extra_cc[extra_cc_nr++] = xstrdup(arg);
+	string_list_append(arg, &extra_cc);
 	return 0;
 }
 
@@ -1008,29 +997,29 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		add_signoff = xmemdupz(committer, endpos - committer + 1);
 	}
 
-	for (i = 0; i < extra_hdr_nr; i++) {
-		strbuf_addstr(&buf, extra_hdr[i]);
+	for (i = 0; i < extra_hdr.nr; i++) {
+		strbuf_addstr(&buf, extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
 	}
 
-	if (extra_to_nr)
+	if (extra_to.nr)
 		strbuf_addstr(&buf, "To: ");
-	for (i = 0; i < extra_to_nr; i++) {
+	for (i = 0; i < extra_to.nr; i++) {
 		if (i)
 			strbuf_addstr(&buf, "    ");
-		strbuf_addstr(&buf, extra_to[i]);
-		if (i + 1 < extra_to_nr)
+		strbuf_addstr(&buf, extra_to.items[i].string);
+		if (i + 1 < extra_to.nr)
 			strbuf_addch(&buf, ',');
 		strbuf_addch(&buf, '\n');
 	}
 
-	if (extra_cc_nr)
+	if (extra_cc.nr)
 		strbuf_addstr(&buf, "Cc: ");
-	for (i = 0; i < extra_cc_nr; i++) {
+	for (i = 0; i < extra_cc.nr; i++) {
 		if (i)
 			strbuf_addstr(&buf, "    ");
-		strbuf_addstr(&buf, extra_cc[i]);
-		if (i + 1 < extra_cc_nr)
+		strbuf_addstr(&buf, extra_cc.items[i].string);
+		if (i + 1 < extra_cc.nr)
 			strbuf_addch(&buf, ',');
 		strbuf_addch(&buf, '\n');
 	}
@@ -1239,6 +1228,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fclose(stdout);
 	}
 	free(list);
+	string_list_clear(&extra_to, 0);
+	string_list_clear(&extra_cc, 0);
+	string_list_clear(&extra_hdr, 0);
 	if (ignore_if_in_upstream)
 		free_patch_ids(&ids);
 	return 0;
-- 
1.7.0.1.171.geb5ee
