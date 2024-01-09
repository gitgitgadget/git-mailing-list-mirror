Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56393635
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="jMn3IEcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=eCnATKnRq+R1g+piEEG1Zlcset6it2a3T1xqmfnzt4k=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=jMn3IEcE9/FQtiohLaGAhS6Oa8du1HX7ObjmFRZS6h6lyLgAXfu97reRKPSE7hvwp46hRfawEnlE
        Q3XyWx3XqZpLg9QGjrJ1pKmrPlHPD5RAakpEnMEPpMTKWVgoxOx9seZvUKZAgxuVK7N6agOuoF5u
        n5viBfTABTAejgc8yWE=
Received: by smtp-relay.sendinblue.com with ESMTP id d37781c3-6af2-409b-95a8-660a9b92d20b; Tue, 09 January 2024 00:53:07 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTA5MDA1MzAzLjQ0NDkzMi0yLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Mon,  8 Jan 2024 15:53:03 -0900
Subject: [PATCH v2 1/1] completion: dir-type optargs for am, format-patch
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id F1A08520261; Mon,  8 Jan 2024 15:53:04 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109005303.444932-1-britton.kerin@gmail.com>
References: <4714b88d-df5b-4e37-a5d7-af5033cfb861@smtp-relay.sendinblue.com> <20240109005303.444932-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>
Origin-messageId: <20240109005303.444932-2-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: 52O3ZVNYm_RT6LkanIon1x6iR5hbqQ-46ugH29Y-tbE5yqQPXhtG4Mt4wQOXPw0KHnUEwKTRnmGIaCBcKbdZrJvgkr2Kq3rkvPDLG32IzmAXpFBkOc-wZwZnnfNkn3LwlhQ2HNQ_9Qmprxqg9Ug0QWPmlfQW8UmHTaqW9aWTYqO5
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 185b47d802..2b2b6c9738 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1356,6 +1356,29 @@ =5F=5Fgit=5Fcount=5Farguments ()
 	printf =22%d=22 $c
 }
=20
+# Complete actual dir (not pathspec), respecting any -C options.
+#
+# Usage: =5F=5Fgit=5Fcomplete=5Frefs [<option>]...
+# --cur=3D<word>: The current dir to be completed.  Defaults to the =
current word.
+=5F=5Fgit=5Fcomplete=5Fdir ()
+{
+	local cur=5F=3D=22$cur=22
+
+	while test $# !=3D 0; do
+		case =22$1=22 in
+		--cur=3D*)	cur=5F=3D=22${1##--cur=3D}=22 ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
+
+        # This rev-parse invocation amounts to a pwd which respects -C =
options
+	local context=5Fdir=3D$(=5F=5Fgit rev-parse --show-toplevel --show-prefix=
 2>/dev/null | paste -s -d '/' 2>/dev/null)
+	[ -d =22$context=5Fdir=22 ] || return 1
+
+	COMPREPLY=3D$(cd =22$context=5Fdir=22 2>/dev/null && compgen -d -- =
=22$cur=5F=22)
+}
+
 =5F=5Fgit=5Fwhitespacelist=3D=22nowarn warn error error-all fix=22
 =5F=5Fgit=5Fpatchformat=3D=22mbox stgit stgit-series hg mboxrd=22
 =5F=5Fgit=5Fshowcurrentpatch=3D=22diff raw=22
@@ -1374,6 +1397,10 @@ =5Fgit=5Fam ()
 		=5F=5Fgitcomp =22$=5F=5Fgit=5Fwhitespacelist=22 =22=22 =
=22${cur##--whitespace=3D}=22
 		return
 		;;
+	--directory=3D*)
+		=5F=5Fgit=5Fcomplete=5Fdir --cur=3D=22${cur##--directory=3D}=22
+		return
+		;;
 	--patch-format=3D*)
 		=5F=5Fgitcomp =22$=5F=5Fgit=5Fpatchformat=22 =22=22 =
=22${cur##--patch-format=3D}=22
 		return
@@ -1867,7 +1894,17 @@ =5F=5Fgit=5Fformat=5Fpatch=5Fextra=5Foptions=3D=22
=20
 =5Fgit=5Fformat=5Fpatch ()
 {
+	case =22$prev,$cur=22 in
+	-o,*)
+		=5F=5Fgit=5Fcomplete=5Fdir
+		return
+		;;
+	esac
 	case =22$cur=22 in
+	--output-directory=3D*)
+		=5F=5Fgit=5Fcomplete=5Fdir --cur=3D=22${cur##--output-directory=3D}=22
+		return
+		;;
 	--thread=3D*)
 		=5F=5Fgitcomp =22
 			deep shallow
--=20
2.43.0


