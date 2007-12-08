From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Calculate $commitsha1 in update() only when needed
Date: Sat, 08 Dec 2007 00:17:56 -0800
Message-ID: <7vtzmtwqff.fsf@gitster.siamese.dyndns.org>
References: <20071208050745.29462.74137.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0utK-0008Qx-5Z
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbXLHISJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbXLHISI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:18:08 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:60770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbXLHISH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:18:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BA441425D;
	Sat,  8 Dec 2007 03:18:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CF304425C;
	Sat,  8 Dec 2007 03:17:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67526>

Pavel Roskin <proski@gnu.org> writes:

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index ecded3b..409b301 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -2427,9 +2427,6 @@ sub update
>      # first lets get the commit list
>      $ENV{GIT_DIR} = $self->{git_path};
>  
> -    my $commitsha1 = `git rev-parse $self->{module}`;
> -    chomp $commitsha1;
> -
>      my $commitinfo = `git cat-file commit $self->{module} 2>&1`;
>      unless ( $commitinfo =~ /tree\s+[a-zA-Z0-9]{40}/ )
>      {

Hmm.  The first rev-parse could be squelched with 2>/dev/null and then
you can check if it does not match [a-f0-9]{40} and die early before
running "cat-file commit", can't you?

Also the regexp to check "tree" object name above seems quite wrong ;-)
If the purpose of this check is to make sure if the ref points at a
commit object, perhaps...

	my $commitsha1 = `git rev-parse --verify $self->{module}^0 2>&1`;
	chomp($commitsha1);
        if ($commitsha1 !~ /^[0-9a-f]{40}$/) {
        	die "no such module $self->{module}";
	}

Then the other hunk below would become unnecessary, I think.

> @@ -2440,8 +2437,13 @@ sub update
>      my $git_log;
>      my $lastcommit = $self->_get_prop("last_commit");
>  
> -    if (defined $lastcommit && $lastcommit eq $commitsha1) { # up-to-date
> -         return 1;
> +    if (defined $lastcommit) {
> +        my $commitsha1 = `git rev-parse $self->{module}`;
> +        chomp $commitsha1;
> +
> +        if ($lastcommit eq $commitsha1) { # up-to-date
> +            return 1;
> +        }
>      }
>  
>      # Start exclusive lock here...
