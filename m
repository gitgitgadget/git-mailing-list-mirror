From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH 3/3] filter-branch: support --submodule-filter
Date: Tue, 4 Jan 2011 14:14:19 +0100
Message-ID: <201101041414.19587.trast@student.ethz.ch>
References: <cover.1293809100.git.trast@student.ethz.ch> <44e6104ba28c80a6befe0f39fa4e2d6eeec56aa9.1293809100.git.trast@student.ethz.ch> <4D225F63.1040502@syncleus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 14:14:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa6iZ-00049D-FD
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 14:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab1ADNOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 08:14:22 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:47405 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab1ADNOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 08:14:21 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 14:14:14 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 14:14:20 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <4D225F63.1040502@syncleus.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164489>

Please don't top-post.  (There's nothing wrong with snipping the whole
message if it does not really relate, as in this case.)

Ccs for the patch at the end; I don't really care much but I could
roll all of it into a sort of "submodule tools" series for g-f-b, so
if you like it, speak up.

Jeffrey Phillips Freeman wrote:
> So im kinda new with all this so bare with me guys. I wanted to figure 
> out how to apply these patches, now i know i can use git to do this with 
> its patch command and such. However i was curious does this exist as a 
> branch somewhere official or semi-official?

Not really.

You can dig through the mailing list archives and also e.g.
gitworkflows to see how Junio handles incoming patches, but for series
like this you usually have to apply them yourself.  I deliberately
flagged it RFC because I wanted to get some feedback ... and because I
would have had to spend more time on it for docs&tests.

> I currently seem to be using
> --split-submodule which is itself in a git repo i have (which i want to 
> also find its source repo so i can keep up to date with it).

For others reading this, I wrote --split-submodule also based on an
IRC request from Jeffrey.  The patch is at the end.  But it's way less
thought through than the --{dump,load}-map feature.  In particular
I've been wondering whether it's possible to use the latter to
implement --split-submodule as a fairly concise index filter.

> So applying 
> the patch itself might be somewhat troubling due to conflicts, therefore 
> id like to actually merge in a remote branch to keep things easy. So can 
> you guys point me to which repo would be best for me to keep up to date 
> with this would be?

You'll get the same conflicts from merging two little branches with
the features on them as with a 'git am -3'.

Many patches are never pushed to a public repo (there are some notable
exceptions in longer-running work).  The hassle of sending and
applying email is far outweighed by the ease of review.  Many reviews
happen without applying the series at all.  That I pushed both of them
to a public repo was an exception for your convenience.


--- 8< ---
Subject: TOY PATCH: filter-branch --split-submodule

Sometimes it makes sense to split out a path not as a subdirectory
(that would be merged by subtree-merge), but as a submodule.  Since
git objects are just shaped in the right way, this is actually quite
easy to do in a way that maintains the correct history relations:

When splitting out DIR in commit C, the submodule commit has tree
C:DIR and the rewritten superproject commit C' gets a submodule entry
at C:DIR instead.

Parent rewriting is done in the obvious way: submodule commits have
their corresponding submodule-changing ancestors as parents.  These
are easy to fetch since we can basically use $(map C^):DIR.

This is a toy patch because of its terrible interface: you will still
have to put the submodule in place.  As a start, you can

  git clone . DIR
  ( cd DIR && git reset --hard $(git rev-parse :DIR) )

to get a sub-repo set to the correct commit.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..329d85c 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -191,6 +191,9 @@ do
 		filter_subdir="$OPTARG"
 		remap_to_ancestor=t
 		;;
+	--split-submodule)
+		split_submodule="$OPTARG"
+		;;
 	--original)
 		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
 		;;
@@ -349,6 +352,43 @@ while read commit parents; do
 	eval "$filter_index" < /dev/null ||
 		die "index filter failed: $filter_index"
 
+	if test -n "$split_submodule"; then
+		sub_differs=
+		sub_parents=
+		sub_commit=
+		submodule="$(git rev-parse --verify $commit:$split_submodule 2>/dev/null)"
+		if test -z "$parents"; then
+			if test -n "$submodule"; then
+				sub_differs=t
+			fi
+		fi
+		for parent in $parents; do
+			if ! test "$(git rev-parse --verify $parent:$split_submodule 2>/dev/null)" = "$submodule"; then
+				sub_differs=t
+			fi
+			for reparent in $(map "$parent"); do
+				p="$(git rev-parse --verify $reparent:$split_submodule 2>/dev/null)"
+				if test -n "$p"; then
+					sub_parents="$sub_parents -p $p"
+				fi
+			done
+		done
+		if test -n "$sub_differs"; then
+			sub_commit="$(sed -e '1,/^$/d' <../commit |
+				      git commit-tree $submodule $sub_parents)" || exit
+		else
+			for parent in $parents; do
+				sub_commit="$(git rev-parse --verify "$(map "$parent")":$split_submodule 2>/dev/null)"
+				break
+			done
+		fi
+		if test -n "$sub_commit"; then
+			git update-index --add --replace --cacheinfo 160000 $sub_commit "$split_submodule" || exit
+		else
+			git update-index --remove "$split_submodule"
+		fi
+	fi
+
 	parentstr=
 	for parent in $parents; do
 		for reparent in $(map "$parent"); do

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
