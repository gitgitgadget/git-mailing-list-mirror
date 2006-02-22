From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add new git-rm command with documentation
Date: Wed, 22 Feb 2006 00:19:46 -0800
Message-ID: <7vaccjst3x.fsf@assigned-by-dhcp.cox.net>
References: <87u0ass7tj.wl%cworth@cworth.org> <43FB8F31.9090302@people.pl>
	<87slqcs4y5.wl%cworth@cworth.org> <87r75ws48c.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 09:19:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBpE0-0007tj-NM
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 09:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWBVITu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 03:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWBVITu
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 03:19:50 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:23770 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932357AbWBVITt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 03:19:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222081715.TXTT17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 03:17:15 -0500
To: Carl Worth <cworth@cworth.org>,
	Krzysiek Pawlik <krzysiek.pawlik@people.pl>
In-Reply-To: <87r75ws48c.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	21 Feb 2006 15:04:51 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16593>

Carl Worth <cworth@cworth.org> writes:

> +files=$(
> +    if test -f "$GIT_DIR/info/exclude" ; then
> +	git-ls-files \
> +	    --exclude-from="$GIT_DIR/info/exclude" \
> +	    --exclude-per-directory=.gitignore -- "$@"
> +    else
> +	git-ls-files \
> +	--exclude-per-directory=.gitignore -- "$@"
> +    fi | sort | uniq
> +)

Note you are not using -z, which means we will c-quote the funny
characters in the output...

> +case "$show_only" in
> +true)
> +	echo $files
> +	;;

And here $files lack surrounding double quote.  For human
consumption it might be OK, but I somehow care about a bit of
details like this.

> +*)
> +	[[ "$remove_files" = "true" ]] && rm -- $files

Same here. What happens to filenames with IFS letters in them?
"git-add" does not use -z and xargs -0 without a good reason.

> +	git-update-index $index_remove_option $verbose $files
> +	;;
> +esac

Even if rm -- $files were quoted correctly, and tried to remove
the right files, if some of the files failed to disappear for
whatever reason, what happens?
