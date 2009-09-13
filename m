From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v3] preserve mtime of local clone
Date: Sun, 13 Sep 2009 12:49:45 +0200
Message-ID: <20090913104945.GA22098@localhost>
References: <20090909195158.GA12968@localhost> <7vmy50lpfr.fsf@alter.siamese.dyndns.org> <20090912082624.GA9654@localhost> <20090912090348.GB9654@localhost> <7vvdjn4k6s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 12:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmmfw-0004FJ-F9
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 12:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbZIMKuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 06:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbZIMKuT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 06:50:19 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:41668 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbZIMKuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 06:50:18 -0400
Received: by fxm17 with SMTP id 17so298649fxm.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=4RVEWbDZVjZSWzv0vxrYqzxEHkIOVf77y5WToVc8FA0=;
        b=wZFNlLK39cqWRRXvLopRwgsj1bYrGg7IVGDzcGXW2StNmdCQUJeYXWneaw2orS17a5
         JJo4lKDqmfsCWBdJp+kf7gRJ0V2yj0iM2g6N+ngB+tVYmcjCf9PT4Wl6Udwl+XNAXnP9
         tdPZTJy+q8hRKvwPlRrbHWYVc6hnKOhHU1ZEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=x13tIX2+e+BmEHaaGhoAMsdCWXA1HyGrW35d+gaaqFH4CUv/Fr3/rPuc0Vi3TVr+/j
         S3cXY2uCN3HdNLjecjL0JYT+vSwmJQgJuDaNFEHj9/r/Zj5t2WFKASJP5WmYKrZbBsTk
         Dwct3ETArDTwSYRnj2CiTrLCd9vOoE/IqRYuQ=
Received: by 10.204.23.77 with SMTP id q13mr3981573bkb.14.1252839020228;
        Sun, 13 Sep 2009 03:50:20 -0700 (PDT)
Received: from darc.lan (p549A70ED.dip.t-dialin.net [84.154.112.237])
        by mx.google.com with ESMTPS id 12sm7712048fxm.29.2009.09.13.03.50.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 03:50:18 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MmmeP-00021Q-Qe; Sun, 13 Sep 2009 12:49:45 +0200
Content-Disposition: inline
In-Reply-To: <7vvdjn4k6s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128353>

A local clone without hardlinks copies all objects, including dangling
ones, to the new repository. Since the mtimes are renewed, those
dangling objects cannot be pruned by "git gc --prune", even if they
would have been old enough for pruning in the original repository.

Instead, preserve mtime during copy. "git gc --prune" will then work
in the clone just like it did in the original.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sat, Sep 12, 2009 at 08:06:51PM -0700, Junio C Hamano wrote:

> This new feature is not wanted by most of the callers of copy_file(), and
> it is not like they may want to conditionally pass 1 in preserve_times
> someday.  I'd limit the damage like this replacement patch, instead.

You're right. That's much better.

> Is it unreasonable to have a test for this one, by the way?

It's not. Test added.

Clemens

 builtin-clone.c  |    2 +-
 cache.h          |    2 ++
 copy.c           |   21 +++++++++++++++++++++
 t/t5304-prune.sh |   54 +++++++++++++++++++++++++++++++++---------------------
 4 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index ad04808..bab2d84 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -269,7 +269,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 				die_errno("failed to create link '%s'", dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file(dest->buf, src->buf, 0666))
+		if (copy_file_with_time(dest->buf, src->buf, 0666))
 			die_errno("failed to copy file to '%s'", dest->buf);
 	}
 	closedir(dir);
diff --git a/cache.h b/cache.h
index 5fad24c..ee9c98c 100644
--- a/cache.h
+++ b/cache.h
@@ -923,6 +923,8 @@ extern const char *git_mailmap_file;
 extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
+extern int copy_times(const char *dst, const char *src);
+extern int copy_file_with_time(const char *dst, const char *src, int mode);
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
 extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
diff --git a/copy.c b/copy.c
index e54d15a..963b481 100644
--- a/copy.c
+++ b/copy.c
@@ -55,3 +55,24 @@ int copy_file(const char *dst, const char *src, int mode)
 
 	return status;
 }
+
+int copy_times(const char *dst, const char *src)
+{
+	struct stat st;
+	struct utimbuf times;
+	if (stat(src, &st) < 0)
+		return -1;
+	times.actime = st.st_atime;
+	times.modtime = st.st_mtime;
+	if (utime(dst, &times) < 0)
+		return -1;
+	return 0;
+}
+
+int copy_file_with_time(const char *dst, const char *src, int mode)
+{
+     int status = copy_file(dst, src, mode);
+     if (!status)
+		return copy_times(dst, src);
+     return status;
+}
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 55ed7c7..15fd90a 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -6,6 +6,17 @@
 test_description='prune'
 . ./test-lib.sh
 
+day=$((60*60*24))
+week=$(($day*7))
+
+add_blob() {
+	before=$(git count-objects | sed "s/ .*//") &&
+	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE
+}
+
 test_expect_success setup '
 
 	: > file &&
@@ -31,11 +42,7 @@ test_expect_success 'prune stale packs' '
 
 test_expect_success 'prune --expire' '
 
-	before=$(git count-objects | sed "s/ .*//") &&
-	BLOB=$(echo aleph | git hash-object -w --stdin) &&
-	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE &&
+	add_blob &&
 	git prune --expire=1.hour.ago &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
@@ -48,16 +55,12 @@ test_expect_success 'prune --expire' '
 
 test_expect_success 'gc: implicit prune --expire' '
 
-	before=$(git count-objects | sed "s/ .*//") &&
-	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
-	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE &&
-	test-chmtime =-$((86400*14-30)) $BLOB_FILE &&
+	add_blob &&
+	test-chmtime =-$((2*$week-30)) $BLOB_FILE &&
 	git gc &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
-	test-chmtime =-$((86400*14+1)) $BLOB_FILE &&
+	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
 	git gc &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
 	! test -f $BLOB_FILE
@@ -114,12 +117,8 @@ test_expect_success 'prune: do not prune heads listed as an argument' '
 
 test_expect_success 'gc --no-prune' '
 
-	before=$(git count-objects | sed "s/ .*//") &&
-	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
-	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
-	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
-	test -f $BLOB_FILE &&
-	test-chmtime =-$((86400*5001)) $BLOB_FILE &&
+	add_blob &&
+	test-chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git config gc.pruneExpire 2.days.ago &&
 	git gc --no-prune &&
 	test 1 = $(git count-objects | sed "s/ .*//") &&
@@ -140,9 +139,8 @@ test_expect_success 'gc respects gc.pruneExpire' '
 
 test_expect_success 'gc --prune=<date>' '
 
-	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
-	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
-	test-chmtime =-$((86400*5001)) $BLOB_FILE &&
+	add_blob &&
+	test-chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git gc --prune=5002.days.ago &&
 	test -f $BLOB_FILE &&
 	git gc --prune=5000.days.ago &&
@@ -150,4 +148,18 @@ test_expect_success 'gc --prune=<date>' '
 
 '
 
+test_expect_success 'gc: prune old objects after local clone' '
+
+	add_blob &&
+	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
+	git clone --no-hardlinks . aclone &&
+	cd aclone &&
+	test 1 = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	git gc --prune &&
+	test 0 = $(git count-objects | sed "s/ .*//") &&
+	! test -f $BLOB_FILE
+
+'
+
 test_done
-- 
1.6.5.rc0.164.g5f6b0
