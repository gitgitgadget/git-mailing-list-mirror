From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bundle: allow rev-list options to exclude annotated tags
Date: Fri, 2 Jan 2009 19:08:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021725530.27818@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 02 19:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIoTH-0002tl-EV
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247AbZABSIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759018AbZABSIV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:08:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:47302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758247AbZABSIU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:08:20 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:08:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 02 Jan 2009 19:08:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xK2Ui5OexT8hiVjmutJIsrjfZKt3Req2/pl9sgl
	lGksKr+65iBxYo
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104394>


With options such as "--all --since=2.weeks.ago", annotated tags used to
be included, when they should have been excluded.  The reason is that we
heavily abuse the revision walker to determine what needs to be included
or excluded.  And the revision walker does not show tags at all (and
therefore never marks tags as uninteresting).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bundle.c          |   32 ++++++++++++++++++++++++++++++++
 t/t5704-bundle.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100755 t/t5704-bundle.sh

diff --git a/bundle.c b/bundle.c
index daecd8e..4977962 100644
--- a/bundle.c
+++ b/bundle.c
@@ -167,6 +167,32 @@ int list_bundle_refs(struct bundle_header *header, int argc, const char **argv)
 	return list_refs(&header->references, argc, argv);
 }
 
+static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
+{
+	unsigned long size;
+	enum object_type type;
+	char *buf, *line, *lineend;
+	unsigned long date;
+
+	if (revs->max_age == -1 && revs->min_age == -1)
+		return 1;
+
+	buf = read_sha1_file(tag->sha1, &type, &size);
+	if (!buf)
+		return 1;
+	line = memmem(buf, size, "\ntagger ", 8);
+	if (!line++)
+		return 1;
+	lineend = memchr(line, buf + size - line, '\n');
+	line = memchr(line, lineend ? lineend - line : buf + size - line, '>');
+	if (!line++)
+		return 1;
+	date = strtoul(line, NULL, 10);
+	free(buf);
+	return (revs->max_age == -1 || revs->max_age < date) &&
+		(revs->min_age == -1 || revs->min_age > date);
+}
+
 int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv)
 {
@@ -255,6 +281,12 @@ int create_bundle(struct bundle_header *header, const char *path,
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
+		if (e->item->type == OBJ_TAG &&
+				!is_tag_in_date_range(e->item, &revs)) {
+			e->item->flags |= UNINTERESTING;
+			continue;
+		}
+
 		/*
 		 * Make sure the refs we wrote out is correct; --max-count and
 		 * other limiting options could have prevented all the tips
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
new file mode 100755
index 0000000..a8f4419
--- /dev/null
+++ b/t/t5704-bundle.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='some bundle related tests'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	: > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	test_tick &&
+	git tag -m tag tag &&
+	: > file2 &&
+	git add file2 &&
+	: > file3 &&
+	test_tick &&
+	git commit -m second &&
+	git add file3 &&
+	test_tick &&
+	git commit -m third
+
+'
+
+test_expect_success 'tags can be excluded by rev-list options' '
+
+	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
+	git ls-remote bundle > output &&
+	! grep tag output
+
+'
+
+test_done
-- 
1.6.1.rc3.224.g95ac9
