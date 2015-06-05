From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: diagnose empty HEAD more clearly
Date: Fri, 05 Jun 2015 13:47:40 -0700
Message-ID: <xmqqvbf1rifn.fsf@gitster.dls.corp.google.com>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
	<20150603062005.GA20580@peff.net>
	<CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
	<20150603081432.GA32000@peff.net>
	<xmqqpp5cyabx.fsf@gitster.dls.corp.google.com>
	<20150604083430.GB5771@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:47:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0yWq-0004nl-Jq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 22:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbbFEUrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 16:47:43 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33777 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbbFEUrn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 16:47:43 -0400
Received: by igbpi8 with SMTP id pi8so24053599igb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Yk4l1xu5a+eL6avi1e3VS2Oa4wCzB7ctdlktveWg1oE=;
        b=FILZbGz4KrcuigmgXEctLPtpw5lmV2eBKeWsmOxPTS2+8aiFoevBb5uqR9UkYU54uK
         7mkVaQ5FEr6muC7PocmsWHyrku3X9e82Im+N0nmA95MpbFHERjB6YnvfJW23d+pbJrtR
         fJsjfuaQdfW1FTwMOTPWL564WvSUTMsoc0Skb6qbcCg5VFyKvQKLHUFYGLJj5xZgEhJ6
         Ln8kA9xNydzI1xuuTGPpWR0gJLRf952HuGap0z7OpC9Ie5V97IX3S88nipHdMcrJgLFo
         63GsnB8rVFHYiT+lEVTdmbQGkm8Ur+2pQfgEkyBN6Au5jfh3Jz6XczC9BZTUGnAXf9G0
         bmKg==
X-Received: by 10.107.135.68 with SMTP id j65mr6798846iod.91.1433537262407;
        Fri, 05 Jun 2015 13:47:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d0d:eed3:5800:fefa])
        by mx.google.com with ESMTPSA id ot6sm2087503igb.11.2015.06.05.13.47.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 13:47:41 -0700 (PDT)
In-Reply-To: <20150604083430.GB5771@peff.net> (Jeff King's message of "Thu, 4
	Jun 2015 04:34:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270891>

Jeff King <peff@peff.net> writes:

> But if you are OK to eventually stop dying, I think this line of
> reasoning is OK.
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 4c4e6be..3b568a1 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -148,6 +148,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>>  		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
>>  	argc = setup_revisions(argc, argv, rev, opt);
>>  
>> +	if (!rev->pending.nr && !opt->def)
>> +		die("you do not have a commit yet on your branch");
>
> Do we want to mention the name of the branch here? I guess it does not
> really matter. Perhaps "the current branch" would be better than "your
> branch", though. Maybe:
>
>   fatal: you do not have any commits yet on the current branch
>
> This message hopefully goes away in the long run, but we'll have it for
> a while.
>
>> +static void default_to_head_if_exists(struct setup_revision_opt *opt)
>> +{
>> +	unsigned char unused[20];
>> +
>> +	if (resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, unused, NULL))
>> +		opt->def = "HEAD";
>> +}
>
> This approach looks sane to me. Want to wrap it up with a commit
> message and a test?

There is an unmerged attempt jc/log-missing-default-HEAD in my
"broken-out" repository https://github.com/gitster/git; I do agree
that we should spend more cycles after deciding to error out to
give a more detailed diagnosis, but I didn't have enough energy
to bring myself do that, so I've tentatively merged your version
instead of this one.
