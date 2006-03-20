From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Sun, 19 Mar 2006 17:55:56 -0800
Message-ID: <7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vu09um3ae.fsf@assigned-by-dhcp.cox.net>
	<m3wteqj6qx.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 02:56:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL9d9-0005DO-0E
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 02:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWCTB4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 20:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWCTB4A
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 20:56:00 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52705 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751145AbWCTBz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 20:55:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320015430.XHIM15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Mar 2006 20:54:30 -0500
To: James Cloos <cloos@jhcloos.com>
In-Reply-To: <m3wteqj6qx.fsf@lugabout.cloos.reno.nv.us> (James Cloos's message
	of "Sun, 19 Mar 2006 19:32:22 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17739>

James Cloos <cloos@jhcloos.com> writes:

> Junio> Maybe it would be a good idea to deprecate
> Junio> clone-pack altogether, use fetch-pack -k, and implement the
> Junio> "copy upstream refs to our refs" logic in git-clone.sh.  We need
> Junio> to do something like that if/when we are switching to use
> Junio> $GIT_DIR/refs/remotes/ to store tracking branches outside
> Junio> refs/heads anyway.
>
> And it looks like you've shown me the door in that wall.

I was going to write that myself, but unfortunately will be
offline for the rest of the evening -- interrupted by a surprise
visitor from India who is only visiting for a few days.

So in case you are really in a rush, and in a mood to build on
top of my WIP, here is one.

* fetch-pack.c is modified so that you can say:

	git fetch-pack --all -k $1

  to get the list of "git ls-remote $1" equivalent while
  fetching everything from the remote.

* Change git-clone.sh to use git-fetch-pack --all -k instead of
  git-clone-pack; the output from fetch-pack is munged further
  by a script that implements "copy the refs to the same
  location while figuring out where the HEAD is".  The latter
  part in my WIP is incomplete so --use-separate-remote option
  probably would not work right now.

---
diff --git a/fetch-pack.c b/fetch-pack.c
index 535de10..2d0a626 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -7,8 +7,9 @@
 static int keep_pack;
 static int quiet;
 static int verbose;
+static int fetch_all;
 static const char fetch_pack_usage[] =
-"git-fetch-pack [-q] [-v] [-k] [--thin] [--exec=upload-pack] [host:]directory <refs>...";
+"git-fetch-pack [--all] [-q] [-v] [-k] [--thin] [--exec=upload-pack] [host:]directory <refs>...";
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
@@ -266,8 +267,9 @@ static void filter_refs(struct ref **ref
 	for (prev = NULL, current = *refs; current; current = next) {
 		next = current->next;
 		if ((!memcmp(current->name, "refs/", 5) &&
-					check_ref_format(current->name + 5)) ||
-				!path_match(current->name, nr_match, match)) {
+		     check_ref_format(current->name + 5)) ||
+		    (!fetch_all &&
+		     !path_match(current->name, nr_match, match))) {
 			if (prev == NULL)
 				*refs = next;
 			else
@@ -426,6 +428,10 @@ int main(int argc, char **argv)
 				use_thin_pack = 1;
 				continue;
 			}
+			if (!strcmp("--all", arg)) {
+				fetch_all = 1;
+				continue;
+			}
 			if (!strcmp("-v", arg)) {
 				verbose = 1;
 				continue;
diff --git a/git-clone.sh b/git-clone.sh
index 4ed861d..718029b 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@
 unset CDPATH
 
 usage() {
-	echo >&2 "Usage: $0 [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
+	echo >&2 "Usage: $0 [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
@@ -40,22 +40,74 @@ Perhaps git-update-server-info needs to 
 	do
 		name=`expr "$refname" : 'refs/\(.*\)'` &&
 		case "$name" in
-		*^*)	;;
-		*)
-			git-http-fetch -v -a -w "$name" "$name" "$1/" || exit 1
+		*^*)	continue;;
 		esac
+		if test -n "$use_separate_remote" &&
+		   branch_name=`expr "$name" : 'heads/\(.*\)'`
+		then
+			tname="remotes/$branch_name"
+		else
+			tname=$name
+		fi
+		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"
 }
 
