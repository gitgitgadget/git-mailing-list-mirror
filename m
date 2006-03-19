From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Sun, 19 Mar 2006 15:18:49 -0800
Message-ID: <7vu09um3ae.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 00:19:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL7Al-0008DC-TV
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 00:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWCSXSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 18:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWCSXSx
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 18:18:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29949 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751200AbWCSXSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 18:18:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060319231451.CKVQ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Mar 2006 18:14:51 -0500
To: James Cloos <cloos@jhcloos.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17734>

James Cloos <cloos@jhcloos.com> writes:

> I presume I need to clone -s -l the local alternate, re-parent it to
> the new URL and grab anything missing, but how can I assure that it
> results in exactly the same repo as this script?

"The same repo as this script" is a very poor way to define what
you really want.  What is "git-repack -a -d -s"?

Guessing what you perhaps are trying to do:

 - You have /gits/linux-2.6/.git on your local disk that is a
   reasonably recent copy of the upstream Linux 2.6 repository.

 - You want to clone from whatever $1 is (maybe a subsystem
   tree, but we cannot tell from your question) to a new
   directory $2.

 - Presumably you know whatever $1 is is related to Linus
   repository and would want to take advantage of the fact that
   it shares many objects with /gits/linux-2.6/.git

It might be worth adding a --reference flag to git-clone like
this patch does.

However, this patch alone does not reduce the transferred data
during cloning any smaller if you are using the "$1" repository
over git native transport (including a local repository),
because the current clone-pack does not look at existing refs
(it was written assuming that there is _nothing_ in the cloned
repository at the beginning).  That needs a separate
enhancements.  Maybe it would be a good idea to deprecate
clone-pack altogether, use fetch-pack -k, and implement the
"copy upstream refs to our refs" logic in git-clone.sh.  We need
to do something like that if/when we are switching to use
$GIT_DIR/refs/remotes/ to store tracking branches outside
refs/heads anyway.

The rsync transport has been deprecated for some time, and it
does not handle alternates correctly anyway, so this patch does
not have any impact on that.

But if you are going to "$1" over http transport, this patch
would help because we stash away the existing refs obtained from
the reference repository under $GIT_DIR/refs/reference-tmp while
we run the fetch.

---
diff --git a/git-clone.sh b/git-clone.sh
index 4ed861d..73fb03c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@
 unset CDPATH
 
 usage() {
-	echo >&2 "Usage: $0 [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
+	echo >&2 "Usage: $0 [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
@@ -56,6 +56,7 @@ upload_pack=
 bare=
 origin=origin
 origin_override=
+reference=
 while
 	case "$#,$1" in
 	0,*) break ;;
@@ -68,6 +69,11 @@ while
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
           local_shared=yes; use_local=yes ;;
 	*,-q|*,--quiet) quiet=-q ;;
+	*,--reference=*)
+	  reference=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+	*,--reference)
+	  case "$#" in 1) usage ;; esac
+	  reference="$1" ;;
 	1,-o) usage;;
 	*,-o)
 		git-check-ref-format "$2" || {
@@ -130,6 +136,23 @@ yes)
 	GIT_DIR="$D/.git" ;;
 esac
 
+# If given a reference we would first add that one; it has to name a
+# local repository that resembles the one being cloned.
+if test -d "$reference"
+then
+	reference=$(cd "$reference" && pwd)
+	if test -d "$reference/.git/objects"
+	then
+		reference="$reference/.git"
+	fi
+	echo "$reference/objects" >"$GIT_DIR/objects/info/alternates"
+	# Pretend we know about these heads - clone-pack does not
+	# honor them currently, but that can be rectified later.
+	mkdir "$GIT_DIR/refs/reference-tmp" 
+	(cd "$reference" && tar cf - refs) |
+	(cd "$GIT_DIR/refs/reference-tmp" && tar xf -)
+fi
+
 # We do local magic only when the user tells us to.
 case "$local,$use_local" in
 yes,yes)
@@ -229,6 +252,7 @@ yes,yes)
 esac
 
 cd "$D" || exit
+test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GIT_DIR/refs/reference-tmp"
 
 if test -f "$GIT_DIR/HEAD" && test -z "$bare"
 then
