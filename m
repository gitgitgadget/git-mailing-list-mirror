From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: nd/magic-pathspec exposes breakage in git-add--interactive on Windows
Date: Thu, 29 Aug 2013 16:47:26 +0700
Message-ID: <CACsJy8B50Xb=S7wp=2H7NHPoM52XXZgBbygTJahFyRzuqT-=HQ@mail.gmail.com>
References: <521EF02A.2020300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 29 11:48:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEypj-0000yB-CZ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 11:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130Ab3H2Jr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 05:47:58 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:42828 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab3H2Jr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 05:47:56 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so205121obp.22
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=biSIk6m53lT9qzeiLZd7uhJ2sBEO+twaXlfOnMmzpFE=;
        b=wgmLrzn8tXQ79iaOPKfzbuIsZlMmkXyle53QbWqTfs5gG+Xs+BjoVFIcWEU+wsVHO2
         jGuFmhGeh3qT/mzf35Qzsu2sz9xfawNQzCAG2D2LeBgg6mq78OZTYobgsZ2dVQhLHHZU
         JCVIcLIuV+V3kB4wrSaBt1VHB1U1xc5zqAfIl4QeP1YpfF451/+cYMbH0TrPiN0zcnFs
         zEpEwCm0aJDrdOWp47NXoMik0Sc+BjI2Dhnu5j5YO1c0HyUmp5f/h9Bzz7yw2h0i/NwC
         O6/IEj33wmdKdn/tdX6IUU+IGsRLr9zJHVNUhIXTD6lnzdNQmNay4tVSGlmcrnBC8aWK
         4xmg==
X-Received: by 10.60.70.134 with SMTP id m6mr1817461oeu.14.1377769676163; Thu,
 29 Aug 2013 02:47:56 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 29 Aug 2013 02:47:26 -0700 (PDT)
In-Reply-To: <521EF02A.2020300@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233245>

On Thu, Aug 29, 2013 at 1:54 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> With nd/magic-pathspec I get the following failure on Windows in
> t2016-checkout-patch.sh:
>
> expecting success:
>         set_state dir/foo work head &&
>         # the third n is to get out in case it mistakenly does not apply
>         (echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
>         verify_saved_state bar &&
>         verify_state dir/foo head head
>
> ==== xx.
> ==== 1d.
> ==== 10e.
> msys does not support: :(prefix:4)dir/foo
> not ok 13 - path limiting works: foo inside dir
>
> The error message 'msys does not support...' originates from this function
> in git-add--interactive.perl (which is invoked from checkout -p):
>
>   sub run_cmd_pipe {
>         if ($^O eq 'MSWin32' || $^O eq 'msys') {
>                 my @invalid = grep {m/[":*]/} @_;
>                 die "$^O does not support: @invalid\n" if @invalid;
>                 my @args = map { m/ /o ? "\"$_\"": $_ } @_;
>                 return qx{@args};
>         } else {
>                 my $fh = undef;
>                 open($fh, '-|', @_) or die;
>                 return <$fh>;
>         }
>   }
>
> It looks like on Windows we disallow arguments that contain double-quote,
> colon, or asterisk, and otherwise wrap arguments in double-quotes if they
> contain space. Then pass them through qx{}, which I can only guess what it
> does.
>
> This code was introduced in 21e9757e (Hack git-add--interactive to make it
> work with ActiveState Perl, 2007-08-01). The commit message has the
> general statement "It wont work for arguments with special characters
> (like ", : or *)), which I do not know how to interpret: Does ActiveState
> Perl not work with special charactoers, or Windows? Because the latter is
> definitely not true.

If it indeed does not work with ActiveState Perl, we still have a
chance to make it :(prefix=4)dir/foo, assuming '=' does not fall to
the same category as ':'

>
> Can we be more permissive in the 'my @invalid' check without breaking
> ActiveState Perl?
>
> BTW, there is a similar failure in t7105-reset-patch.sh, which invokes
> 'git reset -p', but I haven't investigate further.
>
> -- Hannes
-- 
Duy
