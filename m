From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/4] submodule, repack: migrate to git-sh-setup's say()
Date: Mon, 15 Jun 2009 22:56:30 -0700
Message-ID: <7viqiwg1rl.fsf@alter.siamese.dyndns.org>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
	<1245117905-19351-2-git-send-email-bebarino@gmail.com>
	<1245117905-19351-3-git-send-email-bebarino@gmail.com>
	<1245117905-19351-4-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Adam <thomas.adam22@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 08:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGRjG-000770-Mi
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 08:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936305AbZFPF4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 01:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbZFPF4a
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 01:56:30 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45155 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936344AbZFPF43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 01:56:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616055630.KXRA20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 16 Jun 2009 01:56:30 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4VwW1c0064aMwMQ04VwWEL; Tue, 16 Jun 2009 01:56:30 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=H7danD3z24sA:10 a=pGLkceISAAAA:8
 a=rAtSQuJodP8Eo4tgrzQA:9 a=13KY01qu-Kalgtgd-oBDHKzoVgUA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121655>

Stephen Boyd <bebarino@gmail.com> writes:

> Now that there is say() in git-sh-setup, these scripts don't need to use
> their own. Migrate them over by setting GIT_QUIET and removing their
> custom say() functions.

This is not exactly a very nice style.

The contract between the callers of say() and its implementation is that
it does not matter what value is set to GIT_QUIET.  The only thing that
matters is if it is set to empty string or not.  And ...

> @@ -33,7 +33,7 @@ do
>  	-A)	all_into_one=t
>  		unpack_unreachable=--unpack-unreachable ;;
>  	-d)	remove_redundant=t ;;
> -	-q)	quiet=-q ;;
> +	-q)	GIT_QUIET=-q ;;

... this one takes advantage of it to set GIT_QUIET to -q, so that it can
be directly passed to another command that happens to use -q as "quiet"
option, like this ...

> -	git prune-packed $quiet
> +	git prune-packed $GIT_QUIET
>  fi

... while the other one does not have a callout to command that takes -q
at all, and does this ...

>  		-q|--quiet)
> -			quiet=1
> +			GIT_QUIET=1

If the convention is "GIT_QUIET, when set to non-empty string, squelches
the output", then I think the callers should be more consistent and the
call to prune-packed should say something like this, which is admittedly a
roundabout way:

	git prune-packed ${GIT_QUIET:+-q}

for consistency (and then what you set to GIT_QUIET in the first hunk I
quoted does not matter anymore---it can even be t or 1 or whatever).

I think this does not matter too much, because I suspect that in the
longer term scripted Porcelains are going away, but still...
