From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: avoid 'git reset' when possible
Date: Sun, 01 Mar 2009 00:38:44 -0800
Message-ID: <7vvdqt8wob.fsf@gitster.siamese.dyndns.org>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
 <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302>
 <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com>
 <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
 <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 01 09:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdhDu-0001KH-Gg
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 09:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbZCAIjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 03:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbZCAIjF
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 03:39:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZCAIjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 03:39:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E8EF49E9F2;
	Sun,  1 Mar 2009 03:38:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 739E79E9F1; Sun,
  1 Mar 2009 03:38:46 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Fri, 27 Feb 2009 13:56:51 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6873ACD2-063C-11DE-A9C1-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111827>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 3dc659d..a9617a2 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -442,6 +442,27 @@ do_rest () {
>  	done
>  }
>  
> +# skip picking commits whose parents are unchanged
> +skip_unnecessary_picks () {
> +	current=$ONTO
> +	i=0
> +	while read command sha1 rest
> +	do
> +		test pick = "$command" &&
> +		test $current = "$(git rev-parse $sha1^)" ||
> +		break
> +		current=$(git rev-parse $sha1)
> +		i=$(($i+1))
> +	done < "$TODO"
> +	test $i = 0 || {
> +		sed -e "${i}q" < "$TODO" >> "$DONE" &&
> +		sed -e "1,${i}d" < "$TODO" >> "$TODO".new &&
> +		mv -f "$TODO".new "$TODO" &&
> +		ONTO=$current ||
> +		die "Could not skip $i pick commands"
> +	}
> +}

I do not think you have to count and then run two sed.

	this=$ONTO
	skip_pick=t
	while read command sha1 rest
	do
		sha1=$(git rev-parse "$sha1")
        	case "$skip_pick,$command" in
                t,pick | t,p)
			if test "$this" = "$sha1"
                        then
				echo >&3 "$command $sha1 $rest"
                        	this="$sha1"
				continue
			fi
		esac                        
		skip_pick=f
                echo "$command $sha1 $rest"
	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
	...
