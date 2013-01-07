From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: treat field names as case-independent
Date: Sun, 06 Jan 2013 19:27:46 -0800
Message-ID: <7va9sllljh.fsf@alter.siamese.dyndns.org>
References: <1357522498-8086-1-git-send-email-nickolai@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 07 04:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts3Nh-0007wQ-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 04:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab3AGD1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 22:27:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3AGD1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 22:27:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BF22A2C5;
	Sun,  6 Jan 2013 22:27:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KDUh3fuyuDPr5QwLcaxcMgVJZ68=; b=DyYfFn
	WJBpEE2lWRSzvs5dWMCK2l3EltLzjVw9mRGjsgrKSfouBmcO4+K7mhpPULeeXgmy
	o0D+JE2fy4XwFHVkv/XhcC8LrhZViEXwtugDdWXJOAB+CSMZ+1OyAkUum8TnVLk9
	XWh4OhogP83sVZf6kVkt+2+gwcaT+CggBzVI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cxng6SMsJXNXNvZsJhNZHRartFEyICku
	zAQW2tzK8X1ArPTmfgjs3l+faMsn3B3nWy0OodMhlmhMa9sPcEbtonaBu5R3AHa9
	VWy1rjwpDBJEe7zK5t5zVKokInDjX4k6rrv+zmoFbYdCyAXHYdQbH+9fjT0AIQmD
	qMIe6V2QGB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E826A2C4;
	Sun,  6 Jan 2013 22:27:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5F18A2C2; Sun,  6 Jan 2013
 22:27:47 -0500 (EST)
In-Reply-To: <1357522498-8086-1-git-send-email-nickolai@csail.mit.edu>
 (Nickolai Zeldovich's message of "Sun, 6 Jan 2013 20:34:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 354F5272-587A-11E2-BC55-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212871>

Nickolai Zeldovich <nickolai@csail.mit.edu> writes:

> Field names like To:, Cc:, etc should be treated as case-independent;
> use a case-insensitive regexp to match them as such.  Previously,
> git-send-email would send email messages with a lowercase "cc:" line in
> the body without actually sending a copy of the message to that address.
>
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> ---

While I think this patch is a sensible thing to do, I at the same
time wonder who is writing "cc:" in the lowercase in the first
place, and if that is one of our tools, we should fix that part as
well.  Such a header would leak out to the payload given to the
underlying sendmail, doesn't it?

Leaking such lowercased headers of course is not a crime (the
headers are case insensitive), but they look ugly.

>  git-send-email.perl |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 94c7f76..be809e5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1285,10 +1285,10 @@ foreach my $t (@files) {
>  		}
>  
>  		if (defined $input_format && $input_format eq 'mbox') {
> -			if (/^Subject:\s+(.*)$/) {
> +			if (/^Subject:\s+(.*)$/i) {
>  				$subject = $1;
>  			}
> -			elsif (/^From:\s+(.*)$/) {
> +			elsif (/^From:\s+(.*)$/i) {
>  				($author, $author_encoding) = unquote_rfc2047($1);
>  				next if $suppress_cc{'author'};
>  				next if $suppress_cc{'self'} and $author eq $sender;
> @@ -1296,14 +1296,14 @@ foreach my $t (@files) {
>  					$1, $_) unless $quiet;
>  				push @cc, $1;
>  			}
> -			elsif (/^To:\s+(.*)$/) {
> +			elsif (/^To:\s+(.*)$/i) {
>  				foreach my $addr (parse_address_line($1)) {
>  					printf("(mbox) Adding to: %s from line '%s'\n",
>  						$addr, $_) unless $quiet;
>  					push @to, $addr;
>  				}
>  			}
> -			elsif (/^Cc:\s+(.*)$/) {
> +			elsif (/^Cc:\s+(.*)$/i) {
>  				foreach my $addr (parse_address_line($1)) {
>  					if (unquote_rfc2047($addr) eq $sender) {
>  						next if ($suppress_cc{'self'});
> @@ -1325,7 +1325,7 @@ foreach my $t (@files) {
>  			elsif (/^Message-Id: (.*)/i) {
>  				$message_id = $1;
>  			}
> -			elsif (!/^Date:\s/ && /^[-A-Za-z]+:\s+\S/) {
> +			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
>  				push @xh, $_;
>  			}
