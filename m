From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-bundle.txt: Dumping contents of any
	bundle
Date: Thu, 1 Jan 2009 18:48:15 -0500
Message-ID: <20090101234815.GA9049@coredump.intra.peff.net>
References: <20090101192153.GA6536@coredump.intra.peff.net> <87fxk2u13r.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes.Schindelin@gmx.de, nico@cam.org, gitster@pobox.com,
	mdl123@verizon.net, spearce@spearce.org, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Jan 02 00:50:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXIK-0004g6-Gz
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 00:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbZAAXsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 18:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbZAAXsT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 18:48:19 -0500
Received: from peff.net ([208.65.91.99]:1274 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166AbZAAXsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 18:48:18 -0500
Received: (qmail 23550 invoked by uid 111); 1 Jan 2009 23:48:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 01 Jan 2009 18:48:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jan 2009 18:48:15 -0500
Content-Disposition: inline
In-Reply-To: <87fxk2u13r.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104343>

On Fri, Jan 02, 2009 at 06:12:56AM +0800, jidanni@jidanni.org wrote:

> I got as far as these wheezy little bytes,
> $ ls ??/*|tr -d /|sed q|xargs git cat-file tree|perl -pwe 's/[^\0]+[\0]//'|hd
> 00000000  ae 83 2f 22 45 89 2d dd  e5 22 13 57 46 64 48 b4  |../"E.-..".WFdH.|
> 00000010  09 77 51 42                                       |.wQB|

Those are just the bytes of the sha1 of the blob object, which is
pointed to by the tree object. You have the tree object correctly
unpacked, but not the blob, as I said before. So no amount of looking
in .git/objects is going to help you: git-unpack-objects didn't unpack
it, and the data isn't there in any form.

The data is in the pack, but as a delta, and that delta has further been
gzipped. So you can either write a custom parser based on the pack
format (which, as I mentioned, is described in
Documentation/technical/pack-format.txt), or you can add a switch to
unpack-objects, which is already parsing that format, to dump the
unresolved deltas. Which is what I was suggesting before.

Here's a very rough patch to do the latter. Try:

  git unpack-objects --dump-delta <mybundle.pack
  strings .git/lost-found/delta/*

Probably one could also write some tool to decode the delta format into
something more human readable.

---
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 47ed610..ab33ab1 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -13,6 +13,7 @@
 #include "fsck.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
+static int dump_deltas;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
 
 /* We always read in 4kB chunks. */
@@ -462,6 +463,36 @@ static void unpack_one(unsigned nr)
 	}
 }
 
+static void dump_delta_list(void)
+{
+	struct delta_info *d;
+
+	for (d = delta_list; d; d = d->next) {
+		git_SHA_CTX c;
+		unsigned char sha1[20];
+		char *path;
+		int fd;
+
+		git_SHA1_Init(&c);
+		git_SHA1_Update(&c, d->delta, d->size);
+		git_SHA1_Final(sha1, &c);
+		path = git_path("lost-found/delta/%s", sha1_to_hex(sha1));
+
+		if (safe_create_leading_directories(path) < 0)
+			die("could not create lost-found directory");
+
+		fd = open(path, O_CREAT|O_WRONLY, 0666);
+		if (fd < 0)
+			die("unable to open %s: %s", path, strerror(errno));
+		if (write_in_full(fd, d->delta, d->size) < 0)
+			die("error writing to %s: %s", path, strerror(errno));
+		if (close(fd) < 0)
+			die("error writing to %s: %s", path, strerror(errno));
+
+		fprintf(stderr, "dumped delta %s\n", sha1_to_hex(sha1));
+	}
+}
+
 static void unpack_all(void)
 {
 	int i;
@@ -486,8 +517,11 @@ static void unpack_all(void)
 	}
 	stop_progress(&progress);
 
-	if (delta_list)
+	if (delta_list) {
+		if (dump_deltas)
+			dump_delta_list();
 		die("unresolved deltas left after unpacking");
+	}
 }
 
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
@@ -534,6 +568,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				len = sizeof(*hdr);
 				continue;
 			}
+			if (!strcmp(arg, "--dump-deltas")) {
+				dump_deltas = 1;
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
