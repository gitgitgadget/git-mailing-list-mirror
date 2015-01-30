From: Valery Yundin <yuvalery@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Fri, 30 Jan 2015 01:40:31 +0100
Message-ID: <CABNxngMVsaSLmzf0ZsaXZqXhD+hOaRmz-uuSzm0ALDFhKjnrXA@mail.gmail.com>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
	<20150129233429.GA7162@dcvr.yhbt.net>
	<CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com>
	<20150130002247.GA22519@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 01:40:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGzdY-0006bl-Sr
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 01:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbbA3Akf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 19:40:35 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:48149 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbbA3Akc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 19:40:32 -0500
Received: by mail-qg0-f49.google.com with SMTP id i50so36065140qgf.8
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 16:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Dc0XuN/eeGZbu1BMM7MxyC5h5ErjIeyKfgEL4p42Vow=;
        b=PuUcmuza8ppJtZ21Rv1QDAb536DlVlKRVzPePmfejCMoLZEUsBhKhhZGfJdRhLYgD8
         qglGs7amprp3CthMQpam0CzGjfJAPRIOyZGv67o/NsPAPYhdM6o78h3Vj+GHD/TORyAq
         bnYDQmMBFRUvOFf3X1trPOMiT15ZEtddaJZIzwr+0v1Zxjt2WNcvy8hAIKQPIPIunUvy
         22nOV8w3p4ztN/uxWtgQTXCrDrpetN+K+ouhtQ5rHmGG4IwkuHNTFJhBA6BML9VG6dsq
         QfDnm1HCnTTCS+rdHpyuIwo0QFPQYLzBxJ9lnz54fg+Ldu/Y2hobXbTyyaJWqBd4jYQ6
         HzTQ==
X-Received: by 10.224.114.209 with SMTP id f17mr7295388qaq.68.1422578432121;
 Thu, 29 Jan 2015 16:40:32 -0800 (PST)
Received: by 10.96.46.170 with HTTP; Thu, 29 Jan 2015 16:40:31 -0800 (PST)
In-Reply-To: <20150130002247.GA22519@dcvr.yhbt.net>
X-Google-Sender-Auth: dlI0EEwilrNEJyEWQPoLbNApKQM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263169>

Hi,

Your patch seems to fix the problem.
I tried several times and I can svn clone the whole repository in one
go without a crash.

Thanks,
Valery

On 30 January 2015 at 01:22, Eric Wong <normalperson@yhbt.net> wrote:
> Valery Yundin <yuvalery@gmail.com> wrote:
>> Hi,
>>
>> Here you go:
>> dfa72fdb96befbd790f623bb2909a347176753c2 is the first bad commit
>
> Thank you.  Can you give the following patch a try?
> I have not been able to reproduce the problem on my end.
> If it doesn't work out, I might be out of ideas for a bit :/
> Increasing --log-window-size will help you run longer without
> the error, but that's not ideal as it can also eat memory.
>
> -----------------------8<----------------------
> From: Eric Wong <normalperson@yhbt.net>
> Subject: [PATCH] git-svn: destroy all tempfiles when reloading RA
>
> This may fix the errors some users are seeing with:
> "write .git/Git_svn_hash_XXXXXX: Bad file descriptor"
>
> Thanks to Valery Yundin for helping bisect the problem introduced in
> commit dfa72fdb96befbd790f623bb2909a347176753c2
> (git-svn: reload RA every log-window-size)
>
> Cc: Valery Yundin <yuvalery@gmail.com>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  perl/Git.pm        | 6 ++++++
>  perl/Git/SVN/Ra.pm | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index b5905ee..698018e 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1347,6 +1347,12 @@ sub temp_path {
>         $TEMP_FILES{$temp_fd}{fname};
>  }
>
> +sub temp_reset_all {
> +       unlink values %TEMP_FILEMAP if %TEMP_FILEMAP;
> +       %TEMP_FILEMAP = ();
> +       %TEMP_FILES = ();
> +}
> +
>  sub END {
>         unlink values %TEMP_FILEMAP if %TEMP_FILEMAP;
>  }
> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 622535e..878679d 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -397,6 +397,7 @@ sub gs_fetch_loop_common {
>                 $_[0] = undef;
>                 $self = undef;
>                 $RA = undef;
> +               Git->temp_reset_all;
>                 $gpool->clear;
>                 $self = Git::SVN::Ra->new($ra_url);
>                 $ra_invalid = undef;
> --
> EW
