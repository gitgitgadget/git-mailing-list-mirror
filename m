Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E6D1FC96
	for <e@80x24.org>; Sun,  4 Dec 2016 11:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750774AbcLDLW4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 06:22:56 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:50762 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750697AbcLDLWz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 06:22:55 -0500
Received: from PhilipOakley ([92.22.24.49])
        by smtp.talktalk.net with SMTP
        id DUsfcn8aBgKstDUsfcFyTM; Sun, 04 Dec 2016 11:22:54 +0000
X-Originating-IP: [92.22.24.49]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=gLKxDJl5xUopT/8CUaPyCQ==:117
 a=gLKxDJl5xUopT/8CUaPyCQ==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=TWfoW8KcijLH_JWj61EA:9 a=wPNLvfGTeEIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <49DE271A91214D6DADBD4DE667A1659B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kyle J. McKay" <mackyle@gmail.com>, "Jeff King" <peff@peff.net>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git mailing list" <git@vger.kernel.org>
References: <fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0>
Subject: Re: Git v2.11.0 breaks max depth nested alternates
Date:   Sun, 4 Dec 2016 11:22:52 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFnApNQ+zevyqRnXhcbjhNQR3ohx7YG3sm+q9OntIpCcuyIHIh4bflGf3lkHagJ372xO1k6F0xbj5zswmz7qPZLRQ5LbHXsmT8YT9E1lj9djFGYOaiYm
 ZbhZp/KeTgkcu5kZcCJB/Hq2g6W2/VNiN4nEKXdeOjyqKZPeIAlIs9HeyHWkTBCE3U2LEjqO51b8J7dBijvg213CVH1EaG6a2OQ02m1EXfUgJPYvVhUuMFXd
 k82Vfq/tftsYMthbgRlBOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kyle J. McKay" <mackyle@gmail.com>
Sent: Sunday, December 04, 2016 12:24 AM
> The recent addition of pre-receive quarantining breaks nested
> alternates that are already at the maximum alternates nesting depth.
>
> In the file sha1_file.c in the function link_alt_odb_entries we have
> this:
>
> > if (depth > 5) {
> >         error("%s: ignoring alternate object stores, nesting too deep.",
> >                         relative_base);
> >         return;
> > }
>
> When the incoming quarantine takes place the current objects directory
> is demoted to an alternate thereby increasing its depth (and any
> alternates it references) by one and causing any object store that was
> previously at the maximum nesting depth to be ignored courtesy of the
> above hard-coded maximum depth.
>
> If the incoming push happens to need access to some of those objects
> to perhaps "--fix-thin" its pack it will crash and burn.
>
> Originally I was not going to include a patch to fix this, but simply
> suggest that the expeditious fix is to just allow one additional
> alternates nesting depth level during quarantine operations.
>
> However, it was so simple, I have included the patch below :)
>
> I have verified that where a push with Git v2.10.2 succeeds and a push
> with Git v2.11.0 to the same repository fails because of this problem
> that the below patch does indeed correct the issue and allow the push
> to succeed.
>
> Cheers,
>
> Kyle
>
> -- 8< --
> Subject: [PATCH] receive-pack: increase max alternates depth during 
> quarantine
>
> Ever since 722ff7f876 (receive-pack: quarantine objects until
> pre-receive accepts, 2016-10-03, v2.11.0), Git has been quarantining
> objects and packs received during an incoming push into a separate
> objects directory and using the alternates mechanism to make them
> available until they are either accepted and moved into the main
> objects directory or rejected and discarded.

Is there a step here that after the accepted/rejected stage, it should then 
decrement the limit back to its original value. The problem description 
suggests that might be the case.
--
Philip

>
> Unfortunately this has the side effect of increasing the alternates
> nesting depth level by one for all pre-existing alternates.
>
> If a repository is already at the maximum alternates nesting depth,
> then this quarantining operation can temporarily push it over making
> the incoming push fail.
>
> To prevent the failure we simply increase the allowed alternates
> nesting depth by one whenever a quarantine operation is in effect.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>
> Notes:
>    Some alternates nesting depth background:
>
>    If base/fork0/fork1/fork2/fork3/fork4/fork5 represents
>    seven git repositories where base.git has no alternates,
>    fork0.git has base.git as an alternate, fork1.git has
>    fork0.git as an alternate and so on where fork5.git has
>    only fork4.git as an alternate, then fork5.git is at
>    the maximum allowed depth of 5.  git fsck --strict --full
>    works without complaint on fork5.git.
>
>    However, in base/fork0/fork1/fork2/fork3/fork4/fork5/fork6,
>    an fsck --strict --full of fork6.git will generate complaints
>    and any objects/packs present in base.git will be ignored.
>
> cache.h       | 1 +
> common-main.c | 3 +++
> environment.c | 1 +
> sha1_file.c   | 2 +-
> 4 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index a50a61a1..25c17c29 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -676,6 +676,7 @@ extern size_t packed_git_limit;
> extern size_t delta_base_cache_limit;
> extern unsigned long big_file_threshold;
> extern unsigned long pack_size_limit_cfg;
> +extern int alt_odb_max_depth;
>
> /*
>  * Accessors for the core.sharedrepository config which lazy-load the 
> value
> diff --git a/common-main.c b/common-main.c
> index c654f955..9f747491 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -37,5 +37,8 @@ int main(int argc, const char **argv)
>
>  restore_sigpipe_to_default();
>
> + if (getenv(GIT_QUARANTINE_ENVIRONMENT))
> + alt_odb_max_depth++;
> +
>  return cmd_main(argc, argv);
> }
> diff --git a/environment.c b/environment.c
> index 0935ec69..32e11f70 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -64,6 +64,7 @@ int merge_log_config = -1;
> int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
> unsigned long pack_size_limit_cfg;
> enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
> +int alt_odb_max_depth = 5;
>
> #ifndef PROTECT_HFS_DEFAULT
> #define PROTECT_HFS_DEFAULT 0
> diff --git a/sha1_file.c b/sha1_file.c
> index 9c86d192..15b8432e 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -337,7 +337,7 @@ static void link_alt_odb_entries(const char *alt, int 
> len, int sep,
>  int i;
>  struct strbuf objdirbuf = STRBUF_INIT;
>
> - if (depth > 5) {
> + if (depth > alt_odb_max_depth) {
>  error("%s: ignoring alternate object stores, nesting too deep.",
>  relative_base);
>  return;
> ---
> 

