From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] builtins: setup repository before print unknown command error
Date: Sat, 27 Mar 2010 16:13:03 +0700
Message-ID: <1269681184-1992-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 16:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvXhb-0006HQ-Tn
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 16:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab0C0PNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 11:13:15 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:43545 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab0C0PNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 11:13:14 -0400
Received: by fxm23 with SMTP id 23so2847933fxm.21
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=0ihsIKkYzvDBaTkoTeH2LsVpsm0PLeDUdP/2sKIdnyg=;
        b=snTRYc8XF0xmPpxfsNSzkC2ZUnFSGk1wAep/NL5m8NcuoCc1C31FuS29o7/L/pqAld
         uyuPfnzGxpaywewMrVtPvfofLQn7u3OdavirubUnBBkp8hZuz8JkU+rd4lPRobwWIlmk
         0zlUKUq6Mxc2mFKa03Wrtb3OBTzgNVSA/BbSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jcu7c5NygRO8sgHYOtDUpG83ucN7ymn/WPqsycv2sjD+5T1CeFvMGsxkwRt5Thr0KW
         RHPYeCI/nTaqd8RClasQ2lzM27cHL3lUzj94gu/oIfXjgAfnO75vJj7vAkadDv901fpJ
         dReRpPmFwJ7O5TugvMlomxnthzcZX7i6mphJg=
Received: by 10.223.21.23 with SMTP id h23mr2427604fab.21.1269702792649;
        Sat, 27 Mar 2010 08:13:12 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 14sm1512382fxm.9.2010.03.27.08.13.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 08:13:11 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 27 Mar 2010 16:13:05 +0700
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143337>

help_unknown_cmd() will need to look into repository's config, in
order to collect all possible commands/aliases and give a
suggestion. So, repository must be set up before this function is
called.

As it is now, because
 - alias handling will always be done before help_unknown_cmd()
 - alias handling code will search and set up repository if found
 - alias handline code will not undo repository setup

These ensure that repository will always be set up (or attempted to
set up) before help_unknown_cmd(), so there is no issue. But the setup
dependency here is subtle. It may break some day if someone reorders
the loop, for example.

Make a note about this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index bd1d4bb..7ebfea5 100644
--- a/git.c
+++ b/git.c
@@ -547,6 +547,13 @@ int main(int argc, const char **argv)
 			exit(1);
 		}
 		if (!done_help) {
+			/*
+			 * help_unknown_cmd() requires that a repository has been
+			 * searched for and set up if found.
+			 * Luckily, the alias handling code already took care of this.
+			 */
+			if (!startup_info->have_run_setup_gitdir)
+				die("internal error: handling unknown command");
 			cmd =3D argv[0] =3D help_unknown_cmd(cmd);
 			done_help =3D 1;
 		} else
--=20
1.7.0.rc1.541.g2da82.dirty
