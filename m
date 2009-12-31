From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Fix "git remote update" with remotes.defalt set
Date: Thu, 31 Dec 2009 10:43:17 +0100
Message-ID: <4B3C7235.2030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 10:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQHZ3-00070D-MF
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 10:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZLaJnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2009 04:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZLaJnW
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 04:43:22 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:56096 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZLaJnV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 04:43:21 -0500
Received: by ewy19 with SMTP id 19so4455254ewy.21
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 01:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=fI0l5P84gS36FdAc5gPdMnmwow6M4EwM1UPNreZmgEU=;
        b=I4s7gCCRNrzO0kHKxQOr0X9lV0eyz0FWXOZjNZ8azncB7Jlx7HF++QQffcqBcIX/zc
         kWwYhS9suhl00UBZ019B5fWZ+TMibtQ6rfKmX7zN4P3mqbMKPRRpPpc+X0ktdoHb51CC
         hwX0BCd/vYQ+0UCCcype9sxgcM4Ii4QXJxpkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=U4fGfjH7F5dOXBDc9+W0nTniNo3kxhwQc1rFaliVc0mtTMnpciOeyDhfXv4sz14iY3
         np1EjhFAIL+CEkjBGPDDR3S8LveGrN65YUylEZ0YvEjDfFMPAQhKcy4HMpZPyqsqPALo
         5pzKljCdsR10sW3hbc2S5W5FfIre3uT8of1Yg=
Received: by 10.213.1.199 with SMTP id 7mr16833899ebg.23.1262252598767;
        Thu, 31 Dec 2009 01:43:18 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 15sm10089765ewy.0.2009.12.31.01.43.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Dec 2009 01:43:18 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135940>

Starting from commit 8db35596, "git remote update" (with no
group name given) will fail with the following message if
remotes.default has been set in the config file:

fatal: 'default' does not appear to be a git repository
fatal: The remote end hung up unexpectedly

The problem is that the --multiple option is not passed to
"git fetch" if no remote or group name is given on the command
line. Fix the problem by always passing the --multiple
option to "git fetch" (which actually simplifies the code).

Reported-by: YONETANI Tomokazu

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-remote.c  |   10 ++++------
 t/t5505-remote.sh |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index a501939..c4945b8 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1238,13 +1238,11 @@ static int update(int argc, const char **argv)
 		fetch_argv[fetch_argc++] =3D "--prune";
 	if (verbose)
 		fetch_argv[fetch_argc++] =3D "-v";
-	if (argc < 2) {
+	fetch_argv[fetch_argc++] =3D "--multiple";
+	if (argc < 2)
 		fetch_argv[fetch_argc++] =3D "default";
-	} else {
-		fetch_argv[fetch_argc++] =3D "--multiple";
-		for (i =3D 1; i < argc; i++)
-			fetch_argv[fetch_argc++] =3D argv[i];
-	}
+	for (i =3D 1; i < argc; i++)
+		fetch_argv[fetch_argc++] =3D argv[i];
=20
 	if (strcmp(fetch_argv[fetch_argc-1], "default") =3D=3D 0) {
 		git_config(get_remote_default, &default_defined);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index fd166d9..936fe0a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -419,6 +419,20 @@ test_expect_success 'update default (overridden, w=
ith funny whitespace)' '
=20
 '
=20
+test_expect_success 'update (with remotes.default defined)' '
+
+	(cd one &&
+	 for b in $(git branch -r)
+	 do
+		git branch -r -d $b || break
+	 done &&
+	 git config remotes.default "drosophila" &&
+	 git remote update &&
+	 git branch -r > output &&
+	 test_cmp expect output)
+
+'
+
 test_expect_success '"remote show" does not show symbolic refs' '
=20
 	git clone one three &&
--=20
1.6.6.69.gc18d
