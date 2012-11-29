From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-mediawiki: escape double quotes and LF in
 file names
Date: Thu, 29 Nov 2012 08:25:14 -0800
Message-ID: <7vy5hkqsut.fsf@alter.siamese.dyndns.org>
References: <1354192413-9959-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:25:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te6vf-0007ax-Aj
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 17:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab2K2QZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 11:25:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab2K2QZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 11:25:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5479CAA3B;
	Thu, 29 Nov 2012 11:25:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XZd6WHPZ4MT0gtLuxD/ltM0tSZ4=; b=hJIXg3
	etcHr+UZ83eU7guLsQ9DXyE0p4dHoKWYaHWNERadY9FiJVB/TfWlJdk6PX0wPOnT
	QeoqWSb3ezg94rk+2vzJb6pLBOsK5vCmY7kYKJxFGQhWMY6d/cRlhQioiLRA+ZkJ
	rbaqSLtcq70WS42VxJOA67tGiyG+sc7A3G5so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=frqYG9hPMXusXvO92/eNa7uS9OMOZ68W
	Q6Cl7M+JQH2s7MO0hNyilLzQuRpNNS+hnCM6eYY125fv+Uues045ZWGEDRTTaIOb
	UVWiert/yojDxStKg/N4qwS7xsI2cWtYHeRaZOpWjktGkqP74ZHLcCBavcswAWYl
	XZ9Lod94Fjc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C729AA39;
	Thu, 29 Nov 2012 11:25:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9142DAA2C; Thu, 29 Nov 2012
 11:25:15 -0500 (EST)
In-Reply-To: <1354192413-9959-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu, 29 Nov 2012 13:33:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B7234F8-3A41-11E2-B82E-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210842>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> A mediawiki page can contain, and even start with a " character, we have
> to escape it when generating the fast-export stream. While we're there,
> also escape newlines, but I don't think we can get them from MediaWiki
> pages.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
> index 68555d4..e7a0e7b 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -711,6 +711,13 @@ sub fetch_mw_revisions {
>  	return ($n, @revisions);
>  }
>  
> +sub fe_escape_path {
> +    my $path = shift;
> +    $path =~ s/"/\\"/g;
> +    $path =~ s/\n/\\n/g;
> +    return $path;
> +}

Is this sufficient?

My reading of the big comment at the beginning of fast-import.c is
that you would also want to quote each backslash; otherwise a
character (or an octal) after it will be taken as a C-style quoted
special letter, no?

>  sub import_file_revision {
>  	my $commit = shift;
>  	my %commit = %{$commit};
> @@ -738,15 +745,17 @@ sub import_file_revision {
>  		print STDOUT "from refs/mediawiki/$remotename/master^0\n";
>  	}
>  	if ($content ne DELETED_CONTENT) {
> -		print STDOUT "M 644 inline $title.mw\n";
> +		print STDOUT "M 644 inline " .
> +		    fe_escape_path($title . ".mw") . "\n";
>  		literal_data($content);
>  		if (%mediafile) {
> -			print STDOUT "M 644 inline $mediafile{title}\n";
> +			print STDOUT "M 644 inline "
> +			    . fe_escape_path($mediafile{title}) . "\n";
>  			literal_data_raw($mediafile{content});
>  		}
>  		print STDOUT "\n\n";
>  	} else {
> -		print STDOUT "D $title.mw\n";
> +		print STDOUT "D " . fe_escape_path($title . ".mw") . "\n";
>  	}
>  
>  	# mediawiki revision number in the git note
