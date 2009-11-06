From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH/RFC 3/3] builtin-fetch: add --prune option
Date: Fri,  6 Nov 2009 00:10:41 -0500
Message-ID: <1257484241-27219-4-git-send-email-jaysoffian@gmail.com>
References: <1257484241-27219-1-git-send-email-jaysoffian@gmail.com>
 <1257484241-27219-2-git-send-email-jaysoffian@gmail.com>
 <1257484241-27219-3-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 06:11:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6H6g-0006me-W7
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 06:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbZKFFLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 00:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbZKFFLG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 00:11:06 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:1337 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbZKFFLC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 00:11:02 -0500
Received: by qw-out-2122.google.com with SMTP id 3so143925qwe.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 21:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eYg1K4XRnejQSyfDqg1B1NTWdOmgL1bSQovIqKNzYCc=;
        b=Owp0kALuhNLib0J1OQJ9U/G3oUPm3Ne283nuWilp/mGvOPfXJdChJrkY5wR7uDOAzx
         0BZfzsMwTZYJT+6u4Y+7SwEVhAnfv9Fnx0z35A3D0RmNuYkVy7NxjzWUYY0yJ64CFrGM
         QcC6+yKq6yvufHWG3tXK9f6J/kCP0syET4S38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Uvm8x7U8m6io/zwEGOZg4M6909l4TYgbAdRzlEBnopATyS/aJoqvvBVY9v5hSENcug
         KZf8UoFFWVWpoZ3RcMX7YpYGkMNTvFK15/qz9cSkVGYPCtVjiHQz8r0dQdDTIOoSc5C8
         XW+2qsOt6y+KZh35Xxl8V1CaoabT0pRgcN23s=
Received: by 10.224.69.161 with SMTP id z33mr2112697qai.59.1257484268241;
        Thu, 05 Nov 2009 21:11:08 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 21sm1029283qyk.12.2009.11.05.21.11.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 21:11:07 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257484241-27219-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132272>

Teach fetch --prune, as an alternative to git remote prune.
---
 builtin-fetch.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 985b36b..e8a5b9b 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -23,7 +23,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int append, dry_run, force, keep, update_head_ok, verbosity;
+static int append, dry_run, force, keep, prune, update_head_ok, verbosity;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -42,6 +42,8 @@ static struct option builtin_fetch_options[] = {
 		    "fetch all tags and associated objects", TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
+	OPT_BOOLEAN('p', "prune", &prune,
+		    "prune tracking branches no longer on remote"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
@@ -489,6 +491,22 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	return ret;
 }
 
+static int prune_refs(struct transport *transport, struct ref *ref_map)
+{
+	int result = 0;
+	struct ref *ref, *stale_refs = get_stale_heads(transport->remote, ref_map);
+	for (ref = stale_refs; ref; ref = ref->next) {
+		if (!dry_run)
+			result |= delete_ref(ref->name, NULL, 0);
+		if (verbosity >= 0)
+			fprintf(stderr, " x %-*s %-*s -> %s\n",
+				SUMMARY_WIDTH, "[deleted]",
+				REFCOL_WIDTH, "(none)", prettify_refname(ref->name));
+	}
+	free_refs(stale_refs);
+	return 0;
+}
+
 static int add_existing(const char *refname, const unsigned char *sha1,
 			int flag, void *cbdata)
 {
@@ -613,6 +631,8 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		return 1;
 	}
+	if (prune)
+		prune_refs(transport, ref_map);
 	free_refs(ref_map);
 
 	/* if neither --no-tags nor --tags was specified, do automated tag
-- 
1.6.4.2
