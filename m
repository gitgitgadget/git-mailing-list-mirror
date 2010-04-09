From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/3] send-email: Don't use FQDNs without a '.'
Date: Fri, 9 Apr 2010 18:31:48 +0200
Message-ID: <201004091831.49066.jnareb@gmail.com>
References: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com> <1270827746-29229-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 18:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0H7v-0006bq-9E
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 18:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0DIQb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 12:31:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:55787 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab0DIQb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 12:31:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1266839fga.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Y0ZZIUhU0DqhySfYuLeWHpUqWQBEbLUcg7BWqIOd9/Q=;
        b=a1Fr79jj/HDqwPLtcWnfNcE+nIj5PdcoqwCItwuFGeHNw7CfoALqkxhxCUFNm+ysNB
         jN/Lu2wd1jyw+3wNIf0+YHsAiTIvZv9oH5H6T8fb/4cjWIBm56hD5F3YL30RWBZ/yBkP
         9wtSSogMKw7TPDqrQJBWe7z80VGI6bDL0984M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cAPg5t1bx35RzQDUxrl4qPTPUAr7YIKMdWzw2GTTq+zHLsJXLocDyZ8MDxRXmuHFvA
         2hVguTwJ7O5B0frgR8i4Tov7X+GZOnuDq5EHx+j8f+tA4QDMdeOUgkJ1kmkmTmReJoBL
         Hhqghy+c3kxfz1Lz8XpWU/DEwcn2SZ8LSmYj0=
Received: by 10.102.16.14 with SMTP id 14mr135213mup.136.1270830715309;
        Fri, 09 Apr 2010 09:31:55 -0700 (PDT)
Received: from [192.168.1.13] (abvc167.neoplus.adsl.tpnet.pl [83.8.200.167])
        by mx.google.com with ESMTPS id g1sm6164705muf.0.2010.04.09.09.31.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 09:31:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1270827746-29229-1-git-send-email-brian@gernhardtsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144451>

On Fri, 9 Apr 2010, Brian Gernhardt wrote:
 
> Since the same condition is used twice and getting complex, let's move
> it to a new function.

Good idea.


Note that the comments below are just nitpicking about Perl style.
 
> @@ -863,14 +863,19 @@ sub sanitize_address
>  # This maildomain*() code is based on ideas in Perl library Test::Reporter
>  # /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
>  
> +sub valid_fqdn
> +{
> +	my $domain = $_[0];
> +	return !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
> +}

A matter of style: in Perl it more usual to use

  sub <name> {
  	...
  }

style rather than

  sub <name>
  {
  	...
  }

Unfortunately git-send-email.perl is a bit inconsistent in the style used;
23 subroutines use Perl style, 5 subroutines including previous one i.e.
sanitize_address use C-like style (one of).


Also, the usual way of unrolling @_; is to use either

  my ($par1, $par2, ...) = @_;

or use

  mu $par = shift;

The form $_[0] etc. is used very rarely.  I think it is even against 
Perl Best Practices (see http://www.perlcritic.org and Perl::Critic).


So in my opinion this fragment should be:

+sub valid_fqdn {
+	my $domain = shift;
+	return !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+}


> +
>  sub maildomain_net
>  {
>  	my $maildomain;
>  
>  	if (eval { require Net::Domain; 1 }) {
>  		my $domain = Net::Domain::domainname();
> -		$maildomain = $domain
> -			unless $^O eq 'darwin' && $domain =~ /\.local$/;
> +		$maildomain = $domain if valid_fqdn( $domain );
>  	}
>  
>  	return $maildomain;
> @@ -887,8 +892,7 @@ sub maildomain_mta
>  				my $domain = $smtp->domain;
>  				$smtp->quit;
>  
> -				$maildomain = $domain
> -					unless $^O eq 'darwin' && $domain =~ /\.local$/;
> +				$maildomain = $domain if valid_fqdn( $domain );
>  
>  				last if $maildomain;
>  			}

Style: usually there is no space around function arguments, so 
'valid_fqdn($domain);'.

-- 
Jakub Narebski
Poland
