Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3F81F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 23:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJIGPl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 02:15:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41423 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeJIGPk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 02:15:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id 23-v6so10731552qkh.8
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 16:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vewbEgdsHIw17CCi+ugMFnKuDHvzRwxuo+z/w6+Zr8=;
        b=nwHVfF1yGToeHkvAmKedyHIFjcNBPXh9KpyEYOnqU79SJPyk0dePm8BN1uQdHCmCNz
         r8o0jhabFngwE85eDyDLtP5O66XZnB9clHhYFG9+4jdIqtLP6CAhJx9/QdQxb7qmmmqY
         hMgEuxl4sN9AGXxGmu8tn116Kp0ChqP9E72Of7PmesIJnYa6lBR5JDyYadqWM2brI/LW
         hV7PtWmUHq70Ir804tku6Gz7jySA2Lv3eKpd/gpKfRkCnJAouHQkHL7Zd+aXEjsPhrsq
         aF2JILJP4dINEmGcA1KW8+yt37wqhaOqpDlMCzZONUyTOZokm3WDQjfTD8xsJdE6EWri
         eCbg==
X-Gm-Message-State: ABuFfoiD6npAnN2/36FpKpgNqb0Q2UcCjfFjmnGsTAEB6NCPdewJmfAQ
        EdGveaRw6XhazMAUWOBAF/SKdDZF9mSXj5oxk1R0og==
X-Google-Smtp-Source: ACcGV60wLEUYGTPrvIKCPqA4GU25sEuvhiCMnzu1B9iJFmClbCBTcg0hVfx/I5nuv+GQKpvvVuAxu6IAFL4uibFlIkQ=
X-Received: by 2002:a37:8fc7:: with SMTP id r190-v6mr19525060qkd.36.1539039698162;
 Mon, 08 Oct 2018 16:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
 <20181008215701.779099-3-sandals@crustytoothpaste.net> <CAGZ79kYvW2PFdLfvd3W_t6rPs=oMBDxgMEgDRLtC4MHyo6MXVQ@mail.gmail.com>
In-Reply-To: <CAGZ79kYvW2PFdLfvd3W_t6rPs=oMBDxgMEgDRLtC4MHyo6MXVQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Oct 2018 19:01:27 -0400
Message-ID: <CAPig+cS5VdYq1ZOrP9oPwpXZ3ZmSV3_QdQAHiz5fV1Tc1uEF9A@mail.gmail.com>
Subject: Re: [PATCH 02/14] builtin/repack: replace hard-coded constant
To:     Stefan Beller <sbeller@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 6:27 PM Stefan Beller <sbeller@google.com> wrote:
> On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > -               if (line.len != 40)
> > -                       die("repack: Expecting 40 character sha1 lines only from pack-objects.");
> > +               if (line.len != the_hash_algo->hexsz)
> > +                       die("repack: Expecting full hex object ID lines only from pack-objects.");
>
> This is untranslated as it is plumbing? If so, maybe
>
>     if (is_sha1(the_hash_algo)
>         die("repack: Expecting 40 character sh...
>     else
>         die(repack: Expecting full hex object ID in %s, of length %d",
>             the_hash_algo->name,
>             the_hash_algo->hexsz);

Special-casing for SHA-1 seems overkill for an error message. A script
expecting this particular error condition and this particular error
message would be fragile indeed.
