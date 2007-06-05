From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Tue, 05 Jun 2007 03:30:07 -0700
Message-ID: <7vzm3ebsnk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site>
	<f3t2mm$f0$1@sea.gmane.org>
	<Pine.LNX.4.64.0706030147520.4046@racer.site>
	<20070605101845.GA16160@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:30:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWIr-0006Ep-Nu
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763016AbXFEKaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763135AbXFEKaJ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:30:09 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33615 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763016AbXFEKaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:30:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070605103008.QXMJ15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Jun 2007 06:30:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7mW71X0061kojtg0000000; Tue, 05 Jun 2007 06:30:07 -0400
In-Reply-To: <20070605101845.GA16160@diku.dk> (Jonas Fonseca's message of
	"Tue, 5 Jun 2007 12:18:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49185>

Jonas Fonseca <fonseca@diku.dk> writes:

> $ git filter-branch H2
> /home/fonseca/bin/git-filter-branch: 386: arith: syntax error: "i+1"
> $
>
> A possible fix that makes the test pass for me.
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 0c8a7df..5cf9d3c 100644
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -339,7 +339,7 @@ test $commits -eq 0 && die "Found nothing to rewrite"
>  
>  i=0
>  while read commit; do
> -	i=$((i+1))
> +	i=$(echo i+1 | bc)

Are you sure this is not "echo $i+1"???

There are quite a few $((arithmetic)) already in our shell code,
so I was initially a bit surprised.  However, upon closer
inspection, this particular use is not kosher at all.

The portable ones we already have in the code say things like:

	msgnum=$(($msgnum+1))

The one in filter-branch that bit you does not dereference 'i'.
I am reasonably sure if you fix it to read:

	i=$(( $i+1 ))

dash would grok it.
