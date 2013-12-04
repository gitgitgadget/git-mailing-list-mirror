From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 5/5] gitweb: Denote non-heads, non-remotes branches
Date: Wed, 4 Dec 2013 19:54:59 +0100
Message-ID: <CANQwDwfBWbgUfi8w+p3K1OySiMhp_OaxL2TGRyX6Qaeape=DCA@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com> <1386164583-14109-6-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 19:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoHbw-0003y4-EY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 19:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144Ab3LDSzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 13:55:44 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:65245 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010Ab3LDSzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 13:55:43 -0500
Received: by mail-wg0-f45.google.com with SMTP id y10so13650692wgg.0
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 10:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PJizueh6E/3/Spf8mKkI/9OnCoR1GHiCcx1KRTg/0go=;
        b=XOVFe2udGyGmOYWYNicJT7l+0RG+Day4rv5+XPEy7VUMDpbiCYDreeKvcFWJ3d5yx7
         FWNMo1z+gJkRF9lfKswSHH7bNRQfzKy7qqgvF/V2LWJN/L+5gQdxQna5Rw1JEwnFL9jl
         lZHX/qRpP1mUqbJMC7WbFTxJtkTBhmPOflwTRkYEy3VMFSZYAl2dM/sfvYn/JFq8q7kt
         jvR39AEbF0W/X0/hNcxNwtN7RWVUufbFF2vMpE/fLgY2k2RhAtnUZu9ABlSXrLus1rw6
         vRzE2ikkGZIy8Wb17C1R1l/3VkgrAOJCb9hXzcdhzE5kGxRiExI+0qY62Bz6LqM4iv8q
         jtKA==
X-Received: by 10.194.48.115 with SMTP id k19mr13690599wjn.47.1386183339792;
 Wed, 04 Dec 2013 10:55:39 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Wed, 4 Dec 2013 10:54:59 -0800 (PST)
In-Reply-To: <1386164583-14109-6-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238801>

On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.com> wrote:

> Given two branches residing in refs/heads/master and refs/wip/feature
> the list-of-branches view will present them in following way:
>
> master
> feature (wip)
>
> When getting a snapshot of a 'feature' branch, the tarball is going to
> have name like 'project-wip-feature-<short hash>.tgz'.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>

Very nice feature, which allows to distinguish between refs/heads/feature
and refs/wip/feature.

> ---
>  gitweb/gitweb.perl | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6d3d52d..9a63ea9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3739,8 +3739,14 @@ sub git_get_heads_list {
>                 $ref_item{'fullname'}  = $name;
>                 my $strip_refs = join '|', map { quotemeta } get_branch_refs();
>                 $name =~ s!^refs/($strip_refs|remotes)/!!;
> +               $ref_item{'name'} = $name;
> +               # for refs neither in 'heads' nor 'remotes' we want to
> +               # show their different ref dir

Perhaps simply:

  +               # for refs neither in 'heads' nor 'remotes' we want
to show their ref dir

> +               my $ref_dir = (defined $1) ? $1 : '';
> +               if ($ref_dir ne '' and $ref_dir ne 'heads' and $ref_dir ne 'remotes') {
> +                   $ref_item{'name'} .= ' (' . $ref_dir . ')';
> +               }
>
> -               $ref_item{'name'}  = $name;
>                 $ref_item{'id'}    = $hash;
>                 $ref_item{'title'} = $title || '(no commit message)';
>                 $ref_item{'epoch'} = $epoch;
> @@ -7257,7 +7263,24 @@ sub snapshot_name {
>                 # branches and other need shortened SHA-1 hash
>                 my $strip_refs = join '|', map { quotemeta } get_branch_refs();
>                 if ($hash =~ m!^refs/($strip_refs|remotes)/(.*)$!) {
> -                       $ver = $1;
> +                       my $ref_dir = $1;
> +                       $ver = $2;
> +
> +                       if (defined $ref_dir) {
> +                               # this is going to be a part of
> +                               # filename, so lets stick to
> +                               # alphanumerics, dashes and underlines
> +                               # only - some filesystems do not like
> +                               # some punctuation symbols for
> +                               # example.
> +                               $ref_dir =~ s/[^[:alnum:]_-]//g;
> +                       }

I think this safety replacement should apply also to other parts of filename,
if it is to be used.

$ref_dir should be compatibile with path-part - in loose form it is stored
on filesystem... though different filesystems might have different restrictions.

One thing we should worry about is '/' in hierarchical refdir names, e.g.
'wip/jk', which needs to be replaced / sanitized somehow, though probably
as 'wip-jk' or 'wip_jk' rather than 'wipjk', isn't it?

> +
> +                       # for refs not in heads nor remotes we want to
> +                       # add a ref dir to archive name
> +                       if ($ref_dir ne '' and $ref_dir ne 'heads' and $ref_dir ne 'remotes') {
> +                               $ver = $ref_dir . '-' . $ver;
> +                       }
>                 }
>                 $ver .= '-' . git_get_short_hash($project, $hash);
>         }
> --
> 1.8.3.1
>



-- 
Jakub Narebski
