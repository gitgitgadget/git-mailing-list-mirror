From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] bash: Support new 'git fetch' options
Date: Sat, 12 Dec 2009 11:21:46 +0100
Message-ID: <4B236EBA.6050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 12 11:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJP6p-0000pW-8g
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 11:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761303AbZLLKVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Dec 2009 05:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756162AbZLLKVn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 05:21:43 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:49100 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbZLLKVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 05:21:42 -0500
Received: by ewy19 with SMTP id 19so1851830ewy.21
        for <git@vger.kernel.org>; Sat, 12 Dec 2009 02:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ujsqmQsuLRmlXekzRe1KNHTh7Hw0+ou5K19WTgAVWkY=;
        b=ZG72Kv4FiWfjpiBgAh1FeqJKZPPG+cCLZGSm32a5cug75o3qFY/mgPDaia1pCR0iJL
         grd5VjFsh/uQTLd9gzMfG5vSGjqb9/5Sm/gJ1p9LLRfjCJxuQeb75Zml8VnWnzCR17iL
         HRm/8bOjFE2KUHMEmqvkp2mMoJmIOYSEOBzxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=OldII+3JgD+zm3VJatOwSDt2/jILc3I2KmaL5GNlBFF3gY49jENLh/LjuvyNW+V5SL
         IHTJcZldtESNuf1r2W3y048OlI1WJiadPDhNMCODqPrcnRPcbOIoyVgk2eTArw6JwMzp
         B1b0d9K1jReLJ3w1Zps61LxGPKpEiOtRCdXdE=
Received: by 10.216.89.194 with SMTP id c44mr973953wef.199.1260613308455;
        Sat, 12 Dec 2009 02:21:48 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm1201517eyf.2.2009.12.12.02.21.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Dec 2009 02:21:47 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135133>

Support the new options --all, --prune, and --dry-run for
'git fetch'.

As the --multiple option was primarily introduced to enable
'git remote update' to be re-implemented in terms of 'git fetch'
(16679e37) and is not likely to be used much from the command
line, it does not seems worthwhile to complicate the code
(to support completion of multiple remotes) to handle it.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 contrib/completion/git-completion.bash |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 7c18b0c..fbfa5f2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -417,7 +417,17 @@ __git_complete_remote_or_refspec ()
 	while [ $c -lt $COMP_CWORD ]; do
 		i=3D"${COMP_WORDS[c]}"
 		case "$i" in
-		--all|--mirror) [ "$cmd" =3D "push" ] && no_complete_refspec=3D1 ;;
+		--mirror) [ "$cmd" =3D "push" ] && no_complete_refspec=3D1 ;;
+		--all)
+			case "$cmd" in
+			push) no_complete_refspec=3D1 ;;
+			fetch)
+				COMPREPLY=3D()
+				return
+				;;
+			*) ;;
+			esac
+			;;
 		-*) ;;
 		*) remote=3D"$i"; break ;;
 		esac
@@ -1002,7 +1012,7 @@ _git_difftool ()
=20
 __git_fetch_options=3D"
 	--quiet --verbose --append --upload-pack --force --keep --depth=3D
-	--tags --no-tags
+	--tags --no-tags --all --prune --dry-run
 "
=20
 _git_fetch ()
--=20
1.6.6.rc2
