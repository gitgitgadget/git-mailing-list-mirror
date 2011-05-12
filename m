From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adds 'stash.index' configuration option
Date: Wed, 11 May 2011 17:26:50 -0700
Message-ID: <7vboz8epbp.fsf@alter.siamese.dyndns.org>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
 <7vfwoker7i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Pisoni <dpisoni@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 02:27:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKJk7-000738-TH
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 02:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab1ELA06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 20:26:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab1ELA05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 20:26:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E7524F8E;
	Wed, 11 May 2011 20:29:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LD7GgeGkTc7oU71gJ+DTUSHe9xM=; b=NwI7q2
	PdGLjPQwgCjwko5SzOPIoorzcWYUOFYdg+hTxGgI3tRJVHx7g+119Eko46OuiYr5
	Qzy5zxW7B4oelSTUktysemPE4YkcpA/K9eU9N7e9Vi5vLhWhO/CQXJZZbrgapjgT
	znKC52buGm+Jn95QReNVm3Gp/re+vpdTFgaJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cKuOgJleQRqxFcqrtMwfpaJLy3dqwRHJ
	rg5X9ytOJe4JRalO3zjvp2ztI5m7/LAqpmTx0jCtg5ASxdyDb4jvOJK03+byBjDv
	VreKiJHNXgO9zI17xKRXIgODDQf5EvYCHrnpzM0USsdx1fBxGc5SuQkxK9BvAW7h
	gltKcEQqq8w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E94B74F8D;
	Wed, 11 May 2011 20:28:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D81194F8A; Wed, 11 May 2011
 20:28:56 -0400 (EDT)
In-Reply-To: <7vfwoker7i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 11 May 2011 16:46:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D49E4CA4-7C2E-11E0-97E9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173435>

Junio C Hamano <gitster@pobox.com> writes:

>> Setting 'stash.index' config option changes 'git-stash pop|apply' to behave
>> as if '--index' switch is always supplied.

One thing I forgot to say.  "stash.index" invites "index _what_?"
Naming it to "stash.useIndex" may avoid such reaction.

Also, the current code has this comment:

    #   INDEX_OPTION is set to --index if --index is specified.

but it probably makes sense to change it (in the first patch in the series
that adds --no-index support) to a boolean whose value can be either true
or empty.

The reason why the very original code used INDEX_OPTION=--index may be
because it did something like "git some-cmd $INDEX_OPTION", but that is
not what the current code does, and using "either '--index' or ''" as a
form of boolean is confusing.

In other words, something like....



 git-stash.sh |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 0a94036..eed2d1e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -239,7 +239,7 @@ show_stash () {
 #   i_tree is set to the index tree
 #
 #   GIT_QUIET is set to t if -q is specified
-#   INDEX_OPTION is set to --index if --index is specified.
+#   INDEX_OPTION is set to 'true' if applying/popping also to the index.
 #   FLAGS is set to the remaining flags
 #
 # dies if:
@@ -271,14 +271,17 @@ parse_flags_and_rev()
 	for opt
 	do
 		case "$opt" in
-			-q|--quiet)
-				GIT_QUIET=-t
+		-q|--quiet)
+			GIT_QUIET=-t
+			;;
+		--index)
+			INDEX_OPTION=true
 			;;
-			--index)
-				INDEX_OPTION=--index
+		--no-index)
+			INDEX_OPTION=
 			;;
-			-*)
-				FLAGS="${FLAGS}${FLAGS:+ }$opt"
+		-*)
+			FLAGS="${FLAGS}${FLAGS:+ }$opt"
 			;;
 		esac
 	done
@@ -286,15 +289,15 @@ parse_flags_and_rev()
 	set -- $REV
 
 	case $# in
-		0)
-			have_stash || die "No stash found."
-			set -- ${ref_stash}@{0}
+	0)
+		have_stash || die "No stash found."
+		set -- ${ref_stash}@{0}
 		;;
-		1)
-			:
+	1)
+		:
 		;;
-		*)
-			die "Too many revisions specified: $REV"
+	*)
+		die "Too many revisions specified: $REV"
 		;;
 	esac
 
@@ -342,8 +345,8 @@ apply_stash () {
 		die 'Cannot apply a stash in the middle of a merge'
 
 	unstashed_index_tree=
-	if test -n "$INDEX_OPTION" && test "$b_tree" != "$i_tree" &&
-			test "$c_tree" != "$i_tree"
+	if test true = "$INDEX_OPTION" &&
+		test "$b_tree" != "$i_tree" && test "$c_tree" != "$i_tree"
 	then
 		git diff-tree --binary $s^2^..$s^2 | git apply --cached
 		test $? -ne 0 &&
@@ -387,7 +390,7 @@ apply_stash () {
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
-		if test -n "$INDEX_OPTION"
+		if test true = "$INDEX_OPTION"
 		then
 			echo >&2 'Index was not unstashed.'
 		fi




	
