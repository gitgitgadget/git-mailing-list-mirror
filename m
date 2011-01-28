From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 00:06:24 -0800
Message-ID: <1296201984-24426-1-git-send-email-spearce@spearce.org>
Cc: John Hawley <warthog19@eaglescrag.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 28 09:06:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PijLo-0002yt-Vu
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 09:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279Ab1A1IGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 03:06:30 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:61194 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab1A1IG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 03:06:29 -0500
Received: by pxi15 with SMTP id 15so404219pxi.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 00:06:29 -0800 (PST)
Received: by 10.142.178.7 with SMTP id a7mr2760512wff.194.1296201989152;
        Fri, 28 Jan 2011 00:06:29 -0800 (PST)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id w14sm22934496wfd.18.2011.01.28.00.06.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Jan 2011 00:06:27 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.253.gb7420
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165601>

A cache pack is all objects reachable from a single commit that is
part of the project's stable history and won't disappear, and is
accessible to all readers of the repository.  By containing only that
commit and its contents, if the commit is reached from a reference we
know immediately that the entire pack is also reachable.  To help
ensure this is true, the --create-cache flag looks for a commit along
refs/heads and refs/tags that is at least 1 month old, working under
the assumption that a commit this old won't be rebased or pruned.

During a clone request if a commit is discovered that matches the
cache pack, all newer objects can be enumerated using normal rules and
sent to the client, and then the cache pack can be simply appended
onto the end of the stream.  There is no need to enumerate the objects
as the object count is in the header of the cache pack.  There is no
need to allocate all of the objects in the pack-objects process, which
reduces its working set size, and its impact on busy servers.

By keeping the pack with a standard .keep file, later repacks of the
repository won't include these objects, which permits disk usage to
stay within a reasonable factor of the repository size.

Because newer packed objects are not delta compressed against the
older cached pack, clients may receive a larger data transfer when the
cached pack is simply appended onto the stream.  pack-objects could
work around this by constructing a thin pack, and adding the cache
pack's tip commit as the uninteresting/common base for the thin pack.
The references for the newer objects will point to older data behind
them so they will automatically use the larger REF_DELTA format.

This commit only adds the logic to git-repack to construct the cached
pack.  For example on a Linux kernel repository:

  # Construct the initial cache pack
  $ git repack --create-cache --cache-include=v2.6.11-tree

  # Remove duplicated objects
  $ git repack -a -d

If this is actually a good idea, pack-objects can later learn how to
use $GIT_DIR/objects/info/cached during revision traversal to know
when a cached pack is found, and switch to the thin pack + cached pack
transfer method described above.

The cached pack is only useful for initial clones of a repository, and
only if object enumeration takes more than a few seconds.  However
initial clones of big projects like linux-2.6.git are killing some
common mirror sites, so this could be one way to help them out.

Later fetch-pack/upload-pack protocol could learn how to more
intelligently use the cached pack in the data stream, allowing a
client whose connection has been broken to resume with a byte range
request within the cached pack, assuming the pack is still present on
the server.  This can be validated by giving the client both the SHA-1
pack name, and the SHA-1 trailer of the pack content, and requiring
these to match on a byte range request.

Repository owners may also enjoy having the cached pack as frequent
`git gc` invocations will now have lower IO and CPU requirements due
to the large pack having a .keep file.  In the future `git gc --auto`
could learn to suggest removing the .keep file and regenerating the
cached pack once there is sufficient new content to make creating a
new pack worthwhile.
---
 git-repack.sh |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 624feec..7a7984c 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -15,6 +15,9 @@ F               pass --no-reuse-object to git-pack-objects
 n               do not run git-update-server-info
 q,quiet         be quiet
 l               pass --local to git-pack-objects
+create-cache    create a cached pack for older history
+cache-include=  other objects to include in the cache
+cache-age=      how old to start caching from
  Packing constraints
 window=         size of the window used for delta compression
 window-memory=  same as the above, but limit memory size instead of entries count
@@ -26,6 +29,7 @@ SUBDIRECTORY_OK='Yes'
 
 no_update_info= all_into_one= remove_redundant= unpack_unreachable=
 local= no_reuse= extra=
+create_cache= cache_include= cache_age=1.month.ago
 while test $# != 0
 do
 	case "$1" in
@@ -38,6 +42,11 @@ do
 	-f)	no_reuse=--no-reuse-delta ;;
 	-F)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
+	--create-cache) create_cache=t ;;
+	--cache-age) cache_age=$2; shift ;;
+	--cache-include)
+		name=$(git rev-parse --verify $2)
+		cache_include="$cache_include $name"; shift ;;
 	--max-pack-size|--window|--window-memory|--depth)
 		extra="$extra $1=$2"; shift ;;
 	--) shift; break;;
@@ -52,16 +61,19 @@ true)
 esac
 
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
+INFODIR="$GIT_OBJECT_DIRECTORY/info"
 PACKTMP="$PACKDIR/.tmp-$$-pack"
 rm -f "$PACKTMP"-*
 trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 
 # There will be more repacking strategies to come...
-case ",$all_into_one," in
-,,)
+case ",$create_cache,$all_into_one," in
+,t,,)
+	;;
+,,,)
 	args='--unpacked --incremental'
 	;;
-,t,)
+,,t,)
 	args= existing=
 	if [ -d "$PACKDIR" ]; then
 		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
@@ -84,9 +96,22 @@ esac
 
 mkdir -p "$PACKDIR" || exit
 
-args="$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
-names=$(git pack-objects --keep-true-parents --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
-	exit 1
+if [ -n "$create_cache" ]; then
+	root=$(git rev-list -n 1 --until=$cache_age --branches --tags --)
+	args="$args ${GIT_QUIET:+-q} $no_reuse$extra"
+	names=$( ( echo "$root";
+		       for name in $cache_include
+		       do
+		         echo "$name"
+		       done ) |
+		git pack-objects --keep-true-parents --non-empty $args --revs \
+		"$PACKTMP") ||
+		exit 1
+else
+	args="$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
+	names=$(git pack-objects --keep-true-parents --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
+		exit 1
+fi
 if [ -z "$names" ]; then
 	say Nothing new to pack.
 fi
@@ -151,6 +176,10 @@ do
 	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
 	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" ||
 	exit
+
+	if [ -n "$create_cache" ]; then
+		echo "cache $root$cache_include" >"$PACKDIR/pack-$name.keep"
+	fi
 done
 
 # Remove the "old-" files
@@ -162,6 +191,22 @@ done
 
 # End of pack replacement.
 
+# Update the cache list
+if [ -n "$create_cache" ]; then
+	mkdir -p "$INFODIR" || exit
+	( echo "+ $root" &&
+	  for name in $cache_include
+	  do
+	    echo "+ $name"
+	  done
+	  for name in $names
+	  do
+	    echo "P $name"
+	  done ) >"$INFODIR/cached"
+	echo "Cached from:"
+	git log --pretty=format:'  [%h] %cd%n  %s' -1 "$root" --
+fi
+
 if test "$remove_redundant" = t
 then
 	# We know $existing are all redundant.
-- 
1.7.4.rc1.253.gb7420
