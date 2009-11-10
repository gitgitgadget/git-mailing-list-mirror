From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/4] builtin-fetch: add --prune option
Date: Tue, 10 Nov 2009 00:03:33 -0500
Message-ID: <1257829414-52316-4-git-send-email-jaysoffian@gmail.com>
References: <1257829414-52316-1-git-send-email-jaysoffian@gmail.com>
 <1257829414-52316-2-git-send-email-jaysoffian@gmail.com>
 <1257829414-52316-3-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 06:04:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ito-0006KC-8d
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 06:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbZKJFDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 00:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbZKJFDp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 00:03:45 -0500
Received: from mail-qy0-f194.google.com ([209.85.221.194]:49831 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbZKJFDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 00:03:43 -0500
Received: by mail-qy0-f194.google.com with SMTP id 32so1482737qyk.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 21:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uZrl1U7U4jPGNC4ugKZ2w8FNLjTfv4pkuVGkMccjVU4=;
        b=fie1uSaQKJljw85PhUXrAHqk5gyvecIjtyI0ku22IfohnsUfUI/B36XA/molOjDRI9
         z5wV4qaGuQYHhM7WDA0wBAxrWliScHbnS5jBY/WE/LNSC6hRbDBYYmmr3IKZD1h5/2UB
         fL2zMDN8T7hj7gP7MwGen6KdwC+pRVo/WWL1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K1B72E2V5K9QTj/HQi3+w/fMpI7C/Bho0L5n2V9Yv9gaVkHvtLQF1PlG37MZ2wPndZ
         0DkxDmtDQFrf2yyuL+TrKr0CHuDlLA4w+ykgqGXH/66/34W/5PbSL4weRba4u01g8Rtf
         DIF934xjzit3pwbcLQ4QWFyMUinWV+u+1OaJg=
Received: by 10.224.114.160 with SMTP id e32mr4614878qaq.282.1257829429125;
        Mon, 09 Nov 2009 21:03:49 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 21sm262404qyk.8.2009.11.09.21.03.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 21:03:48 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257829414-52316-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132535>

Teach fetch to cull stale remote tracking branches after fetching via --prune.

We can now enable the "--prune" option to "remote update", which was recently
re-implemented as an invocation of git fetch.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/fetch-options.txt |    4 ++++
 builtin-fetch.c                 |   32 ++++++++++++++++++++++++++++++--
 builtin-remote.c                |    4 +++-
 t/t5505-remote.sh               |    2 +-
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 8b0cf58..500637a 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -28,6 +28,10 @@ ifndef::git-pull[]
 --multiple::
 	Allow several <repository> and <group> arguments to be
 	specified. No <refspec>s may be specified.
+
+--prune::
+	After fetching, remove any remote tracking branches which
+	no longer exist	on the remote.
 endif::git-pull[]
 
 ifdef::git-pull[]
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 945dfd8..fd31072 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -26,7 +26,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int all, append, force, keep, multiple, update_head_ok, verbosity;
+static int all, append, force, keep, multiple, prune, update_head_ok, verbosity;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -49,6 +49,8 @@ static struct option builtin_fetch_options[] = {
 		    "fetch all tags and associated objects", TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
+	OPT_BOOLEAN('p', "prune", &prune,
+		    "prune tracking branches no longer on remote"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
@@ -492,6 +494,28 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	return ret;
 }
 
+static int prune_refs(struct transport *transport, struct ref *ref_map)
+{
+	int result = 0;
+	struct ref *ref, *stale_refs = get_stale_heads(transport->remote, ref_map);
+	const char *dangling_msg = dry_run
+		? "   (%s will become dangling)\n"
+		: "   (%s has become dangling)\n";
+
+	for (ref = stale_refs; ref; ref = ref->next) {
+		if (!dry_run)
+			result |= delete_ref(ref->name, NULL, 0);
+		if (verbosity >= 0) {
+			fprintf(stderr, " x %-*s %-*s -> %s\n",
+				SUMMARY_WIDTH, "[deleted]",
+				REFCOL_WIDTH, "(none)", prettify_refname(ref->name));
+			warn_dangling_symref(stderr, dangling_msg, ref->name);
+		}
+	}
+	free_refs(stale_refs);
+	return result;
+}
+
 static int add_existing(const char *refname, const unsigned char *sha1,
 			int flag, void *cbdata)
 {
@@ -657,6 +681,8 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		return 1;
 	}
+	if (prune)
+		prune_refs(transport, ref_map);
 	free_refs(ref_map);
 
 	/* if neither --no-tags nor --tags was specified, do automated tag
@@ -740,9 +766,11 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 static int fetch_multiple(struct string_list *list)
 {
 	int i, result = 0;
-	const char *argv[] = { "fetch", NULL, NULL, NULL, NULL };
+	const char *argv[] = { "fetch", NULL, NULL, NULL, NULL, NULL };
 	int argc = 1;
 
+	if (prune)
+		argv[argc++] = "--prune";
 	if (verbosity >= 2)
 		argv[argc++] = "-v";
 	if (verbosity >= 1)
diff --git a/builtin-remote.c b/builtin-remote.c
index e67b89f..fb0d66d 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1195,13 +1195,15 @@ static int update(int argc, const char **argv)
 	int fetch_argc = 0;
 	int default_defined = 0;
 
-	fetch_argv = xmalloc(sizeof(char *) * (argc+4));
+	fetch_argv = xmalloc(sizeof(char *) * (argc+5));
 
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
 	fetch_argv[fetch_argc++] = "fetch";
 
+	if (prune)
+		fetch_argv[fetch_argc++] = "--prune";
 	if (verbose)
 		fetch_argv[fetch_argc++] = "-v";
 	if (argc < 2) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 562cca2..e931ce6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -365,7 +365,7 @@ test_expect_success 'update with arguments' '
 
 '
 
-test_expect_failure 'update --prune' '
+test_expect_success 'update --prune' '
 
 	(cd one &&
 	 git branch -m side2 side3) &&
-- 
1.6.4.2
