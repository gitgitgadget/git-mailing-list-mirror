From: Michael O'Cleirigh <michael.ocleirigh@rivulet.ca>
Subject: [PATCH] git-filter-branch: add --egrep-filter option
Date: Fri, 15 Apr 2011 18:50:24 -0400
Message-ID: <4DA8CBB0.6080103@rivulet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 01:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAs02-00085B-Na
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 01:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab1DOXAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 19:00:21 -0400
Received: from rivulet.ca ([69.164.222.54]:56632 "EHLO smtp.rivulet.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab1DOXAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 19:00:20 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Apr 2011 19:00:20 EDT
Received: from [10.79.81.13] (24-246-84-164.cable.teksavvy.com [24.246.84.164])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.rivulet.ca (Postfix) with ESMTPSA id 21E1B6195
	for <git@vger.kernel.org>; Fri, 15 Apr 2011 18:50:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171645>

The --subdirectory-filter will look for a single directory and then rewrite
history to make its content the root.  This is ok except for cases where we
want to retain history of those files before they were moved into that
directory.

The --egrep-filter option allows specifying an egrep regex for the files in the
tree of each commit to keep.  For example:

Directories we want are A, B, C, D and they exist in several different
lifetimes.  A and B exist sometimes together then B and C and finally then D.

e.g. git-filter-branch --egrep-filter "(A|B|C|D)"

Each commit will then contain different combination's of A or B or C or D (up to A and B and C and D).
---
  git-filter-branch.sh |   12 ++++++++++++
  1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..2392ad6 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -101,6 +101,7 @@ USAGE="[--env-filter<command>] [--tree-filter<command>]
              [--index-filter<command>] [--parent-filter<command>]
              [--msg-filter<command>] [--commit-filter<command>]
              [--tag-name-filter<command>] [--subdirectory-filter<directory>]
+			[--egrep-filter<filter>]
              [--original<namespace>] [-d<directory>] [-f | --force]
              [<rev-list options>...]"

@@ -122,6 +123,7 @@ filter_msg=cat
  filter_commit=
  filter_tag_name=
  filter_subdir=
+filter_egrep=
  orig_namespace=refs/original/
  force=
  prune_empty=
@@ -191,6 +193,10 @@ do
  		filter_subdir="$OPTARG"
  		remap_to_ancestor=t
  		;;
+	--egrep-filter)
+		filter_egrep="$OPTARG"
+		remap_to_ancestor=t
+		;;
  	--original)
  		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
  		;;
@@ -317,6 +323,12 @@ while read commit parents; do
  		}
  	esac || die "Could not initialize the index"

+	if [ "$filter_egrep" ]; then
+
+		git ls-tree $commit | egrep "$filter_egrep" | git mktree | xargs git read-tree -i -m
+
+	fi
+
  	GIT_COMMIT=$commit
  	export GIT_COMMIT
  	git cat-file commit "$commit">../commit ||
-- 1.7.2.3
