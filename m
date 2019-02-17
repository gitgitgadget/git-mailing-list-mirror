Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D071F453
	for <e@80x24.org>; Sun, 17 Feb 2019 17:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfBQR3c convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 17 Feb 2019 12:29:32 -0500
Received: from elephants.elehost.com ([216.66.27.132]:25316 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBQR3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 12:29:32 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1HHTMeE087671
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 17 Feb 2019 12:29:23 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        <git@vger.kernel.org>
Cc:     "'Joe Ranieri'" <jranieri@grammatech.com>
References: <20190217163456.17560-1-randall.s.becker@rogers.com> <e762e80a-d1ef-f906-e128-03f35de3c3ba@ramsayjones.plus.com>
In-Reply-To: <e762e80a-d1ef-f906-e128-03f35de3c3ba@ramsayjones.plus.com>
Subject: RE: [Fix v1] builtin/ls-files.c: add error check on lstat for modified files
Date:   Sun, 17 Feb 2019 12:29:16 -0500
Message-ID: <000001d4c6e6$52475010$f6d5f030$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEtPhpkA6NQmb2hiGABTpAFKb6pmwL4OlZfpxuNswA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 17, 2019 12:05, Ramsay Jones wrote:
> On 17/02/2019 16:34, randall.s.becker@rogers.com wrote:
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > The result from lstat, checking whether a file has been deleted, is
> > now included priot to calling id_modified when showing modified files.
> > Prior
> 
> s/priot/prior/; s/id_modified/ie_modified/
> 
> > to this fix, it is possible that files that were deleted could show up
> > as being modified because the lstat error was unchecked.
> >
> > Reported-by: Joe Ranieri <jranieri@grammatech.com>
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  builtin/ls-files.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c index
> > 29a8762d4..fc21f4795 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -348,7 +348,7 @@ static void show_files(struct repository *repo,
> struct dir_struct *dir)
> >  			err = lstat(fullname.buf, &st);
> >  			if (show_deleted && err)
> 
> To be pedantic, this should probably check for (err == ENOENT), since
> lstat() can fail for several reasons which don't imply that the path has been
> deleted. However, that is unlikely.

That would be very platform specific error checking. lstat can fail for a variety of other reasons also leaving the file deleted (like a symlink issue), but you are correct. I was following the prior line's model of checking for consistency.

> No reason to include such a check in this patch, of course.
> 
> ATB,
> Ramsay Jones
> 
> >  				show_ce(repo, dir, ce, fullname.buf,
> tag_removed);
> > -			if (show_modified && ie_modified(repo->index, ce,
> &st, 0))
> > +			if (show_modified && !err && ie_modified(repo-
> >index, ce, &st, 0))
> >  				show_ce(repo, dir, ce, fullname.buf,
> tag_modified);
> >  		}
> >  	}
> >

This was just to address what Joe reported earlier. It seemed like an easy one to address.

Regards,
Randall

