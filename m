From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] format-patch --signoff
Date: Thu, 1 Jun 2006 00:42:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606010032410.21774@wbgn013.biozentrum.uni-wuerzburg.de>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
 <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
 <20060531112803.GB3877@spinlock.ch> <m2mzcycn4f.fsf@ziti.fhcrc.org>
 <7vejyayq46.fsf@assigned-by-dhcp.cox.net> <7v4pz5zvtc.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geoff Russell <geoffrey.russell@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 01 00:42:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlZOO-0003Bx-0C
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 00:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbWEaWmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 18:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWEaWmR
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 18:42:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6801 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965218AbWEaWmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 18:42:16 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 04D3921A2;
	Thu,  1 Jun 2006 00:42:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id ECE5F2195;
	Thu,  1 Jun 2006 00:42:06 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C204C215D;
	Thu,  1 Jun 2006 00:42:06 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pz5zvtc.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21095>

Hi,

On Wed, 31 May 2006, Junio C Hamano wrote:

> This resurrects --signoff option to format-patch.

Sorry; I was in cinema, so I missed all the action.


> +			const char *committer = git_committer_info(1);
> +			const char *endpos = strchr(committer, '>');
> +			if (!endpos)
> +				die("bogos committer info %s\n", committer);
> +			add_signoff = xmalloc(endpos - committer + 2);
> +			memcpy(add_signoff, committer, endpos - committer + 1);
> +			add_signoff[endpos - committer + 1] = 0;
> +		}

I don't know, but it may be a good idea to make this more general: Why not 
build the sign-off line here, so that you could also add more than one 
sign-off lines ('--signoff="The great committer <ter@mit.com>"'), and 
maybe even Acked-by's?

> +	/* First see if we already have the sign-off by the signer */
> +	while (1) {
> +		cp = strstr(cp, signed_off_by);
> +		if (!cp)
> +			break;
> +		cp += strlen(signed_off_by);
> +		if ((cp + signoff_len < buf + at) &&
> +		    !strncmp(cp, signoff, signoff_len) &&
> +		    isspace(cp[signoff_len]))
> +			return at; /* we already have him */
> +	}

Okay, this would be a little harder with multiple sign-offs. But the check 
could be easier, i.e. if we say

	rev.add_signoff = xmalloc(enough_room);
	strcpy(rev.add_signoff, "\nSigned-off-by: ");
	strcat(rev.add_signoff, committer_ident);
	strcat(rev.add_signoff, "\n");

then a simple

	p = strstr(commit_buffer, rev.add_signoff);
	if (p)
		return (int)(p - commit_buffer);

would do the trick.

And shouldn't we error out if there is not enough room for a sign-off?

Sorry for all the nit-picking.

Ciao,
Dscho
