From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: check if-modified-since for feeds
Date: Mon, 26 Jan 2009 03:18:05 +0100
Message-ID: <200901260318.05301.jnareb@gmail.com>
References: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com> <1232923370-4427-1-git-send-email-giuseppe.bilotta@gmail.com> <1232923370-4427-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 03:19:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRH4Z-0006a1-KY
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 03:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbZAZCSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 21:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbZAZCSK
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 21:18:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:31090 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZAZCSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 21:18:09 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3341633fgg.17
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 18:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Ud4XsfePWZjcJZbqRMIstKUUirQKbM5tJSfiTv98V4I=;
        b=LbIrWyv6OlcPai4MDvEPb42MJYTLNsQUAjz4BTbxHqdWu1pVruLE2ewUjhNz4db2Nv
         bcUL/5KLcSdvfY4EAawfqRYjIaZM8h46tUcc83PrAoAgW1rSWkIL9HpzczQ7G9QGwUKC
         Nohay0u1tGF4u7bbRW+8FtDMLtei8h631+2nA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oTp6LCGZIirljYSVrT+rfVMfLql8DhSeQSco+l0A0w8EF619xpU6HPBu6fkrIvBtwL
         I22miJNE6z7u1stXOVuBAmtdG6lAr7ma0DLuYWq16BuX2hXnQZeNqJb0W7wS/HjmY19O
         vfsxPoR6uoKZG4Vsj2n/CKV44AUHfT+diECPo=
Received: by 10.86.33.10 with SMTP id g10mr1590149fgg.40.1232936287329;
        Sun, 25 Jan 2009 18:18:07 -0800 (PST)
Received: from ?192.168.1.15? (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id d4sm3274225fga.51.2009.01.25.18.18.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 18:18:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232923370-4427-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107159>

Should be "[PATCH 2/2]" or similar, just in case.

On Sun, 25 Jun 2009, Giuseppe Bilotta wrote:

> Offering Last-modified header

And skipping generating the body if client uses 'HEAD' request to
get only Last-Modified header.

>                              for feeds is only half the work: we should 
> also check that same date against If-modified-since, and bail out early
> with 304 Not Modified.

Lacks signoff.

> ---
>  gitweb/gitweb.perl |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8c49c75..0a5d229 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6015,7 +6015,25 @@ sub git_feed {
>  	}
>  	if (defined($commitlist[0])) {
>  		%latest_commit = %{$commitlist[0]};
> -		%latest_date   = parse_date($latest_commit{'committer_epoch'});
> +		my $latest_epoch = $latest_commit{'committer_epoch'};
> +		%latest_date   = parse_date($latest_epoch);
> +		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
> +		if (defined $if_modified) {
> +			my $since;
> +			if (eval { require HTTP::Date; 1; }) {
> +				$since = HTTP::Date::str2time($if_modified);
> +			} elsif (eval { require Time::ParseDate; 1; }) {
> +				$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
> +			}

I'd really like to fallback on hand-parsing, as we have to parse date
in well defined HTTP-date format (RFC-1123, update to RFC-822), which
I think is what we send in Last-Modified header (or is it RFC-2822?).

But that might be too much work. I like the checking for modules,
and the fallback cascade, but could you explain why in this order?

> +			if (defined $since && $latest_epoch <= $since) {
> +				print $cgi->header(
> +					-type => $content_type,
> +					-charset => 'utf-8',
> +					-last_modified => $latest_date{'rfc2822'},
> +					-status => 304);

I think we spell HTTP status messages in full (even if it is hidden
in die_error subroutine), i.e.

+					-status => '304 Not Modified');

> +				return;
> +			}
> +		}
>  		print $cgi->header(
>  			-type => $content_type,
>  			-charset => 'utf-8',
> -- 
> 1.5.6.5
> 
> 

P.S. It would be nice to have this mechanism (responding to
cache-control headers such as If-Modified-Since) for all of gitweb,
but I guess it is most critical for feeds, which are _polled_.

-- 
Jakub Narebski
Poland
