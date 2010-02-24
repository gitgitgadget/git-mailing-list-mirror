From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/1] Use GIT_ASKPASS environment to launch thirdpart UI
	app to get password
Date: Tue, 23 Feb 2010 21:13:10 -0800
Message-ID: <20100224051307.GA3232@gmail.com>
References: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 06:13:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk9Yo-00075K-W8
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 06:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057Ab0BXFNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 00:13:18 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:37451 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab0BXFNR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 00:13:17 -0500
Received: by ywh35 with SMTP id 35so2438705ywh.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 21:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZYO7XHVVmpbz0C2zYBzyNmCJ3Fu6Vi+vpAVt22Fp5vM=;
        b=HxoVVG3IqqoOSeHC9d1AUglhQFHCArRh88Eu2zq197OmzOwbodYD/9t6Ipf3t8CtfK
         DbP+c97XUYGRKDOOCK7exTzf/5xfVdTfmosqufQtFoivumP8Exi9Qz7BnmD+b9ebOaiP
         2Wa3LyapWBvCLP3xo5WAstw2vh89FK6r88cwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gONhTbnTYlJGMNVKO7L3+KRgwqW9kosK5kzy53yBxDoX/cTWjGc293SnvkBY0yJ+b6
         ab9LPGV9QsF5DDhR/dapGW0K/i/1DfojH46bO1vstvvKP64n2/W171GdeqBrKrdJ8LKj
         Qmc0Q/AuMNCGVe4RAc1lip9ri23XF7fqhGVvc=
Received: by 10.90.45.3 with SMTP id s3mr7564941ags.106.1266988396551;
        Tue, 23 Feb 2010 21:13:16 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm901090ywi.6.2010.02.23.21.13.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 21:13:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266923463-2828-1-git-send-email-lznuaa@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140898>

On Tue, Feb 23, 2010 at 07:11:03PM +0800, Frank Li wrote:
> Default git-svn read charactor from terminal to get password. GUI will
> wait forever because don't know password need input.

What do you think about this message instead?

-- >8 --
Subject: [PATCH] git-svn: Support retrieving passwords with GIT_ASKPASS

git-svn reads passwords from an interactive terminal.
This behavior causes GUIs to hang waiting for git-svn to
complete.

Fix this problem by allowing a password-retrieving command
to be specified in GIT_ASKPASS.  SSH_ASKPASS is supported
as a fallback when GIT_ASKPASS is not provided.

(see note below)


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

I think Junio mentioned this in passing but I'll repeat it.

Many users already have SSH_ASKPASS defined.  It would be very
nice if we supported SSH_ASKPASS as a fallback when GIT_ASKPASS
is not provided.


-- 
		David
