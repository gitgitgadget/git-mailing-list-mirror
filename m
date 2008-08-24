From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-submodule: add "sync" command
Date: Sun, 24 Aug 2008 11:57:31 -0700
Message-ID: <7vwsi6meas.fsf@gitster.siamese.dyndns.org>
References: <1219598500-8334-1-git-send-email-davvid@gmail.com>
 <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
 <341166c1e31ba26c4e8e48cd7cf9ce12a9f745b9.1219598198.git.davvid@gmail.com>
 <23327a679798d19dc52a27c55a58c5b8c9ebe945.1219598198.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mlevedahl@gmail.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 20:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXKnS-0003IL-Bk
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 20:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYHXS5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbYHXS5j
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:57:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYHXS5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:57:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C2FB6DAD2;
	Sun, 24 Aug 2008 14:57:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C3EA06DAD1; Sun, 24 Aug 2008 14:57:33 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 84D9DB84-720E-11DD-998B-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93548>

David Aguilar <davvid@gmail.com> writes:

> +#
> +# Sync remote urls for submodules
> +# This makes the value for remote.$remote.url match the value
> +# specified in .gitmodules.
> +#
> +cmd_sync()
> +{
> +...
> +	cd_to_toplevel
> +	toplevel="$PWD"

I do not think you need $toplevel, as you cd around inside a subshell.

> +	module_list "$@" |
> +	while read mode sha1 stage path
> +	do
> +		name=$(module_name "$path")
> +		url=$(git config -f .gitmodules --get submodule."$name".url)
> +		if test -d "$path"; then

I think this test is wrong.

Compare it with how cmd_foreach does this.  The difference is that you
force "sync" to every submodule that could be cloned and checked out,
while "foreach" skips submodules the user has not expressed any interest
in touching.

> +		(
> +			unset GIT_DIR
> +			cd "$path"
> +			remote=$(get_remote)
> +			say "Synchronizing submodule url for '$name'"
> +			git config remote."$remote".url "$url"

I am not sure about the way you determine $remote.  When the HEAD in the
submodule repository is detached by prior "git submodule update", this
will fall back to the default "origin" --- is it a good behaviour?

This is not an objection; I am merely wondering if that fallback is
sensible, or if people who are interested in submodules can suggest better
alternatives.

> +			cd "$toplevel"

Unneeded (in a subshell).

> +		)
> +		fi
> +	done
> +}

Other than the above comments, the patch looks sensible to me.
