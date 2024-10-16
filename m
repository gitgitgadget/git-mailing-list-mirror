Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98F204F89
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068428; cv=none; b=pdRRP0u64OfoiXbyXyS1VE3qEMMQ5LVeVM3z3/nMnVOvIZBw17FHTHpoYilMbfPQpp/G0bh+O5VawyVP8G0b9Q6m2lOCQpOLilLC3VR4X6WhlBbrQc0qXD8onQIpcpL4fefiEzbdE51DLZoasuS8arsd1OLUz+pRQSBtE7NQgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068428; c=relaxed/simple;
	bh=p6tV2VTJjtYqMLkZLqkk10MNLHoxaCCYWsAj0oi1uXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyEQQca6dA+k0NGIHWvrI7J4C3eiZ8Jx8KGpMompaRmmnJo7R1KRFNhT0yDqUPDvJv1C85TXFXDVExLKyZL4vU3sLKa9RyrqiP2yEsotKWqwQlUITpfmtSzbHRI3PtPc18HHyWgnkAk674+ansDF33oerIBXBqk1pPI4ZRq1w3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=WeiVjYMP; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="WeiVjYMP"
Date: Wed, 16 Oct 2024 10:47:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729068424;
	bh=p6tV2VTJjtYqMLkZLqkk10MNLHoxaCCYWsAj0oi1uXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Sender:
	 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=WeiVjYMPWi+yjCeb5P2XmRc68F8UbsrMpEW1/T9queulfFjyG1Oa99Jm4djA0oFCB
	 Hvok9atQq7CpU5xa1CPUxHkSPkwcFCy2+ALkACdRcCzlODC0ZOmtGgQAd/Il3xJflv
	 SSpAG1vyB5xbEDBXJzDp8yUmmAbXTH2qJksAvJuA+ShXU2MlwgW8WQsGElKK7mHtwn
	 0ICVATTgi/wcRE/5XcWzxy4zuoCmP3kvT03bjq58VTgR0zNqlVPcQUHicvMz+ca2r7
	 y5qim5He+4f0ZqlvVVacRt6q+hjh1z47NFXPut9YYtjq5mCtIBMp7omtyNiYnYIDn1
	 QEn2kifKAnwQg==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw9P90_QtiAAH3yz@pks.im>

On 2024-10-16 07:32, Patrick Steinhardt wrote:
> On Tue, Oct 15, 2024 at 01:48:26PM +0200, Wolfgang Müller wrote:
> > diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> > index c20c885724..ed39c67ba1 100755
> > --- a/t/t4201-shortlog.sh
> > +++ b/t/t4201-shortlog.sh
> > @@ -143,6 +143,11 @@ fuzz()
> >  	test_grep "too many arguments" out
> >  '
> >  
> > +test_expect_success 'shortlog --author from non-git directory does not segfault' '
> > +	git log --no-expand-tabs HEAD >log &&
> > +	env GIT_DIR=non-existing git shortlog --author=author <log 2>out
> > +'
> > +
> 
> I'd like to see another testcase added that exercises behaviour when
> git-shortlog(1) is passed SHA256 output outside of a repo, as I'm
> curious how it'll behave in that scenario.

I had a look at this in builtin/shortlog.c's read_from_stdin() and am
pretty sure that git-shortlog(1), when reading from stdin, simply
ignores anything but either the "Author:" or "Commit:" lines, depending
on the value given by --group. The --group=format: option is not
supported when reading from stdin. Neither is --format handled at all.

So I don't think there is actually a way to make git-shortlog(1)
encounter and handle a commit hash when reading from stdin; the hash
algorithm seems completely meaningless for its user-facing behaviour. As
far as I have seen the closest it comes to getting into contact with a
hash (or more specifically, hexsz) is when cmd_shortlog() sets:

	log.abbrev = rev.abbrev;

This relies on the parsing machinery in parse_revision_opt() - the one
this patch is for. Technically --abbrev is honored by git-shortlog(1)
when reading from stdin, but its value goes unused because of the
difference in code paths when reading from stdin. Do take this with a
grain of salt, however, this is my first look at the inner workings of
git-shortlog(1).

As for the test, I'd be happy to provide one if this is still deemed
necessary after considering the above. There's two questions I have:

1) Is this already covered by GIT_TEST_DEFAULT_HASH=sha256? Running the
t4201-shortlog testsuite with that passes.

2) I've already experimented with setting up a test for this and am
unsure how to cleanly set up a sha256 repository. Ordinarily it should
be a simple init/add (perhaps with test_commit), but t4201-shortlog is
already running within a git repository if I understand the setup step
correctly. Is there a clean way to escape from there, or would it simply
be fine creating another repository within that one?

Thanks!

-- 
Wolf
