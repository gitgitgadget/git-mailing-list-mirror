From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] gitignore: read from index if .gitignore is not in worktree
Date: Wed, 29 Jul 2009 16:49:12 +1000
Message-ID: <1248850154-5469-4-git-send-email-pclouds@gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
 <1248850154-5469-2-git-send-email-pclouds@gmail.com>
 <1248850154-5469-3-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 08:49:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW2yy-0003qW-HC
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 08:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbZG2Gtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 02:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZG2Gtj
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 02:49:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:8079 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbZG2Gtj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 02:49:39 -0400
Received: by wa-out-1112.google.com with SMTP id j5so89055wah.21
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=JUC8nX8bgbYoxxF3jDhcWA1zQVqOqNdmBLY1Rwoig+A=;
        b=kOxIJF0uYRBAcc6lA2CagXC54xioLcQ7v6HoH75FCImGKfMW8wW7skDny/QqPYqXof
         /90RFiaUPHbY54/T+BEcO5VMuKSprmfv89hXsOi9815K4Mfb3YRbmpdd3IRsvUdAlfRw
         hYhrhXVsThXDPkFUOn6yzsE0OhHYRHj0+VKW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fvBOXA5Xs+uuM+FjldNmmlslhvw3WVOrG9leT4TXpkWZaqJdAJwak1lIeGCFZxKRBd
         wPYPtIIVAfhAATNK3mzq/2l9velvBodEX/os8ZahWHizLe/+MyXqoUIoGy8ArUE4NDej
         HvABg+EZaG4IgQFiEF8eZMML5mjr2ccZ9gj3k=
Received: by 10.114.154.8 with SMTP id b8mr13186791wae.194.1248850178961;
        Tue, 28 Jul 2009 23:49:38 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id k37sm852300waf.42.2009.07.28.23.49.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 23:49:38 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 29 Jul 2009 16:49:33 +1000
X-Mailer: git-send-email 1.6.3.2.448.gdf8b6
In-Reply-To: <1248850154-5469-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124312>

this allows to use .gitignore in sparse mode, where .gitignore may or
may not be checked out (CE_VALID)
---
 dir.c                              |   70 ++++++++++++++++++++++++------------
 t/t3001-ls-files-others-exclude.sh |   20 ++++++++++
 2 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index e05b850..86bc90c 100644
--- a/dir.c
+++ b/dir.c
@@ -200,11 +200,36 @@ void add_exclude(const char *string, const char *base,
 	which->excludes[which->nr++] = x;
 }
 
+static void *read_index_data(const char *path, size_t *size)
+{
+	int pos, len;
+	unsigned long sz;
+	enum object_type type;
+	void *data;
+	struct index_state *istate = &the_index;
+
+	len = strlen(path);
+	pos = index_name_pos(istate, path, len);
+	if (pos < 0)
+		return NULL;
+	/* only applies to no-checkout items */
+	if (!(istate->cache[pos]->ce_flags & CE_VALID))
+		return NULL;
+	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	if (!data || type != OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	*size = xsize_t(sz);
+	return data;
+}
+
 static int add_excludes_from_file_1(const char *fname,
 				    const char *base,
 				    int baselen,
 				    char **buf_p,
-				    struct exclude_list *which)
+				    struct exclude_list *which,
+				    int check_index)
 {
 	struct stat st;
 	int fd, i;
@@ -212,27 +237,31 @@ static int add_excludes_from_file_1(const char *fname,
 	char *buf, *entry;
 
 	fd = open(fname, O_RDONLY);
-	if (fd < 0 || fstat(fd, &st) < 0)
-		goto err;
-	size = xsize_t(st.st_size);
-	if (size == 0) {
-		close(fd);
-		return 0;
+	if (fd < 0 || fstat(fd, &st) < 0) {
+		if (0 <= fd)
+			close(fd);
+		if (!check_index || (buf = read_index_data(fname, &size)) == NULL)
+			return -1;
 	}
-	buf = xmalloc(size+1);
-	if (read_in_full(fd, buf, size) != size)
-	{
-		free(buf);
-		goto err;
+	else {
+		size = xsize_t(st.st_size);
+		if (size == 0) {
+			close(fd);
+			return 0;
+		}
+		buf = xmalloc(size);
+		if (read_in_full(fd, buf, size) != size) {
+			close(fd);
+			return -1;
+		}
+		close(fd);
 	}
-	close(fd);
 
 	if (buf_p)
 		*buf_p = buf;
-	buf[size++] = '\n';
 	entry = buf;
-	for (i = 0; i < size; i++) {
-		if (buf[i] == '\n') {
+	for (i = 0; i <= size; i++) {
+		if (i == size || buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
 				add_exclude(entry, base, baselen, which);
@@ -241,17 +270,12 @@ static int add_excludes_from_file_1(const char *fname,
 		}
 	}
 	return 0;
-
- err:
-	if (0 <= fd)
-		close(fd);
-	return -1;
 }
 
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
 	if (add_excludes_from_file_1(fname, "", 0, NULL,
-				     &dir->exclude_list[EXC_FILE]) < 0)
+				     &dir->exclude_list[EXC_FILE], 0) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
@@ -302,7 +326,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
 		add_excludes_from_file_1(dir->basebuf,
 					 dir->basebuf, stk->baselen,
-					 &stk->filebuf, el);
+					 &stk->filebuf, el, 1);
 		dir->exclude_stack = stk;
 		current = stk->baselen;
 	}
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index c65bca8..e8b25d3 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -85,6 +85,26 @@ test_expect_success \
        >output &&
      test_cmp expect output'
 
+test_expect_success 'setup sparse gitignore' '
+	git add .gitignore one/.gitignore one/two/.gitignore &&
+	git update-index --no-checkout .gitignore one/.gitignore one/two/.gitignore &&
+	rm .gitignore one/.gitignore one/two/.gitignore
+'
+
+test_expect_success \
+    'git ls-files --others with various exclude options.' \
+    'git ls-files --others \
+       --exclude=\*.6 \
+       --exclude-per-directory=.gitignore \
+       --exclude-from=.git/ignore \
+       >output &&
+     test_cmp expect output'
+
+test_expect_success 'restore gitignore' '
+	git checkout .gitignore one/.gitignore one/two/.gitignore &&
+	rm .git/index
+'
+
 cat > excludes-file <<\EOF
 *.[1-8]
 e*
-- 
1.6.3.2.448.gdf8b6
