From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Tue, 26 Jun 2012 15:03:07 -0700
Message-ID: <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org> <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org> <20120626212108.GR3125@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjdr6-0005UB-HO
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab2FZWDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 18:03:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab2FZWDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 18:03:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 574B89E12;
	Tue, 26 Jun 2012 18:03:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2cD3qOX5hiiBR5u+Fn2Td2IjU7k=; b=v9INke
	oR1t5/1Nx2HSdkBxfVLkongiAIb9fq8CxsmvPzzAdSd87Lcp05cmTgxfN20YubHG
	f6lTe8uZSlBDORxxQxaOjNiH68CLHLn6D9+iC71Cz8HHRqIO28TWgsYtZoVI93Pz
	s8JZYuO/w+cSoU+96JVT7zGMSg2Ky70El8AcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PyJC1HyFDRY1TktnovhUmFFofQg4JeYU
	S5C5MoyaIw46GhfS4lYwecRGiUx6CNhoDh+rrKwZZ9XRHV71CvsmxF/vpXdMRJYJ
	RJqgu1LC6gyIuSzPqAnOwmj+cDKDnf+MWyMe0M6Hy+mUmDurE3cAQSf/WA6gVZ1S
	SzB783AWA5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42CCC9E11;
	Tue, 26 Jun 2012 18:03:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF54E9E0D; Tue, 26 Jun 2012
 18:03:09 -0400 (EDT)
In-Reply-To: <20120626212108.GR3125@beczulka> (Marcin Owsiany's message of
 "Tue, 26 Jun 2012 22:21:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B75383B2-BFDA-11E1-B659-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200690>

Marcin Owsiany <marcin@owsiany.pl> writes:

> diff --git a/git-svn.perl b/git-svn.perl
> index 0b074c4..2379a71 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1612,9 +1612,9 @@ sub post_fetch_checkout {
>  		}
>  	}
>  
> -	my $valid_head = verify_ref('HEAD^0');
> +	return if verify_ref('HEAD^0');
>  	command_noisy(qw(update-ref refs/heads/master), $gs->refname);

Given that your original motivation was "I do not want master, I am
using something else for my primary branch", I change that still
shows "update-ref refs/heads/master" smells like sweeping something
under the rug (i.e. repeated "oh, running this verison still fails
here, so I'll patch it up" hackery without a solid grand design).

> -	return if ($valid_head || !verify_ref('HEAD^0'));
> +	return unless verify_ref('HEAD^0');
>  
>  	return if $ENV{GIT_DIR} !~ m#^(?:.*/)?\.git$#;
>  	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
> -- 
> 1.7.7.3
