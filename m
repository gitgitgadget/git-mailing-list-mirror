From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid segfault when passed malformed refspec
Date: Fri, 01 Feb 2008 17:03:04 -0800
Message-ID: <7vzluk6ugn.fsf@gitster.siamese.dyndns.org>
References: <BAYC1-PASMTP124F1019C2D2CD7AA81CF5AE310@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Feb 02 02:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL6nf-0001Ge-QY
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 02:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759905AbYBBBDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 20:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759760AbYBBBDP
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 20:03:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550AbYBBBDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 20:03:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9331B2BE8;
	Fri,  1 Feb 2008 20:03:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 026B12BE6;
	Fri,  1 Feb 2008 20:03:06 -0500 (EST)
In-Reply-To: <BAYC1-PASMTP124F1019C2D2CD7AA81CF5AE310@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Fri, 1 Feb 2008 19:00:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72199>

Sean <seanlkml@sympatico.ca> writes:

> A refspec typo can cause a Null-pointer dereference and segmentation
> fault.  For instance, the space before the colon in the following
> example results in a segfault:
>
>    $ git fetch ../repo  refs/heads/* :refs/heads/*
>    Segmentation fault (core dumped)
>
> To avoid the segfault, set an empty refspec destination string
> if one isn't found by parsing.
>
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
> ---
>  remote.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 0e00680..414c73a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -336,6 +336,8 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
>  			ep = gp;
>  		}
>  		rs[i].src = xstrndup(sp, ep - sp);
> +		if (!rs[i].dst)
> +			rs[i].dst = xstrdup("");
>  	}
>  	return rs;
>  }

I haven't followed the codepath carefully before responding, it
feels like sweeping the breakage under the carpet, without
fixing the real issue.

If the problem is a badly formatted input, shouldn't the code
die loudly with diagnostic message, instead of pretending as if
the user said something different (and sensible), especially
without telling the user that that is what the code is doing?
