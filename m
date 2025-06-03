Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499B1C3BEB
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987439; cv=none; b=pM4lKuPPE1eaJ+jhq+ji/jKsaIGkHYhPXastLidbiSuEUfKqPi34x49kKP9zhzEGvfwU2dMNTpibsouE8FvyPrYn96WF9THb9XrAU+FMq49Ov2si2UjjMO0u12Hc1puCYKU9eER0KW7jWw0zNjw6fF8Ab3Jv4cehj4HiYy3SFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987439; c=relaxed/simple;
	bh=t3ljpDbV06oa3Rxx8oYJ3IEgpB/yXO/SPsHSUPu4EZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPqGqepumjUw4nQkVyN2P75sxwxPPxWMbkWd8GRyRS9u2TsQF/4/JVpbzjLMBp8TmXVDVKfsE7Lsvr9X3erv8V7jHcicw11n4LqXolj1jwXezhmMuTeyNNOMVBB7RMySV1SEFz3BQ0I2NZuatOGJayLapQQQrVhb7iSPfczvSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3522184-ipxg00e01tokaisakaetozai.aichi.ocn.ne.jp ([122.27.91.184] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1uMZCb-0018MX-0O;
	Tue, 03 Jun 2025 21:29:45 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1uMZCQ-009VZd-2v;
	Wed, 04 Jun 2025 06:29:34 +0900
Date: Wed, 4 Jun 2025 06:29:34 +0900
From: Mike Hommey <mh@glandium.org>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	ps@pks.im, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250603212934.uojo22zjcuf6yfic@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net>
 <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
 <20250308032309.GA584028@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308032309.GA584028@coredump.intra.peff.net>

On Fri, Mar 07, 2025 at 10:23:09PM -0500, Jeff King wrote:
> On Fri, Mar 07, 2025 at 05:54:45PM -0500, Jeff King wrote:
> 
> > However, clang does implement this option, and it finds the case
> > mentioned above (and no other cases within the code base). And since we
> > run clang in several of our CI jobs, that's enough to get an early
> > warning of breakage.
> 
> Hmph, this might be more trouble than it is worth.
> 
> After correcting the problem in the refs code, the osx CI builds (and
> only those) now fail with:
> 
>   run-command.c:519:3: error: code will never be executed [-Werror,-Wunreachable-code]
>                   die_errno("sigfillset");
>                   ^~~~~~~~~
> 
> The code in question is just:
> 
>   if (sigfillset(&all))
> 	die_errno("sigfillset");
> 
> So I have to imagine that the issue is that sigfillset() on that
> platform is an inline or macro that will never return an error, and the
> compiler can see that. But since POSIX says this can fail (though I'd
> imagine it's unlikely on most platforms), we should check in the general
> case.
> 
> So I don't see how to solve it short of:
> 
> #ifdef SIGFILLSET_CANNOT_FAIL
> 	sigfillset(&all);
> #else
> 	if (sigfillset(&all))
> 		die_errno("sigfillset");
> #endif

There is a similar problem with this code in refs/files-backend.c:

			if (!create_ref_symlink(lock, update->new_target))
				continue;

Where create_ref_symlink is defined as such:

#ifdef NO_SYMLINK_HEAD
#define create_ref_symlink(a, b) (-1)
#else
static int create_ref_symlink(struct ref_lock *lock, const char *target)
{
...
#endif

And NO_SYMLINK_HEAD is defined on Windows.

Mike
