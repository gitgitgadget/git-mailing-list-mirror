From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP-PATCH 1/3] pretty: remove reencode_commit_message()
Date: Wed, 17 Oct 2012 19:20:16 -0700
Message-ID: <1350526818-354-2-git-send-email-gitster@pobox.com>
References: <1350526818-354-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 04:20:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOfiw-00038j-TT
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 04:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602Ab2JRCU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 22:20:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab2JRCUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 22:20:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2067283F9
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RRXH
	Bw4J3jMmYFcUm82Dx/bLnOc=; b=fz7TLBf8xzQ+p3j2juK4itQTGv2GbMx4XrS7
	nNZZceM1+tLnxneAROvbMEtpc0ZlwtV59YsEpS9iEZS+2z88WImX2REolCT5XvfC
	B7Mp7DwdwpynHKhirnZghz4hF1YgJg5Le56BJiTJlFMxwd5NW+YOAvHKK0NgF/1B
	lZ+4vI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=yF7HN8
	8A1n+7xi6T+2fLv2EgupBM1qmIrfZCznCZBR8TNyYTXcPCZQYIjnSoeJu7Es4Z5z
	kxexniRTVEEnwPCGjGadH86AjONpuecqlf1ejVH+OJVtDJH9IyhbwalYyigZAqXE
	ZQojJkqyJvHTFbzjxtQ5xth0hAGx09fo1KmsE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E84A83F8
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 600F383F6 for
 <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:23 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
In-Reply-To: <1350526818-354-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5F305E00-18CA-11E2-BCC2-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207951>

This function has only two callsites, and is a thin wrapper whose
usefulness is dubious.  When the caller needs to learn the log
output encoding, it should be able to do so by directly calling
get_log_output_encoding() and calling the underlying
logmsg_reencode() with it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c |  5 +++--
 commit.h        |  2 --
 pretty.c        | 13 ++-----------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index c27ef21..cfae569 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1425,7 +1425,7 @@ static void get_commit_info(struct commit *commit,
 			    int detailed)
 {
 	int len;
-	const char *subject;
+	const char *subject, *encoding;
 	char *reencoded, *message;
 	static char author_name[1024];
 	static char author_mail[1024];
@@ -1446,7 +1446,8 @@ static void get_commit_info(struct commit *commit,
 			die("Cannot read commit %s",
 			    sha1_to_hex(commit->object.sha1));
 	}
-	reencoded = reencode_commit_message(commit, NULL);
+	encoding = get_log_output_encoding();
+	reencoded = logmsg_reencode(commit, encoding);
 	message   = reencoded ? reencoded : commit->buffer;
 	ret->author = author_name;
 	ret->author_mail = author_mail;
diff --git a/commit.h b/commit.h
index 9f21313..a822af8 100644
--- a/commit.h
+++ b/commit.h
@@ -99,8 +99,6 @@ extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *logmsg_reencode(const struct commit *commit,
 			     const char *output_encoding);
-extern char *reencode_commit_message(const struct commit *commit,
-				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
diff --git a/pretty.c b/pretty.c
index 8b1ea9f..c311a68 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1341,16 +1341,6 @@ void pp_remainder(const struct pretty_print_context *pp,
 	}
 }
 
-char *reencode_commit_message(const struct commit *commit, const char **encoding_p)
-{
-	const char *encoding;
-
-	encoding = get_log_output_encoding();
-	if (encoding_p)
-		*encoding_p = encoding;
-	return logmsg_reencode(commit, encoding);
-}
-
 void pretty_print_commit(const struct pretty_print_context *pp,
 			 const struct commit *commit,
 			 struct strbuf *sb)
@@ -1367,7 +1357,8 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 		return;
 	}
 
-	reencoded = reencode_commit_message(commit, &encoding);
+	encoding = get_log_output_encoding();
+	reencoded = logmsg_reencode(commit, encoding);
 	if (reencoded) {
 		msg = reencoded;
 	}
-- 
1.8.0.rc3.112.gdb88a5e
