From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/8] bundle: use libified rev-list --boundary
Date: Sat, 26 Jun 2010 01:20:05 -0500
Message-ID: <20100626062005.GC15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:20:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOkc-0006sx-1G
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab0FZGUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 02:20:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52224 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZGUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:20:18 -0400
Received: by iwn41 with SMTP id 41so2711242iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=X3ubA872EWTB1gGEiyUNis/1seYtLDAAThR90eLyccE=;
        b=C50dQOR1aAjMNoYZagXS4CCTGlYOAKZ2U5Vog25O/Ao44d3eWiY42LEb2IcIySLm7Z
         JxXU9FAyS1DP8V7q632t0tG2XPk8fCe0Pyr5ZfiM3erXi5Ws5fYuTdEmMZ0zSIOxc2mB
         Nv6tS8IvtC/TU5JeOMJtbTR5gO/b7w163JuSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PH6kXMpYEYQjhdJRv7JlNIq+HPCEQs4DYovC+lADZ+535GV65FOiLYYd2SWy2x0IJl
         UUjoo0WnU4oIgdGIADdfayeG0HTP/7uzgmYdA2C2X9n4DcmTh7ExQt9PyZHZEtpoCXuE
         Tyr4Ns5b0g6BGghmqxTkS+oD8CYr8xBEXLm0s=
Received: by 10.231.149.202 with SMTP id u10mr1888796ibv.56.1277533216946;
        Fri, 25 Jun 2010 23:20:16 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v23sm4298379ibp.21.2010.06.25.23.20.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:20:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626061735.GA15881@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149730>

The revision walker produces structured output, which should be a
little easier to work with than the text from rev-list.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 bundle.c |   69 ++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/bundle.c b/bundle.c
index 66948f4..0dd2acb 100644
--- a/bundle.c
+++ b/bundle.c
@@ -196,40 +196,47 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 static int list_prerequisites(int bundle_fd, struct rev_info *revs,
 		int argc, const char * const *argv)
 {
-	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
-	char buffer[1024];
-	struct child_process rls;
-	FILE *rls_fout;
+	const char **argv_boundary = xmalloc((argc + 1) * sizeof(const char *));
+	struct rev_info boundary_revs;
+	struct commit *rev;
 
-	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
-	argv_boundary[0] = "rev-list";
-	argv_boundary[1] = "--boundary";
-	argv_boundary[2] = "--pretty=oneline";
-	argv_boundary[argc + 2] = NULL;
-	memset(&rls, 0, sizeof(rls));
-	rls.argv = argv_boundary;
-	rls.out = -1;
-	rls.git_cmd = 1;
-	if (start_command(&rls))
-		return -1;
-	rls_fout = xfdopen(rls.out, "r");
-	while (fgets(buffer, sizeof(buffer), rls_fout)) {
-		unsigned char sha1[20];
-		if (buffer[0] == '-') {
-			write_or_die(bundle_fd, buffer, strlen(buffer));
-			if (!get_sha1_hex(buffer + 1, sha1)) {
-				struct object *object = parse_object(sha1);
-				object->flags |= UNINTERESTING;
-				add_pending_object(revs, object, buffer);
-			}
-		} else if (!get_sha1_hex(buffer, sha1)) {
-			struct object *object = parse_object(sha1);
-			object->flags |= SHOWN;
+	memcpy(argv_boundary, argv, (argc + 1) * sizeof(const char *));
+
+	init_revisions(&boundary_revs, NULL);
+	boundary_revs.boundary = 1;
+	if (setup_revisions(argc, argv_boundary, &boundary_revs, NULL) > 1)
+		return error("unrecognized argument: %s", argv_boundary[1]);
+	if (prepare_revision_walk(&boundary_revs))
+		return error("revision walk setup failed");
+
+	while ((rev = get_revision(&boundary_revs))) {
+		if (rev->object.flags & BOUNDARY) {
+			struct strbuf buf = STRBUF_INIT;
+			struct pretty_print_context ctx = {0};
+			enum object_type type;
+			unsigned long size;
+
+			/*
+			 * The commit buffer is needed
+			 * to pretty-print boundary commits.
+			 */
+			rev->buffer = read_sha1_file(rev->object.sha1,
+							&type, &size);
+
+			strbuf_addch(&buf, '-');
+			strbuf_add(&buf, sha1_to_hex(rev->object.sha1), 40);
+			strbuf_addch(&buf, ' ');
+			pretty_print_commit(CMIT_FMT_ONELINE, rev, &buf, &ctx);
+			strbuf_addch(&buf, '\n');
+			write_or_die(bundle_fd, buf.buf, buf.len);
+
+			rev->object.flags |= UNINTERESTING;
+			add_pending_object(revs, &rev->object, buf.buf);
+			strbuf_release(&buf);
+		} else {
+			rev->object.flags |= SHOWN;
 		}
 	}
-	fclose(rls_fout);
-	if (finish_command(&rls))
-		return error("rev-list died");
 	return 0;
 }
 
-- 
1.7.1.198.g8d802