+# A Perl script to read git-fetch -k output and store the
+# remote branches.
+copy_refs='
+use File::Path qw(mkpath);
+my $refs_file = $ARGV[0];
+my $use_separate_remote = $ARGV[1];
+my $git_dir = $ARGV[2];
+
+my $branch_top = ($use_separate_remote ? "heads" : "remotes");
+my $tag_top = "tags";
+my $head = undef;
+
+sub store {
+	my ($sha1, $name, $top) = @_;
+	$name = "$git_dir/refs/$top/$name";
+	mkpath(dirname($name));
+	open O, ">", "$name";
+	print O "$sha1\n";
+	close O;
+}
+
+open FH, "<", $refs_file;
+while (<FH>) {
+	my ($sha1, $name) = /^([0-9a-f]{40}) (.*)$/;
+	if ($name eq "HEAD") {
+		$head = $sha1;
+		next;
+	}
+	if ($name =~ s/^refs\/heads\//) {
+		if (!defined $head && $name eq "master") {
+			$head = $sha1;
+		}
+		store_branch($sha1, $name, $branch_top);
+		next;
+	}
+	if ($name =~ s/^refs\/tags\//) {
+		store_tag($sha1, $name, $tag_top);
+		next;
+	}
+}
+close FH;
+'
+
+
 quiet=
 use_local=no
 local_shared=no
 no_checkout=
 upload_pack=
 bare=
+reference=
 origin=origin
 origin_override=
+use_separate_remote=
 while
 	case "$#,$1" in
 	0,*) break ;;
@@ -68,7 +120,14 @@ while
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
           local_shared=yes; use_local=yes ;;
 	*,-q|*,--quiet) quiet=-q ;;
+	*,--use-separate-remote)
+		use_separate_remote=t ;;
 	1,-o) usage;;
+	1,--reference) usage ;;
+	*,--reference)
+		shift; reference="$2" ;;
+	*,--reference=*)
+		reference=`expr "$1" : '--reference=\(.*\)'` ;;
 	*,-o)
 		git-check-ref-format "$2" || {
 		    echo >&2 "'$2' is not suitable for a branch name"
@@ -130,6 +189,26 @@ yes)
 	GIT_DIR="$D/.git" ;;
 esac
 
+if -n "$reference"
+then
+	if test -d "$reference
+	then
+		if test -d "$reference/.git/objects"
+		then
+			reference="$reference/.git"
+		fi
+		reference=(cd "$reference" && pwd)
+		echo "$reference/objects" >"$GIT_DIR/objects/info/alternates"
+		(cd "$reference" && tar cf - refs) |
+		(cd "$GIT_DIR/refs &&
+		 mkdir reference-tmp &&
+		 cd reference-tmp &&
+		 tar xf -)
+	else
+		echo >&2 "$reference: not a local directory." && usage
+	fi
+fi
+
 # We do local magic only when the user tells us to.
 case "$local,$use_local" in
 yes,yes)
@@ -217,17 +296,22 @@ yes,yes)
 		;;
 	*)
 		cd "$D" && case "$upload_pack" in
-		'') git-clone-pack $quiet "$repo" ;;
-		*) git-clone-pack $quiet "$upload_pack" "$repo" ;;
-		esac || {
+		'') git-fetch-pack -k $quiet "$repo" ;;
+		*) git-fetch-pack -k $quiet "$upload_pack" "$repo" ;;
+		esac >"$GIT_DIR/FETCH_HEAD" || {
 			echo >&2 "clone-pack from '$repo' failed."
 			exit 1
 		}
+		# Now figure out where the remote HEAD points at.
+		perl -e "$copy_refs" "$GIT_DIR/FETCH_HEAD" \
+			"$use_separate_remote" "$GIT_DIR"
 		;;
 	esac
 	;;
 esac
 
+test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GIT_DIR/refs/reference-tmp"
+
 cd "$D" || exit
 
 if test -f "$GIT_DIR/HEAD" && test -z "$bare"
