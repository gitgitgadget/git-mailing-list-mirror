From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Thu, 05 Mar 2009 12:02:02 -0800
Message-ID: <7vd4cvzqkl.fsf@gitster.siamese.dyndns.org>
References: <cover.1236187259.git.barvik@broadpark.no>
 <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no>
 <49AF9745.8050207@viscovery.net> <49AFBDAD.5040501@viscovery.net>
 <7v4oy7241g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:03:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfJnP-0004tB-7L
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbZCEUCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 15:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbZCEUCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:02:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbZCEUCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 15:02:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 42F3E9F2B4;
	Thu,  5 Mar 2009 15:02:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6BB9B9F2AE; Thu,
  5 Mar 2009 15:02:04 -0500 (EST)
In-Reply-To: <7v4oy7241g.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 05 Mar 2009 10:55:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82525996-09C0-11DE-847D-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112330>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Yes, it breaks. You can test this on Linux by commenting out these two
>> lines in git-compat-util.h:
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index dcf4127..ab4b615 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -44,8 +44,8 @@
>>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>>  #endif
>>  #define _ALL_SOURCE 1
>> -#define _GNU_SOURCE 1
>> -#define _BSD_SOURCE 1
>> +/*#define _GNU_SOURCE 1*/
>> +/*#define _BSD_SOURCE 1*/
>>  #include <unistd.h>
>>  #include <stdio.h>
>>
>> The result even passes the test suite (as long as I don't merge
>> kb/checkout-optim, of course).

This actually will trigger more compilation breakages than that.  For
example, it hides memmem() and strchrnul() from everybody, and makes the
compilation error out with this subtract as the compiler has to assume you
are subtracting a pointer from an integer:

		linelen = strchrnul(msg_p, '\n') - msg_p;

I cannot test the result myself to see if it still works this way.

> Isn't it better to separate "do we want to use that information if we can
> nanosecocond timestamps" and "is the API available for reading nanosecond
> timestamps" into separete switches, like this partial patch on top of the
> patch we are discussing, then?  It is partial because it shows the way to
> convert only one call site as an example and of course you need to update
> the Makefile and autoconf.

And here is what I did.  It is meant to replace the patch in discussion.

-- >8 --
Record ns-timestamps if possible, but do not use it without USE_NSEC

Traditionally, the lack of USE_NSEC meant "do not record nor use the
nanosecond resolution part of the file timestamps".  To avoid problems on
filesystems that lose the ns part when the metadata is flushed to the disk
and then later read back in, disabling USE_NSEC has been a good idea in
general.

If you are on a filesystem without such an issue, it does not hurt to read
and store them in the cached stat data in the index entries even if your
git is compiled without USE_NSEC.  The index left with such a version of
git can be read by git compiled with USE_NSEC and it can make use of the
nanosecond part to optimize the check to see if the path on the filesystem
hsa been modified since we last looked at.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile             |    7 +++++++
 builtin-fetch-pack.c |    4 +---
 git-compat-util.h    |    9 +++++++++
 read-cache.c         |   29 ++++-------------------------
 unpack-trees.c       |    2 --
 5 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/Makefile b/Makefile
index 27b9569..e63034d 100644
--- a/Makefile
+++ b/Makefile
@@ -126,6 +126,9 @@ all::
 # randomly break unless your underlying filesystem supports those sub-second
 # times (my ext3 doesn't).
 #
+# Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
+# available.  This automatically turns USE_NSEC off.
+#
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-index perspective.
 #
@@ -802,6 +805,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	RUNTIME_PREFIX = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	NO_NSEC = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
@@ -923,6 +927,9 @@ endif
 ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
 endif
+ifdef NO_NSEC
+	BASIC_CFLAGS += -DNO_NSEC
+endif
 ifdef NO_C99_FORMAT
 	BASIC_CFLAGS += -DNO_C99_FORMAT
 endif
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 3b210c7..59b0b0a 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -801,9 +801,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		int fd;
 
 		mtime.sec = st.st_mtime;
