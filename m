Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964E345EC0
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938769; cv=none; b=bonCOQt3qiMSuJHrldsogc4fiQvymp4ZilyidtVBswp7VIcV6bqR0GP9HStXWEesjio+cGI2ED9CKQS6OxFlp+ls7Jt1Co9Y7Ska/T4osYkfs+tHhkhrGjMHLp2KMOGfVr/ul308isyei3VPI+2vupcvqL1v2yA5Q+yI7hmlJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938769; c=relaxed/simple;
	bh=j/ycawMakpFkuVs3kLk2GZY2C8IYmJ3v+gsh682lokE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rSZx5JQK8MVJKuKTHeMjvbD+h9CO/cfOx7p/3KZJ5J5bZ5WvY6XU7vSL6gf+dwV9QfccfPlfOaNmOjHHd8cudz5pSfkTHaIJ8R1ICbA2rvSf6TjgsrOOQvMtxoBK8s+559joUkA+A6F0OQ8tl96lG3VzKm6GMNI7I3/YgYTypOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-255-187-253.cpe.net.cable.rogers.com [99.255.187.253])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 675E5vob2174881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Aug 2026 14:05:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: <git@vger.kernel.org>
References: <017e01dd2441$476839f0$d638add0$@nexbridge.com> <20260805045026.GA972736@coredump.intra.peff.net>
In-Reply-To: <20260805045026.GA972736@coredump.intra.peff.net>
Subject: RE: Question on textconv
Date: Wed, 5 Aug 2026 10:05:52 -0400
Organization: Nexbridge Inc.
Message-ID: <020201dd24e3$89ad1220$9d073660$@nexbridge.com>
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
Thread-Index: AQEL8od3IO0EK4noYmQoL95xPMrCFgHtJ01QuCJ4EuA=
X-Antivirus: Norton (VPS 260805-4, 8/5/2026), Outbound message
X-Antivirus-Status: Clean

On August 5, 2026 12:50 AM, Jeff King wrote:
> On Tue, Aug 04, 2026 at 02:44:22PM -0400, rsbecker@nexbridge.com =
wrote:
>=20
> > The supplied file going to the textconv program looks like
> > /tmp/git-blob-GFtIhK/simple and is always empty regardless of the =
file
> > contents.
>=20
> I can't reproduce the problem here, even for files with embedded NULs.
> However...
>=20
> > When there is only one file named simple in the repository I can =
find
> > it, but otherwise any ambiguity in the name makes textconv =
processing
> > impractical. Somewhere prior to this I was supplied with the actual
> > file in the working index instead of a temp file.
>=20
> This part I can explain. We sometimes try to reuse the working tree =
instead of
> generating a tempfile, as an optimization. We can only do this when =
the working
> tree file is clean. But we also only bother to try when one of the =
diff endpoints is
> the index. So if we set up a sample textconv like:
>=20
>   git config diff.foo.textconv 'echo >&2 "got: $*" && tr a-z A-Z <'
>   echo "file diff=3Dfoo" >.gitattributes
>=20
>   echo one >file && git add file && git commit -m one
>   echo two >file && git add file && git commit -m two
>=20
> The running either "git diff HEAD^" or "git diff --cached HEAD^" will =
convert the
> copy in the working tree, and you'll get:
>=20
>   got: /tmp/git-blob-0CLCMr/file
>   got: file
>   diff --git a/file b/file
>   index 5626abf..f719efd 100644
>   --- a/file
>   +++ b/file
>   @@ -1 +1 @@
>   -ONE
>   +TWO
>=20
> but if you do "git show HEAD", you'll get two tempfiles:
>=20
>   got: /tmp/git-blob-w1binM/file
>   got: /tmp/git-blob-1nu2Rm/file
>   [same diff]
>=20
> even though this is the same diff! We _could_ try harder to reuse the =
working tree
> copy here by checking whether the path has the same sha1 in the tree =
and the
> index (and that the index entry is clean). But it only helps in a few =
special cases, and
> it's not something users should rely on (we might choose to create a =
tempfile
> anyway if the index is stat-dirty).

Could we extend textconv to support %f (the original path) if specified =
in the
textconv configuration? That would solve the ambiguity of what is being =
supplied.

