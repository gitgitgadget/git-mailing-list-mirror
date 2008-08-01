From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 01 Aug 2008 12:42:44 -0700
Message-ID: <7vmyjwserv.fsf@gitster.siamese.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com>
 <200807311257.49108.litvinov2004@gmail.com>
 <20080731104529.GE7008@dpotapov.dyndns.org>
 <200808011023.32139.litvinov2004@gmail.com>
 <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
 <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
 <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:44:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0Xi-0001tO-St
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 21:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374AbYHATm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYHATm7
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 15:42:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYHATm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 15:42:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FC6146EF8;
	Fri,  1 Aug 2008 15:42:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B5D8646EF7; Fri,  1 Aug 2008 15:42:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0A7D5F0A-6002-11DD-8E68-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91079>

"Dmitry Potapov" <dpotapov@gmail.com> writes:

> On Fri, Aug 1, 2008 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Dmitry Potapov" <dpotapov@gmail.com> writes:
>>>
>>> To being able to synchronize efficiently in both ways, you need to store
>>> files exactly as they were received from SVN then there will be no
>>> problem with applying binary delta patch. All CRLF conversion should be
>>> done on checkout and checkin from/to Git repository.
>>
>> Ahh,... if that is the philosophy, perhaps we can teach --stdin-paths to
>> optionally open the file itself and use index_pipe() like --stdin codepath
>> does?
>
> It is possible to do in this way, but it less efficient, because it uses
> index_pipe, which does not know the actual size, so it reallocates the buffer
> as it reads data from the descriptor, while index_fd uses xmap() instead.
> So I sent another solution yesterday:
> http://article.gmane.org/gmane.comp.version-control.git/90968
>
> It is a bit hackish because...

Ok, earlier I was confused who was proposing what for what purpose, but
that one was not just "a bit hackish" but an unacceptable hack ;-)

Perhaps you would want to do the s/write_object/flags/ conversion, like
this?

--

 cache.h     |    9 ++++++---
 sha1_file.c |   15 +++++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 2475de9..39975fb 100644
--- a/cache.h
+++ b/cache.h
@@ -390,9 +390,12 @@ extern int ie_match_stat(const struct index_state *, struct cache_entry *, struc
 extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
-extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path);
-extern int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object);
-extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
+
+#define HASH_OBJECT_DO_CREATE 01
+#define HASH_OBJECT_LITERALLY 02
+extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int flags, enum object_type type, const char *path);
+extern int index_pipe(unsigned char *sha1, int fd, const char *type, int flags);
+extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int flags);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
diff --git a/sha1_file.c b/sha1_file.c
index e281c14..5def648 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2353,10 +2353,11 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_loose_object(sha1);
 }
 
-int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
+int index_pipe(unsigned char *sha1, int fd, const char *type, int flags)
 {
 	struct strbuf buf;
 	int ret;
+	int write_object = flags & HASH_OBJECT_DO_CREATE;
 
 	strbuf_init(&buf, 0);
 	if (strbuf_read(&buf, fd, 4096) < 0) {
@@ -2375,9 +2376,11 @@ int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
 	return ret;
 }
 
-int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
+int index_fd(unsigned char *sha1, int fd, struct stat *st, int flags,
 	     enum object_type type, const char *path)
 {
+	int write_object = flags & HASH_OBJECT_DO_CREATE;
+	int hash_literally = flags & HASH_OBJECT_LITERALLY;
 	size_t size = xsize_t(st->st_size);
 	void *buf = NULL;
 	int ret, re_allocated = 0;
@@ -2392,7 +2395,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	/*
 	 * Convert blobs to git internal format
 	 */
-	if ((type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
+	if (!hash_literally && (type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
 		struct strbuf nbuf;
 		strbuf_init(&nbuf, 0);
 		if (convert_to_git(path, buf, size, &nbuf,
@@ -2416,7 +2419,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	return ret;
 }
 
-int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object)
+int index_path(unsigned char *sha1, const char *path, struct stat *st, int flags)
 {
 	int fd;
 	char *target;
@@ -2428,7 +2431,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 		if (fd < 0)
 			return error("open(\"%s\"): %s", path,
 				     strerror(errno));
-		if (index_fd(sha1, fd, st, write_object, OBJ_BLOB, path) < 0)
+		if (index_fd(sha1, fd, st, flags, OBJ_BLOB, path) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
@@ -2441,7 +2444,7 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 			return error("readlink(\"%s\"): %s", path,
 			             errstr);
 		}
-		if (!write_object)
+		if (!(flags & HASH_OBJECT_DO_CREATE))
 			hash_sha1_file(target, len, blob_type, sha1);
 		else if (write_sha1_file(target, len, blob_type, sha1))
 			return error("%s: failed to insert into database",
