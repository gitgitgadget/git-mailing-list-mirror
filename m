From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Sat, 2 Aug 2008 02:09:32 +0400
Message-ID: <20080801220932.GK7008@dpotapov.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com> <200807311257.49108.litvinov2004@gmail.com> <20080731104529.GE7008@dpotapov.dyndns.org> <200808011023.32139.litvinov2004@gmail.com> <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com> <7vbq0dtawp.fsf@gitster.siamese.dyndns.org> <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com> <7vmyjwserv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP2pd-000375-E8
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYHAWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbYHAWJk
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:09:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38667 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYHAWJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 18:09:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so511829nfc.21
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gz4uNdJoFMg/zhAX1Z6wxh5NlliwanZmteNgVGpEZcQ=;
        b=unDA2YJipDb2ljEJjkIn4dMJi0EvJ1p2DVaQI1GE4a6AKrKdEW7ZCdBKpJelUInpzT
         ZOBK/D8ld555A9RZnA0K7bBuNogc8F5cQiHSQlye/L/hcrQ9QB4Vp7gRJRWYVaJ/3/eK
         KQEEVUF6l3P8wRaH+CfOTAgtlGogTUvwDwuC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n7SnkpXLFCB0jLowkWkZ+xBGw9EQb/MgOL57YI6bA2jKvqtgCk7D4AhiD0W8EPzOlg
         9oHLrw6v6qwNHPkRtwywsJzF65P/MzUvxMeMuOH46HVM0xB+u0sQMXT5mXwvupitU0um
         q2YmdbQGOxyvoxBHZy/I+yYJMy/ebUFWYvkK0=
Received: by 10.210.51.10 with SMTP id y10mr3422136eby.34.1217628577209;
        Fri, 01 Aug 2008 15:09:37 -0700 (PDT)
Received: from localhost ( [85.141.191.26])
        by mx.google.com with ESMTPS id y34sm4999153iky.10.2008.08.01.15.09.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 15:09:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmyjwserv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91106>

On Fri, Aug 01, 2008 at 12:42:44PM -0700, Junio C Hamano wrote:
> 
> Ok, earlier I was confused who was proposing what for what purpose, but
> that one was not just "a bit hackish" but an unacceptable hack ;-)

Thanks for correct my wording ;-)

> 
> Perhaps you would want to do the s/write_object/flags/ conversion, like
> this?

Yes, it was my prefered choice to change these index_xx functions.

I have applied your patch and then corrected mine to use flags.
See below.

I wonder if something should be done about other places where index_xx
functions are called. I have looked at them and all they use either 0 or
1 (boolean expression which will be evaluated to 0 or 1), so they should
work as is, but I can correct them to use HASH_OBJECT_DO_CREATE instead
of 1 if it helps with readability.

-- 8< --

From: Dmitry Potapov <dpotapov@gmail.com>
Date: Thu, 31 Jul 2008 21:10:26 +0400
Subject: [PATCH] hash-object --no-filters

The --no-filters option makes git hash-object to work as there were no
input filters. This option is useful for importers such as git-svn to
put new version of files as is even if autocrlf is set.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/git-hash-object.txt |    6 ++++++
 hash-object.c                     |   28 +++++++++++++++-------------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index ac928e1..69a17c7 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -35,6 +35,12 @@ OPTIONS
 --stdin-paths::
 	Read file names from stdin instead of from the command-line.
 
+--no-filters::
+	If this option is given then the file is hashed as is ignoring
+	all filters specified in the configuration, including crlf
+	conversion. If the file is read from standard input then no
+	filters is always implied.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/hash-object.c b/hash-object.c
index 46c06a9..2dd7283 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -8,7 +8,7 @@
 #include "blob.h"
 #include "quote.h"
 
-static void hash_object(const char *path, enum object_type type, int write_object)
+static void hash_object(const char *path, enum object_type type, int flags)
 {
 	int fd;
 	struct stat st;
@@ -16,23 +16,23 @@ static void hash_object(const char *path, enum object_type type, int write_objec
 	fd = open(path, O_RDONLY);
 	if (fd < 0 ||
 	    fstat(fd, &st) < 0 ||
-	    index_fd(sha1, fd, &st, write_object, type, path))
-		die(write_object
+	    index_fd(sha1, fd, &st, flags, type, path))
+		die((flags & HASH_OBJECT_DO_CREATE)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
 	printf("%s\n", sha1_to_hex(sha1));
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
-static void hash_stdin(const char *type, int write_object)
+static void hash_stdin(const char *type, int flags)
 {
 	unsigned char sha1[20];
-	if (index_pipe(sha1, 0, type, write_object))
+	if (index_pipe(sha1, 0, type, flags))
 		die("Unable to add stdin to database");
 	printf("%s\n", sha1_to_hex(sha1));
 }
 
-static void hash_stdin_paths(const char *type, int write_objects)
+static void hash_stdin_paths(const char *type, int flags)
 {
 	struct strbuf buf, nbuf;
 
@@ -45,7 +45,7 @@ static void hash_stdin_paths(const char *type, int write_objects)
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		hash_object(buf.buf, type_from_string(type), write_objects);
+		hash_object(buf.buf, type_from_string(type), flags);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
@@ -58,7 +58,7 @@ int main(int argc, char **argv)
 {
 	int i;
 	const char *type = blob_type;
-	int write_object = 0;
+	int flags = 0;
 	const char *prefix = NULL;
 	int prefix_length = -1;
 	int no_more_flags = 0;
@@ -80,7 +80,7 @@ int main(int argc, char **argv)
 					prefix_length =
 						prefix ? strlen(prefix) : 0;
 				}
-				write_object = 1;
+				flags |= HASH_OBJECT_DO_CREATE;
 			}
 			else if (!strcmp(argv[i], "--")) {
 				no_more_flags = 1;
@@ -104,6 +104,8 @@ int main(int argc, char **argv)
 					die("Multiple --stdin arguments are not supported");
 				hashstdin = 1;
 			}
+			else if (!strcmp(argv[i], "--no-filters"))
+				flags |= HASH_OBJECT_LITERALLY;
 			else
 				usage(hash_object_usage);
 		}
@@ -116,21 +118,21 @@ int main(int argc, char **argv)
 			}
 
 			if (hashstdin) {
-				hash_stdin(type, write_object);
+				hash_stdin(type, flags);
 				hashstdin = 0;
 			}
 			if (0 <= prefix_length)
 				arg = prefix_filename(prefix, prefix_length,
 						      arg);
-			hash_object(arg, type_from_string(type), write_object);
+			hash_object(arg, type_from_string(type), flags);
 			no_more_flags = 1;
 		}
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, write_object);
+		hash_stdin_paths(type, flags);
 
 	if (hashstdin)
-		hash_stdin(type, write_object);
+		hash_stdin(type, flags);
 	return 0;
 }
-- 
1.6.0.rc1.33.gb756f
