From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH 1/2] [submodule] handle multibyte characters in name
Date: Wed, 12 Jun 2013 01:04:13 +0200
Message-ID: <1370991854-1414-2-git-send-email-iveqy@iveqy.com>
References: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, jens.lehmann@web.de,
	hvoigt@hvoigt.net
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Wed Jun 12 01:01:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmXZO-0001Md-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 01:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354Ab3FKXBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 19:01:39 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:54916 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab3FKXBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 19:01:36 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so5516411lab.39
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+xaGqwPSfEFN+oC9S/r4tiwBvktbAvl8lLbcG7vU7PQ=;
        b=d8p8OAITGsz/InwKinq54kLQhn3GhUS1uN8VsCud18FWeU0Q4AYwTB7UxwOBs7ryYp
         Wx56Di9vk9wt4c+Qwagob+KlPZvwT1VEly4qXTdy2TExQDfuhIUmXeBEj2UJlhmzqtrr
         NnmdplrtpgHZTaZj1ndGMWyrEyYZWbWLWZ/Va/WKjqRnjISEZl2hXFBqj4zH3P5LCTa8
         rWEGXBqWUA6WnhEbeyQ1azdowt1jgv5xcsIv2wfLqVbCpU64NonDvI/Uo0uP7F0i9aoO
         ncskxfgxYwXNGODf5hbFd3EsyqfeNMsSeWDhXbC37BZnsqM+hf0+IQtRvUVgCGqFSZOB
         lzUg==
X-Received: by 10.112.5.199 with SMTP id u7mr5460272lbu.67.1370991694276;
        Tue, 11 Jun 2013 16:01:34 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id n7sm8170136lbd.12.2013.06.11.16.01.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 16:01:33 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UmXc4-0000NX-2l; Wed, 12 Jun 2013 01:04:28 +0200
X-Mailer: git-send-email 1.8.3.253.g20b40b5.dirty
In-Reply-To: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227573>

Bugg reported here:
http://thread.gmane.org/gmane.comp.version-control.git/218922/focus=3D2=
26791

Note that newline (\n) is still not supported and will not be until the
sh-script is replaced by something in an other language. This however
let us to use mostly all other strange characters.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh           | 3 ++-
 t/t7400-submodule-basic.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..31524d3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -113,9 +113,10 @@ resolve_relative_url ()
 module_list()
 {
 	(
-		git ls-files --error-unmatch --stage -- "$@" ||
+		git ls-files --error-unmatch --stage -z -- "$@" ||
 		echo "unmatched pathspec exists"
 	) |
+	sed -e 's/\x00/\n/g' |
 	perl -e '
 	my %unmerged =3D ();
 	my ($null_sha1) =3D ("0" x 40);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ff26535..47ab7e7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -868,4 +868,9 @@ test_expect_success 'submodule deinit fails when su=
bmodule has a .git directory
 	test -n "$(git config --get-regexp "submodule\.example\.")"
 '
=20
+test_expect_success 'submodule with strange name works "=C3=A5 =C3=A4=C3=
=B6"' '
+	git init "=C3=A5 =C3=A4=C3=B6" &&
+	git submodule add "./=C3=A5 =C3=A4=C3=B6" &&
+	test -n "$(cat .gitmodules | grep "=C3=A5 =C3=A4=C3=B6")"
+'
 test_done
--=20
1.8.3.253.g20b40b5.dirty
