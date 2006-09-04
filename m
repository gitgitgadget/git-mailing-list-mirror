From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] unpack-objects --desperate
Date: Sun, 03 Sep 2006 23:05:54 -0700
Message-ID: <7vveo4p3nh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 04 10:37:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK9wr-00020j-NZ
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 10:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWIDIgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 04:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWIDIgu
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 04:36:50 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49050 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751347AbWIDGFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 02:05:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904060536.VWEG13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Sep 2006 02:05:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J65c1V00H1kojtg0000000
	Mon, 04 Sep 2006 02:05:37 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26401>

The command unpack-objects dies upon the first error.  This is
probably considered a feature -- if a pack is corrupt, instead
of trying to extract from it and possibly risking to contaminate
a good repository with objects whose validity is dubious, we
should seek a good copy of the pack and retry.  However, we may
not have any good copy anywhere.  This implements the last
resort effort to extract what are salvageable from such a
corrupt pack.

This flag might have helped Sergio when recovering from a
corrupt pack.  In my test, it managed to salvage 247 objects out
of a pack that had 251 objects but without it the command
stopped after extracting 73 objects.

---

* A new flag I do not know what to call so I used -r for
  "recover" but used the word "salvage" when describing it in
  the documentation and the variable used for this option is
  called "desperate".  Obviously I am not good at naming things.

  Only lightly tested.

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index c20b38b..415c09b 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -8,7 +8,7 @@ git-unpack-objects - Unpack objects from
 
 SYNOPSIS
 --------
-'git-unpack-objects' [-n] [-q] <pack-file
+'git-unpack-objects' [-n] [-q] [-r] <pack-file
 
 
 DESCRIPTION
@@ -34,6 +34,12 @@ OPTIONS
 	The command usually shows percentage progress.  This
 	flag suppresses it.
 
+-r::
+	When unpacking a corrupt packfile, the command dies at
+	the first corruption.  This flag tells it to keep going
+	and make the best effort to salvage as many objects as
+	possible.
+
 
 Author
 ------
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 0c180b5..5f9c0d2 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -10,7 +10,7 @@ #include "tree.h"
 
 #include <sys/time.h>
 
-static int dry_run, quiet;
+static int dry_run, quiet, desperate, has_errors;
 static const char unpack_usage[] = "git-unpack-objects [-n] [-q] < pack-file";
 
 /* We always read in 4kB chunks. */
@@ -71,8 +71,15 @@ static void *get_data(unsigned long size
 		use(len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
-		if (ret != Z_OK)
-			die("inflate returned %d\n", ret);
+		if (ret != Z_OK) {
+			error("inflate returned %d\n", ret);
+			free(buf);
+			buf = NULL;
+			if (!desperate)
+				exit(1);
+			has_errors = 1;
+			break;
+		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
 	}
@@ -110,9 +117,9 @@ static void write_object(void *buf, unsi
 	added_object(sha1, type, buf, size);
 }
 
-static int resolve_delta(const char *type,
-	void *base, unsigned long base_size,
-	void *delta, unsigned long delta_size)
+static void resolve_delta(const char *type,
+			  void *base, unsigned long base_size,
+			  void *delta, unsigned long delta_size)
 {
 	void *result;
 	unsigned long result_size;
@@ -125,7 +132,6 @@ static int resolve_delta(const char *typ
 	free(delta);
 	write_object(result, result_size, type);
 	free(result);
-	return 0;
 }
 
 static void added_object(unsigned char *sha1, const char *type, void *data, unsigned long size)
@@ -145,7 +151,7 @@ static void added_object(unsigned char *
 	}
 }
 
-static int unpack_non_delta_entry(enum object_type kind, unsigned long size)
+static void unpack_non_delta_entry(enum object_type kind, unsigned long size)
 {
 	void *buf = get_data(size);
 	const char *type;
@@ -157,39 +163,42 @@ static int unpack_non_delta_entry(enum o
 	case OBJ_TAG:    type = tag_type; break;
 	default: die("bad type %d", kind);
 	}
-	if (!dry_run)
+	if (!dry_run && buf)
 		write_object(buf, size, type);
 	free(buf);
-	return 0;
 }
 
-static int unpack_delta_entry(unsigned long delta_size)
+static void unpack_delta_entry(unsigned long delta_size)
 {
 	void *delta_data, *base;
 	unsigned long base_size;
 	char type[20];
 	unsigned char base_sha1[20];
-	int result;
 
 	hashcpy(base_sha1, fill(20));
 	use(20);
 
 	delta_data = get_data(delta_size);
-	if (dry_run) {
+	if (dry_run || !delta_data) {
 		free(delta_data);
-		return 0;
+		return;
 	}
 
 	if (!has_sha1_file(base_sha1)) {
 		add_delta_to_list(base_sha1, delta_data, delta_size);
-		return 0;
+		return;
 	}
 	base = read_sha1_file(base_sha1, type, &base_size);
-	if (!base)
-		die("failed to read delta-pack base object %s", sha1_to_hex(base_sha1));
-	result = resolve_delta(type, base, base_size, delta_data, delta_size);
+	if (!base) {
+		error("failed to read delta-pack base object %s",
+		      sha1_to_hex(base_sha1));
+		if (!desperate)
+			exit(1);
+		has_errors = 1;
+		return;
+	}
+	resolve_delta(type, base, base_size, delta_data, delta_size);
 	free(base);
-	return result;
 }
 
 static void unpack_one(unsigned nr, unsigned total)
@@ -236,7 +245,11 @@ static void unpack_one(unsigned nr, unsi
 		unpack_delta_entry(size);
 		return;
 	default:
-		die("bad object type %d", type);
+		error("bad object type %d", type);
+		has_errors = 1;
+		if (desperate)
+			return;
+		exit(1);
 	}
 }
 
@@ -280,6 +293,10 @@ int cmd_unpack_objects(int argc, const c
 				quiet = 1;
 				continue;
 			}
+			if (!strcmp(arg, "-r")) {
+				desperate = 1;
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
@@ -306,5 +323,5 @@ int cmd_unpack_objects(int argc, const c
 	/* All done */
 	if (!quiet)
 		fprintf(stderr, "\n");
-	return 0;
+	return has_errors;
 }


-- 
VGER BF report: S 0.999272
