From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/32] read-cache: save index SHA-1 after reading
Date: Fri, 13 Jun 2014 19:19:35 +0700
Message-ID: <1402661991-14977-17-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:21:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQUM-0003l6-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbaFMMVm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:21:42 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:40277 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaFMMVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:21:41 -0400
Received: by mail-pd0-f181.google.com with SMTP id v10so1195819pde.26
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9Ux3hkoVNw5LG/ZfZ4UZgE0D0PPGIAMCm4S+89a8xNQ=;
        b=dQ4fqIcw32V2tJIsV+VIaDQJCNPdVxx3RLYnH3ofd/+zFeQQgvSZz7lpsriMH+BV7Y
         jsPTehl1g8PyTVG/I1mQERL5swePOOu3vkPqXYJx+HMpGDOVxv/Z+9tdhzwX+KUWMQT+
         WK0j8DBkL2f69l6VdgVIAGgtKrulzZuLkGJl9Jdw+a95L9xXekYDBMa0dCo3BcKRTJdv
         MTe58JY5mYDOdskr0BY3FLjOy/IW0mQwJy5CqUODuJO0/T7EVRZ9cdew7YLMpSnPsj/F
         LGJPQh6Z82DV9mqoe4rmiXYnd0QjdhLhV+MsxyXEPNwvs0Cu7GThLNh0vYoIBQnYaFET
         EuIw==
X-Received: by 10.68.190.98 with SMTP id gp2mr151267pbc.88.1402662101488;
        Fri, 13 Jun 2014 05:21:41 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id lq6sm20671987pab.48.2014.06.13.05.21.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:21:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:21:41 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251572>

Also update SHA-1 after writing. If we do not do that, the second
read_index() will see "initialized" variable already set and not read
=2Egit/index again, which is fine, except istate->sha1 now has a stale
value.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        | 1 +
 read-cache.c   | 6 ++++--
 unpack-trees.c | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index bf09d1c..41cdcd0 100644
--- a/cache.h
+++ b/cache.h
@@ -286,6 +286,7 @@ struct index_state {
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
+	unsigned char sha1[20];
 };
=20
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index d1ad227..b4653c0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1481,6 +1481,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
=20
+	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
 	istate->version =3D ntohl(hdr->hdr_version);
 	istate->cache_nr =3D ntohl(hdr->hdr_entries);
 	istate->cache_alloc =3D alloc_nr(istate->cache_nr);
@@ -1616,7 +1617,7 @@ static int write_index_ext_header(git_SHA_CTX *co=
ntext, int fd,
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
=20
-static int ce_flush(git_SHA_CTX *context, int fd)
+static int ce_flush(git_SHA_CTX *context, int fd, unsigned char *sha1)
 {
 	unsigned int left =3D write_buffer_len;
=20
@@ -1634,6 +1635,7 @@ static int ce_flush(git_SHA_CTX *context, int fd)
=20
 	/* Append the SHA1 signature at the end */
 	git_SHA1_Final(write_buffer + left, context);
+	hashcpy(sha1, write_buffer + left);
 	left +=3D 20;
 	return (write_in_full(fd, write_buffer, left) !=3D left) ? -1 : 0;
 }
@@ -1872,7 +1874,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd)
 			return -1;
 	}
=20
-	if (ce_flush(&c, newfd) || fstat(newfd, &st))
+	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
 		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
diff --git a/unpack-trees.c b/unpack-trees.c
index 26f65c7..f594932 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1046,6 +1046,7 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 	o->result.timestamp.sec =3D o->src_index->timestamp.sec;
 	o->result.timestamp.nsec =3D o->src_index->timestamp.nsec;
 	o->result.version =3D o->src_index->version;
+	hashcpy(o->result.sha1, o->src_index->sha1);
 	o->merge_size =3D len;
 	mark_all_ce_unused(o->src_index);
=20
--=20
1.9.1.346.ga2b5940
