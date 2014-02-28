From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH] rewrite bulk-checkin.c:finish_bulk_checkin() using strbuf
Date: Fri, 28 Feb 2014 13:28:25 +0530
Message-ID: <1393574305-24015-1-git-send-email-faiz.off93@gmail.com>
Cc: mhagger@alum.mit.edu, Faiz Kothari <faiz.off93@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 08:58:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJILQ-0005Xs-EJ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 08:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbaB1H6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 02:58:52 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48062 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaB1H6v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 02:58:51 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so436250pad.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 23:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rrd/Ivp8VeOgTU1OPZDaJTSCGnc/cWcuxDlqdGeyiT0=;
        b=FISVuBM66Tzuglv7vJ9e4xv5DyjY8TbnsYcccFsnlnFYm3VwdC8DhxqY4OlwASODeq
         yeOQbLySo7jIbP5F+UmKJoSqV7FA8O5NruE0XPJK84vt6pc0IdFEkHdhG4Fa0BWtOVXu
         AzFdnLZE7HJFjFoCvOdRQytgqu/MT/xdonupA76HYnD9BQiTqphJEWs3mqRg4q/rDpCm
         SeqU3O1c6FtikG4b93037aiVLYl45LcTyxx5mVaJU7fFFdTwb5Tsv/24qqCIrG+NCcxu
         ICdZBJ3/a6Q2Mox4KoLWL0gkn5tN4NFuf8OT/kmkpNqA208oY9WKRiWrlpETM7TRk36Z
         KDEw==
X-Received: by 10.68.172.37 with SMTP id az5mr1772620pbc.139.1393574330747;
        Thu, 27 Feb 2014 23:58:50 -0800 (PST)
Received: from dj-pc.bits-goa.ac.in ([115.248.130.148])
        by mx.google.com with ESMTPSA id f5sm7627060pat.11.2014.02.27.23.58.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 23:58:49 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242903>

Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>

Notes:
    I finally got what's happening, and why the errors were caused.
    packname is supposed to contain the complete path to the .pack file.
    Packs are stored as /path/to/<SHA1>.pack which I overlooked earlier.
    After inspecting what is happening in pack-write.c:finish_tmp_packfile()
    which indirectly modifies packname by appending the SHA1 and ".pack" to packname
    This is happening in these code snippets:
    	char *end_of_name_prefix = strrchr(name_buffer, 0);
    
    and later
    	sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
    
    name_buffer is packname.buf
    Using const for the first argument of pack-write.c:finish_tmp_packfile()
    doesnot raise any compile time warning or error and not any runtime errors,
    since the packname.buf is on heap and has extra space to which more char can be written.
    If this was not the case,
    	for e.g. passing a constant string and modifying it.
    	This will result in a segmentation fault.
---
 bulk-checkin.c |    8 +++++---
 pack-write.c   |    2 +-
 pack.h         |    2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 118c625..bbdf1ec 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -23,7 +23,7 @@ static struct bulk_checkin_state {
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	unsigned char sha1[20];
-	char packname[PATH_MAX];
+	struct strbuf packname = STRBUF_INIT;
 	int i;
 
 	if (!state->f)
@@ -42,9 +42,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 					 state->offset);
 		close(fd);
 	}
+	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
+	strbuf_grow(&packname, 40 + 5);
 
-	sprintf(packname, "%s/pack/pack-", get_object_directory());
-	finish_tmp_packfile(packname, state->pack_tmp_name,
+	finish_tmp_packfile(packname.buf, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, sha1);
 	for (i = 0; i < state->nr_written; i++)
@@ -53,6 +54,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 clear_exit:
 	free(state->written);
 	memset(state, 0, sizeof(*state));
+	strbuf_release(&packname);
 
 	/* Make objects we just wrote available to ourselves */
 	reprepare_packed_git();
diff --git a/pack-write.c b/pack-write.c
index 605d01b..ac38867 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -336,7 +336,7 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 	return sha1fd(fd, *pack_tmp_name);
 }
 
-void finish_tmp_packfile(char *name_buffer,
+void finish_tmp_packfile(const char *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
diff --git a/pack.h b/pack.h
index 12d9516..3b9e033 100644
--- a/pack.h
+++ b/pack.h
@@ -91,6 +91,6 @@ extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned ch
 extern int read_pack_header(int fd, struct pack_header *);
 
 extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
-extern void finish_tmp_packfile(char *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+extern void finish_tmp_packfile(const char *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
 
 #endif
-- 
1.7.9.5
