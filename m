From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport.sh: disallow fuzz
Date: Tue, 21 Oct 2014 14:32:38 -0700
Message-ID: <xmqqd29lyuq1.fsf@gitster.dls.corp.google.com>
References: <20140924213512.GA7619@logfs.org>
	<xmqqwq8sb81e.fsf@gitster.dls.corp.google.com>
	<20140925220831.GA14433@logfs.org>
	<xmqq7g0r9v04.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 23:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgh2s-0001SX-A6
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 23:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933781AbaJUVcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 17:32:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933458AbaJUVcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 17:32:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61E98181B1;
	Tue, 21 Oct 2014 17:32:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AMKpcMSwyLCoob/pr7ghrihkAqI=; b=gULGie
	+aMbVgF+/7773/UqTzXlvV0VD2mZntfVghn+ie153aiXEM7hUHIQ7OZhmWQi/gdi
	849YFptmLVraz/mIrytQC5OeXgu3wEpSfKgSnCxmzxmEyozTobEe5NRzjc2ljmfa
	TzMSkbOXfKU1A5nHLS/nglu3q7zNVGOwQHSxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUai+iODcsLJti1qIByDKTeU5T7/3g/T
	4dnQldzHb9KT+kVy4OTezVE15bi3dpb2yqcAHXuq+vRTiEDeHvXf4OVCalbLK8vW
	fp5nF9E87djmR18E33rolz9ZrjAwyntrGVJs6eqN+KJVZ6Bs77Uq0lhmoQr36p2x
	wHf1Xffqlco=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 597FE181B0;
	Tue, 21 Oct 2014 17:32:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC7A1181AF;
	Tue, 21 Oct 2014 17:32:39 -0400 (EDT)
In-Reply-To: <xmqq7g0r9v04.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Sep 2014 15:48:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C879B460-5969-11E4-A25F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Things might have been different if this were mid 2006 or early
> 2007, but I am afraid that "the spirit of git" with a quote from
> Linus no longer carries much weight on this particular issue.  A
> backward incompatible change is backward incompatible change that
> breaks existing users no matter how loudly you (and I) shout that it
> is the right thing to do in the long run.
>
> Let's have it the other way around, keep the same behaviour for
> those who run the command without the new option, while allowing
> people who know better and are aligned with the spirit of git to
> pass the parameter, at least for now, with a note in the
> documentation to warn that the default may change in the future to
> allow no fuzz, or something.

I was waiting to hear an Ack or some comments and then forgot about
this topic.

I'll send two patches, one is essentially yours *but* does not
flip the default (i.e. those who want to be safe have to be explicit
about it), and then the other is to flip the default but more gently.

Here is the first one.  I'll send the "default flipping" as a reply
to this message.

-- >8 --
From: Joern Engel <joern@logfs.org>
Date: Thu, 25 Sep 2014 18:08:31 -0400
Subject: [PATCH 1/2] git-quiltimport.sh: allow declining fuzz with --exact option

git-quiltimport unconditionally passes "-C1" to "git apply",
supposedly to roughly match the quilt default of --fuzz 2.  Allow
users to pass --exact option to disable it, requiring the patch to
apply without any fuzz.

Also note that -C1 and fuzz=2 is not identical.  Most patches have
three lines of context, so fuzz=2 leaves one relevant line of
context.  But for any patches with more or less context this is not
true.  git-apply has no option for fuzz, so any emulation will
always be best-effort.

Signed-off-by: Joern Engel <joern@logfs.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-quiltimport.txt | 12 ++++++++++++
 git-quiltimport.sh                | 17 ++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index a356196..109918d 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -49,6 +49,18 @@ The default for the patch directory is patches
 or the value of the $QUILT_PATCHES environment
 variable.
 
+-C <number>::
+	Pass `-C<number>` to underlying `git apply` when applying
+	the patch, to reduce number of context lines to be matched.
+	By default, `-C1` is passed to `git apply` to emulate the
+	`--fuzz=2` behaviour of quilt (assuming the standard 3
+	context lines).
+
+--exact::
+	Do not pass any `-C<number>` option to `git apply` when
+	applying the patch, to require context lines to fully match.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 167d79f..929365f 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -6,6 +6,8 @@ git quiltimport [options]
 --
 n,dry-run     dry run
 author=       author name and email address for patches without any
+C=            minimum context (see git apply)
+exact         allow no-fuzz
 patches=      path to the quilt series and patches
 "
 SUBDIRECTORY_ON=Yes
@@ -13,6 +15,7 @@ SUBDIRECTORY_ON=Yes
 
 dry_run=""
 quilt_author=""
+cflag=-C1
 while test $# != 0
 do
 	case "$1" in
@@ -20,6 +23,18 @@ do
 		shift
 		quilt_author="$1"
 		;;
+	-C)
+		shift
+		# ensure numerical parameter
+		case "$1" in
+		''|*[!0-9]*) usage;;
+		*) ;;
+		esac
+		cflag="-C$1"
+		;;
+	--exact)
+		cflag=
+		;;
 	-n|--dry-run)
 		dry_run=1
 		;;
@@ -130,7 +145,7 @@ do
 	fi
 
 	if [ -z "$dry_run" ] ; then
-		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
+		git apply --index $cflag ${level:+"$level"} "$tmp_patch" &&
 		tree=$(git write-tree) &&
 		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
-- 
2.1.2-583-g325e495
