Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9552018B
	for <e@80x24.org>; Mon, 20 Jun 2016 17:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282AbcFTRqM (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 13:46:12 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35162 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbcFTRqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 13:46:09 -0400
Received: by mail-qk0-f170.google.com with SMTP id c73so172056789qkg.2
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 10:46:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E5xU+ynu/GYGw837Q1Su1UPs0NxeTONDhAHOHtNUc2A=;
        b=QcQRMXh+XUpJgZh3w36T7TiNCw5iIiirF3avLjdJu+d2snv0UOCvqIEYhIB6RX1jtr
         XVSckLh+oZ4TO4a0Kwgz3yh07w27couFebSA08jlvZPfeklARbI6hARDhWfzL8aSCOdX
         zMyqw8RXkxRwiSp4GiYSeoVcOnj1p6mAGZgm4EiZjCZuEb1ECsvnGw4At7tqcD1luwmQ
         6rurBLF+Rv34yytuCygxqITkpDABL8f9bt1IxZ07dQc4NrHX26IsflSiZvwclK51QnCN
         JoT2U6sJVU7pEbpCEMbxnSkPPQWzdAGH78HexcjHTrN3PygRIjiLJpTHhQTp9xkeS3dT
         2RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E5xU+ynu/GYGw837Q1Su1UPs0NxeTONDhAHOHtNUc2A=;
        b=iwj3XjDje3PhpVMBUgMGcu46ncRagA2ftcF32NQxRHZERN6bEx4H3IJZpChoSMiiwy
         KxyuW7oNszO6ZDCqVAYeYvzsI82PMnjLAUPDge+A1hHMQR3w69vUdTkXVOTkpBQvFa9A
         d2KfKervgXm4jmiNmSqK9d2GTfSwfZ2D/I2Z8vaOXMekL+QpcG6gvFMbz40q4jHbiiNs
         rCg73iQo+tVuzTDlbRnhS5lMjU9DyX0yTAR1qmq7KYn8G8nf9OgmnW/tzEM/Wqnej5YC
         RmE3qGnC5qt4f3ipz5qxuuqflJ+8QEsGJmnHyIYnNvSP414E2xaPnzXRN+BVswaC8r+o
         OHpw==
X-Gm-Message-State: ALyK8tJTn41XmobTg2t8MxDqZwOOnKouHwfsDWXplOyc8n0UCzRF7oBV3RLxOrjqLSmkJdAwaOTh2VN2vw4wij/a
X-Received: by 10.233.223.5 with SMTP id t5mr22505697qkf.35.1466444758274;
 Mon, 20 Jun 2016 10:45:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Mon, 20 Jun 2016 10:45:57 -0700 (PDT)
In-Reply-To: <loom.20160620T145755-931@post.gmane.org>
References: <loom.20160620T145755-931@post.gmane.org>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 20 Jun 2016 10:45:57 -0700
Message-ID: <CAGZ79kZyEzp92JP_Bp2te1XO=PB0+fwFn57MrBPuWe25PQKOog@mail.gmail.com>
Subject: Re: Problem with --shallow-submodules option
To:	Istvan Zakar <istvan.zakar@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 6:06 AM, Istvan Zakar <istvan.zakar@gmail.com> wrote:
> Hello,
>
> I'm working on a relatively big project with many submodules. During
> cloning for testing I tried to decrease the amount of data need to be
> fetched from the server by using --shallow-submodules option in the clone
> command. It seems to check out the tip of the remote repo, and if it's not
> the commit registered in the superproject the submodule update fails
> (obviously).

Yes that is broken as the depth of a submodule is counted from its own HEAD
not from the superprojects sha1 as it should.

So it does

    git clone --depth=1 <submodule-url> <submodule-path>

    if HEAD != recorded gitlink sha1,
        git fetch <recorded gitlink sha1>

    git checkout <recorded gitlink sha1>

> Can I somehow tell to fetch that exact commit I need for my
> superproject?

Some servers support fetching by direct sha1, which is what we make use
of here, then it sort-of works.

If the server doesn't support the capability to fetch an arbitrary sha1,
the submodule command fails, with a message such as

    error: no such remote ref $sha1
    Fetched in submodule path '<submodule>', but it did not contain
$sha1. Direct fetching of that commit failed.

So if it breaks for you now, I would suggest not using that switch, I
don't think there is a quick
workaround.

>
> Thanks,
>    Istvan

Thanks,
Stefan

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
