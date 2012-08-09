From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: URL-decode $my_url/$my_uri when stripping
 PATH_INFO
Date: Thu, 09 Aug 2012 08:38:53 -0700
Message-ID: <7vr4rgoz1u.fsf@alter.siamese.dyndns.org>
References: <1344479366-8957-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 17:39:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzUpC-0004SV-O2
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 17:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031107Ab2HIPi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 11:38:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030774Ab2HIPi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 11:38:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47CCC54FF;
	Thu,  9 Aug 2012 11:38:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qmy89InVN2SbZnDGUiauLrx/gmI=; b=s/Y3zu
	83HE2DItjRS4N/iDNIG+W911ahZoiGpsjuigxRhAqZ8V39xW5XWTAYKTxgPCRk7N
	vzok1td/L2MZQZ8Buae3Q205KdOxj/21X+DY1UBnRChzLOXFhpqQuOUb/em9xmH6
	lu6wKoCWSTeGnrFzr4766PQzFmODo0MfRIaJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DktHxdvYmIbzfV4u5ku3FTEBdngU1Rpf
	MfEQBgcmJS4oNEIUqSE2hJiuc36Kj8x0eYDr5tfn5K4kK+DDtpQx42wxzEjNSePl
	BJ3cjgiQKFHWX4issNAymxpnWGmrJzGAmgErHPxfFkG8xjh8g5prbmtDfbU25KmL
	OXQ4zZEiTeg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3526754FD;
	Thu,  9 Aug 2012 11:38:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9007A54FC; Thu,  9 Aug 2012
 11:38:54 -0400 (EDT)
In-Reply-To: <1344479366-8957-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed, 8 Aug 2012 22:29:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53926674-E238-11E1-BD99-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203158>

Jay Soffian <jaysoffian@gmail.com> writes:

> When gitweb is used as a DirectoryIndex, it attempts to strip
> PATH_INFO on its own, as $cgi->url() fails to do so.
>
> However, it fails to account for the fact that PATH_INFO has
> already been URL-decoded by the web server, but the value
> returned by $cgi->url() has not been. This causes the stripping
> to fail whenever the URL contains encoded characters.
>
> To see this in action, setup gitweb as a DirectoryIndex and
> then use it on a repository with a directory containing a
> space in the name. Navigate to tree view, examine the gitweb
> generated html and you'll see a link such as:
>
>   <a href="/test.git/tree/HEAD:/directory with spaces">directory with spaces</a>
>
> When clicked on, the browser will URL-encode this link, giving
> a $cgi->url() of the form:
>
>    /test.git/tree/HEAD:/directory%20with%20spaces
>
> While PATH_INFO is:
>
>    /test.git/tree/HEAD:/directory with spaces
>
> Fix this by calling unescape() on both $my_url and $my_uri before
> stripping PATH_INFO from them.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---

Thanks.  From a cursory look, with the help from the explanation in
the proposed commit log message, the change looks sensible.

I wonder if a breakage like this is something we can catch in one of
the t95xx series of tests, though.

Jakub, Ack?

>  gitweb/gitweb.perl | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3d6a705388..7f8c1878d4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -54,6 +54,11 @@ sub evaluate_uri {
>  	# to build the base URL ourselves:
>  	our $path_info = decode_utf8($ENV{"PATH_INFO"});
>  	if ($path_info) {
> +		# $path_info has already been URL-decoded by the web server, but
> +		# $my_url and $my_uri have not. URL-decode them so we can properly
> +		# strip $path_info.
> +		$my_url = unescape($my_url);
> +		$my_uri = unescape($my_uri);
>  		if ($my_url =~ s,\Q$path_info\E$,, &&
>  		    $my_uri =~ s,\Q$path_info\E$,, &&
>  		    defined $ENV{'SCRIPT_NAME'}) {
