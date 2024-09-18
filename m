Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBB376F1
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677024; cv=none; b=fxu8JsBYTyT3A7I8uFCBFxCeeGsc8kN68HI/PwUhfO4gusZMCrSPQC4o0DNhihtTn49xJc1Ru2lAeRVO8KB0HP3kacVU8zIRobKivO+GldnYJaIQ8330TJusCjSwdiWY2x8pqMzM9tZkX+JYlCEIQAAnSb4K8AmN1SEE+JEq92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677024; c=relaxed/simple;
	bh=piIP3lY9wY7V8D1xIIY5A/up+RwDbgEskKQr4A/Lk3g=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VhUrLqc0pSjO+ccTcLfnCvXZTrfmnahQ+Z6GVnj+R8k+JbQEBriWAYPkUBY1MjgxSUXxQ+FVJMeYqrsI3MRUKeT8p/eBVGU/wqthyYL+UZkaBEwLXsy34JuOXa8kE1Z4Lw0gfzagRIGbv9pvc+WsOVwUEDUL0Ih9EzfyMlmhcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48IGUAKo309413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 16:30:10 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Marcos Del Sol Vives'" <marcos@orca.pet>, "'git'" <git@vger.kernel.org>
References: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
In-Reply-To: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet>
Subject: RE: Permission issue in Git in DrvFs-mounted network drives
Date: Wed, 18 Sep 2024 12:30:05 -0400
Organization: Nexbridge Inc.
Message-ID: <03ed01db09e8$080cf090$1826d1b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIypJDh3QEUm6MoQJhXxylSxxHhwrGuhicQ

On September 18, 2024 12:16 PM, Marcos Del Sol Vives wrote:
>Under WSL1 (Windows Subsystem for Linux), when using a network share
>mounted via DrvFs, Git fails to add any files to a new or an existing =
repository.
>
>The reason is that Git tries to open a temporary file as with RW =
permissions but
>mode 0444, which causes WSL1 (or Samba, unsure who's here to blame) to =
create
>first an file empty with the read-only DOS attribute set that prevents =
any writes,
>and then actually trying to opening it in write mode, which of course =
fails.
>
>Seems to be a pretty common issue that nobody has yet reported =
officially, judging
>by the amount of posts on Stackoverflow, impacting not only WSL but =
also CIFS
>under Linux (hence why sending to this mailing list and not the =
Windows-specific
>one):
>
> - =
https://superuser.com/questions/681196/debugging-git-repo-permissions-on-=

>samba-share
> - =
https://superuser.com/questions/1450094/git-on-wsl-commands-fail-despite-=

>permissions-seeming-fine
> - =
https://superuser.com/questions/1491499/use-git-on-a-shared-drive-within-=

>wsl
>
>As a workaround, opening the file with permissions 0600 and then using =
a fchmod
>with the final desired mode works, which is a very small change that =
should cause
>no issues under neither real Linux nor WSL:
>
>--- git-2.39.5.orig/wrapper.c
>+++ git-2.39.5/wrapper.c
>@@ -484,9 +484,11 @@ int git_mkstemps_mode(char *pattern, int
> 			v /=3D num_letters;
> 		}
>
>-		fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
>-		if (fd >=3D 0)
>+		fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, 0600);
>+		if (fd >=3D 0) {
>+			fchmod(fd, mode);
> 			return fd;
>+		}

I am not certain this is either necessary or important to platforms =
other than Windows.
The /tmp directory is often, and properly set with the sticky bit +t. =
This ensures that only
The creating user has access to the temp file regardless of create =
ownership or security.
I would prefer that this be put into a compat layer rather than made =
general change.

> 		/*
> 		 * Fatal error (EPERM, ENOSPC etc).
> 		 * It doesn't make sense to loop.
>
>The WSL team at Microsoft has been already informed as well:
>https://github.com/microsoft/WSL/issues/12051

