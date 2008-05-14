From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/2] let pack-objects do the writing of unreachable objects as
 loose objects
Date: Wed, 14 May 2008 01:33:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805140132500.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 07:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw9dU-0005zf-Lz
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 07:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbYENFdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 01:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYENFdz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 01:33:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35651 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYENFdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 01:33:54 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0U00CV4FGHXM20@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 May 2008 01:33:54 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82073>


Commit ccc1297226b184c40459e9d373cc9eebfb7bd898 changed the behavior
of 'git repack -A' so unreachable objects are stored as loose objects.
However it did so in a naive and inn efficient way by making packs
about to be deleted inaccessible and feeding their content through
'git unpack-objects'.  While this works, there are major flaws with
this approach:

- It is unacceptably sloooooooooooooow.

  In the Linux kernel repository with no actual unreachable objects,
  doing 'git repack -A -d' before:

	real    2m33.220s
	user    2m21.675s
	sys     0m3.510s

  And with this change:

	real    0m36.849s
	user    0m24.365s
	sys     0m1.950s

  For reference, here's the timing for 'git repack -a -d':

	real    0m35.816s
	user    0m22.571s
	sys     0m2.011s

  This is explained by the fact that 'git unpack-objects' was used to
  unpack _every_ objects even if (almost) 100% of them were thrown away.

- There is a black out period.

  Between the removal of the .idx file for the redundant pack and the
  completion of its unpacking, the unreachable objects become completely
  unaccessible.  This is not a big issue as we're talking about unreachable
  objects, but some consistency is always good.

- There is no way to easily set a sensible mtime for the newly created
  unreachable loose objects.

So, while having a command called "pack-objects" to perform object
unpacking looks really odd, this is probably the best compromize to be
able to solve the above issues in an efficient way.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e20851e..f43eb67 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -28,7 +28,8 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
-	[--stdout | base-name] [--include-tag] [--keep-unreachable] \n\
+	[--stdout | base-name] [--include-tag] \n\
+	[--keep-unreachable | --unpack-unreachable] \n\
 	[<ref-list | <object-list]";
 
 struct object_entry {
@@ -67,7 +68,7 @@ static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
-static int keep_unreachable, include_tag;
+static int keep_unreachable, unpack_unreachable, include_tag;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
@@ -1946,6 +1947,32 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 	free(in_pack.array);
 }
 
+static void loosen_unused_packed_objects(struct rev_info *revs)
+{
+	struct packed_git *p;
+	uint32_t i;
+	const unsigned char *sha1;
+
+	for (p = packed_git; p; p = p->next) {
+		for (i = 0; i < revs->num_ignore_packed; i++) {
+			if (matches_pack_name(p, revs->ignore_packed[i]))
+				break;
+		}
+		if (revs->num_ignore_packed <= i)
+			continue;
+
+		if (open_pack_index(p))
+			die("cannot open pack index");
+
+		for (i = 0; i < p->num_objects; i++) {
+			sha1 = nth_packed_object_sha1(p, i);
+			if (!locate_object_entry(sha1))
+				if (force_object_loose(sha1, p->mtime))
+					die("unable to force loose object");
+		}
+	}
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
@@ -1980,6 +2007,8 @@ static void get_object_list(int ac, const char **av)
 
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
+	if (unpack_unreachable)
+		loosen_unused_packed_objects(&revs);
 }
 
 static int adjust_perm(const char *path, mode_t mode)
@@ -2114,6 +2143,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			keep_unreachable = 1;
 			continue;
 		}
+		if (!strcmp("--unpack-unreachable", arg)) {
+			unpack_unreachable = 1;
+			continue;
+		}
 		if (!strcmp("--include-tag", arg)) {
 			include_tag = 1;
 			continue;
@@ -2179,6 +2212,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
 
+	if (keep_unreachable && unpack_unreachable)
+		die("--keep-unreachable and --unpack-unreachable are incompatible.");
+
 #ifdef THREADED_DELTA_SEARCH
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
diff --git a/git-repack.sh b/git-repack.sh
index 0aede89..10f735c 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -8,7 +8,7 @@ OPTIONS_SPEC="\
 git-repack [options]
 --
 a               pack everything in a single pack
-A               same as -a, and keep unreachable objects too
+A               same as -a, and turn unreachable objects loose
 d               remove redundant packs, and run git-prune-packed
 f               pass --no-reuse-delta to git-pack-objects
 n               do not run git-update-server-info
@@ -23,7 +23,7 @@ max-pack-size=  maximum size of each packfile
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
-no_update_info= all_into_one= remove_redundant= keep_unreachable=
+no_update_info= all_into_one= remove_redundant= unpack_unreachable=
 local= quiet= no_reuse= extra=
 while test $# != 0
 do
@@ -31,7 +31,7 @@ do
 	-n)	no_update_info=t ;;
 	-a)	all_into_one=t ;;
 	-A)	all_into_one=t
-		keep_unreachable=t ;;
+		unpack_unreachable=--unpack-unreachable ;;
 	-d)	remove_redundant=t ;;
 	-q)	quiet=-q ;;
 	-f)	no_reuse=--no-reuse-object ;;
@@ -79,6 +79,9 @@ case ",$all_into_one," in
 	if test -z "$args"
 	then
 		args='--unpacked --incremental'
+	elif test -n "$unpack_unreachable"
+	then
+		args="$args $unpack_unreachable"
 	fi
 	;;
 esac
@@ -128,18 +131,7 @@ then
 		  do
 			case " $fullbases " in
 			*" $e "*) ;;
-			*)
-				rm -f "$e.idx" "$e.keep"
-				if test -n "$keep_unreachable" &&
-				   test -f "$e.pack"
-				then
-					git unpack-objects < "$e.pack" || {
-						echo >&2 "Failed unpacking unreachable objects from redundant pack file $e.pack"
-						exit 1
-					}
-				fi
-				rm -f "$e.pack"
-			;;
+			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
 			esac
 		  done
 		)
