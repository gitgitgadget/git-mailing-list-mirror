From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib git-resurrect: find traces of a branch name
 and resurrect it
Date: Mon, 26 Jan 2009 22:31:27 -0800
Message-ID: <7vwschz2dc.fsf@gitster.siamese.dyndns.org>
References: <200901261254.39360.trast@student.ethz.ch>
 <1232973657-31444-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 07:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRhVP-0001XP-HB
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 07:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbZA0Gbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 01:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbZA0Gbh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 01:31:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbZA0Gbh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 01:31:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA00B935CA;
	Tue, 27 Jan 2009 01:31:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F267D935C2; Tue,
 27 Jan 2009 01:31:29 -0500 (EST)
In-Reply-To: <1232973657-31444-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Mon, 26 Jan 2009 13:40:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25406776-EC3C-11DD-A2AE-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107319>

Thomas Rast <trast@student.ethz.ch> writes:

> Add a tool 'git-resurrect.sh <branch>' that tries to find traces of
> the <branch> in the HEAD reflog and, optionally, all merge commits in
> the repository.  It can then resurrect the branch, pointing it at the
> most recent of all candidate commits found.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Fixed the -h to upper-case in the short options summaries, and removed
> a stray 'q' in the default assignment of new_name.

I hate to paint bikeshed, but -H "try-hard" looks somewhat unusual doesn't
it?  It sounds more like --all (find from all possible sources).

> +. git-sh-setup
> +cd_to_toplevel

Why?

> +search_reflog () {
> +        sed -n 's~^\([^ ]*\) .*\tcheckout: moving from '"$1"' .*~\1~p' \
> +                < .git/logs/HEAD
> +}

Once you used ". git-sh-setup", use "$GIT_DIR/logs/HEAD".  That way, you
can work in a bare repository (and you do not have to cd_to_toplevel,
either, I think).

Oh, don't forget to skip this step if the reflog does not exist.

> +search_reflog_merges () {
> +        sed -n 's~^[^ ]* \([^ ]*\) .*\tmerge '"$1"':~\1~p' \
> +                < .git/logs/HEAD
> +}

The two commits both point at the HEAD that merges the other branch into,
so this finds a merge commit that has the tip of target branch as its
second parent.  Is that really what you want?

> +search_merges () {
> +	git rev-list --pretty=tformat:"%h %p:%s" --all |
> +	grep "Merge branch.*'$branch'.*into" |

"git merge tr/topic~4" can say "Merge branch 'tr/topic' (early part)".
Also merge into 'master' won't have "into ...".

> +	while read sha rest; do
> +		parents="$(echo "$rest" | cut -d: -f1)"
> +		case "$parents" in
> +		    *' '*' '*)
> +			warn "$branch took part in octopus merge $sha"
> +			warn "check manually!"
> +			;;
> +		    *' '*)
> +			echo "$parents" | cut -d' ' -f2
> +			;;
> +		esac
> +	done

Reading everything down to the root commit sounds like fun.  rev-list
gives you the output from newer to older so you may want to break out once
you have found enough candidates.

Anyway, if I were doing this script, I'd write this part like this without
a shell loop:

        _x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
        _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"

	git rev-list --all --grep="Merge branch '$1'" \
        	--pretty=tformat:"%H %P %s" |
	sed -ne "s/^$_x40 $_x40 \($_x40\) Merge .*/\1/p"
