Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE167F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hvZzdyZh"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867E5B7
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 17:15:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5F041C288E;
	Tue, 31 Oct 2023 20:15:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AN1XkpR4NO2k
	T+76KJbdFFtapR7+FKzrJfB2mowm830=; b=hvZzdyZhIMc/stRnK3gboQlPFP1i
	bZ+G3uGdjsSPSxukK4DMtLhLpMiJMya1umFRmsiqzy4zKGY+sRqI3n5SuFEp2CzW
	nIz+jIn628kdWja4PO82DK3l5Lz6T1HJI44HtCSsdCRXSPCLOv2mkPrtnK3wdG6p
	2NQGluzoo0RHEi4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD6501C288D;
	Tue, 31 Oct 2023 20:15:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1EE0B1C288C;
	Tue, 31 Oct 2023 20:15:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] ci: add GitLab CI definition
In-Reply-To: <ZUCw1B6oQaDWKx3O@tanuki> (Patrick Steinhardt's message of "Tue,
	31 Oct 2023 08:46:28 +0100")
References: <cover.1698305961.git.ps@pks.im> <ZT/P5Bl9lD9V6ID9@nand.local>
	<ZUCw1B6oQaDWKx3O@tanuki>
Date: Wed, 01 Nov 2023 09:15:51 +0900
Message-ID: <xmqqttq6xr9k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D11FD382-784B-11EE-A062-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

>> So I have some hesitation about trying to mirror this rather complicat=
ed
>> set of build rules in another CI environment. My primary concern would
>> be that the two might fall out of sync and a series that is green on
>> GitHub would be red on GitLab, or vice-versa. Importantly, this can
>> happen even without changes to the build definitions, since (AFAICT)
>> both forges distribute new images automatically, so the set of package=
s
>> installed in GitHub may not exactly match what's in GitLab (and
>> vice-versa).
>
> Yup, that's a valid concern.

Is it?

I rather na=C3=AFvely think different set of build options and tools
running the tests would mean we gain wider test coverage.  Even with
the current setup that relies on whatever GitHub offers, we already
see "this version passes all tests except for the job on macOS" and
"the version that was passing yesterday is not broken today---perhas
the image of the test environment has been updated and we need to
adjust to it" every once in a while.

> As mentioned, this patch series does not have the intent to make
> GitLab CI a second authoritative CI platform.  GitHub Actions
> should remain the source of truth of whether a pipeline passes or
> not.

I am not sure I follow.  Often we take a version that happened to
have failed Actions tests when we know the reason of the failure
has nothing to do with the new code.  From time to time people help
to make CI tests less flakey, but flakes are expected.

> Most importantly, I do not want to require the maintainer
> to now watch both pipelines on GitHub and GitLab.

I don't even make tests by GitHub Actions force me to do anything,
so there is no worry here.

> This might be another indicator that the pipeline should rather be
> in "contrib/", so that people don't start to treat it as
> authoritative.

Let me step back and as more basic questions.

 - What do you mean by "authoritative"?  For an authoritative CI
   test, contributors whose changes do not pass it should take it as
   a sign that their changes need more work?  If so, isn't it a
   natural expectation and a good thing?  Unless you expect the CI
   tests to be extra flakey, that is.

 - Are there reasons why you do not trust the CI tests at GitLab
   more than those run at GitHub?

> Last but not least, I actually think that having multiple supported CI
> platforms also has the benefit that people can more readily set it up
> for themselves. In theory, this has the potential to broaden the set of
> people willing to contribute to our `ci/` scripts, which would in the
> end also benefit GitHub Actions.

Yes, assuming that we can do so without much cutting and pasting but
with a clear sharing of the infrastructure code, and the multiple
supported CI environments are not too flakey, I am with this rather
na=C3=AFve worldview that the more we have the merrier we would be.

> I understand your points, and especially the point about not having a
> second authoritative CI platform. I'm very much on the same page as you
> are here, and would be happy to move the definitions to "contrib/" if
> you want me to.
>
> But I think we should also see the potential benefit of having a second
> CI platform, as it enables a more diverse set of people to contribute.
> which can ultimately end up benefitting our CI infra for both GitHub
> Actions and GitLab CI.

I do *not* want to add new things, if we were to use them ourselves,
to "contrib/".  We have passed that stage long time ago that keeping
everything in my tree gives wider exposure and foster cooperation.

Thanks.
