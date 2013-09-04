From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] add--interactive: fix external command invocation on Windows
Date: Wed, 4 Sep 2013 19:02:17 +0700
Message-ID: <CACsJy8DbkNz8rTFDV3u9j3+mmzF0JVdO+TNVBX6uRQPCCfis_g@mail.gmail.com>
References: <521EF02A.2020300@viscovery.net> <1378001284-18426-1-git-send-email-pclouds@gmail.com>
 <5224334A.2090300@viscovery.net> <20130902092959.GA17306@lanh>
 <52246B70.3080200@viscovery.net> <CACsJy8BxGVyVsOV=XyWRqSnNjna0LQOAk6rgJ_jRkVox1jUSxQ@mail.gmail.com>
 <5226E03F.208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 04 14:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHBnQ-00042m-NS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 14:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762572Ab3IDMCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 08:02:49 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:43982 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762456Ab3IDMCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 08:02:48 -0400
Received: by mail-ob0-f169.google.com with SMTP id es8so210083obc.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HPnvpwMSHFZSL8FlqnkxaFlj7c7MXbE/MiLYoD7n2T4=;
        b=c02/459sER+I2anOcahrOWm3Y6hC5ePvxK0i+SdGbsXFpvrEwmPkeCEo9b9R8AX7pq
         ib0eN1wWWoDFvQ+BMt8763fHAgxB+TBBE6IkUa25/d83FNtdtgJB086BLKX4tQ1vIGMZ
         lcGLgKRNv9aoLgMghAaxnwQeXHeAlt996H1s7BGIJ4orpVm7Q17aGOBPlppUcoXZnsSx
         tIzmmp3vRmZgQZt7k/qBi3TqfFgOTkXnCraQpqqpZaFpL0XMiBXqq88LJ6gYi67NiHEa
         9RorHwNZ8h5GXSRLK9YI4V4J7CbEuu793rUaBye/5vpjxXYV7l7Re3PkHZWl55vQ9Ys4
         P1HA==
X-Received: by 10.60.133.71 with SMTP id pa7mr1889455oeb.44.1378296167878;
 Wed, 04 Sep 2013 05:02:47 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 4 Sep 2013 05:02:17 -0700 (PDT)
In-Reply-To: <5226E03F.208@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233833>

On Wed, Sep 4, 2013 at 2:24 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> From: Johannes Sixt <j6t@kdbg.org>
>
> Back in 21e9757e (Hack git-add--interactive to make it work with
> ActiveState Perl, 2007-08-01), the invocation of external commands was
> changed to use qx{} on Windows. The rationale was that the command
> interpreter on Windows is not a POSIX shell, but rather Windows's CMD.
> That patch was wrong to include 'msys' in the check whether to use qx{}
> or not: 'msys' identifies MSYS perl as shipped with Git for Windows,
> which does not need the special treatment; qx{} should be used only with
> ActiveState perl, which is identified by 'MSWin32'.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 9/2/2013 13:56, schrieb Duy Nguyen:
>> On Mon, Sep 2, 2013 at 5:41 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Which features do we lose on Windows with the previous patch and this fixup?
>>
>> New pathspec magic :(glob), :(literal) and :(icase). You can still use
>> them via --*-pathspecs or equivalent env variables. You just can't
>> enable them per individual pathspec.
>
> I think this here is the correct "solution" rather than the special cases
> for Windows that you proposed. ActiveState perl users would still suffer,
> but that is a problem of the run_cmd_pipe implementation, which would
> need a smarter method to quote the arguments before it feeds them to qx{}.

I admit this is cleaner than my patch. Let's see any users using
ActiveState Perl yell up, then we'll deal with the problem.

>  git-add--interactive.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 75a991f..5156384 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -169,7 +169,7 @@ my %patch_modes = (
>  my %patch_mode_flavour = %{$patch_modes{stage}};
>
>  sub run_cmd_pipe {
> -       if ($^O eq 'MSWin32' || $^O eq 'msys') {
> +       if ($^O eq 'MSWin32') {
>                 my @invalid = grep {m/[":*]/} @_;
>                 die "$^O does not support: @invalid\n" if @invalid;
>                 my @args = map { m/ /o ? "\"$_\"": $_ } @_;
> --
> 1.8.4.1549.gc059550.dirty
>
-- 
Duy
