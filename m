From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (for maint)] gitweb: Fix fixed string (non-regexp)
 project search
Date: Sun, 04 Mar 2012 21:16:09 -0800
Message-ID: <7vfwdn631i.fsf@alter.siamese.dyndns.org>
References: <20120228183919.26435.86795.stgit@localhost.localdomain>
 <7vwr72a6m6.fsf@alter.siamese.dyndns.org>
 <201203031156.00948.jnareb@gmail.com> <201203041035.03133.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 06:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4QHR-00072p-6J
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 06:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab2CEFQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 00:16:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab2CEFQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 00:16:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC99D7A7F;
	Mon,  5 Mar 2012 00:16:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sAJNFyy5V/X3oNBGflGmbK93zkQ=; b=MTLhp5
	e+EN6aOkS17duMnPz3OTi5p+8ixUwk8qjWwT733VuizlzgE1ALPCMq5cpTetNQ3P
	8qzkM7ogj2rj+3WNs1SvwXh+VlmgqGJVL/NDqqoITwHuYq9liujvb1oGqdOGGaV4
	w1WuwEj0IC3c0Hwh0WE5Jy9qqo2d9uO3nzeRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sCTjCEAPIJmMtUcrHIVOVU22OTcT+m0u
	TWI9sQ5In8G/O+FaZELh0DYgufpBjRT7ZhXApmoNC7qxy4IPw4iJPuuDHAKAbWnJ
	f71fMMhaLZBgXK7e7CzE0uGINatdgugWuPcbPNKh938gZUsh5O4ZR+o5oDv5YfVM
	SnBA8d/Dz6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1BE77A7E;
	Mon,  5 Mar 2012 00:16:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77AF97A7D; Mon,  5 Mar 2012
 00:16:10 -0500 (EST)
In-Reply-To: <201203041035.03133.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 4 Mar 2012 10:35:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51FAFE84-6682-11E1-B505-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192206>

Jakub Narebski <jnareb@gmail.com> writes:

> And here is the patch for maint
> -->8-- -------------------------------------------------------- -->8--
> Subject: gitweb: Fix fixed string (non-regexp) project search
>
> Use $search_regexp, where regex metacharacters are quoted, for
> searching projects list, rather than $searchtext, which contains
> original search term.
>
> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |   20 +++++++++++---------
>  1 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d5dbd64..e248792 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5290,9 +5290,11 @@ sub git_project_list_body {
>  	@projects = fill_project_list_info(\@projects);
>  	# searching projects require filling to be run before it
>  	@projects = search_projects_list(\@projects,
> -	                                 'searchtext' => $searchtext,
> -	                                 'tagfilter'  => $tagfilter)
> -		if ($tagfilter || $searchtext);
> +	                                 'search_regexp' => $search_regexp,
> +	                                 'tagfilter' => $tagfilter)
> +		if ($tagfilter || $search_regexp);
> +	# fill the rest
> +	@projects = fill_project_list_info(\@projects);

Hmph, didn't you already call fill_project_list_info(\@projects) before
search_projects_list() already?
