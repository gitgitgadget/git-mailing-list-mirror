From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [PATCH] submodule update - don't run git-fetch if sha1 available
Date: Sat, 11 Aug 2007 20:23:12 +0200
Message-ID: <e7bda7770708111123m6e497450yaa91ccb600d37d53@mail.gmail.com>
References: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 20:23:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJvcX-0005jp-9k
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 20:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbXHKSXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 14:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbXHKSXO
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 14:23:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:9728 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbXHKSXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 14:23:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1284796wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 11:23:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W4g1OwPYZ9xVmaDU1eF5oBICJhv6qQ6mGI1u3BbHqzHurA+SKBUmCPFzvIE+XSc8M47PjuZj3GghU8mGqtxEdZcakUPCEJlEg10bJKkOA6FnpRSpbpIGibc5R1FylZhI6/nr20qCNP65XtsidiEO0pav1tK95B3VwHqJrb/N73M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hjrjpl9LyUuLu9qyZgN8QfmnJkNG2KCWWvZQbxSXIC5b3ctJwVvwICGeVjr4ggKqAzPxJN+txlYhYt9kSU3HL7Jm27nMSbhtQbXJ/GkwI1vFDHhUojY60gJ47TKLCmVMYGiaDGXQJRkBQ+7+XdeXImGbeUpVZ7FexNFuK6n7C0g=
Received: by 10.115.47.1 with SMTP id z1mr1072836waj.1186856592351;
        Sat, 11 Aug 2007 11:23:12 -0700 (PDT)
Received: by 10.114.47.7 with HTTP; Sat, 11 Aug 2007 11:23:12 -0700 (PDT)
In-Reply-To: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55619>

Hi

Sorry for a broken patch [inserted line-feeds]. If anyone knows how to
disable that in gmail web client, please let me know.

I also tried to follow "Using msmtp to send your patches"
[http://git.or.cz/gitwiki/GitTips ] on msys/mingw/WindowsXP with the
following result (at best) from git-send-email:

"Can't call method "mail" on an undefined value at
C:/msysgit/git/git-send-email line 551."

So I would appreciate if someone that has used the combination gmail
SMTP+Windows+git-send-email successfully (cygwin,msys or "pure") to
let us know how you did it.

Best Regards,

//Torgil


On 8/11/07, Torgil Svensson <torgil.svensson@gmail.com> wrote:
> It's un-necessary (both time-consuming and annoying if you are
> disconnected) for git submodule update to always running git-fetch
> prior to the detached head checkout of the submodule if the commit
> already exists.
>
> Signed-off-by: Torgil Svensson <torgil.svensson@gmail.com>
> ---
>  git-submodule.sh |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2cfeadd..dc2ed4b 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -39,6 +39,11 @@ get_repo_base() {
>         ) 2>/dev/null
>  }
>
> +has_sha1()
> +{
> +       git rev-list 2>/dev/null --max-count=0 $1
> +}
> +
>  #
>  # Map submodule path to submodule name
>  #
> @@ -193,9 +198,9 @@ modules_update()
>
>                 if test "$subsha1" != "$sha1"
>                 then
> -                       (unset GIT_DIR && cd "$path" && git-fetch &&
> +                       (unset GIT_DIR && cd "$path" && (has_sha1
> "$sha1" || git-fetch) &&
>                                 git-checkout -q "$sha1") ||
> -                       die "Unable to checkout '$sha1' in submodule
> path '$path'"
> +                       die "Unable to checkout '$sha1' in submodule
> path '$path'"
>
>                         say "Submodule path '$path': checked out '$sha1'"
>                 fi
> --
> 1.5.3.rc4.730.ga8c3-dirty
>
