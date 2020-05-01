Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE35C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C2A206D9
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgEAIml convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 1 May 2020 04:42:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37287 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgEAImk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 04:42:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so10746643wrx.4
        for <git@vger.kernel.org>; Fri, 01 May 2020 01:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M9DCV5wVVQ+UhtmPPDgAvcWFRWuoUm0nty8Y0xmgYM4=;
        b=BHJX4H83FkCQ5bZPXB0OXIcCVYDCQuFjHW8hby7+ds+pw7RqH5eGYfFKmReFwourvh
         5RI9ijwGpw/LrysSP4vlPnsELe4CoXh6CaipQLxxruXbuVCy9sXfT3hIyvNkcLCybfhf
         bueHJbjjhOV9/KKRDzqio60/3lOcemZp1SlnYIL98zM9o6wpskE1ULi0NKmM/yLHu25w
         HRf+07TZWL1G4+g39v3o1UkSjaLnpNG7LhkENvimiHj2LEhnZDM5AxkEMjAms1oIwUYv
         qgxMWXfZWdMXsq3/k6Eu3R9UzkDPjp9F+BKQs4BrzqyjYYa/9q6HdUMTuMP6s86LKVeP
         f9FA==
X-Gm-Message-State: AGi0Puau7J1YLg4X0eblj4Zx7U18u+9x5+mzEA1Oobpi/UYsU7aa1sdV
        9W+4IJswgEwiJyO1aaF+3CtTTKfK2IU7OvNxDu5HG5JF
X-Google-Smtp-Source: APiQypLz0eYu6JqpfUMVn6JuyAJulbWjegAOgudNgd4NcYVUdfEHte1+lYZPnsxfLbh58bsA+jsTPm7J4itYZqmyl/g=
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr3021947wrx.120.1588322557309;
 Fri, 01 May 2020 01:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR09MB298072F9FEB469130EAEB8F18BAC0@AM6PR09MB2980.eurprd09.prod.outlook.com>
In-Reply-To: <AM6PR09MB298072F9FEB469130EAEB8F18BAC0@AM6PR09MB2980.eurprd09.prod.outlook.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 May 2020 04:42:26 -0400
Message-ID: <CAPig+cTqqHqM6i8JHTLoY8SyCu=WWh1KCH2HCj8VNNxvux-toQ@mail.gmail.com>
Subject: Re: Bug: git restore --staged --worktree not working in git version 2.26.2.windows.1
To:     =?UTF-8?B?SGFycmkgTWVodMOkbMOk?= <harri.mehtala@finago.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 5:16 AM Harri Mehtälä <harri.mehtala@finago.com> wrote:
> I am trying to do git restore --staged --worktree for a file. I
> understood from the documentation that you can do both.
>
> "Specify the restore location. If neither option is specified, by
> default the working tree is restored. Specifying --staged will only
> restore the index. Specifying both restores both."
>
> $ git restore --staged --worktree pom.xml
> $ git status
> Changes to be committed:
>     modified:  pom.xml
>
> It looks like currently I have to do both separately.

If you read a bit further in the documentation, it says that you must
specify --source when combining --staged and --worktree, so your "git
restore" invocation is incorrect. Unfortunately, "git restore" is a
bit buggy in this regard since it blindly accepts this invalid
combination of options when it should instead error out. I submitted a
patch series[1] which fixes this shortcoming.

Having to specify --source in this case can be cumbersome if you just
want to restore from HEAD (a reasonable default), so the submitted
patch series[1] also makes --source default to HEAD when --staged and
--worktree are combined.

[1]: https://lore.kernel.org/git/20200501082746.23943-1-sunshine@sunshineco.com/T/
