From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-submodule: add "sync" command
Date: Fri, 22 Aug 2008 16:13:17 -0700
Message-ID: <7vhc9c63ua.fsf@gitster.siamese.dyndns.org>
References: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
 <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
 <e1d3f1871f869a0161fb3f0d84777de9e0125023.1219390139.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfpu-00008U-IK
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbYHVXN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbYHVXN1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:13:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbYHVXN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:13:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 093FB69D45;
	Fri, 22 Aug 2008 19:13:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4EB8F69D44; Fri, 22 Aug 2008 19:13:23 -0400 (EDT)
In-Reply-To: <e1d3f1871f869a0161fb3f0d84777de9e0125023.1219390139.git.davvid@gmail.com>
 (David Aguilar's message of "Fri, 22 Aug 2008 00:30:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC75F96E-709F-11DD-9EE5-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93396>

David Aguilar <davvid@gmail.com> writes:

> When a submodule's URL changes upstream, existing submodules
> will be out of sync since their remote.origin.url will still
> be set to the old value.

Ok.

> +#
> +# Sync git urls for submodules
> +# This makes the value for remote.origin.url match the value
> +# specified in .gitmodules.
> +#
> +cmd_sync()
> +{
> +	while test $# -ne 0
> +	do
> +		case "$1" in
> +		-q|--quiet)
> +			quiet=1
> +			;;
> +		-*)
> +			usage
> +			;;
> +		--)
> +			shift
> +			break
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +
> +	cd_to_toplevel
> +
> +	module_list "$@" |
> +	while read mode sha1 stage path
> +	do
> +		! test -f "$path"/.git/config &&
> +		echo "Warn: submodule at path '$path' does not exist."
> +		test -f "$path"/.git/config || continue
> +		name=$(module_name "$path")
> +		url=$(git config -f .gitmodules --get submodule."$name".url)
> +		say "Synchronizing submodule url for '$name'"
> +		git config -f "$path"/.git/config remote.origin.url "$url"
> +	done
> +}

Hmm.  I do not quite like this.

We allow using a gitfile for submodule $GIT_DIR; checking for file
existence of "$path/.git/config" does not work for such a configuration.

Neither does 'git config -f "$path/.git/config"' work.  I think it should
be more like:

    ( unset GIT_DIR; cd "$path" && git config remote.origin.url "$url" )

It is a norm not to have any interest in a submodule that appears in the
index of a superproject.  You shouldn't get as many warnings as you have
submodules in such a repository.  You should just skip them (which you
already do, but see above), or at least honor "$quiet".

I also think the warning should be sent to the standard error stream.
