From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2 2/2] headers: include dependent headers
Date: Sun, 7 Sep 2014 12:49:18 -0700
Message-ID: <20140907194917.GB1611@google.com>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
 <1410049821-49861-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 21:49:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQiSo-0001X1-Go
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 21:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbaIGTtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 15:49:21 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55594 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaIGTtV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 15:49:21 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so423828pde.40
        for <git@vger.kernel.org>; Sun, 07 Sep 2014 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Z0Ggi1pDisZgR5rzRjkENSPQZ8SQrggelqgI6LD52Uc=;
        b=TtujZtgVQ5nh9Px8EFvpDUuIbeqrCdsURywmlof296VNDb00v6aLj9QhvWHulmoyRb
         xINVxyAmxiaAE3/OcQS94cyaYrj2Y0ii1cA4Hm44Z6ryHdoEJRejSvgM9kFJ5JBW+Q/I
         p05yGcEDiqfPiLON38zfLdhGcTnb3j8r7/AvOlL8+DqH+d0CkqQE08X4lplbTLWGy54i
         dUAXIW+zDqVBhFsSs2c2hDvF6jfT8ZXmhx0HVuSTjHL2gJvksqEhgHwCVhiIRIPw4ZZb
         4j8jGL+FbllZQQIkjPBO0OPEYu02bpDL4zdf7svjBBXW9EPq1Xw+HQMcakA57qLzgsDg
         I9sg==
X-Received: by 10.68.195.228 with SMTP id ih4mr5570180pbc.167.1410119360610;
        Sun, 07 Sep 2014 12:49:20 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id by6sm7514727pab.15.2014.09.07.12.49.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Sep 2014 12:49:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410049821-49861-2-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256624>

David Aguilar wrote:

> Add dependent headers so that including a header does not
> require including additional headers.

I agree with this goal, modulo the compat-util.h caveat.  Thanks
for working on it.

[...]
> --- a/archive.h
> +++ b/archive.h
> @@ -1,6 +1,7 @@
>  #ifndef ARCHIVE_H
>  #define ARCHIVE_H
>  
> +#include "cache.h"
>  #include "pathspec.h"
>  
>  struct archiver_args {

I'm less happy about the way of achieving that goal.  Here's an
alternative.  Advantages:

 * (fully expanded) headers stay small

 * fewer other headers included as a side-effect of including one
   header, so callers are more likely to remember to #include the
   headers defining things they need (which makes later refactoring
   easier)

 * circular header dependencies are harder to produce

If this seems like a good direction to go in, I can finish the patch
later today (or I don't mind if someone else takes care of it).  This
is just to give the idea --- I stopped at dir.h.

Sensible?
Jonathan

diff --git i/archive.h w/archive.h
index 4a791e1..11f4d42 100644
--- i/archive.h
+++ w/archive.h
@@ -3,6 +3,9 @@
 
 #include "pathspec.h"
 
+enum object_type;
+
+
 struct archiver_args {
 	const char *base;
 	size_t baselen;
diff --git i/attr.h w/attr.h
index 8b08d33..c971ef2 100644
--- i/attr.h
+++ w/attr.h
@@ -1,6 +1,8 @@
 #ifndef ATTR_H
 #define ATTR_H
 
+struct index_state;
+
 /* An attribute is a pointer to this opaque structure */
 struct git_attr;
 
diff --git i/branch.h w/branch.h
index 64173ab..ed63209 100644
--- i/branch.h
+++ w/branch.h
@@ -1,6 +1,9 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+enum branch_track;
+struct strbuf;
+
 /* Functions for acting on the information about branches. */
 
 /*
diff --git i/cache-tree.h w/cache-tree.h
index b47ccec..c22e2ec 100644
--- i/cache-tree.h
+++ w/cache-tree.h
@@ -1,8 +1,12 @@
 #ifndef CACHE_TREE_H
 #define CACHE_TREE_H
 
-#include "tree.h"
-#include "tree-walk.h"
+struct traverse_info;
+struct index_state;
+struct name_entry;
+struct tree;
+struct string_list;
+struct strbuf;
 
 struct cache_tree;
 struct cache_tree_sub {
diff --git i/column.h w/column.h
index 0a61917..8211386 100644
--- i/column.h
+++ w/column.h
@@ -1,6 +1,9 @@
 #ifndef COLUMN_H
 #define COLUMN_H
 
+struct option;
+struct string_list;
+
 #define COL_LAYOUT_MASK   0x000F
 #define COL_ENABLE_MASK   0x0030   /* always, never or auto */
 #define COL_PARSEOPT      0x0040   /* --column is given from cmdline */
@@ -26,7 +29,6 @@ struct column_options {
 	const char *nl;
 };
 
-struct option;
 extern int parseopt_column_callback(const struct option *, const char *, int);
 extern int git_column_config(const char *var, const char *value,
 			     const char *command, unsigned int *colopts);
diff --git i/commit.h w/commit.h
index aa8c3ca..d2fd182 100644
--- i/commit.h
+++ w/commit.h
@@ -1,13 +1,18 @@
 #ifndef COMMIT_H
 #define COMMIT_H
 
+#include "cache.h"
 #include "object.h"
-#include "tree.h"
-#include "strbuf.h"
-#include "decorate.h"
-#include "gpg-interface.h"
+#include "trace.h"
 #include "string-list.h"
 
+struct reflog_walk_info;
+struct rev_info;
+struct ref;
+struct signature_check;
+struct sha1_array;
+struct strbuf;
+
 struct commit_list {
 	struct commit *item;
 	struct commit_list *next;
@@ -151,7 +156,6 @@ struct userformat_want {
 };
 
 extern int has_non_ascii(const char *text);
-struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
@@ -231,8 +235,6 @@ extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
 
-struct sha1_array;
-struct ref;
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
diff --git i/convert.h w/convert.h
index 0c2143c..e623527 100644
--- i/convert.h
+++ w/convert.h
@@ -4,6 +4,8 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
+struct strbuf;
+
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
diff --git i/csum-file.h w/csum-file.h
index bb543d5..9e29e35 100644
--- i/csum-file.h
+++ w/csum-file.h
@@ -1,6 +1,8 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
+#include "cache.h"
+
 struct progress;
 
 /* A SHA1-protected file */
diff --git i/diffcore.h w/diffcore.h
index c876dac..96fc827 100644
--- i/diffcore.h
+++ w/diffcore.h
@@ -4,6 +4,9 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
 
+struct userdiff_driver;
+struct diff_options;
+
 /* This header file is internal between diff.c and its diff transformers
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
@@ -22,8 +25,6 @@
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
-struct userdiff_driver;
-
 struct diff_filespec {
 	unsigned char sha1[20];
 	char *path;
diff --git i/object.h w/object.h
index 5e8d8ee..40bd3a8 100644
--- i/object.h
+++ w/object.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+enum object_type;
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git i/tree-walk.h w/tree-walk.h
index ae7fb3a..d7612cf 100644
--- i/tree-walk.h
+++ w/tree-walk.h
@@ -1,6 +1,8 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
+struct strbuf;
+
 struct name_entry {
 	const unsigned char *sha1;
 	const char *path;
diff --git i/tree.h w/tree.h
index d84ac63..ef84153 100644
--- i/tree.h
+++ w/tree.h
@@ -3,6 +3,9 @@
 
 #include "object.h"
 
+struct pathspec;
+
+
 extern const char *tree_type;
 
 struct tree {
