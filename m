From: Laszlo Papp <djszapi@archlinux.us>
Subject: Re: [PATCH 1/1] Use GIT_ASKPASS environment to launch thirdpart UI 
	app to get password
Date: Wed, 24 Feb 2010 00:31:39 +0100
Message-ID: <a362e8011002231531k17725788sb45e70428c33848b@mail.gmail.com>
References: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4EM-00087X-2A
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab0BWXbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:31:41 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:44049 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab0BWXbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:31:40 -0500
Received: by gxk9 with SMTP id 9so4623212gxk.8
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:31:39 -0800 (PST)
Received: by 10.101.179.34 with SMTP id g34mr2939845anp.85.1266967899420; Tue, 
	23 Feb 2010 15:31:39 -0800 (PST)
In-Reply-To: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140868>

Nice to see someone who are interested in the solution to hack it :-)

On 2/23/10, Frank Li <lznuaa@gmail.com> wrote:
> Default git-svn read charactor from terminal to get password. GUI will
> wait forever because don't know password need input.
>
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---
>  git-svn.perl |   27 +++++++++++++++++----------
>  1 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 265852f..f9f104e 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3966,18 +3966,25 @@ sub username {
>
>  sub _read_password {
>  	my ($prompt, $realm) = @_;
> -	print STDERR $prompt;
> -	STDERR->flush;
> -	require Term::ReadKey;
> -	Term::ReadKey::ReadMode('noecho');
>  	my $password = '';
> -	while (defined(my $key = Term::ReadKey::ReadKey(0))) {
> -		last if $key =~ /[\012\015]/; # \n\r
> -		$password .= $key;
> +	if (exists $ENV{GIT_ASKPASS}) {
> +		open(PH, "$ENV{GIT_ASKPASS} \"$prompt\" |");
> +		$password = <PH>;
> +		$password =~ s/[\012\015]//; # \n\r
> +		close(PH);
> +	} else {
> +		print STDERR $prompt;
> +		STDERR->flush;
> +		require Term::ReadKey;
> +		Term::ReadKey::ReadMode('noecho');
> +		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
> +			last if $key =~ /[\012\015]/; # \n\r
> +			$password .= $key;
> +		}
> +		Term::ReadKey::ReadMode('restore');
> +		print STDERR "\n";
> +		STDERR->flush;
>  	}
> -	Term::ReadKey::ReadMode('restore');
> -	print STDERR "\n";
> -	STDERR->flush;
>  	$password;
>  }
>
> --
> 1.7.0.83.g241b9.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
