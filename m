From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Wed, 04 May 2011 19:11:18 -0700
Message-ID: <7v62ppdhh5.fsf@alter.siamese.dyndns.org>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
 <20110504073850.GA8512@sigill.intra.peff.net>
 <7vliymfp4t.fsf@alter.siamese.dyndns.org>
 <20110504212848.GA27779@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 04:11:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHo2Y-0005eo-7P
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 04:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab1EECLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 22:11:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab1EECLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 22:11:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B861C4472;
	Wed,  4 May 2011 22:13:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j6bJBU9nqQtwdRsk3PlPUcpb/l4=; b=wGg/ET
	LP754ECYhBSOjnq/zZ5V2PE854OxGVplW5Hs+ObrbOE5w668rqr3zBppNdUg8IPH
	LzcVNdoFOEPnt6KYt8m3MsXa9bbtIjiAPbn6a7ISugKDrLS7ygJ+VRrRp/oxlBIC
	amUoihzQEMm6GuSy8eTe3MtrxnKianjfr1enU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZm2n/f1zAf1iVnLZQ5zleAlSViQsmFx
	sXpzj68GQ/DHdF3lqMRZY+qdtpGUvXyP17wh0fKZYZjiuZCJTXkTHigJyxtfzJSj
	wXokiCbbvLduW+Khpv+lpJSGGNV5YabPzMMT5u3Zvcx3J0jzs0D1WnfKdWN6rToc
	B9/mZew14nM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94A0F4471;
	Wed,  4 May 2011 22:13:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 509454470; Wed,  4 May 2011
 22:13:24 -0400 (EDT)
In-Reply-To: <20110504212848.GA27779@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 May 2011 17:28:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 438A0634-76BD-11E0-BE9B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172786>

Jeff King <peff@peff.net> writes:

> On Wed, May 04, 2011 at 08:42:58AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > ... but I worry about compatibility. We can audit our in-tree scripts,
>> > but git-sh-setup is part of the recommended API for external scripts,
>> > no?
>> 
>> I am Ok with renaming the thing to "require_work_tree_exists", and all the
>> worry will go away.
>
> Yeah, that seems like a fine solution to me.

Ok, then here is a reroll.

-- >8 --
Somebody tried "git pull" from a random place completely outside the work
tree, while exporting GIT_DIR and GIT_WORK_TREE that are set to correct
places, e.g.

	GIT_WORK_TREE=$HOME/git.git
        GIT_DIR=$GIT_WORK_TREE/.git
        export GIT_WORK_TREE GIT_DIR
        cd /tmp
        git pull

At the beginning of git-pull, we check "require-work-tree" and then
"cd-to-toplevel".  I _think_ the original intention when I wrote the
command was "we MUST have a work tree, our $(cwd) might not be at the
top-level directory of it", and no stronger than that.  That check is a
very sensible thing to do before doing cd-to-toplevel.  We check that the
place we would want to go exists, and then go there.

But the implementation of require_work_tree we have today is quite
different.  I don't have energy to dig the history, but currently it says:

 	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
 	die "fatal: $0 cannot be used without a working tree."

Which is completely bogus.  Even though we may happen to be just outside
of it right now, we may have a working tree that we can cd_to_toplevel
back to.

Add a function "require_work_tree_exists" that implements the check
this function originally intended (this is so that third-party scripts
that rely on the current behaviour do not have to get broken), and
update all the in-tree users to use it.

Some comments:

 - The call in git-rebase--interactive.sh can actually be removed, I
   think, as it is always called from git-rebase.sh that has done
   cd_to_toplevel already.

 - I am not sure if git-submodule.sh correctly works with the "as long as
   there is a working tree somewhere, it is OK" semantics.  It may have
   to stay "require_work_tree" to ensure that the $cwd is within the
   working tree.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/git-sh-setup.txt |   11 ++++++++---
 git-am.sh                      |    2 +-
 git-bisect.sh                  |    2 +-
 git-mergetool.sh               |    2 +-
 git-pull.sh                    |    2 +-
 git-rebase--interactive.sh     |    2 +-
 git-rebase.sh                  |    2 +-
 git-sh-setup.sh                |    7 +++++++
 git-stash.sh                   |    2 +-
 git-submodule.sh               |    2 +-
 10 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 3da2413..1f02c4b 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -58,9 +58,14 @@ cd_to_toplevel::
 	runs chdir to the toplevel of the working tree.
 
 require_work_tree::
-	checks if the repository is a bare repository, and dies
-	if so.  Used by scripts that require working tree
-	(e.g. `checkout`).
+	checks if the current directory is within the working tree
+	of the repository, and otherwise dies.
+
+require_work_tree_exists::
+	checks if the working tree associated with the repository
+	exists, and otherwise dies.  Often done before calling
+	cd_to_toplevel, which is impossible to do if there is no
+	working tree.
 
 get_author_ident_from_commit::
 	outputs code for use with eval to set the GIT_AUTHOR_NAME,
diff --git a/git-am.sh b/git-am.sh
index 6cdd591..430bbd5 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -39,7 +39,7 @@ rebasing*       (internal use for git-rebase)"
 . git-sh-setup
 prefix=$(git rev-parse --show-prefix)
 set_reflog_action am
-require_work_tree
+require_work_tree_exists
 cd_to_toplevel
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
diff --git a/git-bisect.sh b/git-bisect.sh
index c21e33c..f46dda2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -28,7 +28,7 @@ Please use "git help bisect" to get the full man page.'
 
 OPTIONS_SPEC=
 . git-sh-setup
-require_work_tree
+require_work_tree_exists
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2f8dc44..8a74d00 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -14,7 +14,7 @@ OPTIONS_SPEC=
 TOOL_MODE=merge
 . git-sh-setup
 . git-mergetool--lib
-require_work_tree
+require_work_tree_exists
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
diff --git a/git-pull.sh b/git-pull.sh
index eb87f49..7500b58 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -10,7 +10,7 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 set_reflog_action "pull $*"
-require_work_tree
+require_work_tree_exists
 cd_to_toplevel
 
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5873ba4..051a4ad 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -34,7 +34,7 @@ autosquash         move commits that begin with squash!/fixup! under -i
 "
 
 . git-sh-setup
-require_work_tree
+require_work_tree_exists
 
 DOTEST="$GIT_DIR/rebase-merge"
 
diff --git a/git-rebase.sh b/git-rebase.sh
index cbb0ea9..60a405d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -31,7 +31,7 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 set_reflog_action rebase
-require_work_tree
+require_work_tree_exists
 cd_to_toplevel
 
 LF='
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index aa16b83..94e26ed 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -140,6 +140,13 @@ cd_to_toplevel () {
 	}
 }
 
+require_work_tree_exists () {
+	if test "z$(git rev-parse --is-bare-repository)" != zfalse
+	then
+		die "fatal: $0 cannot be used without a working tree."
+	fi
+}
+
 require_work_tree () {
 	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
 	die "fatal: $0 cannot be used without a working tree."
diff --git a/git-stash.sh b/git-stash.sh
index 7561b37..ce633f3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -13,7 +13,7 @@ USAGE="list [<options>]
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
-require_work_tree
+require_work_tree_exists
 cd_to_toplevel
 
 TMP="$GIT_DIR/.git-stash.$$"
diff --git a/git-submodule.sh b/git-submodule.sh
index 8b90589..f2a541e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -15,7 +15,7 @@ USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <r
 OPTIONS_SPEC=
 . git-sh-setup
 . git-parse-remote
-require_work_tree
+require_work_tree_exists
 
 command=
 branch=
