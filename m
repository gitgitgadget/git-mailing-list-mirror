From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 02/9] Stop starting pager recursively
Date: Tue, 13 Mar 2012 19:09:14 +0700
Message-ID: <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QVE-0005Sj-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab2CMMGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:06:34 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59624 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab2CMMGb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:06:31 -0400
Received: by mail-pz0-f52.google.com with SMTP id p12so885281dad.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lYJCnURppZI0jSX5NDgfusU/4dEEfe66PPRxYJk9H08=;
        b=ollxXJNL6wp1eaGW2+aHqthGyU0adgjnr+Ea4SmwmjkfOW+aPowlE7hW9RaqGFmxab
         A+voOybJNK4lNjfI/h5PfV5+UCEQR+oN79aiLn23A33CyVDvDsoxFpvCDY0jZmfEdXCG
         HSAvvoPwzYsBnqbaydzgCOuN3lny5LXJci7HV9QW4u92jhDsvkXchm9dzpXfESUEtJhb
         IypQw3L0SxMgyoy0gZmhFaEXC0jlrpLesvgDPLYakfxZT7K+I3Z9ioJyzITOnKcLVST/
         441/E5goBXzb0kRqD5VaMHxVf+19Dmd8V/zB4hODXBOLJpQXRZdUS1hc67aeex3CD+r2
         E9mw==
Received: by 10.68.236.73 with SMTP id us9mr6307308pbc.116.1331640390935;
        Tue, 13 Mar 2012 05:06:30 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id r9sm630135pbi.53.2012.03.13.05.06.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:06:29 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:09:38 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192999>

git-column can be used as a pager for other git commands, something
like this:

    GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branch

The problem with this is that "git -p column" also has $GIT_PAGER set s=
o
the pager runs itself again as another pager. The end result is an
infinite loop of forking. Other git commands have the same problem if
being abused this way.

Check if $GIT_PAGER is already set and stop launching another pager.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pager.c b/pager.c
index 05584de..4dcb08d 100644
--- a/pager.c
+++ b/pager.c
@@ -73,7 +73,7 @@ void setup_pager(void)
 {
 	const char *pager =3D git_pager(isatty(1));
=20
-	if (!pager)
+	if (!pager || pager_in_use())
 		return;
=20
 	/*
--=20
1.7.8.36.g69ee2
