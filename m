From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/8] bundle: split basis discovery into its own function
Date: Sat, 26 Jun 2010 01:19:04 -0500
Message-ID: <20100626061904.GB15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOjf-0006b8-LS
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab0FZGTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 02:19:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39319 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZGTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:19:16 -0400
Received: by iwn41 with SMTP id 41so2710823iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C+/39g9aoks7pAkqAzmwgp+4gzvE4f5AhbLI+Pty+5k=;
        b=bLwXQkxf0G9d3PhWiREbKwslW88O1lZ9wn3WWy3FZmWpWa78Wf6r2FtlktJkx2oThM
         7w9RMGWcl078FQoEoWQrklaqvNcolcbM7/TD6XPRFdCZsWexBqZDVD86keNBCOY4e0aD
         mgrZ5sagKrZb8xtfG2hqZzcfZ3g+wls5wK2jA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=o5uGAJ6PjF0rm0Y7pvSBkBAVz24TdwoJvfegajdpJObmoykmO8hXS5Uj+1qD0ENImS
         St9M8IzkA4MaaQNn9n4o+kbvKKTlzxglIt+OaPz02a0QqLvaQlvSf2kF/CO/LllU1VQJ
         57IHzOUl3qMb2bNlJ8ZB8+IpjFMr1sKddg0zc=
Received: by 10.231.167.141 with SMTP id q13mr1856016iby.34.1277533156409;
        Fri, 25 Jun 2010 23:19:16 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id cw14sm3975792ibb.13.2010.06.25.23.19.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:19:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626061735.GA15881@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149729>

create_bundle() is getting a little long.  Isolate a small
piece to work on without distractions.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 bundle.c |   58 ++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/bundle.c b/bundle.c
index ff97adc..66948f4 100644
--- a/bundle.c
+++ b/bundle.c
@@ -193,35 +193,14 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 		(revs->min_age == -1 || revs->min_age > date);
 }
 
-int create_bundle(struct bundle_header *header, const char *path,
-		int argc, const char **argv)
+static int list_prerequisites(int bundle_fd, struct rev_info *revs,
+		int argc, const char * const *argv)
 {
-	static struct lock_file lock;
-	int bundle_fd = -1;
-	int bundle_to_stdout;
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
-	const char **argv_pack = xmalloc(5 * sizeof(const char *));
-	int i, ref_count = 0;
 	char buffer[1024];
-	struct rev_info revs;
 	struct child_process rls;
 	FILE *rls_fout;
 
-	bundle_to_stdout = !strcmp(path, "-");
-	if (bundle_to_stdout)
-		bundle_fd = 1;
-	else
-		bundle_fd = hold_lock_file_for_update(&lock, path,
-						      LOCK_DIE_ON_ERROR);
-
-	/* write signature */
-	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
-
-	/* init revs to list objects for pack-objects later */
-	save_commit_buffer = 0;
-	init_revisions(&revs, NULL);
-
-	/* write prerequisites */
 	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
 	argv_boundary[0] = "rev-list";
 	argv_boundary[1] = "--boundary";
@@ -241,7 +220,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 			if (!get_sha1_hex(buffer + 1, sha1)) {
 				struct object *object = parse_object(sha1);
 				object->flags |= UNINTERESTING;
-				add_pending_object(&revs, object, buffer);
+				add_pending_object(revs, object, buffer);
 			}
 		} else if (!get_sha1_hex(buffer, sha1)) {
 			struct object *object = parse_object(sha1);
@@ -251,6 +230,37 @@ int create_bundle(struct bundle_header *header, const char *path,
 	fclose(rls_fout);
 	if (finish_command(&rls))
 		return error("rev-list died");
+	return 0;
+}
+
+int create_bundle(struct bundle_header *header, const char *path,
+		int argc, const char **argv)
+{
+	static struct lock_file lock;
+	int bundle_fd = -1;
+	int bundle_to_stdout;
+	const char **argv_pack = xmalloc(5 * sizeof(const char *));
+	int i, ref_count = 0;
+	struct rev_info revs;
+	struct child_process rls;
+
+	bundle_to_stdout = !strcmp(path, "-");
+	if (bundle_to_stdout)
+		bundle_fd = 1;
+	else
+		bundle_fd = hold_lock_file_for_update(&lock, path,
+						      LOCK_DIE_ON_ERROR);
+
+	/* write signature */
+	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
+
+	/* init revs to list objects for pack-objects later */
+	save_commit_buffer = 0;
+	init_revisions(&revs, NULL);
+
+	/* write prerequisites */
+	if (list_prerequisites(bundle_fd, &revs, argc, argv))
+		return -1;
 
 	/* write references */
 	argc = setup_revisions(argc, argv, &revs, NULL);
-- 
1.7.1.198.g8d802
