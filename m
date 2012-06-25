From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Sun, 24 Jun 2012 22:44:57 -0700
Message-ID: <7v8vfchrmu.fsf@alter.siamese.dyndns.org>
References: <20120624220835.GA4762@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:45:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj26l-0005gO-87
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 07:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab2FYFpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 01:45:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310Ab2FYFo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 01:44:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 940D93F93;
	Mon, 25 Jun 2012 01:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iW0/IDiAWEWSArWK+tW0LABU0js=; b=poU0PB
	fDGWQjUdmltBDTeuFaNtAQTG2a96ikz5AwTd/RaeY2FYRq3y2odzgbi6fo3qDfXH
	U/t8urGiDMM7A3IpG8Ik4vhebSdxOZK/F3ii6nBBoxGqEqSkPLw6brkwE9SknMJL
	0bHY/0JDKOeYxj1kFYlG76uIre/fuZMMNSYzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KH7YqDA8h0EoxmkMQhRD/oF4LnNGyGjG
	IHUMmywgMTVFm6dbT5ACiNCkF5759HQ391U2HQ1QEtfnrYkoH8pS4q27pvizU8kh
	GB1iruZGOE4tLStDBeMVPI/5LAIEE7HJUnWZwjGEPHeMC/z0/JloFrGZEq8jp/RH
	s3ji4HTEUrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FE73F92;
	Mon, 25 Jun 2012 01:44:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AB443F91; Mon, 25 Jun 2012
 01:44:59 -0400 (EDT)
In-Reply-To: <20120624220835.GA4762@beczulka> (Marcin Owsiany's message of
 "Sun, 24 Jun 2012 23:08:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6955AEA-BE88-11E1-8720-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200547>

Marcin Owsiany <marcin@owsiany.pl> writes:

> git-svn insists on creating the "master" head (unless it exists) on every
> "fetch". While it is useful that it gets created initially (users expect this
> git convention), some users find it annoying that it gets recreated, especially
> when they would like the git branch names to follow SVN repository branch
> names. More background in
> http://thread.gmane.org/gmane.comp.version-control.git/115030
>
> Make git-svn skip the "master" creation if there is another head ref pointing
> to the same place. This means "master" does get created on initial "clone" but
> does not get recreated once a user deletes it.
>
> Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
> ---
>  git-svn.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 0b074c4..90f3d06 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1613,6 +1613,8 @@ sub post_fetch_checkout {
>  	}
>  
>  	my $valid_head = verify_ref('HEAD^0');
> +	my @heads_commits = eval { command(qw(show-ref --heads --hash)) };
> +	return if $valid_head and grep { $_ eq $valid_head } @heads_commits;

This is strange.  Much earlier in the code there is this use of
master.

    sub post_fetch_checkout {
            return if $_no_checkout;
            my $gs = $Git::SVN::_head or return;
            return if verify_ref('refs/heads/master^0');

If your goal is to get rid of "master" (because you have a different
branch that serves the role of the primary branch), shouldn't this
code be killed?  Otherwise, if you have a stray "master" that you
are not even using, you would end up skipping checkout for your true
primary branch, no?
