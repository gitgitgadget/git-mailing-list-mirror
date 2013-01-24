From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Wed, 23 Jan 2013 21:29:01 -0800
Message-ID: <7vehhbdu8y.fsf@alter.siamese.dyndns.org>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
 <20130123023235.GA24135@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Barry Wardell <barry.wardell@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 06:29:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyFNT-0008T6-G3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 06:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab3AXF3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 00:29:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab3AXF3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 00:29:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55386CE1C;
	Thu, 24 Jan 2013 00:29:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pAEZcs+soB+zljE5ShyFK2M+7DM=; b=KdbBS/
	Z/gFiYl8BdhH+snyLue45CeTwZ69QJimMVWHCrMsJI3s9aVS5PfKVjTGSGguz9ph
	A+PDyee+I8zW0oJ2oblM7Z/SFZPua+9caqrcRcQGbeC+TTNLxmcL3eCDt8ZB12OT
	Swv3ThNDm36it9aijkhOWxaz9e2UFD9ipll3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H4JjWKxPEaqXSa0Ka839FimYA6PrErHS
	PMNYPYWfPHOv+WLtjl9oDdX+K5O7zsNeJ3qn3KdEDazzz/sh36iphQYWldwXt+ph
	wSD8ysFhPa0wkLJTJMxh61YF3fDUBR/figpiQSZpEmRZ1kbXWCwRP/L09T1xtJCQ
	V1zeodt2CUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A486CE1B;
	Thu, 24 Jan 2013 00:29:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94C3ECE19; Thu, 24 Jan 2013
 00:29:03 -0500 (EST)
In-Reply-To: <20130123023235.GA24135@dcvr.yhbt.net> (Eric Wong's message of
 "Wed, 23 Jan 2013 02:32:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F70BE794-65E6-11E2-AAD1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214393>

Eric Wong <normalperson@yhbt.net> writes:

> diff --git a/git-svn.perl b/git-svn.perl
> index c232798..e5bd292 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -332,11 +332,13 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
>  		$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
>  	} "Unable to find .git directory\n";
>  	my $cdup = undef;
> +	my $git_dir = delete $ENV{GIT_DIR};
>  	git_cmd_try {
>  		$cdup = command_oneline(qw/rev-parse --show-cdup/);
>  		chomp $cdup if ($cdup);
>  		$cdup = "." unless ($cdup && length $cdup);
> -	} "Already at toplevel, but $ENV{GIT_DIR} not found\n";
> +	} "Already at toplevel, but $git_dir not found\n";
> +	$ENV{GIT_DIR} = $git_dir;
>  	chdir $cdup or die "Unable to chdir up to '$cdup'\n";
>  	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
>  }

This does not look quite right, though.

Can't the user have his own $GIT_DIR when this command is invoked?
The first command_oneline() runs rev-parse with that environment and
get the user specified value of GIT_DIR in $ENV{GIT_DIR}, but by
doing a "delete" before running --show-cdup, you are not honoring
that GIT_DIR (and GIT_WORK_TREE if exists) the user gave you.  You
already used that GIT_DIR when you asked rev-parse --git-dir to find
what the GIT_DIR value should be, so you would be operating with
values of $git_dir and $cdup that you discovered in an inconsistent
way, no?

Shouldn't it be more like this instead?

	my ($git_dir, $cdup) = undef;
        try {
		$git_dir = command_oneline(qw(rev-parse --git-dir));
	} "Unable to ...";
        try {
		$cdup = command_oneline(qw(rev-parse --show-cdup));
		... tweak $cdup ...
	} "Unable to ...";
	if (defined $git_dir) { $ENV{GIT_DIR} = $git_dir; }
	chdir $cdup;
