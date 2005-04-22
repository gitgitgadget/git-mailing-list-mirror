From: Junio C Hamano <junkio@cox.net>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Thu, 21 Apr 2005 23:23:41 -0700
Message-ID: <7vzmvr72j6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
	<7vis2fbr0p.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 08:19:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOrVg-0007oj-KQ
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 08:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVDVGX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 02:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDVGX6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 02:23:58 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:14757 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261932AbVDVGXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 02:23:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050422062340.CWGJ9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Apr 2005 02:23:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 21 Apr 2005 22:05:06 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I'd _really_ prefer to just try to teach people to work from
LT> the "top" directory instead.

I share the sentiment, but I do not think that is an option.
There are three possibilities:

 - Train people to always work from the top and never support
   working in subdirectory at any layer.

 - Admit that people cannot be trained, and support it at Cogito
   layer.

 - Further admit that to support it without core layer help,
   what Cogito layer needs to do involves quite a lot of "yuck"
   factor.

For somebody whose primary concern is to pull the whole tree
from outside and watch out for merge conflicts, always working
from the top may be a practical option.  But you also have to
consider that the people who actually feed those whole trees to
you probably do most of their work in their subdirectories.  You
would want to make life easier for them in order for you to get
high-quality results from them.

I initially thought that the third one in the above list was the
case, and that's why I asked.  After reviewing the core layer to
see the extent of the damage the proposed change would cause, to
my surprise, it turns out that it is not all that bad.  It
probably is not surprising to you because of the way you
designed things --- doing as much as possible in the dircache,
and avoiding looking at the working tree.

The commands I would want to take paths relative to the user cwd
are quite limited; note that I just want these available to the
user and I do not care which one, the core or Cogito, groks the
cwd relative paths:

  check-files paths...
  show-diff [-R] [-q] [-s] [-z] [paths...]
  update-cache [--add] [--remove] [--refresh]
      [--cacheinfo mode blob-id] paths...

The only parameters that needs $R prefixing are the "paths..."
above.  I think the wrapper layer can manage without the help
from the core layer for these small number of commands using the
workaround I outlined in my previous message.

In addition, there is another one that looks at the working
tree:

  diff-cache [-z] [-r] [--cached] tree-id

But this one is even easier.  The wrapper layer needs to figure
out the project top, chdir to it and run the underlying
diff-cache there.

LT> I really don't like it that much, but to some degree it
LT> obviously is exactly what "--prefix=" does to
LT> checkout-cache. It's basically saying that all normal file
LT> operations have to be prefixed with a magic string.

More or less so.  I actually was thinking about going a bit more
than just prefix, and normalizing paths in the core layer, in
order to get something like the following operate sensibly:

  $ find . -type f | xargs update-cache
  $ cd mozilla-sha1 && show-diff ../*.h

But this may be going a bit overboard.

LT> And git really doesn't do too many of those, so maybe it's
LT> ok. What would the patch look like? I don't really love the
LT> idea, but if the patch is clean enough...

Please forget this one for a bit.  I'm attacking this from both
fronts.

Core changes supporting the "project root" notion is what we are
discussing here.  As I said, I do not think it would be a huge
change as I feared initially, but after the initial "let's get
the list of commands and analyze how they use the paths" phase,
I have backburnered this approach, at least for now.  Working
around in the wrapper layer without core support seems to be a
viable option, especially now I know that what needs to be
wrapped are not that many, and that is what I've been looking
at this evening.

For your amusement, eh, rather, to test your "yuck" tolerance
;-), I've attached two scripts.  jit-find-index is a helper
script for wrappers.  It finds the project root and computes $R
prefix; the wrappers call it and eval its result.
jit-update-cache is a wrapper to run update-cache inside of
subdirectory.  This is the worst example among the four wrappers.

Not-Signed-off-yet-by: Junio C Hamano <junkio@cox.net>
---

 jit-find-index   |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 jit-update-cache |   23 +++++++++++++++++++++
 2 files changed, 83 insertions(+)

--- /dev/null	2005-03-19 15:28:25.000000000 -0800
+++ jit-find-index	2005-04-21 22:59:55.000000000 -0700
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+sq=s/\'/\''\\'\'\'/g ;# see sq-expand in show-diff.c
+
+lookfor_index=${GIT_INDEX_FILE-.git/index}
+lookfor_object=${SHA1_FILE_DIRECTORY-.git/objects}
+
+index= object= project_top=
+
+# No point in looking for something specified with an absolute path.
+case "$lookfor_index" in
+/*) index="$lookfor_index" ;;
+esac
+case "$lookfor_object" in
+/*) object="$lookfor_object" ;;
+esac
+
+# Beware of symlinks.  We need to find out what the current directory
+# is called relative to the path recorded in the dircache.
+dir=${PWD-$(pwd)} cwd="$dir" down=
+
+while 
+    case "$dir" in /) break ;; esac && # we searched all.
+    case ",$index,$object,$project_top," in
+    *,,*) ;;
+    *)    break ;; # we now have all.
+    esac
+do
+    case "$index" in
+    '') test -f "$dir/$lookfor_index" &&
+	index="$dir/$lookfor_index" ;;
+    esac
+    case "$object" in
+    '') test -d "$dir/$lookfor_object" &&
+	object="$dir/$lookfor_object" ;;
+    esac
+
+    case "$project_top" in
+    '') test -d "$dir/.git" &&
+	project_top="$dir" &&
+	working_dir="$down" ;;
+    esac
+    down="$(basename "$dir")/$down"
+    dir=$(dirname "$dir")
+done
+
+if test ! -f "$index" || test ! -d "$object" || test ! -d "$project_top"
+then
+    echo >&2 \
+      "Cannot find the project top, index file, or object database."
+    echo exit 1 ;# love this!
+else
+    # Working directory relative to the project top
+
+    echo "GIT_INDEX_FILE='$(echo "$index" | sed -e "$sq")'"
+    echo "SHA1_FILE_DIRECTORY='$(echo "$object" | sed -e "$sq")'"
+    echo "GIT_PROJECT_TOP='$(echo "$project_top" | sed -e "$sq")'"
+    echo "GIT_WORKING_DIR='$(echo "$working_dir" | sed -e "$sq")'"
+    echo export GIT_INDEX_FILE SHA1_FILE_DIRECTORY GIT_PROJECT_TOP
+fi



--- /dev/null	2005-03-19 15:28:25.000000000 -0800
+++ jit-update-cache	2005-04-21 22:59:48.000000000 -0700
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+eval "$(jit-find-index)"
+sq=s/\'/\''\\'\'\'/g
+RQ=$(echo "$GIT_WORKING_DIR" | sed -e "$sq")
+args=
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	--add | --remove | --refresh)
+	    args="${args}$1 " ;;
+	--cacheinfo)
+	    args="${args}$1 "
+	    shift; args="${args}'$(echo "$1" | sed -e "$sq")' "
+	    shift; args="${args}'$(echo "$1" | sed -e "$sq")' " ;;
+	*)
+	    args="${args}'$RQ$(echo "$1" | sed -e "$sq")' " ;;
+	esac
+	shift
+done
+eval "set x $args; shift"
+
+cd $GIT_PROJECT_TOP && exec update-cache "$@"



