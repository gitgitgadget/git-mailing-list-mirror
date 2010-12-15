From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/21] t7810: overlapping pathspecs and depth limit
Date: Wed, 15 Dec 2010 22:02:56 +0700
Message-ID: <1292425376-14550-22-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:06:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsw8-0001Yr-PX
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab0LOPGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:06:34 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37229 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0LOPGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:06:33 -0500
Received: by mail-yw0-f46.google.com with SMTP id 5so1084142ywl.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=K5D04PScTSfpFIE/6nKo1RMls5ah00YCcXZy30EEgCI=;
        b=E9icE6ldZCUmZfz1UppzmxzRn5+smEr3ld2+gzTj2ya+9qGaU+hUBrYxryqqM0FGhi
         lChnvex4BXuW2gH+BfhsVV5OD+Tm3R/plak57NK6KhGwvNKJJjHxU3H92VG1qIXOJL1i
         Pz+McbIawjhFKPuFkCu+gTw5v+JkrfeWxTLws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Owszc42WF+s6Io7I1toI2mkoCgZX9HNIXgyvfPjQ2QBj7bqUlnBLM04j1V4uLOTmgt
         lhfl5VsijvdT4Jq83E1idsW7xLNNL8ybMaO516z5bBIy24VdPX6+9fkFP42U5OJ5V43R
         sRHBTF79+/D7Mz26LS4UUrYZxfRP0K0iNpxsM=
Received: by 10.42.167.9 with SMTP id q9mr5988660icy.293.1292425593454;
        Wed, 15 Dec 2010 07:06:33 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id 34sm1033279ibi.20.2010.12.15.07.06.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:06:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:05:41 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163773>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t7810-grep.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 023f225..d89faee 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -182,6 +182,24 @@ do
 		test_cmp expected actual
 	'
=20
+	test_expect_success "grep --max-depth 0 -- . t $L" '
+		{
+			echo ${HC}t/v:1:vvv
+			echo ${HC}v:1:vvv
+		} >expected &&
+		git grep --max-depth 0 -n -e vvv $H -- . t >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep --max-depth 0 -- t . $L" '
+		{
+			echo ${HC}t/v:1:vvv
+			echo ${HC}v:1:vvv
+		} >expected &&
+		git grep --max-depth 0 -n -e vvv $H -- t . >actual &&
+		test_cmp expected actual
+	'
+
 done
=20
 cat >expected <<EOF
--=20
1.7.3.3.476.g10a82
