Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F714C64EC4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCDKxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCDKxn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:53:43 -0500
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Mar 2023 02:53:42 PST
Received: from mta01.prd.rdg.aluminati.org (mta01.prd.rdg.aluminati.org [94.76.243.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D901166DD
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:53:42 -0800 (PST)
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta.aluminati.local (Postfix) with ESMTP id BAAFBC023B;
        Sat,  4 Mar 2023 10:45:28 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id A73012062D;
        Sat,  4 Mar 2023 10:45:28 +0000 (GMT)
X-Quarantine-ID: <5b_bzpb_ExQF>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5b_bzpb_ExQF; Sat,  4 Mar 2023 10:45:27 +0000 (GMT)
Received: from keeping.me.uk (unknown [81.174.171.191])
        by svc01-1.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 9A95C1C0002;
        Sat,  4 Mar 2023 10:45:26 +0000 (GMT)
Date:   Sat, 4 Mar 2023 10:45:20 +0000
From:   John Keeping <john@keeping.me.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: output header for empty commits
Message-ID: <ZAMhOehmuIov/KM8@keeping.me.uk>
References: <20230303160301.3659328-1-john@keeping.me.uk>
 <xmqqwn3xg3m0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwn3xg3m0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2023 at 09:13:27AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > When formatting an empty commit, it is surprising that a totally empty
> > file is generated.  Set the flag to always print the header, matching
> > the behaviour of git-log.
> 
> Don't these empty files help send-email as safety against sending
> them out?  Unless existing tools depend on the current behaviour in
> such a way, I think this is quite a sensible change.

Yes, send-email fails trying to send an empty file, but to me this feels
more like an accident than an intentional safeguard.  If there were
something intentional I'd expect format-patch to fail with --allow-empty
as an option to bypass that safety check.

Since there are checks in place to avoid unintentionally creating empty
commits, it seems reasonable for format-patch to create output that
represents what is present in the repository without needing extra
options.

> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index f3313b8c58..ffc7c60680 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -59,6 +59,10 @@ test_expect_success setup '
> >  	test_tick &&
> >  	git commit -m "patchid 3" &&
> >  
> > +	git checkout -b empty main &&
> > +	test_tick &&
> > +	git commit --allow-empty -m "empty commit" &&
> > +
> >  	git checkout main
> >  '
> >  
> > @@ -128,6 +132,12 @@ test_expect_success 'replay did not screw up the log message' '
> >  	grep "^Side .* with .* backslash-n" actual
> >  '
> >  
> > +test_expect_success 'format-patch empty commit' '
> > +	git format-patch --stdout main..empty >empty &&
> > +	grep "^From " empty >from &&
> > +	test_line_count = 1 from
> > +'
> > +
> >  test_expect_success 'extra headers' '
> >  	git config format.headers "To: R E Cipient <rcipient@example.com>
> >  " &&
