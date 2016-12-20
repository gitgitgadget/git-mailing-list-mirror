Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666111FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 11:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756211AbcLTLB0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 06:01:26 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36736 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755441AbcLTLBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 06:01:24 -0500
Received: by mail-qt0-f169.google.com with SMTP id w33so172979379qtc.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 03:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b825mgcIgwwAJAkKLCoalJbf84BDvirBkKFrlq8hWFI=;
        b=emrJp2tBjwRlFDKZfGU5TSuGRYbla+9V3VYcsmsqtAzf7rcT/L7jbY1kxw9NZ35F5o
         WYYzmhRKgz/P4J+HZ5Gw9Kwb/UlCmzdMf2R9qVSb+C9VXXQrMuICtEF3493XpGrhTuCa
         GBM98IN16HGeOe5BfRw33HEKKCnLI5q/hr+Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b825mgcIgwwAJAkKLCoalJbf84BDvirBkKFrlq8hWFI=;
        b=EGv69SVwUo9vY5t0vyhJRJe7TsT6B+zhu2wUI35roIydY4b5/OMYYn17wVU4Iv0d+k
         B8Oxurgf+J0by0NWdUBhJ5jr56G2YJ3tCc74FGTPqbTu+ci2fupE3oxAhbsyiQCiT4od
         NQBGqyxFmihvJ93/R4G8R+RGzbz4gv+rrskSPGQT8nHzQCkqPdbmeDd0nlZZkjFIZIRI
         krjon7uxigfOr6EOLScV5ZB7ZTFsnf7ofYuKmpVJXurOBDOqejmOWCm5ppalSJz/EJz2
         Z36L9Yd7KRr2dPyZA5B4Bqfm8xluWYFpcBkLNY4odir+A4V4I54j0LNEadjyJ++H42kz
         JwJQ==
X-Gm-Message-State: AIkVDXLg7fMpA1FWwx8sCPwnOs50GkrFZak2tF83kmtzUwXErBVdRnj21MZ+vhMIE8r7QY34PV+SVllRPz6SOA==
X-Received: by 10.200.41.9 with SMTP id y9mr21669560qty.26.1482231683619; Tue,
 20 Dec 2016 03:01:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Tue, 20 Dec 2016 03:01:23 -0800 (PST)
In-Reply-To: <xmqq37hjobf6.fsf@gitster.mtv.corp.google.com>
References: <20161218175153.92336-1-larsxschneider@gmail.com> <xmqq37hjobf6.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 20 Dec 2016 11:01:23 +0000
Message-ID: <CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com>
Subject: Re: [PATCH v1] git-p4: fix git-p4.pathEncoding for removed files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 December 2016 at 21:29, Junio C Hamano <gitster@pobox.com> wrote:
> larsxschneider@gmail.com writes:
>
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> In a9e38359e3 we taught git-p4 a way to re-encode path names from what
>> was used in Perforce to UTF-8. This path re-encoding worked properly for
>> "added" paths. "Removed" paths were not re-encoded and therefore
>> different from the "added" paths. Consequently, these files were not
>> removed in a git-p4 cloned Git repository because the path names did not
>> match.
>>
>> Fix this by moving the re-encoding to a place that affects "added" and
>> "removed" paths. Add a test to demonstrate the issue.
>>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>
> Thanks.
>
> The above description makes me wonder what happens to "modified"
> paths, but presumably they are handled in a separate codepath?  Or
> does this also cover not just "removed" but also paths with any
> change?
>
> Luke, does this look good?

I'm not totally sure. In the previous version the conversion happened
in streamOneP4File(). There is a counterpart to this,
streamOneP4Deletion() which would seem like the callpoint that needs
to know about this.

The change puts the logic into stripRepoPath() instead, which is
indeed called from both of those functions (good), but also from
splitFilesIntoBranches(), but only if self.useClientSpec is set. That
function only gets used if we're doing the automatic branch detection
logic, so it's possible that this code might now be broken and we
wouldn't know.

Lars, what do you think? Other than the above, the change looks good,
so it may all be fine.

(As an aside, this is the heart of the code that's going to need some
careful rework if/when we ever move to Python3).

Luke
