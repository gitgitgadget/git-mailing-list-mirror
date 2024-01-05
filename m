Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A332E65B
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ew1xZCvT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6226B1C6F95;
	Fri,  5 Jan 2024 10:59:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zTHv2T54JrESmz14wd5CAchU+FOQR/Gm7Y9GTP
	W1SHQ=; b=ew1xZCvT91TEtCIZDx9KmF9D2qzWOeXsLfG7UiRYDVbouy16rmw6i0
	LtmaI645WMeXNqCwWY2M3IvPyeO5JEfknMn+QLkxiqLo5KLSs/30aDYZOQIZB6CU
	swdQW6MGL4X0H/Yy1pF75Zlvp08R/9dkjN5no7oZCVWmuXz/G3NFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51A6C1C6F94;
	Fri,  5 Jan 2024 10:59:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 956FF1C6F93;
	Fri,  5 Jan 2024 10:59:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Ghanshyam Thakkar
 <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de
Subject: Re: [GSOC][RFC] Heed core.bare from template config file when no
 command line override given, as a microproject.
In-Reply-To: <CABPp-BH+cPdfsctquE60tw_nD6_LCaWf0JwGusuZ0tvQQuWy4w@mail.gmail.com>
	(Elijah Newren's message of "Thu, 4 Jan 2024 18:11:00 -0800")
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
	<CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>
	<CABPp-BH+cPdfsctquE60tw_nD6_LCaWf0JwGusuZ0tvQQuWy4w@mail.gmail.com>
Date: Fri, 05 Jan 2024 07:59:02 -0800
Message-ID: <xmqqjzonpy9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5923872C-ABE3-11EE-ADD6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

> If you look back at the mailing list discussion on the series that
> introduced this TODO comment you are trying to address, you'll note
> that both Glen and I dug into the code and attempted to explain it to
> each other, and we both got it wrong on our first try.

I think you meant 0f7443bd (init-db: document existing bug with
core.bare in template config, 2023-05-16), where it says:

    The comments in create_default_files() talks about reading config from
    the config file in the specified `--templates` directory, which leads to
    the question of whether core.bare could be set in such a config file and
    thus whether the code is doing the right thing.

But I suspect the all of the above comes from a misunderstanding.
The comment the above commit log message talks about is:

 /*
  * First copy the templates -- we might have the default
  * config file there, in which case we would want to read
  * from it after installing.
  *
  * Before reading that config, we also need to clear out any cached
  * values (since we've just potentially changed what's available on
  * disk).
  */

This primarily comes from my 4f629539 (init-db: check template and
repository format., 2005-11-25), whose focus was to control the way
HEAD symref is created, but care was taken to avoid propagating
values from the configuration variables in the template that do not
make sense for the repository being initialized.  The most important
thing being the repository format version, but the intent to avoid
nonsense combination between the characteristic the new repository
has and the configuration values copied from the template was not
limited to the format version.

Specifically, the commit that introduced the comment never wanted to
honor core.bare in the template.  I do not think I has core.bare in
mind when I wrote the comment, but I would have described it as the
same category as the repository format version, i.e. something you
would not want to copy, if I were pressed to clarify back then.

Besides, create_default_files() is way too late, even if we wanted
to create a bare repository when the template config file says
core.bare = true, as the caller would already have created before
passing $DIR (when "git --bare init $DIR" was run) or $DIR/.git
(when "git init $DIR" was run) to the function.

If somebody wants to always create a bare repository by having
core.bare=true in their template and if we wanted to honor it (which
I am dubious of the value of, by the way), I would think the right
place to do so would be way before create_default_files() is called.
When running "git init [$DIR]", long before calling init_db(), we
decide if we are about to create a bare repository and either create
$DIR or $DIR/.git.  What is in the template, if we really wanted to
do so, should be read before that happens, no?
