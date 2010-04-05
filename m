From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 42/43] builtins: setup repository before print unknown command error
Date: Mon,  5 Apr 2010 20:41:27 +0200
Message-ID: <1270492888-26589-43-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrI6-0003NW-E1
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab0DESoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:44:15 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151Ab0DESoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:44:09 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cUuhH6/QNwbCXa/ZKtSzduu6UiACR/52JgfzxoWUz9U=;
        b=NeW+F4Z8AscGx8MJ02tlT9FA2c1rnrD1MEH9Mj0iny98aF+GHVh90iTz440393+pH1
         zXdqICSOHZzf2JsIxicATX2weosOXkoHFA85/VWrxg60m9Ez4uOI2me+xjjB9sJAsIna
         AvwcNUBn6Vamwr5IzekkfAeAI5m0RGX54MGn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RaY47bM7dFuH4W2obeFUpUUlrWhwT/HPBrqLMEbIWy+LQCzMxx/TCaKnjMJbi/nKZo
         LxUu2SWR2TmXHKYfkVnaIXbQPxZ9ADjKBfJSf7oaNFf/crKkkCoLhFSVXko24bdae3Sc
         XjFMqRJBlHxIqZsZu6NB6vdgg40fSXcEuwkgI=
Received: by 10.223.50.193 with SMTP id a1mr6222953fag.34.1270493048402;
        Mon, 05 Apr 2010 11:44:08 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id p9sm11341595fkb.33.2010.04.05.11.44.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:44:07 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:44:05 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144036>

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
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 43cebd7..1fb478f 100644
--- a/git.c
+++ b/git.c
@@ -555,6 +555,13 @@ int main(int argc, const char **argv)
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
