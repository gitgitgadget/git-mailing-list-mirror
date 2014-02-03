From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 18/26] file-watcher: inotify support, notification part
Date: Mon,  3 Feb 2014 11:29:06 +0700
Message-ID: <1391401754-15347-19-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBd-0001Ra-PW
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbaBCEbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:05 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39143 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbaBCEbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:03 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so6584980pbc.4
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/IX1sfFaPfogIvAyLu1u4vHTqE7xabq3RxDZ6Pcbx28=;
        b=T/KnKpnENYwc9xTrrv3t7gXNEFLTSeBu/1i98doQ6e+0J42QFb67slncoE12O53fMr
         uvxm0zgVClPuk+HcXObepGhM2RMvb1C6O0RNgPr/BkHcLN38AIUB+JYB3EJv02ODPifR
         J1dVTykbh6/XXLhgX3Q0hyCMShPcDbe33/S2Mh1h0laaFnwTGYLNyVuuan0wksp6aIwB
         eZSf6CT4XShSMDjBdjmW2MXmep2cG5Zllk4zOK5+Rizgd1J0dWnF1yuwh5xls0eMpnE0
         L3QsEQjJMjrbuCmu4t0dsZKw82MPMsX+jgkAaz5EGUH2mTMjl+uIMUOBuBhDviipIRUZ
         4GcQ==
X-Received: by 10.68.241.101 with SMTP id wh5mr34865984pbc.134.1391401862350;
        Sun, 02 Feb 2014 20:31:02 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id cz3sm51425609pbc.9.2014.02.02.20.30.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:00 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241413>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/file-watcher.c b/file-watcher.c
index d0762e6..5867942 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -260,6 +260,131 @@ static int watch_path(struct repository *repo, ch=
ar *path)
 	return 0;
 }
=20
+static inline void queue_file_changed(struct file *f, struct strbuf *s=
b)
+{
+	int len =3D sb->len;
+	strbuf_addf(sb, "%s%s", f->parent->parent ? "/" : "", f->name);
+	string_list_append(&f->repo->updated, sb->buf);
+	f->repo->updated_sorted =3D 0;
+	strbuf_setlen(sb, len);
+}
+
+static void construct_path(struct dir *d, struct strbuf *sb)
+{
+	if (!d->parent)
+		return;
+	if (!d->parent->parent) {
+		strbuf_addstr(sb, d->name);
+		return;
+	}
+	construct_path(d->parent, sb);
+	strbuf_addf(sb, "/%s", d->name);
+}
+
+static void file_changed(const struct inotify_event *event,
+			 struct dir *d, int pos)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	construct_path(d, &sb);
+	queue_file_changed(d->files[pos], &sb);
+	strbuf_release(&sb);
+	free_file(d, pos, 0);
+}
+
+static void dir_changed(const struct inotify_event *event, struct dir =
*d,
+			const char *base)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i;
+
+	if (!base)		/* top call -> base =3D=3D NULL */
+		construct_path(d, &sb);
+	else {
+		strbuf_addstr(&sb, base);
+		if (sb.len)
+			strbuf_addch(&sb, '/');
+		strbuf_addstr(&sb, d->name);
+	}
+
+	for (i =3D 0; i < d->nr_files; i++)
+		queue_file_changed(d->files[i], &sb);
+	for (i =3D 0; i < d->nr_subdirs; i++) {
+		dir_changed(event, d->subdirs[i], sb.buf);
+		if (!base)
+			free_dir(d->subdirs[i], 1);
+	}
+	strbuf_release(&sb);
+	if (!base)
+		free_dir(d, 0);
+}
+
+static void reset_repo(struct repository *repo, ino_t inode);
+static int do_handle_inotify(const struct inotify_event *event)
+{
+	struct dir *d;
+	int pos;
+
+	if (event->mask & (IN_Q_OVERFLOW | IN_UNMOUNT)) {
+		int i;
+		for (i =3D 0; i < nr_repos; i++)
+			reset_repo(repos[i], 0);
+		return 0;
+	}
+
+	if ((event->mask & IN_IGNORED) ||
+	    /*
+	     * Perhaps left over events that we have not consumed
+	     * before the watch descriptor is removed.
+	     */
+	    event->wd >=3D wds_alloc || wds[event->wd] =3D=3D NULL)
+		return 0;
+
+	d =3D wds[event->wd];
+
+	/*
+	 * If something happened to the watched directory, consider
+	 * everything inside modified
+	 */
+	if (event->mask & (IN_DELETE_SELF | IN_MOVE_SELF)) {
+		dir_changed(event, d, NULL);
+		return 0;
+	}
+
+	if (!(event->mask & IN_ISDIR)) {
+		pos =3D get_file_pos(d, event->name);
+		if (pos >=3D 0)
+			file_changed(event, d, pos);
+	}
+
+	return 0;
+}
+
+static int handle_inotify(int fd)
+{
+	static char *buf;
+	static unsigned int buf_len =3D 0;
+	unsigned int avail, offset;
+	int ret, len;
+
+	/* drain the event queue */
+	if (ioctl(fd, FIONREAD, &avail))
+		die_errno("unable to FIONREAD inotify handle");
+	if (buf_len < avail) {
+		buf =3D xrealloc(buf, avail);
+		buf_len =3D avail;
+	}
+	len =3D read(fd, buf, avail);
+	if (len <=3D 0)
+		return -1;
+	ret =3D offset =3D 0;
+	while (offset < len) {
+		struct inotify_event *event =3D (void *)(buf + offset);
+		ret +=3D do_handle_inotify(event);
+		offset +=3D sizeof(struct inotify_event) + event->len;
+	}
+	return ret;
+}
+
 static void get_changed_list(int conn_id)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -466,6 +591,12 @@ static int handle_command(int conn_id)
 	 * capabilities. Capabilities in uppercase MUST be
 	 * supported. If any side does not understand any of the
 	 * advertised uppercase capabilities, it must disconnect.
+	 *
+	 * The way the main event loop is structured, we should get at
+	 * least one handle_inotify() before receiving the next
+	 * command. And handle_inotify() should process all events by
+	 * this point of time. This guarantees our reports won't miss
+	 * anything by the time get-changed is called.
 	 */
 	if ((arg =3D skip_prefix(msg, "hello"))) {
 		if (*arg) {	/* no capabilities supported yet */
@@ -753,11 +884,15 @@ int main(int argc, const char **argv)
 		close(err);
 	}
=20
-	nr_common =3D 1;
+	nr_common =3D 1 + !!inotify_fd;
 	pfd_alloc =3D pfd_nr =3D nr_common;
 	pfd =3D xmalloc(sizeof(*pfd) * pfd_alloc);
 	pfd[0].fd =3D fd;
 	pfd[0].events =3D POLLIN;
+	if (inotify_fd) {
+		pfd[1].fd =3D inotify_fd;
+		pfd[1].events =3D POLLIN;
+	}
=20
 	while (!quit) {
 		if (poll(pfd, pfd_nr, -1) < 0) {
@@ -769,6 +904,11 @@ int main(int argc, const char **argv)
 			continue;
 		}
=20
+		if (inotify_fd && (pfd[1].revents & POLLIN)) {
+			if (handle_inotify(inotify_fd))
+				break;
+		}
+
 		for (new_nr =3D i =3D nr_common; i < pfd_nr; i++) {
 			if (pfd[i].revents & (POLLERR | POLLNVAL))
 				shutdown_connection(i);
--=20
1.8.5.2.240.g8478abd
