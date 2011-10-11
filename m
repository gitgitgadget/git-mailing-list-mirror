From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Bug - diff in commit message.
Date: Tue, 11 Oct 2011 16:00:09 -0700
Message-ID: <7v62jvdthi.fsf@alter.siamese.dyndns.org>
References: <1315493353942-6772145.post@n2.nabble.com>
 <CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com>
 <7vpqj9vh87.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, anikey <arty.anikey@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 01:00:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDlJ6-0004Ku-RF
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 01:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab1JKXAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 19:00:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab1JKXAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 19:00:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8951E6AFE;
	Tue, 11 Oct 2011 19:00:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4KMjMfpmxQ11p5xuUup1xEf9Je4=; b=Lq1LSI
	nlNlx+k6DCszOOJdR+WaaVXR/SM+skmDcTiydSsFpJqLXvCsB3uGL6c7XcfcK39n
	SP1hYOhDJ++U3Wsvp4U/tpThCYsQJxKD9ohcI36KrzPg8HsffGnr13oHDJM7iPh0
	/NgO1+2eICA6vbJ3iIv042/ToJjjc4pIzHdxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVmIn0npW2P85SCVNyhf6gPUytCXxz50
	1D1zH3X2QPFw6IWt96xERE+Zg+iPvu5qphxCtDLIyjEjfWA6q+ti6FLmlFIdWLiG
	HYuzoEnCpOAxiLzdyGn997m8lx3ccR8VLCsEbRnyzLIH2zIAAp89BiViKKBXMJ8u
	Lj0O26zyClM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 810946AFD;
	Tue, 11 Oct 2011 19:00:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFF426AFC; Tue, 11 Oct 2011
 19:00:10 -0400 (EDT)
In-Reply-To: <7vpqj9vh87.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 09 Sep 2011 09:00:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5739DE6-F45C-11E0-B3C3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183343>

Junio C Hamano <gitster@pobox.com> writes:

> In the longer term, I think "git-rebase--am.sh" should be rewritten to
> have format-patch avoid the cost of actually generating the patch text,
> and the "mailinfo" call that comes above the context shown in this patch
> should be made conditional---when using "am" for rebasing we do not really
> care anything but the commit object names, and everything else is figured
> out from the commit this codepath.

And here is a quick hack to do that using "log --cherry-pick --right-only".

 git-am.sh         |   44 ++++++++++++++++++++++++--------------------
 git-rebase--am.sh |   12 +++++++++---
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 9042432..b79ccc5 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -641,32 +641,36 @@ do
 	# by the user, or the user can tell us to do so by --resolved flag.
 	case "$resume" in
 	'')
-		git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
-			<"$dotest/$msgnum" >"$dotest/info" ||
-			stop_here $this
-
-		# skip pine's internal folder data
-		sane_grep '^Author: Mail System Internal Data$' \
-			<"$dotest"/info >/dev/null &&
-			go_next && continue
-
-		test -s "$dotest/patch" || {
-			eval_gettextln "Patch is empty.  Was it split wrong?
-If you would prefer to skip this patch, instead run \"\$cmdline --skip\".
-To restore the original branch and stop patching run \"\$cmdline --abort\"."
-			stop_here $this
-		}
 		rm -f "$dotest/original-commit" "$dotest/author-script"
-		if test -f "$dotest/rebasing" &&
+
+		if test -f "$dotest/rebasing"
+		then
 			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
 				-e q "$dotest/$msgnum") &&
-			test "$(git cat-file -t "$commit")" = commit
-		then
+			test "$(git cat-file -t "$commit")" = commit || {
+				stop_here $this
+			}
 			git cat-file commit "$commit" |
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
-			echo "$commit" > "$dotest/original-commit"
-			get_author_ident_from_commit "$commit" > "$dotest/author-script"
+			echo "$commit" >"$dotest/original-commit"
+			get_author_ident_from_commit "$commit" >"$dotest/author-script"
+			git diff-tree -p --root "$commit" >"$dotest/patch"
 		else
+			git mailinfo $keep $no_inbody_headers \
+			$scissors $utf8 "$dotest/msg" "$dotest/patch" \
+			<"$dotest/$msgnum" >"$dotest/info" ||
+			stop_here $this
+
+			# skip pine's internal folder data
+			sane_grep '^Author: Mail System Internal Data$' \
+				<"$dotest"/info >/dev/null &&
+				go_next && continue
+			test -s "$dotest/patch" || {
+				eval_gettextln "Patch is empty.  Was it split wrong?
+If you would prefer to skip this patch, instead run \"\$cmdline --skip\".
+To restore the original branch and stop patching run \"\$cmdline --abort\"."
+				stop_here $this
+			}
 			{
 				sed -n '/^Subject/ s/Subject: //p' "$dotest/info"
 				echo
diff --git a/git-rebase--am.sh b/git-rebase--am.sh

[...]
