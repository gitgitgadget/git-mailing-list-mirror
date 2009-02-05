From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 6/6] gitweb: check if-modified-since for feeds
Date: Thu, 5 Feb 2009 03:03:42 +0100
Message-ID: <200902050303.43356.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-6-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 03:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUtcK-0000Ck-Nd
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 03:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbZBECDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 21:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755791AbZBECDp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 21:03:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:26871 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbZBECDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 21:03:44 -0500
Received: by fg-out-1718.google.com with SMTP id 16so12244fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 18:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kRytz5xha0lWflLeHHKYV+EbzvLMvdMhKiQM4Il/LRQ=;
        b=bycavcQAuPSuP2QvL6BVO1Iv7VWITIbLLNDGJHKHDOEyPjF9E4QerL84wxZGvSpQB3
         K9hYq2/u5KZ4nDnT/MT4bu1nYIc361yNOGfe1bti8ArWDMOZlRxMSFQ9+3nztwRSZDbX
         SyhG1GD3/bQUwDesi8qQqDqeio32IGNxyEYDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gALXcNwSrL9qFgZ7r+A9Y1DyA/KpY1gw9n2PZZ1Ka55bnSwZG4ruv9I1KVYOXWX3Lc
         fgT40Shf3uf4aYt2IPOhYxyqBxRRcoXnBPuJ1Co5IEJ/vQ/acv//Gr3sa81mv9K4pQRK
         Zy7AmOAOEyqNkQQPE4g1qfkdMRI2WPGWWtGv4=
Received: by 10.86.61.13 with SMTP id j13mr27137fga.6.1233799422314;
        Wed, 04 Feb 2009 18:03:42 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id l12sm60168fgb.41.2009.02.04.18.03.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 18:03:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232970616-21167-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108491>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> Offering Last-modified header for feeds is only half the work, even if
> we bail out early on HEAD requests. We should also check that same date
> against If-modified-since, and bail out early with 304 Not Modified if
> that's the case.

It looks now quite nice, but I'd like to see information about
dependencies for this feature in the commit message, something like:

   This feature (terminating early with '304 Not Modified' in response
   to 'If-Modified-Since' conditional request) requires having either
   HTTP::Date module (from libwww-perl) or Time::ParseDate module.
   If neither is present gitweb falls back to earlier behaviour of not
   reacting to 'If-Modified-Since'.

Note also (although I'm not sure if it is worth mentioning in commit
message) that it doesn't save gitweb as much work as one could think,
because at this place the whole list of commits is already generated
and parsed.  What we save is cost of running git-diff-tree for each
commit (we could do better here, I think), and of course bandwidth.


I wonder if it would be possible to separate this code into subroutine,
to make it possible to have support for "cache control" conditional
requests also in other cases where it might help (for the future of
course, not in this commit).

Perhaps if we run gitweb from Apache mod_perl in compatibility mode
(ModPerl::Registry) to use Apache Perl API to respond to 
'If-Modified-Since' ($r->is_fresh or something). But that is also
just idea for the future improvement.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Here I think:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8c49c75..f4defb0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6015,7 +6015,25 @@ sub git_feed {
>  	}
>  	if (defined($commitlist[0])) {
>  		%latest_commit = %{$commitlist[0]};
> -		%latest_date   = parse_date($latest_commit{'committer_epoch'});
> +		my $latest_epoch = $latest_commit{'committer_epoch'};
> +		%latest_date   = parse_date($latest_epoch);

Nitpick: either follow aligning on '=' characters, or skip it
altogether and always use one space before '=' in this fragment.

> +		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
> +		if (defined $if_modified) {
> +			my $since;
> +			if (eval { require HTTP::Date; 1; }) {
> +				$since = HTTP::Date::str2time($if_modified);
> +			} elsif (eval { require Time::ParseDate; 1; }) {
> +				$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
> +			}
> +			if (defined $since && $latest_epoch <= $since) {
> +				print $cgi->header(
> +					-type => $content_type,
> +					-charset => 'utf-8',
> +					-last_modified => $latest_date{'rfc2822'},
> +					-status => '304 Not Modified');
> +				return;
> +			}
> +		}

Good.

>  		print $cgi->header(
>  			-type => $content_type,
>  			-charset => 'utf-8',
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
