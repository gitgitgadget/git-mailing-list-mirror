From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 43/43] builtins: do not commit pager choice early
Date: Mon,  5 Apr 2010 20:41:28 +0200
Message-ID: <1270492888-26589-44-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrI7-0003NW-02
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab0DESoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:44:18 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab0DESoO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:44:14 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=94TF9qqLoO6NsZDsypOIzsCAUTphx64YhVV8uAYlkdA=;
        b=twngkJErwb51GtD3Y+GDI7/hoZjfYj62wGZLEAmchdqm2R/cKbc2auJPrZxgwjRRca
         qqaolJlcfIQ7HOEQENPy0hnAWsYZHJAAxOwcCoWNaWBwwgu8FEX6ohLKPIcV55kQIEAb
         oDxCqLIWjfawwDMmYo0rFt7Ry6NQ5cma+1Sng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YypnQkHg7KLNXfrbQw9nn0RQi7tACaCOfdQ0c7rYrTGhNy0aViX98WvVyUuqP254tU
         brIIA07+yh3KrBBOOPt3t14n6H/Cv1iQi4dUck0PFEx7sFAvKCtlJkz2qWWze8ru0HHn
         /xEaryTlTBGg0RNrAwtSxdj3cpb9V1xTUKh18=
Received: by 10.223.42.22 with SMTP id q22mr6152161fae.40.1270493051559;
        Mon, 05 Apr 2010 11:44:11 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id h2sm27054314fkh.55.2010.04.05.11.44.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:44:10 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:44:08 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144041>

Committing pager choice may require setting up the pager, which
will need access to repository.

At the time after handle_options() is called, the repository has not
been found yet. As a result, unallowed access to repository may
happen.

There are several possible code path after
handle_options()/commit_pager_choice() is called:

1. list_common_cmds_help()
2. run_argv()
3. help_unknown_cmd()

Case 2. will have commit_pager_choice() called inside run_builtin() if
a command is found. Case 1. and 3. won't need a pager, it's short
printout and should be fitted within a screen. So, removing
commit_pager_choice() call after handle_options() is safe.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 1fb478f..060cfe8 100644
--- a/git.c
+++ b/git.c
@@ -521,7 +521,6 @@ int main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
-	commit_pager_choice();
 	if (argc > 0) {
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] +=3D 2;
--=20
1.7.0.rc1.541.g2da82.dirty
