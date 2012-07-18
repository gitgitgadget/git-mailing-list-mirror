From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Wed, 18 Jul 2012 13:32:26 -0700
Message-ID: <7vliigx12d.fsf@alter.siamese.dyndns.org>
References: <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org> <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org> <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka> <7v8vesk12v.fsf@alter.siamese.dyndns.org>
 <20120711012617.GA18369@dcvr.yhbt.net> <20120711214019.GF30213@beczulka>
 <7vmx35dhzo.fsf@alter.siamese.dyndns.org> <20120718074908.GA23460@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Wed Jul 18 22:32:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SravM-0003PG-IW
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 22:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab2GRUcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 16:32:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072Ab2GRUc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 16:32:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D3A86B3;
	Wed, 18 Jul 2012 16:32:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NGgopb0dNIggZKkaFzRfsS/DRxs=; b=BrTnMs
	BHtxh/x2MEBDVVXY428BrLHJ4SjkCUFdtpl4zGNoUQsDb6CHI0V2VQc8ij8Gi1jf
	3pPsdteklJ+lKu31RKYcbmGyaYqwnQCYQ+S9BLg/pALTh97nTnWUTAQxfsgQlf5N
	bl5l/LfQB0olJXbGjvSn8+K1pvg3UnZujqcAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HCdWj/xhBR5SJml2oSW1fJ5tForFVvAa
	YqFZPVCuf5TRW96nzyqNSdbnUJjfCYOCFeUX6vRK092dCRRMqjUA2WFlHZIV6Dy/
	Yebbrl7/PUtgs+o/xfiQ2oav2Ofh2hvxVbaKeFzCbm3EAni8RZhZVws9G4WyciKy
	y6Isw3HWIqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8021F86B2;
	Wed, 18 Jul 2012 16:32:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B306386AE; Wed, 18 Jul 2012
 16:32:27 -0400 (EDT)
In-Reply-To: <20120718074908.GA23460@beczulka> (Marcin Owsiany's message of
 "Wed, 18 Jul 2012 08:49:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0BC5C24-D117-11E1-81D3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201696>

Marcin Owsiany <marcin@owsiany.pl> writes:

> PTAL:
>
> From: Marcin Owsiany <marcin@owsiany.pl>
> Date: Sun, 24 Jun 2012 22:40:05 +0100
> Subject: [PATCH] git-svn: don't create master if another head exists
>
> git-svn insists on creating the "master" head (unless it exists) on every
> "fetch". It is useful that it gets created initially, when no head exists
> - users expect this git convention of having a "master" branch on initial
> clone.
>
> However creating it when there already is another head does not provide any
> value - the ref is never updated, so it just gets stale after a while.  Also,
> some users find it annoying that it gets recreated, especially when they would
> like the git branch names to follow SVN repository branch names. More
> background in http://thread.gmane.org/gmane.comp.version-control.git/115030
>
> Make git-svn skip the "master" creation if HEAD already points at a valid head.
> This means "master" does get created on initial "clone" but does not get
> recreated once a user deletes it.
>
> Also, make post_fetch_checkout work with any head that is pointed to by HEAD,
> not just "master".
>
> Also, use fatal error handling consistent with the rest of the program for
> post_fetch_checkout.
>
> Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
> ---
>  git-svn.perl |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 0b074c4..6673d21 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -367,9 +367,9 @@ Git::SVN::init_vars();
>  eval {
>  	Git::SVN::verify_remotes_sanity();
>  	$cmd{$cmd}->[0]->(@ARGV);
> +	post_fetch_checkout();
>  };
>  fatal $@ if $@;
> -post_fetch_checkout();
>  exit 0;
>  
>  ####################### primary functions ######################
> @@ -1598,8 +1598,8 @@ sub rebase_cmd {
>  
>  sub post_fetch_checkout {
>  	return if $_no_checkout;
> +	return if verify_ref('HEAD^0');
>  	my $gs = $Git::SVN::_head or return;
> -	return if verify_ref('refs/heads/master^0');
>  
>  	# look for "trunk" ref if it exists
>  	my $remote = Git::SVN::read_all_remotes()->{$gs->{repo_id}};
> @@ -1612,9 +1612,8 @@ sub post_fetch_checkout {
>  		}
>  	}
>  
> -	my $valid_head = verify_ref('HEAD^0');
> -	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
> -	return if ($valid_head || !verify_ref('HEAD^0'));
> +	command_noisy(qw(update-ref HEAD), $gs->refname);
> +	return unless verify_ref('HEAD^0');
>  
>  	return if $ENV{GIT_DIR} !~ m#^(?:.*/)?\.git$#;
>  	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";

I am happy with this version, as long as Eric is happy ;-)

Thanks.
