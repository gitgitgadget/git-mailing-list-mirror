From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool merge/skip/abort at prompt
Date: Wed, 28 Jan 2009 08:47:56 +0000
Message-ID: <20090128084756.GA28493@hashpling.org>
References: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 09:49:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS66w-0000dR-IR
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbZA1IsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbZA1IsA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:48:00 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:40269 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752880AbZA1Ir7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 03:47:59 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACKqf0nUnw6T/2dsb2JhbADLT4VHBg
Received: from ptb-relay03.plus.net ([212.159.14.147])
  by relay.ptn-ipout02.plus.net with ESMTP; 28 Jan 2009 08:47:57 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1LS65V-0002kP-CP; Wed, 28 Jan 2009 08:47:57 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0S8lvkE029132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Jan 2009 08:47:57 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0S8luSs029131;
	Wed, 28 Jan 2009 08:47:56 GMT
Content-Disposition: inline
In-Reply-To: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 0c580de2915f732b291300667f1e8dd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107510>

On Wed, Jan 28, 2009 at 01:56:47AM -0500, Caleb Cushing wrote:
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 00e1337..575fbb2 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -177,8 +177,24 @@ merge_file () {
>      describe_file "$local_mode" "local" "$LOCAL"
>      describe_file "$remote_mode" "remote" "$REMOTE"
>      if "$prompt" = true; then
> -	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
> -	read ans
> +	while true; do
> +	    printf "Use (m)erge file or (s)kip file, or (a)bort? (%s): " \
> +	    "$merge_tool"
> +	    read ans
> +	    case "$ans" in
> +		[mM]*|"")
> +		    break
> +		    ;;
> +		[sS]*)
> +		    cleanup_temp_files
> +		    return 0
> +		    ;;
> +		[aA]*)
> +		    cleanup_temp_files
> +		    exit 0
> +		    ;;
> +	    esac
> +	done

This patch does now apply for me, so I've given it a longer look. It
does roughly what I expect, but I can't help feeling that the change
isn't in the best place.

Currently, whatever the prompt, the merge tool will always be run so
it makes sense (or at least there is no negative) in creating the
temporary files before running the merge tool.

With this change, it would seem to be more logical to ask whether the
merge tool is to be run before creating the temporary files, removing
the need for them to be cleaned up if the answer is no. I think that
this would be cleaner overall.

At the same time, however, it might be worth refactoring the
merge_file function as the same criticism could probably levelled at
the code paths that perform symlink and deleted file merges and these
paths would probably now share much more of the logic and behaviour of
a normal file merge.

Trying out this refactoring and adding the option to choose local or
remote file versions without running the merge tool has been on my
todo list for a while, but I might actually have a go at it this
weekend if nobody beats me to it.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
