Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D5646
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ltBXmUhi"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F74DBB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 21:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698293209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHKITEhc66lNh9YpIrAw69ISs2chgBWvX3hE+c4IL7k=;
	b=ltBXmUhi0TIjfe1pPca71gJROyf5cwVDmtLpbvtOe2uv3X41kqM9ufo6/ytsm2CbvTYxTK
	Ohd1T9VsFxvqVYCW9gC2etXR8oYYj0QpURbRlhkeVKYNiXkQL7KuwWZvXfDAj6bnKiKyZt
	8axxbu6xdqOkasE1F8fLk9zEscbEltlHrkjSMsB4BjiLGW13icMlV0uouL8JePysBig66I
	aqz851liKzuJmQ0svkzwdp9bA2suUrLo9q+WumY7IUKNS7PkZgeDDpb9mhSiR9Rk+UIc4z
	G9FKUGQURl7czGiAI0MbD7i4ESmnfGRLSOgprs5GfiwAAGykEoIhjOOxHy9rfw==
Date: Thu, 26 Oct 2023 06:06:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: emilyshaffer@google.com, git@vger.kernel.org, Emily Shaffer
 <nasamuffin@google.com>, Sheik <sahibzone@gmail.com>
Subject: Re: [PATCH v2] bugreport: reject positional arguments
In-Reply-To: <CAPig+cTJFKp6RFdqJTpyL49V+M-zaTDbgpVd2OrgfWf4H-+K+g@mail.gmail.com>
References: <CAPig+cQtoEpTDK1U5R+wUD4qovFtpcx6+zyOQE-SAYp5SE2q2Q@mail.gmail.com>
 <20231026005542.872301-1-nasamuffin@google.com>
 <CAPig+cT4G9vdu+se9Fbbs0TRCyPoAYFgVtkSwph_U=sWf-kQ9g@mail.gmail.com>
 <8c82a138faa28a3c5d15a52b1d9c2c0f@manjaro.org>
 <CAPig+cTJFKp6RFdqJTpyL49V+M-zaTDbgpVd2OrgfWf4H-+K+g@mail.gmail.com>
Message-ID: <aa11162c3220304b91ef25f30600c231@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-26 06:03, Eric Sunshine wrote:
> On Wed, Oct 25, 2023 at 11:52 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2023-10-26 05:43, Eric Sunshine wrote:
>> > On Wed, Oct 25, 2023 at 8:55 PM <emilyshaffer@google.com> wrote:
>> >> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
>> >> @@ -126,6 +126,12 @@ int cmd_bugreport(int argc, const char **argv,
>> >> const char *prefix)
>> >> +       if (argc) {
>> >> +               if (argv[0])
>> >> +                       error(_("unknown argument `%s'"), argv[0]);
>> >> +               usage(bugreport_usage[0]);
>> >> +       }
>> >
>> > Can it actually happen that argc is non-zero but argv[0] is NULL? (I
>> > don't have parse-options in front of me to check.) If not, then the
>> > extra `if (argv[0])` conditional may confuse future readers.
>> 
>> According to https://stackoverflow.com/a/2794171/22330192 it can't, 
>> but
>> argv[0] can be a zero-length string.
> 
> This case is different, though, since, by this point, argv[] has been
> processed by Git's parse-options API. Here's the relevant comment from
> parse-options.h:

Ah, I see, thanks for the clarification.

>    * parse_options() will filter out the processed options and leave 
> the
>    * non-option arguments in argv[]. argv0 is assumed program name and
>    * skipped.
>    *
>    * Returns the number of arguments left in argv[].
> 
> So, I think the `if (argv[0])` conditional is unnecessary, thus
> potentially confusing.
> 
> It's possible that Emily meant `if (*argv[0])`, but even that seems
> undesirable since even a zero-length argv[0] provides some useful
> context.
> 
>     % git bugreport ""
>     error: unknown argument `'
