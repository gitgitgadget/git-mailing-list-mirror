From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/5] Be careful about lstat()-vs-readlink()
Date: Wed, 17 Dec 2008 10:42:02 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 19:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD1NY-0004Ae-EY
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 19:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbYLQSm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 13:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYLQSm6
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 13:42:58 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52120 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751060AbYLQSm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 13:42:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIg3jR030051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 10:42:04 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIg2dI008497;
	Wed, 17 Dec 2008 10:42:03 -0800
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103365>



This series of five patches makes us a lot more careful about readlink(), 
and in particular it avoids the code that depends on doing an lstat(), and 
then using st_size as the length of the link. That's what POSIX says 
_should_ happen, but Ramon Tayag reported git failing on NTFS under Linux 
because st_size doesn't match readlink() return value.

It doesn't seem to be unknown elsewhere either, since coreutils (through 
gnulib's areadlink_with_size) also has a big compatibility layer around 
readlink().

This series has been 'tested' by running it with the appended totally 
hacky patch that fakes out the lstat() st_size values for symlinks, so it 
has actually had some testing. 

The complete series does:

Linus Torvalds (5):
  Add generic 'strbuf_readlink()' helper function
  Make 'ce_compare_link()' use the new 'strbuf_readlink()'
  Make 'index_path()' use 'strbuf_readlink()'
  Make 'diff_populate_filespec()' use the new 'strbuf_readlink()'
  Make 'prepare_temp_file()' ignore st_size for symlinks

 builtin-apply.c |    6 ++----
 diff.c          |   25 +++++++++++--------------
 read-cache.c    |   22 ++++++++--------------
 sha1_file.c     |   14 +++++---------
 strbuf.c        |   28 ++++++++++++++++++++++++++++
 strbuf.h        |    1 +
 6 files changed, 55 insertions(+), 41 deletions(-)

and the hacky test-patch (which is obviously _not_ meant to be applied) is 
as follows...

		Linus

---
diff --git a/cache.h b/cache.h
index 231c06d..2d85fca 100644
--- a/cache.h
+++ b/cache.h
@@ -943,4 +943,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
 
+extern int gitlstat(const char *, struct stat *);
+#define lstat gitlstat
+
 #endif /* CACHE_H */
diff --git a/read-cache.c b/read-cache.c
index b1475ff..defbb20 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -15,6 +15,16 @@
 #include "revision.h"
 #include "blob.h"
 
+#undef lstat
+int gitlstat(const char *path, struct stat *buf)
+{
+	int retval = lstat(path, buf);
+	if (!retval && S_ISLNK(buf->st_mode))
+		buf->st_size = 1;
+	return retval;
+}
+#define lstat gitlstat
+
 /* Index extensions.
  *
  * The first letter should be 'A'..'Z' for extensions that are not
