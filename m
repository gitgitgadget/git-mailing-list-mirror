From: Phil Hord <phil.hord@gmail.com>
Subject: [PATCH 3/4] Teach transport about the gitfile mechanism
Date: Tue, 4 Oct 2011 16:08:20 -0400
Message-ID: <CABURp0qkVcpNRyEg8gcNPjv2KbRbdHYk1XsqCjkp8Yrf7T_Lkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:08:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBIF-0007WJ-6s
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933603Ab1JDUIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:08:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47213 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933403Ab1JDUIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:08:42 -0400
Received: by wwf22 with SMTP id 22so1382228wwf.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=z51sMTDzMU8v0uN/LBxBYz/q1NdackvQnhn6MPoYb5A=;
        b=HiSdZOg3A9GwKWNvUhzuGpCX7Rp2WfO14KT0eEOQGq5DpY+N3tHYxs4nfrLp76bUPN
         WlXKeiu6n12o3xcnyTmokqW5jO5TOCA75jgpJ013OnULoVJwGkbychQlzd1ZbDVHkru6
         Plwr7wGrytQ1D/RgKMKwJVCprD4XefgIc3O20=
Received: by 10.216.80.69 with SMTP id j47mr5565789wee.102.1317758921106; Tue,
 04 Oct 2011 13:08:41 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 13:08:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182794>

The transport_get() function assumes that a regular file is a
bundle rather than a local git directory. Look inside the file
for the telltale "gitlink: " header to see if it is actually a
gitfile.  If so, do not try to process it as a bundle, but
treat it as a local repository instead.

Signed-off-by: Phil Hord <hordp@cisco.com>

diff --git a/transport.c b/transport.c
index cd49a25..f7017c1 100644
--- a/transport.c
+++ b/transport.c
@@ -867,6 +867,28 @@ static int is_local(const char *url)
 		has_dos_drive_prefix(url);
 }

+static int is_gitfile(const char *url)
+{
+	struct stat st;
+	char buf[9];
+	int fd, len;
+	if (stat(url, &st))
+		return 0;
+	if (!S_ISREG(st.st_mode))
+		return 0;
+	if (st.st_size < 10 || st.st_size > PATH_MAX)
+		return 1;
+
+	fd = open(url, O_RDONLY);
+	if (fd < 0)
+		die_errno("Error opening '%s'", url);
+	len = read_in_full(fd, buf, sizeof(buf));
+	close(fd);
+	if (len != sizeof(buf))
+		die("Error reading %s", url);
+	return !prefixcmp(buf, "gitdir: ");
+}
+
 static int is_file(const char *url)
 {
 	struct stat buf;
@@ -915,7 +937,7 @@ struct transport *transport_get(struct remote
*remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 		ret->smart_options = NULL;
-	} else if (is_local(url) && is_file(url)) {
+	} else if (is_local(url) && is_file(url) && !is_gitfile(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->get_refs_list = get_refs_from_bundle;
-- 
1.7.7.503.g26392.dirty
