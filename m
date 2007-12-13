From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: expand handling of From: and Signed-off-by:
Date: Thu, 13 Dec 2007 08:32:53 -0800
Message-ID: <20071213163253.GC18433@soma>
References: <20071213065815.GH30608@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qzv-0005HD-AG
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526AbXLMQcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 11:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756012AbXLMQcy
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:32:54 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59023 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990AbXLMQcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:32:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 517687DC10A;
	Thu, 13 Dec 2007 08:32:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071213065815.GH30608@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68173>

Andy Whitcroft <apw@shadowen.org> wrote:
> The current parsing for From: and Signed-off-by: lines handles fully
> specified names:
> 
> 	From: Full Name <email@address>
> 
> Expand this to include the raw email addresses and straight "names":
> 
> 	From: email@address       -> email <email@address>
> 	From: Full Name           -> Full Name <unknown>
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>

Some minor whitespace damage (which Junio can fix up), but
Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks Andy.

> ---
>  git-svn.perl |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> diff --git a/git-svn.perl b/git-svn.perl
> index 54d7844..058f8e9 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2363,11 +2363,20 @@ sub make_log_entry {
>  
>  	my ($commit_name, $commit_email) = ($name, $email);
>  	if ($_use_log_author) {
> -		if ($log_entry{log} =~ /From:\s+(.*?)\s+<(.*)>\s*\n/) {
> -			($name, $email) = ($1, $2);
> -		} elsif ($log_entry{log} =~
> -		                      /Signed-off-by:\s+(.*?)\s+<(.*)>\s*\n/) {
> +		my $name_field;
> +		if ($log_entry{log} =~ /From:\s+(.*\S)\s*\n/i) {
> +			$name_field = $1;
> +		} elsif ($log_entry{log} =~ /Signed-off-by:\s+(.*\S)\s*\n/i) {
> +			$name_field = $1;
> +		}
> +		if (!defined $name_field) {
> +			#
> +		} elsif ($name_field =~ /(.*?)\s+<(.*)>/) {
>  			($name, $email) = ($1, $2);
> +        	} elsif ($name_field =~ /(.*)@/) {
    ^ spaces before tab here

> +			($name, $email) = ($1, $name_field);
> +		} else {
> +			($name, $email) = ($name_field, 'unknown');
>  		}
>  	}
>  	if (defined $headrev && $self->use_svm_props) {

-- 
Eric Wong
