From: "Tom Clarke" <tom@u2i.com>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 17:10:31 +0200
Message-ID: <550f9510708300810y1ca84e8dt4d0bab8fc99deb3c@mail.gmail.com>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
	 <Pine.LNX.4.64.0708301415150.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 17:11:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQlfp-0006Nl-2M
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 17:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760994AbXH3PKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 11:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758344AbXH3PKe
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 11:10:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:31927 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760905AbXH3PKd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 11:10:33 -0400
Received: by wr-out-0506.google.com with SMTP id 36so431333wra
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 08:10:32 -0700 (PDT)
Received: by 10.90.93.6 with SMTP id q6mr619209agb.1188486631147;
        Thu, 30 Aug 2007 08:10:31 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Thu, 30 Aug 2007 08:10:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708301415150.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57044>

On 8/30/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> In my TODO, there is "add the 'rebase' strategy".  It is definitely
> something post-1.5.3, so I do not look into it.  But the most logical
> place for me would be to have a strategy 'rebase'.  IOW a
> git-merge-rebase.sh.

The following is my first naive attempt, is this the kind of thing you
were thinking of?

In addition to running the rebase, I changed the merge script to
prevent the update-ref as this is (it seems) inappropriate as it
wasn't really a merge we did.

I'm not sure if any of the other arguments (other than remotes) to the
merge script are applicable here.

-Tom

commit b68df7b3c31953216a03b8f34ffbc6d0c0927ea3
Author: Tom Clarke <tom@u2i.com>
Date:   Thu Aug 30 17:06:21 2007 +0200

    adding rebase merge strategy

diff --git a/.gitignore b/.gitignore
index 63c918c..dd1aa22 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,6 +74,7 @@ git-merge-tree
 git-merge-octopus
 git-merge-one-file
 git-merge-ours
+git-merge-rebase
 git-merge-recursive
 git-merge-resolve
 git-merge-stupid
diff --git a/Makefile b/Makefile
index 4eb4637..f6adca2 100644
--- a/Makefile
+++ b/Makefile
@@ -210,7 +210,7 @@ SCRIPT_SH = \
        git-sh-setup.sh \
        git-am.sh \
        git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
-       git-merge-resolve.sh git-merge-ours.sh \
+       git-merge-resolve.sh git-merge-ours.sh git-merge-rebase.sh \
        git-lost-found.sh git-quiltimport.sh git-submodule.sh \
        git-filter-branch.sh \
        git-stash.sh
diff --git a/git-merge-rebase.sh b/git-merge-rebase.sh
new file mode 100755
index 0000000..6140d38
--- /dev/null
+++ b/git-merge-rebase.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# Resolve two trees with rebase
+
+# The first parameters up to -- are merge bases; the rest are heads.
+bases= head= remotes= sep_seen=
+for arg
+do
+       case ",$sep_seen,$head,$arg," in
+       *,--,)
+               sep_seen=yes
+               ;;
+       ,yes,,*)
+               head=$arg
+               ;;
+       ,yes,*)
+               remotes="$remotes$arg "
+               ;;
+       *)
+               bases="$bases$arg "
+               ;;
+       esac
+done
+
+# Give up if we are given more than two remotes -- not handling octopus.
+case "$remotes" in
+?*' '?*)
+       exit 2 ;;
+esac
+
+git update-index --refresh 2>/dev/null
+
+git rebase $remotes || exit 2
diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..02611f3 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -16,11 +16,12 @@ test -z "$(git ls-files -u)" ||
 LF='
 '

-all_strategies='recur recursive octopus resolve stupid ours subtree'
+all_strategies='recur recursive octopus resolve stupid ours subtree rebase'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
 no_fast_forward_strategies='subtree ours'
 no_trivial_strategies='recursive recur subtree ours'
+no_update_ref='rebase'
 use_strategies=

 allow_fast_forward=t
@@ -81,11 +82,18 @@ finish () {
                        echo "No merge message -- not updating HEAD"
                        ;;
                *)
-                       git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
+                       case " $wt_strategy " in
+                       *" $no_update_ref "*)
+                               ;;
+                       *)
+                               git update-ref -m "$rlogm" HEAD "$1"
"$head" || exit 1
+                               ;;
+                       esac
                        ;;
                esac
                ;;
        esac
+
        case "$1" in
        '')
                ;;