-#ifdef USE_NSEC
-		mtime.nsec = st.st_mtim.tv_nsec;
-#endif
+		mtime.nsec = ST_MTIME_NSEC(st);
 		if (stat(shallow, &st)) {
 			if (mtime.sec)
 				die("shallow file was removed during fetch");
diff --git a/git-compat-util.h b/git-compat-util.h
index 079cbe9..9b495dc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -384,4 +384,13 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 # define FORCE_DIR_SET_GID 0
 #endif
 
+#ifdef NO_NSEC
+#undef USE_NSEC
+#define ST_CTIME_NSEC(st) 0
+#define ST_MTIME_NSEC(st) 0
+#else
+#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
+#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
+#endif
+
 #endif
diff --git a/read-cache.c b/read-cache.c
index 91f1d03..b819abb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -69,13 +69,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
 	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
 	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
-#ifdef USE_NSEC
-	ce->ce_ctime.nsec = (unsigned int)st->st_ctim.tv_nsec;
-	ce->ce_mtime.nsec = (unsigned int)st->st_mtim.tv_nsec;
-#else
-	ce->ce_ctime.nsec = 0;
-	ce->ce_mtime.nsec = 0;
-#endif
+	ce->ce_ctime.nsec = ST_CTIME_NSEC(*st);
+	ce->ce_mtime.nsec = ST_MTIME_NSEC(*st);
 	ce->ce_dev = st->st_dev;
 	ce->ce_ino = st->st_ino;
 	ce->ce_uid = st->st_uid;
@@ -1183,13 +1178,8 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 
 	ce->ce_ctime.sec = ntohl(ondisk->ctime.sec);
 	ce->ce_mtime.sec = ntohl(ondisk->mtime.sec);
-#ifdef USE_NSEC
 	ce->ce_ctime.nsec = ntohl(ondisk->ctime.nsec);
 	ce->ce_mtime.nsec = ntohl(ondisk->mtime.nsec);
-#else
-	ce->ce_ctime.nsec = 0;
-	ce->ce_mtime.nsec = 0;
-#endif
 	ce->ce_dev   = ntohl(ondisk->dev);
 	ce->ce_ino   = ntohl(ondisk->ino);
 	ce->ce_mode  = ntohl(ondisk->mode);
@@ -1309,11 +1299,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		dst_offset += ce_size(ce);
 	}
 	istate->timestamp.sec = st.st_mtime;
-#ifdef USE_NSEC
-	istate->timestamp.nsec = (unsigned int)st.st_mtim.tv_nsec;
-#else
-	istate->timestamp.nsec = 0;
-#endif
+	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
@@ -1500,13 +1486,8 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 
 	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
 	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
-#ifdef USE_NSEC
 	ondisk->ctime.nsec = htonl(ce->ce_ctime.nsec);
 	ondisk->mtime.nsec = htonl(ce->ce_mtime.nsec);
-#else
-	ondisk->ctime.nsec = 0;
-	ondisk->mtime.nsec = 0;
-#endif
 	ondisk->dev  = htonl(ce->ce_dev);
 	ondisk->ino  = htonl(ce->ce_ino);
 	ondisk->mode = htonl(ce->ce_mode);
@@ -1583,9 +1564,7 @@ int write_index(struct index_state *istate, int newfd)
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_ctime;
-#ifdef USE_NSEC
-	istate->timestamp.nsec = (unsigned int)st.st_ctim.tv_nsec;
-#endif
+	istate->timestamp.nsec = ST_CTIME_NSEC(st);
 	return 0;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 9fe0cd5..da2e3c0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -362,9 +362,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.initialized = 1;
 	if (o->src_index) {
 		o->result.timestamp.sec = o->src_index->timestamp.sec;
-#ifdef USE_NSEC
 		o->result.timestamp.nsec = o->src_index->timestamp.nsec;
-#endif
 	}
 	o->merge_size = len;
 
