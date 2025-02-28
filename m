Received: from evolvis.org (evolvis.org [217.144.135.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2923DE
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.135.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724049; cv=none; b=gDed4P5pTCXJFQ8WZW9GAEC5ZlyobBBhfIl73syhqLz/mlRiy5UAJKY/7E0w5GJ2B615efBTq+loYCBjUOCejDOcfEhEKZ7gHL5XmRHB1doX+4Q8JqOZlHQsMqRL8tUhRuptSdcCHCAkiNLQG+Eh9/nPK8HPKkr/Fwu89zO6wi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724049; c=relaxed/simple;
	bh=X1I4nSo6AV8ZQidbUamKGbjYQi8ITJblHASwofa6Cyk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=bTEmLxOyAqKfJaKRHiOAlGyCqF8++a4OQFDOPau/Ebdp9y3oJwmI1Lp7QYZ7PVnBq4YjGI29Qc4+To3wKmNkeYJHps4n9udX3yZTqHVW2O0N+Tjd8dxloCEgGGiuZ6nOrD/jfoXmFiBNm49YumQCJl1RTjjJXXUhP7Z084MwpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.144.135.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from x61p.mirbsd.org (2001-4dd7-25b2-0-21d-e0ff-fe77-c17b.ipv6dyn.netcologne.de [IPv6:2001:4dd7:25b2:0:21d:e0ff:fe77:c17b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: x61p@relay.evolvis.org)
	by evolvis.org (Postfix) with ESMTPSA id 7609F100119
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:27:13 +0000 (UTC)
Received: by x61p.mirbsd.org (Postfix, from userid 1000)
	id 5A529147132; Fri, 28 Feb 2025 07:27:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by x61p.mirbsd.org (Postfix) with ESMTP id 56522147131
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 07:27:12 +0100 (CET)
Date: Fri, 28 Feb 2025 07:27:12 +0100 (CET)
From: Thorsten Glaser <tg@debian.org>
To: git@vger.kernel.org
Subject: gitweb encoding issues (partial patch)
Message-ID: <8e89b5d0-c913-0dcf-7c3a-62de5af02282@debian.org>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi again,

I also noticed a mojibake issue: a git diff that contains UTF-8
is double-encoded (converted to UTF-8 as if it were latin1 or
something, even if it was already UTF-8), and this seems to be
independent of the locale.

I *think* using the to_utf8 sub on the content is the right fix,
as it seems to check if it=E2=80=99s UTF-8, pass through if it is, and
encode to UTF-8 (which the HTTP headers say is sent) if it=E2=80=99s not.

Patch which fixes this, for commitdiff_plain and patch for me:

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b5490dfecf..434b1c01cd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8063,12 +8063,12 @@ sub git_commitdiff {
=20
 =09} elsif ($format eq 'plain') {
 =09=09local $/ =3D undef;
-=09=09print <$fd>;
+=09=09print to_utf8(<$fd>);
 =09=09close $fd
 =09=09=09or print "Reading git-diff-tree failed\n";
 =09} elsif ($format eq 'patch') {
 =09=09local $/ =3D undef;
-=09=09print <$fd>;
+=09=09print to_utf8(<$fd>);
 =09=09close $fd
 =09=09=09or print "Reading git-format-patch failed\n";
 =09}

This might probably need fixing in more places. While scrolling,
I saw blobdiff; I have not identified all places needed and would
appreciate the maintainer on your side doing so and fixing them.

Thanks in advance,
//mirabilos
--=20
I believe no one can invent an algorithm. One just happens to hit upon it
when God enlightens him. Or only God invents algorithms, we merely copy the=
m.
If you don't believe in God, just consider God as Nature if you won't deny
existence.=09=09-- Coywolf Qi Hunt
