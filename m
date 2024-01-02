Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A116402
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="0ucIF8cf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=jvz56T59CRnw2lhFMgvret3LEz9uk9e5nA305bQTAQo=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=0ucIF8cfjY9xu4ERGtvUc7G23OIQvEaaKw+KnG3aNOL+QHwfmZP+poe9QHYgSxINMDa2VyGEU71e
        Dlmircshvx6J68fGfj1WkXE7cqHqpKgGI9wFMZPBZMst9yFKnKF4/2zigGLksQnJoDwO3j8lm7+4
        2fLbBCHDFyr53J1FqFk=
Received: by smtp-relay.sendinblue.com with ESMTP id 66708709-247c-49ea-afda-6ac607159795; Tue, 02 January 2024 19:57:53 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAyMTk1NzQ0LjQ3ODUwMy0zLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Tue,  2 Jan 2024 10:57:40 -0900
Subject: [RFC PATCH 2/6] completion: git-log opts to bisect visualize
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 436D7520261; Tue,  2 Jan 2024 10:57:51 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102195744.478503-1-britton.kerin@gmail.com>
References: <20240102195744.478503-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <66708709-247c-49ea-afda-6ac607159795@smtp-relay.sendinblue.com>
Origin-messageId: <20240102195744.478503-3-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: gDRfXqW-RANFOaeV07lwcDIa5ikn2M0AtOK0j-IxYLMM_qG2TscIQQE44lZuQW_NOi4kfFolBRleymzadeopoVa08hPjk2UaEHJVwq6C9lYc1ZizKQNE3ea6u1JC1GeAeafwuvTtiImnadGGBKVGraRqrLmT0ueqKEuPIMSrDKoF
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

To do this the majority of =5Fgit=5Flog has been factored out into the new
=5F=5Fgit=5Fcomplete=5Flog=5Fopts.  This is needed because the visualize =
command
accepts git-log options but not rev arguments (they are fixed to the
commits under bisection).

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 30 ++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 15d22ff7d9..3472fab514 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1472,6 +1472,16 @@ =5Fgit=5Fbisect ()
 			;;
 		esac
 		;;
+	visualize)
+		case =22$cur=22 in
+		-*)
+			=5F=5Fgit=5Fcomplete=5Flog=5Fopts
+			return
+			;;
+		*)
+			;;
+		esac
+		;;
 	esac
=20
 	case =22$subcommand=22 in
@@ -2074,11 +2084,12 @@ =5F=5Fgit=5Fdiff=5Fmerges=5Fopts=3D=22off none on =
first-parent 1 separate m combined c dense-c
 =5F=5Fgit=5Flog=5Fpretty=5Fformats=3D=22oneline short medium full fuller =
reference email raw format: tformat: mboxrd=22
 =5F=5Fgit=5Flog=5Fdate=5Fformats=3D=22relative iso8601 iso8601-strict =
rfc2822 short local default human raw unix auto: format:=22
=20
-=5Fgit=5Flog ()
-{
-	=5F=5Fgit=5Fhas=5Fdoubledash && return
-	=5F=5Fgit=5Ffind=5Frepo=5Fpath
=20
+# Find only porcelain (i.e. not git-rev-list) option (not argument) and
+# selected option argument completions for git-log options and put them =
in
+# COMPREPLY.
+=5F=5Fgit=5Fcomplete=5Flog=5Fopts ()
+{
 	local merge=3D=22=22
 	if [ -f =22$=5F=5Fgit=5Frepo=5Fpath/MERGE=5FHEAD=22 ]; then
 		merge=3D=22--merge=22
@@ -2171,6 +2182,17 @@ =5Fgit=5Flog ()
 		return
 		;;
 	esac
+
+}
+
+=5Fgit=5Flog ()
+{
+	=5F=5Fgit=5Fhas=5Fdoubledash && return
+	=5F=5Fgit=5Ffind=5Frepo=5Fpath
+
+        =5F=5Fgit=5Fcomplete=5Flog=5Fopts
+        [ -z =22$COMPREPLY=22 ] || return
+
 	=5F=5Fgit=5Fcomplete=5Frevlist
 }
=20
--=20
2.43.0


