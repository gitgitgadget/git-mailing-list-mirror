From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] * remote.c (valid_fetch_refspec): remove useless
 if-before-free test
Date: Wed, 20 Aug 2008 17:16:25 -0700
Message-ID: <7vr68jmdd2.fsf@gitster.siamese.dyndns.org>
References: <87k5ecx2pl.fsf@rho.meyering.net>
 <pI8EXbuWhkm4pM0AaaTAPQQYBeFSffOSzCiM4NfNHKomivEcfUfShA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <meyering@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 21 02:17:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVxs4-00080Z-AQ
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 02:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbYHUAQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 20:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbYHUAQo
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 20:16:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYHUAQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 20:16:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DE2AC53BB3;
	Wed, 20 Aug 2008 20:16:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 40BE353BB2; Wed, 20 Aug 2008 20:16:37 -0400 (EDT)
In-Reply-To: <pI8EXbuWhkm4pM0AaaTAPQQYBeFSffOSzCiM4NfNHKomivEcfUfShA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 20 Aug 2008 18:38:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6D8DEE7A-6F16-11DD-924D-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93076>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Maybe we should also begin the process of not leaking memory here...
>
> diff --git a/remote.c b/remote.c
> index 7f2897b..984ad1b 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -449,6 +449,20 @@ static int verify_refname(char *name, int is_glob)
> 	return result;
>  }
>  
> +void free_refspecs(struct refspec *refspec, int nr_refspec)
> +{
> +	int i;
> +
> +	if (!refspec)
> +		return;
> +
> +	for (i = 0; i < nr_refspec; i++) {
> +		free(refspec[i].src);
> +		free(refspec[i].dst);
> +	}
> +	free(refspec);
> +}

Are you sure all the codepaths that stuff refspec[].{src,dst} give
freeable pointer?  E.g. if anybody splits a originally single string
"refs/heads/foo:refs/remotes/origin/foo" into two by replacing the colon
with NUL and pointing the halves, and/or such string came from argv[]
without strdup(), I'd imagine free() would not like you very much.

I didn't look, though.
