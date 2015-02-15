From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 2/2] daemon: use callback to build interpolated path
Date: Sun, 15 Feb 2015 19:33:52 +0100
Message-ID: <54E0E690.8000607@web.de>
References: <54E0E60D.6000305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 15 19:34:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN41L-0004US-BL
	for gcvg-git-2@plane.gmane.org; Sun, 15 Feb 2015 19:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbbBOSeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 13:34:14 -0500
Received: from mout.web.de ([212.227.17.12]:58920 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069AbbBOSeN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 13:34:13 -0500
Received: from [192.168.178.27] ([79.253.163.94]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MHowb-1YQdzR2qLt-003g6H; Sun, 15 Feb 2015 19:34:08
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54E0E60D.6000305@web.de>
X-Provags-ID: V03:K0:+MBIRbh7i3V5jP6/rOfXlgYJAdrA0q8OtnRoWypF/ntKrD9Z9+V
 T6ljiZ+fEkRfSwmPOBf3UaRLS9jNfeWSlPIlwaAtJaK95DxrNPQIM/laHDeo8GJv0RC1+5Q
 uyKZ3OrLTB45DsTOnKq0GKnl09rOt+svDkQ9XUdFNuMnB9o1JiRNFMxNJDTwqkoeV0QclYe
 BRvbLzTSgJw5weqJBkf0Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263854>

Provide a callback function for strbuf_expand() instead of using the
helper strbuf_expand_dict_cb().  While the resulting code is longer, it
only looks up the canonical hostname and IP address if at least one of
the placeholders %CH and %IP are used with --interpolated-path.

Use a struct for passing the directory to the callback function instead
of passing it directly to avoid having to cast away its const qualifier.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 daemon.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/daemon.c b/daemon.c
index ef41943..09fa652 100644
--- a/daemon.c
+++ b/daemon.c
@@ -122,6 +122,46 @@ static void NORETURN daemon_die(const char *err, va_list params)
 	exit(1);
 }
 
+static void strbuf_addstr_or_null(struct strbuf *sb, const char *s)
+{
+	if (s)
+		strbuf_addstr(sb, s);
+}
+
+struct expand_path_context {
+	const char *directory;
+};
+
+static size_t expand_path(struct strbuf *sb, const char *placeholder, void *ctx)
+{
+	struct expand_path_context *context = ctx;
+
+	switch (placeholder[0]) {
+	case 'H':
+		strbuf_addstr_or_null(sb, hostname);
+		return 1;
+	case 'C':
+		if (placeholder[1] == 'H') {
+			strbuf_addstr_or_null(sb, get_canon_hostname());
+			return 2;
+		}
+		break;
+	case 'I':
+		if (placeholder[1] == 'P') {
+			strbuf_addstr_or_null(sb, get_ip_address());
+			return 2;
+		}
+		break;
+	case 'P':
+		strbuf_addstr_or_null(sb, tcp_port);
+		return 1;
+	case 'D':
+		strbuf_addstr(sb, context->directory);
+		return 1;
+	}
+	return 0;
+}
+
 static const char *path_ok(const char *directory)
 {
 	static char rpath[PATH_MAX];
@@ -160,14 +200,10 @@ static const char *path_ok(const char *directory)
 	}
 	else if (interpolated_path && saw_extended_args) {
 		struct strbuf expanded_path = STRBUF_INIT;
-		struct strbuf_expand_dict_entry dict[6];
-
-		dict[0].placeholder = "H"; dict[0].value = hostname;
-		dict[1].placeholder = "CH"; dict[1].value = get_canon_hostname();
-		dict[2].placeholder = "IP"; dict[2].value = get_ip_address();
-		dict[3].placeholder = "P"; dict[3].value = tcp_port;
-		dict[4].placeholder = "D"; dict[4].value = directory;
-		dict[5].placeholder = NULL; dict[5].value = NULL;
+		struct expand_path_context context;
+
+		context.directory = directory;
+
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (interpolated-path active)", dir);
@@ -175,7 +211,7 @@ static const char *path_ok(const char *directory)
 		}
 
 		strbuf_expand(&expanded_path, interpolated_path,
-				strbuf_expand_dict_cb, &dict);
+			      expand_path, &context);
 		strlcpy(interp_path, expanded_path.buf, PATH_MAX);
 		strbuf_release(&expanded_path);
 		loginfo("Interpolated dir '%s'", interp_path);
-- 
2.3.0
