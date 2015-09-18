From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] send-email: fix uninitialized var warning for $smtp_auth
Date: Fri, 18 Sep 2015 15:42:42 -0700
Message-ID: <20150918224242.GA45466@google.com>
References: <1442614370-39880-1-git-send-email-computersforpeace@gmail.com>
 <20150918222524.GA22410@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Viktorin <viktorin@rehivetech.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 00:42:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd4Mk-0001Rf-8Z
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 00:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbbIRWmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 18:42:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34098 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbbIRWmp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 18:42:45 -0400
Received: by padhy16 with SMTP id hy16so61954832pad.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ta7YlArbVEgrS91pfpGrl1YBeXRxEuEDzJJjG4Q85cU=;
        b=gqxxvj466rysX+vkNjKE3TIhcFBmLhYzcXV52Ae9yO313TvtBiqeu0Jj46coSoUbBu
         Y47qDeO1dUQ+U2FRVOynmKbJKbDgRCnL9kktCIZfFWpbJEpyQUxVOPTI/VGAZnZS81Ao
         Lz3LIp1PJZ7820/2u2uvyz9M/AoEkua1vzbgiHSO3azGLsdKbK3WLQO5nLHroNd/CU4s
         AVHllV2kWpnAmYjzpfXve1LzENO+uPDBxL5tik8t4EAlDtpodQLEwrLw4uL8wk2HSi13
         xAGeciqfCzLtIO+H+W5PgtGPw5XXcvZf8PuxdKGcYFuT6iVRKXg0sJAISikzGUBIqxWP
         Qo2g==
X-Received: by 10.69.17.1 with SMTP id ga1mr9535727pbd.163.1442616164557;
        Fri, 18 Sep 2015 15:42:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:a098:188d:dd8b:3b19])
        by smtp.gmail.com with ESMTPSA id yk5sm10911460pab.31.2015.09.18.15.42.43
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 18 Sep 2015 15:42:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150918222524.GA22410@flurp.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278225>

On Fri, Sep 18, 2015 at 06:25:24PM -0400, Eric Sunshine wrote:
> On Fri, Sep 18, 2015 at 03:12:50PM -0700, Brian Norris wrote:
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1136,7 +1136,7 @@ sub smtp_auth_maybe {
> >  
> >  	# Check mechanism naming as defined in:
> >  	# https://tools.ietf.org/html/rfc4422#page-8
> > -	if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
> > +	if ($smtp_auth && $smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
> >  		die "invalid smtp auth: '${smtp_auth}'";
> >  	}
> 
> Thanks, makes sense. I wonder if moving the check to the point where
> $smtp_auth is actually used (despite the noisier diff) would be cleaner,
> like this:
> 
> --- 8< ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index c5a3f76..2a5ceda 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1134,12 +1134,6 @@ sub smtp_auth_maybe {
>  		Authen::SASL->import(qw(Perl));
>  	};
>  
> -	# Check mechanism naming as defined in:
> -	# https://tools.ietf.org/html/rfc4422#page-8
> -	if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
> -		die "invalid smtp auth: '${smtp_auth}'";
> -	}
> -
>  	# TODO: Authentication may fail not because credentials were
>  	# invalid but due to other reasons, in which we should not
>  	# reject credentials.
> @@ -1154,6 +1148,12 @@ sub smtp_auth_maybe {
>  		my $cred = shift;
>  
>  		if ($smtp_auth) {
> +			# Check mechanism naming as defined in:
> +			# https://tools.ietf.org/html/rfc4422#page-8
> +			if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
> +				die "invalid smtp auth: '${smtp_auth}'";
> +			}
> +
>  			my $sasl = Authen::SASL->new(
>  				mechanism => $smtp_auth,
>  				callback => {
> --- 8< ---

By moving the patch into the sub-subroutine (is this a lambda? I'm not
too familiar with my perl), I think you change the order of the checks.
So, previously, initial password auth would happen after the
$smtp_auth format check. With your patch, it comes first.

My patch:

  $ git send-email --smtp-auth="@" ...
  ...
  Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
  invalid smtp auth: '@' at ./git-send-email.perl line 1140.

Your patch:

  $ git send-email --smtp-auth="@" ...
  ...
  Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
  Password for xxxx:
  invalid smtp auth: '@' at ./git-send-email.perl line 1155.

Seems like the former is a little better, so you don't have to waste
time with your password too many times.

Regards,
Brian
