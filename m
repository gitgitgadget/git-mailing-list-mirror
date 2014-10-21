From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git-quiltimport: flip the default not to allow fuzz
Date: Tue, 21 Oct 2014 14:38:00 -0700
Message-ID: <xmqq38ahje87.fsf_-_@gitster.dls.corp.google.com>
References: <20140924213512.GA7619@logfs.org>
	<xmqqwq8sb81e.fsf@gitster.dls.corp.google.com>
	<20140925220831.GA14433@logfs.org>
	<xmqq7g0r9v04.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 23:38:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgh87-00049w-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 23:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933660AbaJUViH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 17:38:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933613AbaJUViE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 17:38:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9A40182F9;
	Tue, 21 Oct 2014 17:38:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=llauFxcw/8KdKJuvApmIfupobHA=; b=Is59YN
	VNM+1wM7B5Q0+1MPmorTglBFg4cabQzJATLhQky6tn6aH/XuiF+beLEKVynhEafQ
	w59lzi8xrecFbYMOVfEemGasRx3hRdnleZy1y6sNYdhXkynxYEJn1A2efilUIqnt
	o2e2E+/3DmGt+bgcqy3w0lDz2lCx65whLVeS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QpPiJDZRsyGGSpfkvSTTO3sL4X67Aick
	+R9kBcJ9wUIszAquD1egFrbapepslz942YOZ40Axn7f2+NbtFDMvW7x9/kNqvwEy
	f6v+N/qhjUUZyrdANZ3hspMXfo7DnYhpPtVzeF+b/lUviC1qoIZcJza+IUAz0wEy
	paM+uSuglFQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0E54182F8;
	Tue, 21 Oct 2014 17:38:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 716ED182F5;
	Tue, 21 Oct 2014 17:38:02 -0400 (EDT)
In-Reply-To: <xmqq7g0r9v04.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Sep 2014 15:48:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88D09DAA-596A-11E4-AF85-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trying to be as strict as possible when applying the patch may be a
good discipline, so let's flip the default but we can be helpful to
those who do rely on the original behaviour thanks to the previous
change to add -C$n option.

Suggest using -C1 when (and only when):

 - "git apply" without fuzz fails to apply; and
 - the user did not specify a -C$n or --exact option; and
 - "git apply -C1" (old behaviour) would have succeeded.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is the "flipping of the default"

 git-quiltimport.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 929365f..1190eb9 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -15,7 +15,8 @@ SUBDIRECTORY_ON=Yes
 
 dry_run=""
 quilt_author=""
-cflag=-C1
+cflag=
+fuzz_specified=
 while test $# != 0
 do
 	case "$1" in
@@ -31,9 +32,11 @@ do
 		*) ;;
 		esac
 		cflag="-C$1"
+		fuzz_specified=yes
 		;;
 	--exact)
 		cflag=
+		fuzz_specified=yes
 		;;
 	-n|--dry-run)
 		dry_run=1
@@ -74,6 +77,25 @@ tmp_msg="$tmp_dir/msg"
 tmp_patch="$tmp_dir/patch"
 tmp_info="$tmp_dir/info"
 
+# Helper to warn about -C$n option
+do_apply () {
+	if git apply --index ${cflag+"$cflag"} "$@"
+	then
+		return
+	fi
+	if test -z "$fuzz_specified" &&
+	   git apply --check --index -C1 "$@" >/dev/null 2>&1
+	then
+		cat >&2 <<-\EOM
+		'git quiltimport' by default no longer attempts to apply
+		patches with reduced context lines to allow fuzz; if you
+		want the old 'unsafe' behaviour, run the command with -C1
+		option.
+		EOM
+
+	fi
+	return 1
+}
 
 # Find the initial commit
 commit=$(git rev-parse HEAD)
@@ -145,7 +167,7 @@ do
 	fi
 
 	if [ -z "$dry_run" ] ; then
-		git apply --index $cflag ${level:+"$level"} "$tmp_patch" &&
+		do_apply ${level:+"$level"} "$tmp_patch" &&
 		tree=$(git write-tree) &&
 		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
-- 
2.1.2-583-g325e495
