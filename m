From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Sun, 1 Dec 2013 20:04:50 +0100
Message-ID: <20131201190447.GA31367@kaarsemaker.net>
References: <1385922611.3240.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ingy@ingy.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 20:05:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnCKO-0003x8-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 20:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab3LATE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 14:04:56 -0500
Received: from mail-wg0-f54.google.com ([74.125.82.54]:41518 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab3LATEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 14:04:55 -0500
Received: by mail-wg0-f54.google.com with SMTP id n12so10025815wgh.33
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 11:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=R/Zb1HnS1UIOT6TU1yedlLcQR7aZlQQFerVPaMkFDO0=;
        b=lfO9wWu9icPMfXrzZnaVSPy5Fw4RWQjN7BWW+M5V+sxGmOGoxS/aTjSf9WF7wYV/jq
         UuqpSJUZPUUBF2P6lX1LuEP3HCR6X5kp8ScoFyMONs/G380hyNQoJy9jDYsGdrgMKlOK
         gm1jHUJB7YVGdzH7r7A9TJcZhxRmgRCBTLefkRJ3PqLAYb4hj/fJ6PBVmyrp+3M2DhHr
         +G6+JDxfS0WC5OXGPID2yVrOxSlxSkyjcSx7JRmUO4lEH6DxLWNc+TUX+vQ+1pcOoB9e
         VTe+vmTB/NDLm9JCXtMdjBrwh5dEGwTya5StNOBqzIS1z6oW9YcNSn0u2tBxjeKPe9Ce
         SkrQ==
X-Gm-Message-State: ALoCoQlOMHR+nr8mxKy6OYjUOscCI0LipLlJveYyM78+0slRyd1bT93QfLVBvt+CEWbxuLRf3X7P
X-Received: by 10.195.13.45 with SMTP id ev13mr49388734wjd.20.1385924693797;
        Sun, 01 Dec 2013 11:04:53 -0800 (PST)
Received: from kaarsemaker.net (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id dj8sm115072280wid.2.2013.12.01.11.04.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Dec 2013 11:04:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385922611.3240.6.camel@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238593>

We always ignore anything named .git, but we should also ignore the git
directory if the user overrides it by setting $GIT_DIR

Reported-By: Ingy d=F6t Net <ingy@ingy.net>
Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 dir.c             | 2 +-
 t/t7508-status.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 23b6de4..884b37d 100644
--- a/dir.c
+++ b/dir.c
@@ -1198,7 +1198,7 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
 		return path_none;
 	strbuf_setlen(path, baselen);
 	strbuf_addstr(path, de->d_name);
-	if (simplify_away(path->buf, path->len, simplify))
+	if (simplify_away(path->buf, path->len, simplify) || is_git_directory=
(path->buf))
 		return path_none;
=20
 	dtype =3D DTYPE(de);
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c987b5e..2bd7ef1 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -198,6 +198,13 @@ test_expect_success 'status -s' '
=20
 '
=20
+test_expect_success 'status -s with non-standard $GIT_DIR' '
+	mv .git .foo &&
+	GIT_DIR=3D.foo git status -s >output &&
+	test_cmp expect output &&
+	mv .foo .git
+'
+
 test_expect_success 'status with gitignore' '
 	{
 		echo ".gitignore" &&
--=20
1.8.5-386-gb78cb96


--=20
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
