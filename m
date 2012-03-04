From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 4/4] submodules: fix ambiguous absolute paths under Windows
Date: Sun, 04 Mar 2012 22:16:19 +0100
Message-ID: <4F53DBA3.4010500@web.de>
References: <4F53DA95.2020402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 22:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4In2-0002NQ-Nb
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 22:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485Ab2CDVQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 16:16:21 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:54555 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194Ab2CDVQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 16:16:20 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate04.web.de (Postfix) with ESMTP id 9FBCD73222B3
	for <git@vger.kernel.org>; Sun,  4 Mar 2012 22:16:19 +0100 (CET)
Received: from [192.168.178.48] ([91.3.220.167]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MGzFy-1S8AOv17sA-00DXEG; Sun, 04 Mar 2012 22:16:19
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F53DA95.2020402@web.de>
X-Provags-ID: V02:K0:N9ybAfm/R9satE53oNRwMVbnK2cdoB/jCmUkL3iQf1d
 Talf3MhIPYiLA6RgRV4EHj+JexrPLQik98+LQ9WfoZdhI7LUGw
 DM2Ltb099putxO7mNam/qYG5v3mSvGybBaEFMudLLspK5RALM9
 tBcJzJuZnauXkKfvqyH1L0BokdvZOrx81JqsusKSr7B23N10xo
 87a0UbcKxTQ+yfv62gGBA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192177>

From: Johannes Sixt <j6t@kdbg.org>

Under Windows the "git rev-parse --git-dir" and "pwd" commands may return
either drive-letter-colon or POSIX style paths. This makes module_clone()
behave badly because it expects absolute paths to always start with a '/'.

Fix that by always converting the "c:/" notation into "/c/" when computing
the relative paths from gitdir to the submodule work tree and back.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-submodule.sh |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index a9e9822..efc86ad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -151,6 +151,9 @@ module_clone()

 	a=$(cd "$gitdir" && pwd)/
 	b=$(cd "$path" && pwd)/
+	# normalize Windows-style absolute paths to POSIX-style absolute paths
+	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} ;; esac
+	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} ;; esac
 	# Remove all common leading directories after a sanity check
 	if test "${a#$b}" != "$a" || test "${b#$a}" != "$b"; then
 		die "$(eval_gettext "Gitdir '\$a' is part of the submodule path '\$b' or vice versa")"
-- 
1.7.9.2.362.g684a8
