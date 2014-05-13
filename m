From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] read-cache: try index data from shared memory
Date: Tue, 13 May 2014 18:15:34 +0700
Message-ID: <1399979737-8577-8-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAhB-0000Rc-De
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760710AbaEMLQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:16:24 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:45171 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760675AbaEMLQW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:16:22 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so163088pbb.35
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=keEy10iRuFwHPCIHslX9aukxKBrPSk4K3OeAgaUcJpo=;
        b=QJyyZCv0rZJnb28NWIEFNzZTVJwEuJffkZPeenH9oxP/kvUzGUfwu/sVp4Qwkt1WwL
         WAqFUb5aubbvmHysbyzaWtenZSMs8zAczxh5pAffgkrqKzmqOH/A9H7nvEsAcmX7W8bI
         VmZ+0kdM8sWzeuL+Aucb2ScAx3EIA8YrEpJ6clGCHZ1VnObEDL5H8xbqOOUpcNGyVMb0
         nHiYoSwIeRvyVx0n5SV8ZfaMqmgVs22EncGHBoxbaNXXyWD66VMSTGboGpEBXnxy3WSc
         LfrRbm+6QxzNWx1UnjgAT5BAZC+H76UU2xIpCWK1a9LW+QiABa6n0HMqFpTLATd2zjfm
         FZIw==
X-Received: by 10.66.65.204 with SMTP id z12mr63516767pas.60.1399979781391;
        Tue, 13 May 2014 04:16:21 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id au16sm60437109pac.27.2014.05.13.04.16.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:16:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:16:27 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248767>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  4 ++++
 cache.h                  |  1 +
 config.c                 | 12 ++++++++++++
 environment.c            |  1 +
 read-cache.c             | 43 ++++++++++++++++++++++++++++++++++++++++=
+++
 submodule.c              |  1 +
 6 files changed, 62 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d8b6cc9..ccbe00b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -617,6 +617,10 @@ relatively high IO latencies.  With this set to 't=
rue', Git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.
=20
+core.useReadCacheDaemon::
+	Use `git read-cache--daemon` to speed up index reading. See
+	linkgit:git-read-cache--daemon for more information.
+
 core.createObject::
 	You can set this to 'link', in which case a hardlink followed by
 	a delete of the source are used to make sure that object creation
diff --git a/cache.h b/cache.h
index d0ff11c..fb29c7e 100644
--- a/cache.h
+++ b/cache.h
@@ -603,6 +603,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
+extern int use_read_cache_daemon;
=20
 /*
  * Do replace refs need to be checked this run?  This variable is
diff --git a/config.c b/config.c
index a30cb5c..5c832ad 100644
--- a/config.c
+++ b/config.c
@@ -874,6 +874,18 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+#ifdef HAVE_SHM
+	/*
+	 * Currently git-read-cache--daemon is only built when
+	 * HAVE_SHM is set. Ignore user settings if HAVE_SHM is not
+	 * defined.
+	 */
+	if (!strcmp(var, "core.usereadcachedaemon")) {
+		use_read_cache_daemon =3D git_config_bool(var, value);
+		return 0;
+	}
+#endif
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 5c4815d..b76a414 100644
--- a/environment.c
+++ b/environment.c
@@ -63,6 +63,7 @@ int merge_log_config =3D -1;
 int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+int use_read_cache_daemon;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/read-cache.c b/read-cache.c
index a5031f3..0e46523 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1462,6 +1462,48 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
+static void *try_shm(void *mmap, size_t *mmap_size)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	size_t old_size =3D *mmap_size;
+	void *new_mmap;
+	struct stat st;
+	int fd;
+
+	if (old_size <=3D 20 || !use_read_cache_daemon)
+		return mmap;
+
+	strbuf_addf(&sb, "/git-index-%s.lock",
+		    sha1_to_hex((unsigned char *)mmap + old_size - 20));
+	fd =3D shm_open(sb.buf, O_RDONLY, 0777);
+	if (fd >=3D 0) {
+		close(fd);
+		return mmap;
+	}
+	strbuf_setlen(&sb, sb.len - 5); /* no ".lock" */
+	fd =3D shm_open(sb.buf, O_RDONLY, 0777);
+	strbuf_release(&sb);
+	if (fd < 0)
+		/*
+		 * git-read-cache--daemon is probably not started yet. For
+		 * simplicity, only start it at the next index update, which
+		 * should happen often.
+		 */
+		return mmap;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return mmap;
+	}
+	new_mmap =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (new_mmap =3D=3D MAP_FAILED)
+		return mmap;
+	munmap(mmap, old_size);
+	*mmap_size =3D st.st_size;
+	return new_mmap;
+}
+
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1501,6 +1543,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	}
 	close(fd);
=20
+	mmap =3D try_shm(mmap, &mmap_size);
 	hdr =3D mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
diff --git a/submodule.c b/submodule.c
index b80ecac..9872928 100644
--- a/submodule.c
+++ b/submodule.c
@@ -195,6 +195,7 @@ void gitmodules_config(void)
 		int pos;
 		strbuf_addstr(&gitmodules_path, work_tree);
 		strbuf_addstr(&gitmodules_path, "/.gitmodules");
+		git_config(git_default_config, NULL);
 		if (read_cache() < 0)
 			die("index file corrupt");
 		pos =3D cache_name_pos(".gitmodules", 11);
--=20
1.9.1.346.ga2b5940
