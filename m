Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F9BE4F
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362161; cv=none; b=g5ooQKndjoshTMRofYc3N39CEdK+oxGg3Qmzzgq72AUZKRRYBj5cBo4J7Yk3pB+/IW/oziHVSeY2rWpCYeubhuyyXzkdasrsuudXC/7rdEtjnwUouwNyjgWMDRUU6nj0J5KwghKjT0VcV11fth/+NDmCzoylh+x6VcoqbZ3iMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362161; c=relaxed/simple;
	bh=DdNN9U5QEGCtxowbXamR6TnI77ik9x/ygD2ky1a+zPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P55lykBkLt5pjndYjJMpCYpHUgCbYlVT+840/4Ql6+pKt7wcZo9ivnYn/opOacCo5UVfP+3L+DpRbnCCYmgtKjcHpjhop3npfYgsqpIlIScNBe/OsAQcE6qHh4qGc2Rv3co15EnRgV3qC/ikvHtpcX3Fzts5iWH0UK+Yp99wOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v6Rqx9RG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v6Rqx9RG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 268771DB1FE;
	Fri,  5 Apr 2024 20:09:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=DdNN9U5QEGCtxowbXamR6TnI7
	7ik9x/ygD2ky1a+zPA=; b=v6Rqx9RGSwhsvtk+FnODZcrDxzoIFNjLI/58XPFHU
	PnJPk7A/WGAa0Yhq01laggR/8sgBhTJdu0ldqp1uZSM8lvOCslq85f1nvpmiQzwm
	HvthCIeEiXF5VnumU78XABzn+p4Sd7jzk/p+CuaOvf4XC2HNmutIbKCvMCUWv7IJ
	DQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F0181DB1FC;
	Fri,  5 Apr 2024 20:09:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 828641DB1FB;
	Fri,  5 Apr 2024 20:09:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 6/6] t: teach lint that RHS of 'local VAR=VAL' needs to be quoted
Date: Fri,  5 Apr 2024 17:09:02 -0700
Message-ID: <20240406000902.3082301-7-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-501-g19981daefd
In-Reply-To: <20240406000902.3082301-1-gitster@pobox.com>
References: <20240406000902.3082301-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 E9604038-F3A9-11EE-8FE7-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Teach t/check-non-portable-shell.pl that right hand side of the
assignment done with "local VAR=3DVAL" need to be quoted.  We
deliberately target only VAL that begins with $ so that we can catch

 - $variable_reference and positional parameter reference like $4
 - $(command substitution)
 - ${variable_reference-with_magic}

while excluding

 - $'\n' that is a bash-ism freely usable in t990[23]
 - $(( arithmetic )) whose result should be $IFS safe.
 - $? that also is $IFS safe

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/check-non-portable-shell.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.p=
l
index dd8107cd7d..b2b28c2ced 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -47,6 +47,8 @@ sub err {
 	/\bgrep\b.*--file\b/ and err 'grep --file FILE is not portable (use gre=
p -f FILE)';
 	/\b[ef]grep\b/ and err 'egrep/fgrep obsolescent (use grep -E/-F)';
 	/\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not portab=
le (use FOO=3Dbar && export FOO)';
+	/\blocal\s+[A-Za-z0-9_]*=3D\$([A-Za-z0-9_{]|[(][^(])/ and
+		err q(quote "$val" in 'local var=3D$val');
 	/^\s*([A-Z0-9_]+=3D(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) a=
nd
 		err '"FOO=3Dbar shell_func" assignment extends beyond "shell_func"';
 	$line =3D '';
--=20
2.44.0-501-g19981daefd

