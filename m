From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/7] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Fri, 17 Sep 2010 00:14:12 +0200
Message-ID: <201009170014.12483.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 00:14:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwMij-0003n8-4l
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 00:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab0IPWOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 18:14:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58794 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab0IPWOO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 18:14:14 -0400
Received: by bwz11 with SMTP id 11so2060667bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rD5ZG8OMmZZElO+gWr4I8KyD/srkCHbKnNsCGxrNSeM=;
        b=FnRrHRfuLSwq5qnDJ8zylSo0fGEaNd51jwZRE5mAEtbnrhfcRpD0An3Ea0ireqRCcu
         0DCC2vxgwEv1VbUTI7AqIc3XPrJUs/ZZ2UUzw8jJ0S4pps8jKgA/txEjrfWnp2pcy8in
         9ADZd2gLKKldrG3PHr2R6g7vn6MXbekPlfEfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JGmtnB+Chemya6+xL/bjlCsPYaXWyLKGt+2WsWkwK5GY9g6PvknFq2PZUBJbQOP2PH
         rXBZpS5PmOHxcEvdPAR4JTyHflLfKeLfD62NXIWHUkuEF25vb05PYokS1pWqFMGrW8LM
         GZFpD9U/+HmiL7cc3b8Tg/w0EwAcER/RC581k=
Received: by 10.204.163.69 with SMTP id z5mr2996394bkx.167.1284675253198;
        Thu, 16 Sep 2010 15:14:13 -0700 (PDT)
Received: from [192.168.1.13] (abvm37.neoplus.adsl.tpnet.pl [83.8.210.37])
        by mx.google.com with ESMTPS id d27sm2934405bku.10.2010.09.16.15.14.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 15:14:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1284629465-14798-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156357>

On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
> refs/class1, refs/class2 etc. Defaults to ('heads') or ('heads', 'remotes')
> depending on the remote_heads option.

I like this API very much.
 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7116c26..21e83bb 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3155,15 +3155,18 @@ sub parse_from_to_diffinfo {
>  ## parse to array of hashes functions
>  
>  sub git_get_heads_list {
> -	my $limit = shift;
> +	my ($limit, @class) = @_;

Nitpick: @class or @classes.

> +	unless (defined @class) {
> +		my $remote_heads = gitweb_check_feature('remote_heads');
> +		@class = ('heads', $remote_heads ? 'remotes' : undef);

Same comment as for previous patch:

  +		@class = ('heads', $remote_heads ? 'remotes' : ());

Or alternative solution:

  +		@class = 'heads';
  +		push @class, 'remotes' if gitweb_check_feature('remote_heads');


> +	}
> +	my @refs = map { "refs/$_" } @class;

... or you would get 

  "Use of uninitialized value in concatenation (.) or string [...]"

warning when 'remote_heads" feature is disabled, isn't it?

>  	my @headslist;
>  
> -	my $remote_heads = gitweb_check_feature('remote_heads');
> -
>  	open my $fd, '-|', git_cmd(), 'for-each-ref',
>  		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
>  		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
> -		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
> +		@refs

Nitpick: it is called '<pattern>...' in git-for-each-ref manpage...

>  		or return;
>  	while (my $line = <$fd>) {
>  		my %ref_item;
> -- 
> 1.7.3.rc1.230.g8b572
> 
> 

-- 
Jakub Narebski
Poland
