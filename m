From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default
 configuration setting.
Date: Wed, 11 Jul 2012 11:21:40 -0700
Message-ID: <7vr4siduq3.fsf@alter.siamese.dyndns.org>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
 <1342020841-24368-3-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Wed Jul 11 20:21:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp1Xo-0005aA-W5
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 20:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab2GKSVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 14:21:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877Ab2GKSVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 14:21:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAB2C5F1D;
	Wed, 11 Jul 2012 14:21:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/9selJymBStKCVyiH/Q+K/cRKBo=; b=ayQ+w/GemkY5hrlF/5IK
	6hwjxBNt37rl2/HpkcZZenou+n21SfAgAHYZYZeHMK9r/k6aBVl/of+Yyex+tNXr
	fvGQEWHSg1FOxYkOGy88tyk9VZVcT7wF5FdDypjseDe8bixAODWokY9lWK1tHoxA
	2+DEUqbAFJchpy39GxRvIgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=AA7v+MNKRIWrvE3ZRzaIJv20uM+miDh4d02Kise02U0sL0
	WQRxAsTeWBS7SvT0Cv/4YGYzrmA7HW2ME/u6xyzxWRKxsnG3hE42pIO3GwuXWxP3
	Gzr4tZUdDNpVmq98mHdTIOYoKiXRrDcjTLJzPNiSCA7dvNt0ocvhMfIOtc5S8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A15B45F1C;
	Wed, 11 Jul 2012 14:21:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1248A5F1A; Wed, 11 Jul 2012
 14:21:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 437856D2-CB85-11E1-9CB4-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201321>

marcnarc@xiplink.com writes:

> From: Marc Branchaud <marcnarc@xiplink.com>
>
> The code now has a default_remote_name and an effective_remote_name:
>
>  - default_remote_name is set by remote.default in the config, or is "origin"
>    if remote.default doesn't exist ("origin" was the fallback value before
>    this change).
>
>  - effective_remote_name is the name of the remote tracked by the current
>    branch, or is default_remote_name if the current branch doesn't have a
>    remote.
>
> This has a minor side effect on the default behavior of "git push".  Consider
> the following sequence of commands:
>
>       git config remote.default foo                 # Set default remote
>       git checkout somelocalbranch                  # Does not track a remote
>       git remote add origin ssh://example.com/repo  # Add a new "origin"
>       git push
>
> Prior to this change, the above "git push" would attempt to push to the new
> "origin" repository at ssh://example.com/repo.  Now instead that "git push"
> will attempt to push to the repository named "foo".

Hrm, is this a _minor_ side effect?

Isn't that a natural and direct consequence of "now you can set
remote.default configuration to name the remote you want to use in
place of traditional 'origin'" feature?  I think changing the
behaviour of "git push" in such a way is the point (may not be the
only but one of the important points) of this series.

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index cb97cc1..fc17d39 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -27,10 +27,16 @@ documentation for linkgit:git-receive-pack[1].
>  OPTIONS[[OPTIONS]]
>  ------------------
>  <repository>::
> -	The "remote" repository that is destination of a push
> +	The "remote" repository that is the destination of the push
>  	operation.  This parameter can be either a URL
>  	(see the section <<URLS,GIT URLS>> below) or the name
>  	of a remote (see the section <<REMOTES,REMOTES>> below).
> +	If this parameter is omitted, git tries to use the remote
> +	associated with the currently checked-out branch.  If there
> +	is no remote associated with the current branch, git uses
> +	the remote named by the "remote.default" configuration variable.
> +	If "remote.default" is not set, git uses the name "origin" even
> +	if there is no actual remote named "origin".

This comment applies to other changes to the documentation in this
patch I didn't quote, but I think the phrasing 'even if there is no
acutual remote named "origin"' needs to be rethought, because "we
use it even if there is no such remote determined with this logic"
applies equally to branch.$name.remote, remote.default or built-in
default value of remote.default which happens to be "origin".

> diff --git a/remote.c b/remote.c
> index 6f371e0..2ebdbbd 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -47,6 +47,7 @@ static int branches_alloc;
>  static int branches_nr;
>  
>  static struct branch *current_branch;
> +static const char *default_remote_name;
>  static const char *effective_remote_name;

Coming from UNIX background, "effective" gives me an impression that
it is contrasted with "real" (i.e. there is "real remote" for the
branch, but during this particular invocation it is overridden and
"effective remote" is used instead).  Perhaps it is just me.

Something along the line of remote-name-to-use, use-remote, might
sound more natural.
