From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup_git_directory(): fix move to worktree toplevel directory
Date: Sat, 30 Aug 2008 16:15:32 +0700
Message-ID: <1220087732-2288-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de,
	=?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 11:17:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMZn-00030A-8l
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbYH3JPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 05:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYH3JPx
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:15:53 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:10630 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbYH3JPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:15:52 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1110367wfd.4
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=DC3LOuNbq6hlPEgOnjsNZ/PJ8in2tIkxw8neSGcQxus=;
        b=A5IDM+9ffPrdY6z9/BWLg/ZDKWmqkMwMfXUfH/WSD51aRiGgd3QJS3hWOfcqSQM5i1
         K+qQ9CeVmbozVfDFIwoPNwVsncXCPTaM4yxIqy2Tob8aUb11d/pgQ6i1wolqjKU3z327
         mzwl1SLIGD7Hh6y9S1kPmnVyOewQJOX4TfhGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=nlnI040UNZ2LbhuufGXiTqoLINngGL7tyDwy5IGvUrdpqi0aKXYa+4oDO5ZohTr+vi
         HC5WreuAMnxEldjAXPqewsVdZ/Fg0Hbf1ykvw1Re0Wavyp73oOifuRFWtuBCakkimEnW
         2B7tnCfphbqZ6b/euS257oWckbDhvKGPvUQBs=
Received: by 10.142.53.19 with SMTP id b19mr1309082wfa.167.1220087751759;
        Sat, 30 Aug 2008 02:15:51 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.54.222])
        by mx.google.com with ESMTPS id 28sm5980680wfd.4.2008.08.30.02.15.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 02:15:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 30 Aug 2008 16:15:32 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94363>

When setup_git_directory() returns successfully, it is supposed to move
current working directory to worktree toplevel directory.

However, the code recomputing prefix inside setup_git_directory() has
to move cwd back to original working directory, in order to get new
prefix.  After that, it should move cwd back to worktree toplevel
directory as expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is a revised version of "Preserve cwd in setup_git_directory()"
 I sent before. Hopefully this time the commit message makes it clear.

 setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 6cf9094..2e3248a 100644
--- a/setup.c
+++ b/setup.c
@@ -581,6 +581,8 @@ const char *setup_git_directory(void)
 		if (retval && chdir(retval))
 			die ("Could not jump back into original cwd");
 		rel =3D get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
+		if (rel && *rel && chdir(get_git_work_tree()))
+			die ("Could not jump to working directory");
 		return rel && *rel ? strcat(rel, "/") : NULL;
 	}
=20
--=20
1.6.0.96.g2fad1.dirty
