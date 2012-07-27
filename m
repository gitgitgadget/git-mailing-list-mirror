From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Prepare Git::SVN for extraction into its own file.
Date: Thu, 26 Jul 2012 22:18:01 -0700
Message-ID: <7vvch93hpy.fsf@alter.siamese.dyndns.org>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-3-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SucwW-0002gQ-LZ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 07:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab2G0FSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 01:18:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab2G0FSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 01:18:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7A1A67ED;
	Fri, 27 Jul 2012 01:18:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=B28+qcQksdpCn0YiWq7MrtSdPM4=; b=Hn02QUcGwmhcrIyVsKq3
	Q08wFTbX7rqu67U51kn9P6Z741Jhcs9/H1iM3X6VZM8qgaIk5zsUhnJk+CaesHh3
	F2k54/dABf5uxUidtrw1W8rs3UsDTFh/lchIqYZanPdmhq+8EgvZSEWXAqLd8RYU
	XeQ8DrUUrzFlMQ21Jq40f5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XPUR2w8yidJRaD4BG4yBlX1BfuNPUwPYEW09ipkrcQYZSi
	PsTjR4PlRlt+6JtO3XtJjVPXUTPTe7zfcKz73G5zTp6sbJ+bkgMUUdJEaXosimAT
	0z95LQ5IaAq5EQu8d2mR/oFcvW+U9LaaYjR/LxbK/r0EWOxnbH6H7KtPvyIfs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93F7F67EC;
	Fri, 27 Jul 2012 01:18:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5DBA67EB; Fri, 27 Jul 2012
 01:18:02 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 707D8126-D7AA-11E1-9B3E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202333>

"Michael G. Schwern" <schwern@pobox.com> writes:

> From: "Michael G. Schwern" <schwern@pobox.com>
>
> This means it should be able to load without git-svn being loaded.
>
> * Load Git.pm on its own and all the needed command functions.
>
> * It needs to grab at a git-svn lexical $_prefix representing the --prefix
>   option.  Provide opt_prefix() for that.  This is a refactoring artifact.
>   The prefix should really be passed into Git::SVN->new.

I agree that the prefix is part of SVN->new arguments in the final
state after applying the whole series (not just these four but also
with the follow-up patches).

> * Unqualify unnecessarily fully qualified globals like
>   $Git::SVN::default_repo_id.
>
> * Lexically isolate the class just to make sure nothing is leaking out.
> ---

Forgot to sign-off, or are you still unsure about this step?

> diff --git a/git-svn.perl b/git-svn.perl
> index 79fe4a4..9cdf6fc 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -109,6 +109,10 @@ my ($_stdin, $_help, $_edit,
>  	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_local,
>  	$_prefix, $_no_checkout, $_url, $_verbose,
>  	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
> +
> +# This is a refactoring artifact so Git::SVN can get at this git-svn switch.
> +sub opt_prefix { return $_prefix || '' }
> +
>  $Git::SVN::_follow_parent = 1;
>  $Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
>  $_q ||= 0;
> @@ -4280,12 +4292,13 @@ sub find_rev_after {
>  sub _new {
>  	my ($class, $repo_id, $ref_id, $path) = @_;
>  	unless (defined $repo_id && length $repo_id) {
> -		$repo_id = $Git::SVN::default_repo_id;
> +		$repo_id = $default_repo_id;
>  	}
>  	unless (defined $ref_id && length $ref_id) {
> -		$_prefix = '' unless defined($_prefix);
> +		# Access the prefix option from the git-svn main program if it's loaded.
> +		my $prefix = defined &::opt_prefix ? ::opt_prefix() : "";

Again, I agree with you that passing $prefix as one of the arguments
to ->new is the right thing to do in the final state after applying
the whole series.  I don't know if later steps in your patch series
will do so, but it _might_ make more sense to update ->new and its
callers to do so without doing anything else first, so that you do
not have to call out to the ::opt_prefix() when you split things
out.
