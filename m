From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix esc_param
Date: Wed, 14 Oct 2009 10:23:14 +0200
Message-ID: <200910141023.15475.jnareb@gmail.com>
References: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 10:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxzFS-0005Sk-8i
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 10:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068AbZJNIYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 04:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757341AbZJNIYI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 04:24:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:41043 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbZJNIYD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 04:24:03 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1245733fga.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4z/A9UG2NQ+uM+PKKxFkFzjNyLcIa0JzDscs46Of/gY=;
        b=RZxgsJXXGQ++CKC0ebxOAg5v3Og12+A2Vt6ijAQhOV8880PAq52BCGy5x05Q3m+Ugy
         kp+L0PeL5n2QeN29W8gwhoEo1l0S4vlz9wtkJ0KAWhRr50reaX8rzHi98+CNhTg3wu02
         nZVm/1HTYW+Ifgp1p6ywHF+iUXZCAwsxRiyXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qyW3beCa619s3WihhGmOpSPK8sZ/npslLD+h09oduFc3wuYb7f2Fz4cA6odpcUYH2y
         nhtjascS50UX8xMUcD2/MA272vym72YWbJ36mJov705npA42pjD9ghC4HmLPHt3J9ycS
         va5PMtBtVDYRKx1qvQ8suYGTt7slAflJE0miY=
Received: by 10.86.195.29 with SMTP id s29mr3356890fgf.73.1255508536222;
        Wed, 14 Oct 2009 01:22:16 -0700 (PDT)
Received: from ?192.168.1.13? (abvb70.neoplus.adsl.tpnet.pl [83.8.199.70])
        by mx.google.com with ESMTPS id 3sm1735093fge.24.2009.10.14.01.22.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 01:22:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130266>

On Tue, 13 Oct 2009, Giuseppe Bilotta wrote:

> The custom CGI escaping done in esc_param failed to escape UTF-8
> properly. Fix by using CGI::escape on each sequence of matched
> characters instead of sprintf()ing a custom escaping for each byte.

Hmmm... I wonder if this bug isn't caused by failing to mark some
input as utf8 using to_utf8() subroutine... or by using 
binmode $fd, ':utf8' on $fd from opening git-rev-list, after ensuring
that it outputs utf8 by --encoding=utf8 (or is it only git-log that
accepts that option?).

> 
> Additionally, the space -> + escape was being escaped due to greedy
> matching on the first substitution. Fix by adding space to the
> list of characters not handled on the first substitution.

Thanks.

> 
> Finally, remove an unnecessary escaping of the + sign.

Signoff?

> ---
>  gitweb/gitweb.perl |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> The issues with this routine were exposed by Stephen's
> "author as search link" patch. This should fix them.
> 
> Since the idea of esc_param is to replicate CGI::escape except for the /
> character (if I read the comment correclty), a possible alternative
> would be to just use CGI::escape on the whole string and then undo the
> escaping for the / character.

Well, that and widely used but non-standard (well, not using percent
encoding) escaping of space with '+'; CGI::escape(" ") is %20, not '+'.
Se we would have to turn '%2F' into '/', and '%20' into '+'.

> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6237865..6593e5c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1115,8 +1115,7 @@ sub to_utf8 {
>  # correct, but quoted slashes look too horrible in bookmarks
>  sub esc_param {
>  	my $str = shift;
> -	$str =~ s/([^A-Za-z0-9\-_.~()\/:@])/sprintf("%%%02X", ord($1))/eg;
> -	$str =~ s/\+/%2B/g;
> +	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
>  	$str =~ s/ /\+/g;
>  	return $str;
>  }
> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
