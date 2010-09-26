From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 02/12] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Sun, 26 Sep 2010 19:27:02 +0200
Message-ID: <201009261927.02414.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 19:27:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozv0Q-0006Pj-BF
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 19:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804Ab0IZR1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 13:27:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61167 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757081Ab0IZR1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 13:27:11 -0400
Received: by fxm3 with SMTP id 3so1440541fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=D1RSZJ6yXKNzJHNxMuI5I78l+PeFlGwLzZRx7KOzuG4=;
        b=M8ds4PaPDgvqV/MXl7JoH0CoXW685Q2/WjO1CdxzYe7a0LevLsaKzWjTmfSP58L5Db
         80OFm2OegxZe3QljYCgrH+2UPeMmubNZ3IOlcZA3/0h7wnmGofdeaXKahlxh1//1ABWY
         jHAhFmBPIxWhKUN/dwcLw7iwpqMYF8LE3wJlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xYOZ+ype9/Fe2HcQlRCANJz0orgPCKs51RnV7SG7U6Z0cL0GkMmuh+UyOytGu9QUhE
         R1WMWHxgrSv1EElSB60gvdY7dHDqA1XcPO67an0HYgqUgrL07XHaoGHaldBXy4DN6nlh
         /YaOm/fCZZAQqM8/ZRN1+wlH4DCK+KmohaT5c=
Received: by 10.223.124.148 with SMTP id u20mr937064far.57.1285522029871;
        Sun, 26 Sep 2010 10:27:09 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id f28sm2000790faa.0.2010.09.26.10.27.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 10:27:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157241>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
> refs/class1, refs/class2 etc. Defaults to ('heads') or ('heads', 'remotes')
> depending on the remote_heads option.

Possible (very minor) nitpick:

s/on remote_heads option/on 'remote_heads' feature/

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Very nice extension of an API.  Good work.  FWIW

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f09fcee..27c455e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3155,15 +3155,18 @@ sub parse_from_to_diffinfo {
>  ## parse to array of hashes functions
>  
>  sub git_get_heads_list {
> -	my $limit = shift;
> +	my ($limit, @classes) = @_;
> +	unless (defined @classes) {
> +		my $remote_heads = gitweb_check_feature('remote_heads');
> +		@classes = ('heads', $remote_heads ? 'remotes' : ());
> +	}
> +	my @patterns = map { "refs/$_" } @classes;
>  	my @headslist;
>  
> -	my $remote_heads = gitweb_check_feature('remote_heads');
> -
>  	open my $fd, '-|', git_cmd(), 'for-each-ref',
>  		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
>  		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
> -		'refs/heads', ($remote_heads ? 'refs/remotes' : ())
> +		@patterns
>  		or return;
>  	while (my $line = <$fd>) {
>  		my %ref_item;
> -- 
> 1.7.3.68.g6ec8
> 
> 

-- 
Jakub Narebski
Poland
