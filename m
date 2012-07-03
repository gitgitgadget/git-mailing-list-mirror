From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 18/25] revision.c: allow handle_revision_arg() to take
 other flags
Date: Tue,  3 Jul 2012 14:37:08 -0700
Message-ID: <1341351435-31011-19-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAnj-0005Tg-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639Ab2GCViW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756560Ab2GCVhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21106868A
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KOZ7
	+gLTBHFhZIz9TafZacwZzzY=; b=Ym3Q0rJBpTaVAYO131hmDge9CO20R+dYxJiy
	YgfVbXxnBv1whUJ3+uZ+PLHYRh6kTXemBN2yHP/SkpHpnGEwPB5X8JcgymyaDbrW
	CTUqCbqr1pV/2Xegl9fOZJV/ezD19U7AmjF95Y0Fjm89Y8oMUI5JrIlrp8ZXyoRd
	dULKtPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kMDyZk
	jKo/+mVXSc1RADDWyE/vn4AHpa25cX4rQXFCUot/A9DWtxxjU1kuUyI4V7BsQLbi
	2CneNdQc5sDzKt7f3+neQzkLAqoX8Xnsx4+ck9m3ym2z+Wv0fTHxP5gE/czZMJ1D
	TXXLugssxk184kr+bKYXCkGSXfeGyCcr/jBmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 186238689
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 769AA867F for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:52 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 57E039F2-C557-11E1-BA48-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200954>

The existing "cant_be_filename" that tells the function that the
caller knows the arg is not a path (hence it does not have to be
checked for absense of the file whose name matches it) is made into
a bit in the flag word.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |  2 +-
 revision.c             | 13 +++++++------
 revision.h             |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0f2e7b8..48ccadd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2290,7 +2290,7 @@ static void get_object_list(int ac, const char **av)
 			}
 			die("not a rev '%s'", line);
 		}
-		if (handle_revision_arg(line, &revs, flags, 1))
+		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", line);
 	}
 
diff --git a/revision.c b/revision.c
index c3160f2..929497f 100644
--- a/revision.c
+++ b/revision.c
@@ -1093,9 +1093,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	revs->limited = 1;
 }
 
-int handle_revision_arg(const char *arg_, struct rev_info *revs,
-			int flags,
-			int cant_be_filename)
+int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsigned revarg_opt)
 {
 	struct object_context oc;
 	char *dotdot;
@@ -1103,6 +1101,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs,
 	unsigned char sha1[20];
 	int local_flags;
 	const char *arg = arg_;
+	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
 
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
@@ -1236,7 +1235,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			}
 			die("options not supported in --stdin mode");
 		}
-		if (handle_revision_arg(sb.buf, revs, 0, 1))
+		if (handle_revision_arg(sb.buf, revs, 0, REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
 	if (seen_dashdash)
@@ -1684,7 +1683,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
-	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0;
+	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0, revarg_opt;
 	struct cmdline_pathspec prune_data;
 	const char *submodule = NULL;
 
@@ -1708,6 +1707,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	/* Second, deal with arguments and options */
 	flags = 0;
+	revarg_opt = seen_dashdash ? REVARG_CANNOT_BE_FILENAME : 0;
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -1743,7 +1743,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			continue;
 		}
 
-		if (handle_revision_arg(arg, revs, flags, seen_dashdash)) {
+
+		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
 			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
diff --git a/revision.h b/revision.h
index b8e9223..8eceaec 100644
--- a/revision.h
+++ b/revision.h
@@ -190,7 +190,8 @@ extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, s
 extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 				 const struct option *options,
 				 const char * const usagestr[]);
-extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
+#define REVARG_CANNOT_BE_FILENAME 01
+extern int handle_revision_arg(const char *arg, struct rev_info *revs, int flags, unsigned revarg_opt);
 
 extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
-- 
1.7.11.1.229.g706c98f
