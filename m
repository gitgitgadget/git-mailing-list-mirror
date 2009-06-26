From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 5/8] gitweb: gravatar url cache
Date: Sat, 27 Jun 2009 01:11:26 +0200
Message-ID: <200906270111.26640.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 01:11:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKKa4-0006VK-VU
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 01:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbZFZXLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 19:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZFZXLa
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 19:11:30 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:35090 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbZFZXLa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 19:11:30 -0400
Received: by fxm9 with SMTP id 9so2377245fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 16:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sl7l0pl1qHYBnlT1SoGSprPm8sSl7E8I2eESVjjI5DM=;
        b=kzyUwOu9p61mH6qankfUyf8alFQbCcvXJvra15LDFEX4/ueB8bkcVU6zntCMrPFfqI
         PcMiCVekR9z/tmJCGt2cM2HhRRCGGncCNArUYrBmQcv0LG7z/uHOKUK8sYdfg7IS1wCf
         yxDbZQgQOElxSzjTvCGWOgUXEdwrnluG9hoZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cpOTBIrpv/sv43Q2u14YnNmSZPw/j+I4YRUvWzOfpGXoa/TE1RzohwMpXurUs/JrcC
         tAqgb0X1slqGo+x9CEC7EMw492CdnwR9nTk4L4/EuFP3v9zpPiBKsMG19K7S9+hqF5oJ
         67Q31w0q8JpxULO92+H8irXEnBGtaf1/Jqwng=
Received: by 10.103.212.2 with SMTP id o2mr2603240muq.18.1246057891716;
        Fri, 26 Jun 2009 16:11:31 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id j2sm19706768mue.12.2009.06.26.16.11.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 16:11:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122332>

On Thu, 25 Jun 2009, Giuseppe Bilotta wrote:

> Views which contain many occurrences of the same email address (e.g.
> shortlog view) benefit from not having to recalculate the MD5 of the
> email address every time.

It would be nice to have some benchmarks comparing performance before
and after this patch.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   24 ++++++++++++++++++++++--
>  1 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f2e0cfe..d3bc849 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3257,6 +3257,27 @@ sub git_print_header_div {
>  	      "\n</div>\n";
>  }
>  
> +# Rather than recomputing the url for an email multiple times, we cache it
> +# after the first hit. This gives a visible benefit in views where the avatar
> +# for the same email is used repeatedly (e.g. shortlog).
> +# The cache is shared by all avatar engines (currently gravatar only), which
> +# are free to use it as preferred. Since only one avatar engine is used for any
> +# given page, there's no risk for cache conflicts.
> +our %avatar_cache = ();

Nice explanation.

> +
> +# Compute the gravatar url for a given email, if it's not in the cache already.
> +# Gravatar stores only the part of the URL before the size, since that's the
> +# one computationally more expensive. This also allows reuse of the cache for
> +# different sizes (for this particular engine).
> +sub gravatar_url {
> +	my $email = lc shift;
> +	my $size = shift;
> +	$avatar_cache{$email} ||=
> +		"http://www.gravatar.com/avatar.php?gravatar_id=" .
> +			Digest::MD5::md5_hex($email) . "&amp;size=";
> +	return $avatar_cache{$email} . $size;
> +}

Nice solution. Very good.

I guess it is not worth it to _not_ use cache for few avatars views 
such as 'commit', 'commitdiff', in the future also 'tag' view, isn't it?

BTW. http://www.gravatar.com/site/implement/url recommends
http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802 rather than
http://www.gravatar.com/avatar.php?gravatar_id=3b3be63a4c2a439b013787725dfce802
you use, following http://www.gravatar.com/site/implement/perl
Hmmm...

> +
>  # Insert an avatar for the given $email at the given $size if the feature
>  # is enabled.
>  sub git_get_avatar {
> @@ -3266,8 +3287,7 @@ sub git_get_avatar {
>  	my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};
>  	my $url = "";
>  	if ($git_avatar eq 'gravatar') {
> -		$url = "http://www.gravatar.com/avatar.php?gravatar_id=" .
> -			Digest::MD5::md5_hex(lc $email) . "&amp;size=$size";
> +		$url = gravatar_url($email, $size);
>  	}
>  	# Currently only gravatars are supported, but other forms such as
>  	# picons can be added by putting an else up here and defining $url

Very nice.

> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
