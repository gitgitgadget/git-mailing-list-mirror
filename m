Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04115201A7
	for <e@80x24.org>; Sat, 20 May 2017 14:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbdETO4e (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 10:56:34 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:12474 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbdETO4d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 10:56:33 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id C5nxdOsPNHGLwC5nxdAeJ9; Sat, 20 May 2017 15:56:31 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=SKq0fmrryAYdkadTzRoA:9 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <F66E608B6CE34520BD764C404A2AD36C@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Cc:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net> <20170519124834.ipk42isngqck2egu@sigill.intra.peff.net>
Subject: Re: [PATCH 01/15] handle_revision_arg: reset "dotdot" consistently
Date:   Sat, 20 May 2017 15:56:32 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfJTPBWDXBADnRYJhw/jteYe5uV0DV9RCthm5sm4XPLzR/Xxx/6lRLRPycyz7Wg+AGNtGPGnOg/Rk9Yxu7PKjTZbzCsCVzoIc7T7xhZQfEYD14sIhZHt8
 kAgvEkdwBBGNKKlt48cfeqEOQDTS8lpvagUTIxitv0qmeYl2pWAhFJ59m2I4i+iKn0azeySrmL2SS+DaHGitfukmKFKTRFLyYJfqa31T8nHyRFo8qWz5os2z
 /j0NEfcTHRxYNfxvTTzKzSWKbOLHhJ8VzeM4Ee3vNSkqIUu/rNosvji1cD1k0EO/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> When we are parsing a range like "a..b", we write a
> temporary NUL over the first ".", so that we can access the
> names "a" and "b" as C strings. But our restoration of the
> original "." is done at inconsistent times, which can lead
> to confusing results.
>
> For most calls, we restore the "." after we resolve the
> names, but before we call verify_non_filename().  This means
> that when we later call add_pending_object(), the name for
> the left-hand "a" has been re-expanded to "a..b". You can
> see this with:
>
>  git log --source a...b
>
> where "b" will be correctly marked with "b", but "a" will be
> marked with "a...b". Likewise with "a..b" (though you need
> to use --boundary to even see "a" at all in that case).
>
> To top off the confusion, when the REVARG_CANNOT_BE_FILENAME
> flag is set, we skip the non-filename check, and leave the
> NUL in place.
>
> That means we do report the correct name for "a" in the
> pending array. But some code paths try to show the whole
> "a..b" name in error messages, and these erroneously show
> only "a" instead of "a..b". E.g.:
>
>  $ git cherry-pick HEAD:foo..HEAD:foo

shouldn't this be three dots? Also the para above uses two dot examples in 
its description but the paras before that start by describing the three dot 
case.
--
Philip

>  error: object d95f3ad14dee633a758d2e331151e950dd13e4ed is a blob, not a 
> commit
>  error: object d95f3ad14dee633a758d2e331151e950dd13e4ed is a blob, not a 
> commit
>  fatal: Invalid symmetric difference expression HEAD:foo
>
> (That last message should be "HEAD:foo...HEAD:foo"; I used
> cherry-pick because it passes the CANNOT_BE_FILENAME flag).
>
> As an interesting side note, cherry-pick actually looks at
> and re-resolves the arguments from the pending->name fields.
> So it would have been visibly broken by the first bug, but
> the effect was canceled out by the second one.
>
> This patch makes the whole function consistent by re-writing
> the NUL immediately after calling verify_non_filename(), and
> then restoring the "." as appropriate in some error-printing
> and early-return code paths.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I also considered just making a copy of the string rather than this
> in-place munging (technically we get it as a pointer-to-const; it's only
> the use of strstr() that lets us quietly drop the const). But it doesn't
> really make the code any cleaner; now instead of restoring the dot you
> have to remember to free() the string in each code path.
>
> revision.c     | 3 +++
> t/t4202-log.sh | 9 +++++++++
> 2 files changed, 12 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 8a8c1789c..014bf52e3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1477,12 +1477,14 @@ int handle_revision_arg(const char *arg_, struct 
> rev_info *revs, int flags, unsi
>  if (!cant_be_filename) {
>  *dotdot = '.';
>  verify_non_filename(revs->prefix, arg);
> + *dotdot = '\0';
>  }
>
>  a_obj = parse_object(from_sha1);
>  b_obj = parse_object(sha1);
>  if (!a_obj || !b_obj) {
>  missing:
> + *dotdot = '.';
>  if (revs->ignore_missing)
>  return 0;
>  die(symmetric
> @@ -1525,6 +1527,7 @@ int handle_revision_arg(const char *arg_, struct 
> rev_info *revs, int flags, unsi
>  REV_CMD_RIGHT, flags);
>  add_pending_object(revs, a_obj, this);
>  add_pending_object(revs, b_obj, next);
> + *dotdot = '.';
>  return 0;
>  }
>  *dotdot = '.';
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index f57799071..6da1bbe91 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1380,4 +1380,13 @@ test_expect_success 'log --source paints tag names' 
> '
>  test_cmp expect actual
> '
>
> +test_expect_success 'log --source paints symmetric ranges' '
> + cat >expect <<-\EOF &&
> + 09e12a9 source-b three
> + 8e393e1 source-a two
> + EOF
> + git log --oneline --source source-a...source-b >actual &&
> + test_cmp expect actual
> +'
> +
> test_done
> -- 
> 2.13.0.219.g63f6bc368
> 

