From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] sha1_file.c: rename move_temp_to_file() to finalize_temp_file()
Date: Fri, 07 Aug 2015 17:24:29 -0700
Message-ID: <xmqqh9oawrsy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 02:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNrwC-0006aT-FM
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 02:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946490AbbHHAYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 20:24:31 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34783 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946426AbbHHAYb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 20:24:31 -0400
Received: by pawu10 with SMTP id u10so98900257paw.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 17:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=LWROqgiXwTkbtuNd1r5uJn/iZExK3YmuqlRZFeESkIQ=;
        b=ya3+hDuhE7V2XyB5uml+ElqI8aqzSBgZY0TREEptws7e8ABx61heTEStSxdysTC0Ft
         A/xxll1xN+pJf6XK4gRD7vFnNlaOrywBLW9GSPo/muVuVFysRqj0TXb5FAxZ9nKYKpD6
         Km2lknRgb1d22w1pOmX5kCEt3ZzAU2PQVNFyHlnh7hjFhAUA7K8sYO3x+cEfqIQbqXwT
         LaJTDBzewsQRB3YvEi3ZS94FxhjPO681HrDVkNVt1vV6WnLgiWhI/FvUmsaNEabgW9+9
         91Zw1PppmFRoHNedrJ17rCGeiHAX2mWlRX15Iv98XZpKdK1ZLtcP5Gpsm+nyn/Bp2syd
         iLqg==
X-Received: by 10.68.200.225 with SMTP id jv1mr20298127pbc.63.1438993470602;
        Fri, 07 Aug 2015 17:24:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id sa9sm11411606pbc.18.2015.08.07.17.24.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 17:24:29 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275502>

Since 5a688fe4 ("core.sharedrepository = 0mode" should set, not
loosen, 2009-03-25), we kept reminding ourselves:

    NEEDSWORK: this should be renamed to finalize_temp_file() as
    "moving" is only a part of what it does, when no patch between
    master to pu changes the call sites of this function.

without doing anything about it.  Let's do so.

The purpose of this function was not to move but to finalize.  The
detail of the primarily implementation of finalizing was to link the
temporary file to its final name and then to unlink, which wasn't
even "moving".  The alternative implementation did "move" by calling
rename(2), which is a fun tangent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just something I noticed while reviewing that O_NOATIME topic...

 builtin/index-pack.c |  4 ++--
 cache.h              |  2 +-
 fast-import.c        |  4 ++--
 http.c               | 10 +++++-----
 sha1_file.c          |  7 ++-----
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9ca0203..7f417f5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1322,7 +1322,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				 get_object_directory(), sha1_to_hex(sha1));
 			final_pack_name = name;
 		}
-		if (move_temp_to_file(curr_pack_name, final_pack_name))
+		if (finalize_temp_file(curr_pack_name, final_pack_name))
 			die(_("cannot store pack file"));
 	} else if (from_stdin)
 		chmod(final_pack_name, 0444);
@@ -1333,7 +1333,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				 get_object_directory(), sha1_to_hex(sha1));
 			final_index_name = name;
 		}
-		if (move_temp_to_file(curr_index_name, final_index_name))
+		if (finalize_temp_file(curr_index_name, final_index_name))
 			die(_("cannot store index file"));
 	} else
 		chmod(final_index_name, 0444);
diff --git a/cache.h b/cache.h
index f23fdbe..6dc522c 100644
--- a/cache.h
+++ b/cache.h
@@ -865,7 +865,7 @@ extern int do_check_packed_object_crc;
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
-extern int move_temp_to_file(const char *tmpfile, const char *filename);
+extern int finalize_temp_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
diff --git a/fast-import.c b/fast-import.c
index fb4738d..05b61ce 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -919,12 +919,12 @@ static char *keep_pack(const char *curr_index_name)
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	if (move_temp_to_file(pack_data->pack_name, name))
+	if (finalize_temp_file(pack_data->pack_name, name))
 		die("cannot store pack file");
 
 	snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	if (move_temp_to_file(curr_index_name, name))
+	if (finalize_temp_file(curr_index_name, name))
 		die("cannot store index file");
 	free((void *)curr_index_name);
 	return name;
diff --git a/http.c b/http.c
index 94e1afd..47415f4 100644
--- a/http.c
+++ b/http.c
@@ -1091,7 +1091,7 @@ static int http_get_file(const char *url, const char *filename,
 	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
-	if (ret == HTTP_OK && move_temp_to_file(tmpfile.buf, filename))
+	if (ret == HTTP_OK && finalize_temp_file(tmpfile.buf, filename))
 		ret = HTTP_ERROR;
 cleanup:
 	strbuf_release(&tmpfile);
@@ -1178,7 +1178,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	ret = verify_pack_index(new_pack);
 	if (!ret) {
 		close_pack_index(new_pack);
-		ret = move_temp_to_file(tmp_idx, sha1_pack_index_name(sha1));
+		ret = finalize_temp_file(tmp_idx, sha1_pack_index_name(sha1));
 	}
 	free(tmp_idx);
 	if (ret)
@@ -1290,8 +1290,8 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 	unlink(sha1_pack_index_name(p->sha1));
 
-	if (move_temp_to_file(preq->tmpfile, sha1_pack_name(p->sha1))
-	 || move_temp_to_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
+	if (finalize_temp_file(preq->tmpfile, sha1_pack_name(p->sha1))
+	 || finalize_temp_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
 		free(tmp_idx);
 		return -1;
 	}
@@ -1555,7 +1555,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		return -1;
 	}
 	freq->rename =
-		move_temp_to_file(freq->tmpfile, sha1_file_name(freq->sha1));
+		finalize_temp_file(freq->tmpfile, sha1_file_name(freq->sha1));
 
 	return freq->rename;
 }
diff --git a/sha1_file.c b/sha1_file.c
index a38854c..aa2d6ff 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2784,11 +2784,8 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
 
 /*
  * Move the just written object into its final resting place.
- * NEEDSWORK: this should be renamed to finalize_temp_file() as
- * "moving" is only a part of what it does, when no patch between
- * master to pu changes the call sites of this function.
  */
-int move_temp_to_file(const char *tmpfile, const char *filename)
+int finalize_temp_file(const char *tmpfile, const char *filename)
 {
 	int ret = 0;
 
@@ -2962,7 +2959,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 				tmp_file, strerror(errno));
 	}
 
-	return move_temp_to_file(tmp_file, filename);
+	return finalize_temp_file(tmp_file, filename);
 }
 
 int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
-- 
2.5.0-427-g286dcbc
