From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH] status: Add json output format
Date: Sun, 11 Apr 2010 00:03:48 +0100
Message-ID: <20100410230349.43948.68755.julian@quantumfyre.co.uk>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
	<20100410040959.GA11977@coredump.intra.peff.net>
	<9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
	<20100410192529.23731.79803.julian@quantumfyre.co.uk>
	<20100410195003.GA28871@thyrsus.com>
	<1702f7c7b0e0689149702335c9efad3f@212.159.54.234>
	<20100410211223.GA29067@thyrsus.com>
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 01:06:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jkR-0000V6-B7
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 01:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab0DJXFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 19:05:38 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:60844 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752408Ab0DJXFh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 19:05:37 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 07063819C6CF;
	Sun, 11 Apr 2010 00:05:30 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 28EEB20CF39;
	Sun, 11 Apr 2010 00:05:35 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EWptWUHUodxX; Sun, 11 Apr 2010 00:05:34 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 3366520CF38;
	Sun, 11 Apr 2010 00:05:33 +0100 (BST)
X-git-sha1: 74b758aa6d43b02fcc43d4cfc561079e18677d85 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100410211223.GA29067@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144612>

This adds a --json switch to status, which enables a json output
format.  This provides a standard output format that should be easily
parsed by scripts using any of the large number of readily available
json libraries.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
On Sat, 10 Apr 2010, Eric Raymond wrote:

> Julian Phillips <julian@quantumfyre.co.uk>:
>> I didn't use "-" instead of " " as that seemed out of scope for a output
>> formatting option.  Though I don't personally have an objection to it, I
>> also don't see a particularly strong need for it as with the -Z format
>> there is no ambiguity.
>
> Good point.  OK, the combinaation of -Z and a switch to list ignored
> files should solve Emacs VC's problem.
>
> Having some sort of JSON dump might still not be a bad idea.

Starter for 10 ...

 builtin/commit.c |   10 ++++
 wt-status.c      |  132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h      |    1 +
 3 files changed, 143 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..f2b5cfa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -91,6 +91,7 @@ static enum {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_JSON,
 } status_format = STATUS_FORMAT_LONG;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
@@ -422,6 +423,9 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s, null_termination);
 		break;
+	case STATUS_FORMAT_JSON:
+		wt_json_print(s);
+		break;
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
 		break;
@@ -1025,6 +1029,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    "show porcelain output format",
 			    STATUS_FORMAT_PORCELAIN),
+		OPT_SET_INT(0, "json", &status_format,
+			    "show json output format",
+			    STATUS_FORMAT_JSON),
 		OPT_BOOLEAN('z', "null", &null_termination,
 			    "terminate entries with NUL"),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
@@ -1068,6 +1075,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s, null_termination);
 		break;
+	case STATUS_FORMAT_JSON:
+		wt_json_print(&s);
+		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
 		wt_status_print(&s);
diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..ab934e7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -750,3 +750,135 @@ void wt_porcelain_print(struct wt_status *s, int null_termination)
 	s->prefix = NULL;
 	wt_shortstatus_print(s, null_termination);
 }
+
+static char *json_quote(char *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	while (*s) {
+		switch (*s) {
+		case '"':
+			strbuf_addstr(&buf, "\\\"");
+			break;
+		case '\\':
+			strbuf_addstr(&buf, "\\\\");
+			break;
+		case '\b':
+			strbuf_addstr(&buf, "\\b");
+			break;
+		case '\f':
+			strbuf_addstr(&buf, "\\f");
+			break;
+		case '\n':
+			strbuf_addstr(&buf, "\\n");
+			break;
+		case '\r':
+			strbuf_addstr(&buf, "\\r");
+			break;
+		case '\t':
+			strbuf_addstr(&buf, "\\t");
+			break;
+		default:
+			/* All control characters must be encode, even if they
+			 * don't have a specific escape character of their own */
+			if (*s < 0x20)
+				strbuf_addf(&buf, "\\u%04x", *s);
+			else
+				strbuf_addch(&buf, *s);
+			break;
+		}
+		s++;
+	}
+
+	return strbuf_detach(&buf, NULL);
+}
+
+static void wt_json_unmerged(struct string_list_item *it,
+			   struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	char ours = '?', theirs = '?';
+	char *name = json_quote(it->string);
+
+	switch (d->stagemask) {
+	case 1: ours = 'D'; theirs = 'D'; break; /* both deleted */
+	case 2: ours = 'A'; theirs = 'U'; break; /* added by us */
+	case 3: ours = 'U'; theirs = 'D'; break; /* deleted by them */
+	case 4: ours = 'U'; theirs = 'A'; break; /* added by them */
+	case 5: ours = 'D'; theirs = 'U'; break; /* deleted by us */
+	case 6: ours = 'A'; theirs = 'A'; break; /* both added */
+	case 7: ours = 'U'; theirs = 'U'; break; /* both modified */
+	}
+
+	fprintf(stdout, "{");
+	fprintf(stdout, "\"ours\" : \"%c\", ", ours);
+	fprintf(stdout, "\"theirs\" : \"%c\", ", theirs);
+	fprintf(stdout, "\"name\" : \"%s\"", name);
+	fprintf(stdout, "}");
+
+	free(name);
+}
+
+static void wt_json_status(struct string_list_item *it,
+			 struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	char index = '-', worktree = '-';
+	char *name = json_quote(it->string);
+
+	if (d->index_status)
+		index = d->index_status;
+	if (d->worktree_status)
+		worktree = d->worktree_status;
+
+	fprintf(stdout, "{");
+	fprintf(stdout, "\"index\" : \"%c\", ", index);
+	fprintf(stdout, "\"worktree\" : \"%c\", ", worktree);
+	fprintf(stdout, "\"name\" : \"%s\"", name);
+
+	if (d->head_path) {
+		free(name);
+		name = json_quote(d->head_path);
+		fprintf(stdout, ", \"orig_name\" : \"%s\"", name);
+	}
+
+	fprintf(stdout, "}");
+
+	free(name);
+}
+
+void wt_json_print(struct wt_status *s)
+{
+	int i;
+	fprintf(stdout, "[");
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+
+		if (i > 0)
+			fprintf(stdout, ",\n");
+		it = &(s->change.items[i]);
+		d = it->util;
+		if (d->stagemask)
+			wt_json_unmerged(it, s);
+		else
+			wt_json_status(it, s);
+	}
+	if (s->change.nr > 0 && s->untracked.nr > 0)
+		fprintf(stdout, ",\n");
+	for (i = 0; i < s->untracked.nr; i++) {
+		char *name = json_quote(s->untracked.items[i].string);
+
+		if (i > 0)
+			fprintf(stdout, ",\n");
+
+		fprintf(stdout, "{");
+		fprintf(stdout, "\"index\" : \"?\", ");
+		fprintf(stdout, "\"worktree\" : \"?\", ");
+		fprintf(stdout, "\"name\" : \"%s\"", name);
+		fprintf(stdout, "}");
+
+		free(name);
+	}
+	fprintf(stdout, "]\n");
+}
diff --git a/wt-status.h b/wt-status.h
index 9120673..effd3fd 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -61,5 +61,6 @@ void wt_status_collect(struct wt_status *s);
 
 void wt_shortstatus_print(struct wt_status *s, int null_termination);
 void wt_porcelain_print(struct wt_status *s, int null_termination);
+void wt_json_print(struct wt_status *s);
 
 #endif /* STATUS_H */
-- 
1.7.0.4
