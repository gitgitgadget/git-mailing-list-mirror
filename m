From: Jed Brown <jed@59A2.org>
Subject: [PATCH 1/2] Added the --notmuch option to git format-patch.
Date: Wed, 25 Nov 2009 03:50:46 +0100
Message-ID: <1259117447-23052-1-git-send-email-jed@59A2.org>
References: <87d4375ne0.fsf@59A2.org>
Cc: madcoder@debian.org, Jed Brown <jed@59A2.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 03:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND7xp-0002Im-F6
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 03:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934224AbZKYCua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 21:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934184AbZKYCua
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 21:50:30 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48075 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934162AbZKYCu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 21:50:29 -0500
Received: by bwz27 with SMTP id 27so6585968bwz.21
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 18:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=fjSUxRu8WI0IJ6fDoRNCVYN6Gt9F2fuPTixWoOXxAfo=;
        b=O72sQhBzKvegr02U8D+7l6z4COTi5Ca6LHhd85YQTgxcoXslf92zTNTw7oDykeZp6L
         h1q0MpDXBhbj4siBo+rmA9y+RCRHJSNIKse2/yFdWC4dqgnersSwsjm3SXVIssDY9C9a
         wcGX2auDoG07xbk0aKG5gFhiyZ01ye1elZD9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=W3At9CfFhcVkzAZDynbhpOYsL5QqyWPuJ8vhuffCkJJZOIEmR0d4ZtVu88v6Ic7fZM
         9qjrzc8L9ycy/LLLW2pWqMHbYeLhJpUkGWx8ef8v26kLomma571JZ48dXcR1Nur8pWSo
         0WAqeefQzJ2fokpdQpUbyFGv/aGk0zOWX+UpA=
Received: by 10.204.49.68 with SMTP id u4mr7013031bkf.42.1259117434920;
        Tue, 24 Nov 2009 18:50:34 -0800 (PST)
Received: from localhost.localdomain (vawpc43.ethz.ch [129.132.59.11])
        by mx.google.com with ESMTPS id 12sm410890fks.39.2009.11.24.18.50.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 18:50:33 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <87d4375ne0.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133609>

The typical use case for this is

  git format-patch --notmuch id:<MESSAGE-ID>

which will format your patch with all threading, references, and To, Cc
fields appropriate for a reply to the given message.
---
 builtin-log.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 33fa6ea..9a44955 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -754,6 +754,53 @@ static const char *clean_message_id(const char *msg_id)
 	return xmemdupz(a, z - a);
 }
 
+static int get_notmuch_reply(struct strbuf *buf, struct string_list *ref_message_ids, const char *query)
+{
+	struct child_process notmuch;
+	struct strbuf notmuch_out;
+	char *p, *other_headers, *rstart;
+	ssize_t len;
+	const char *argv[] = {"notmuch", "reply", "--format=headers-only", query, NULL};
+
+	memset(&notmuch, 0, sizeof(notmuch));
+
+	notmuch.argv	 = argv;
+	notmuch.no_stdin = 1;
+	notmuch.out	 = -1;
+
+	if (start_command(&notmuch))
+		return error("could not run notmuch.");
+
+	strbuf_init(&notmuch_out, 4096);
+	len = strbuf_read(&notmuch_out, notmuch.out, 4096);
+	close(notmuch.out);
+
+	if (finish_command(&notmuch) || !len || len < 0)
+		return error("notmuch did not return any headers");
+
+	/* Harvest the referenced message IDs, all on the first line */
+	p = notmuch_out.buf;
+
+	if (!strncmp(p, "References: ", sizeof("References: ")))
+		return error("notmuch response malformed");
+
+	other_headers = strstr(p, "To: ");
+	if (!other_headers)
+		return error("notmuch provided no other headers");
+
+	while ((rstart = strchr(p, '<')) && (p = strchr(rstart, '>')) && p < other_headers-1) {
+		if (!p)
+			error("notmuch returned malformed references");
+		p++;
+		*p++ = 0;
+		string_list_append(clean_message_id(rstart), ref_message_ids);
+	}
+	/* Add everything after the first line */
+	strbuf_addstr(buf, other_headers);
+	strbuf_release(&notmuch_out);
+	return 0;
+}
+
 static const char *set_outdir(const char *prefix, const char *output_directory)
 {
 	if (output_directory && is_absolute_path(output_directory))
@@ -893,7 +940,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	struct commit *origin = NULL, *head = NULL;
-	const char *in_reply_to = NULL;
+	const char *in_reply_to = NULL, *notmuch = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
 	struct strbuf buf = STRBUF_INIT;
@@ -940,6 +987,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_NONEG, cc_callback },
 		OPT_STRING(0, "in-reply-to", &in_reply_to, "message-id",
 			    "make first mail a reply to <message-id>"),
+		OPT_STRING(0, "notmuch", &notmuch, "query",
+			    "make first mail a reply to messages matched by <query>"),
 		{ OPTION_CALLBACK, 0, "attach", &rev, "boundary",
 			    "attach the patch", PARSE_OPT_OPTARG,
 			    attach_callback },
@@ -1015,8 +1064,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		strbuf_addch(&buf, '\n');
 	}
 
-	rev.extra_headers = strbuf_detach(&buf, NULL);
-
 	if (start_number < 0)
 		start_number = 1;
 
@@ -1135,12 +1182,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
-	if (in_reply_to || thread || cover_letter)
+	if (in_reply_to || thread || cover_letter || notmuch)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
 		const char *msgid = clean_message_id(in_reply_to);
 		string_list_append(msgid, rev.ref_message_ids);
 	}
+	if (notmuch) {
+		get_notmuch_reply(&buf, rev.ref_message_ids, notmuch);
+	}
+
+	rev.extra_headers = strbuf_detach(&buf, NULL);
+
 	rev.numbered_files = numbered_files;
 	rev.patch_suffix = fmt_patch_suffix;
 	if (cover_letter) {
-- 
1.6.5.3
