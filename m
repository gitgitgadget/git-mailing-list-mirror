From: Nikolaus Schulz <microschulz@web.de>
Subject: git am --rebasing clobbers commit encoding
Date: Sat, 7 Mar 2009 17:38:02 +0100
Message-ID: <20090307163802.GA25501@luigi.zusammrottung.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 17:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfzZ2-0007Rt-U3
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 17:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbZCGQi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 11:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbZCGQiZ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 11:38:25 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:51596 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbZCGQiY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 11:38:24 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 92F1EF907857
	for <git@vger.kernel.org>; Sat,  7 Mar 2009 17:38:21 +0100 (CET)
Received: from [83.125.40.75] (helo=tunichtgut.zusammrottung.local)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LfzXX-00080i-00
	for git@vger.kernel.org; Sat, 07 Mar 2009 17:38:20 +0100
Received: from luigi.zusammrottung.local ([192.168.178.203])
	by tunichtgut.zusammrottung.local with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <nikolaus@luigi.zusammrottung.local>)
	id 1LfzXW-000357-Id
	for git@vger.kernel.org; Sat, 07 Mar 2009 17:38:18 +0100
Received: from nikolaus by luigi.zusammrottung.local with local (Exim 4.69)
	(envelope-from <nikolaus@luigi.zusammrottung.local>)
	id 1LfzXH-0006lF-25
	for git@vger.kernel.org; Sat, 07 Mar 2009 17:38:03 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Sender: microschulz@web.de
X-Provags-ID: V01U2FsdGVkX1/OdAiYSjV68T3y66WrO0f7uGUvji2yL4UPM1Vq
	oPLZGYTcVcasvTHWHDiNNjmU//pnzFa75CdH0K6VA+glLCRIVH
	y1Qzv4OVo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112548>

Hi,

commit 5e835cac "rebase: do not munge commit log message", aiming to fix
rebasing of commits with multiple lines in the first paragraph of the
commit message, has broken rebasing of commits which are not encoded in
i18n.commitEncoding.

Here's the patch from 5e835cac:

diff --git a/git-am.sh b/git-am.sh
index 245e1db..5a7695e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -327,11 +327,20 @@ do
 			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
 		}
-		SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
-		case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
-
-		(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
-			git stripspace > "$dotest/msg-clean"
+		if test -f "$dotest/rebasing" &&
+			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
+				-e q "$dotest/$msgnum") &&
+			test "$(git cat-file -t "$commit")" = commit
+		then
+			git cat-file commit "$commit" |
+			sed -e '1,/^$/d' >"$dotest/msg-clean"
+		else
+			SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
+			case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
+
+			(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
+				git stripspace > "$dotest/msg-clean"
+		fi
 		;;
 	esac
 
The problem is, that "git cat-file commit .. | sed -e '1,/^$/d'"
discards the commit encoding header.  The commit message is taken as-is,
but later committed with the current i18n.commitEncoding.

I'm working on several machines, some of which use the legacy latin1
encoding; if I push a latin1-encoded commit to a machine using utf-8,
and rebase it there, the commits messages are corrupted.

This is particularly unlucky since with correct commit messages (no
multiple lines in first paragraph), "$dotest/msg" is perfectly fine, and
the above patch is not needed anyway.

Unfortunately, I don't see an easy way to fix this.  It seems to me that
recoding commit messages isn't really supported: commits are _always_
done with the configured i18n.commitencoding, and the only place where
recoding takes place is processing of patches sent by email, where
git-mailinfo recodes the commit message.  And commit 5e835cac has
bypassed git-mailinfo in git-am for rebasing.

I guess we cannot call iconv(1) after git cat-file because that's not
portable, and there is no plumbing command that can be used from a shell
script to convert the encoding of a commit; the functionality is in
utf8.c:reencode_string(), so only C code can use it.

Nikolaus
