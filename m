From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 02/15] read-cache: allow to keep mmap'd memory after
 reading
Date: Wed, 20 Apr 2016 11:01:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604201059530.2826@virtualbox>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com> <1461108489-29376-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 11:01:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aso0y-0002wD-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 11:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbcDTJBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 05:01:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:61556 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbcDTJB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 05:01:28 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MfmWy-1b4qga0rdE-00NCD5; Wed, 20 Apr 2016 11:01:24
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1461108489-29376-3-git-send-email-dturner@twopensource.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:5LZ8egsDsS+JHOKL0wncEX28MFZAwyGQ+KFjDmXLdmyjuB7vKwe
 cSklJSMzVOzq+cY1ZODXLVshosW7lpQVW1o7qxCLJaTrOl1cJy5CQQfzoe3Y25ddSimNvz9
 b4/JMOXm9iSpmvwxzwHgEKuUDFsQNwt2fHhXtVfvX49xOdnrJ7Z3V/gEGF4lxLCHWE3O9cg
 gFoZLacbGkPcxbCB1Z0ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qxJeVK0CRhc=:0fhUwTcIoGH+IcRJZlRvUq
 Tj9fAzSlxims98685gBBRBzeGX/tY7h2NDIGtPrM203/Z0zsxImnYJlEz4P7x3CjhENicd1JU
 GkpiPOKCXCPRJrXS4ZP14U6IMj5rbrSo93U+67c0dxUFQ4n6wdS8ZnJNH9SPHKY6UfjJFdMRu
 YC1QVN2BebOczytg6dodKiLOtAhKjN9M3MCAI8I0LdJv/T67V+ED1sI6mKdObZ8PbvwLdXPkO
 5EC33637n0zTmai8EI77kzmuAuR0DkXpnd9W+7PnkWO8YrFjKqp2Kp2z2X5R8BUn+K/hCazsa
 cdAu/gunmWinCbU+KqLGVVqkS5FrBjOcRTppAYAYWoiupnBJ3Lg4AT/+r1IFL5wI7yCd/P084
 Er6mnWQ25mZu5fOJ+qIwIuZ4S8xgLVFGYWGwMSY58bserO2feImMGuFr4TYvbiLd8vJ0+9J3X
 Kf9Mz8+XxkpaWdRCQYkTFsfaKQV1Iyq5ei0MA1nEEaeMYYSpVEaOh1Gpt0DNZLqonBHxN5prT
 MN/91Ri2WJaMhgFosfj6ZLbV/tuTorszwQslpW1Ofm4HCQHTddOInJds3x1HfXbtNe2O/cvnF
 f6cJeRGmZ3pBSK2rhPIL96pCzCOg+wLKhXNsTciIS/aTksIhtc/4u1M5cCpK7Q1P3Lr/CbLSA
 EFnTdbF4/IeCCvxhhMAA5B2Kl5lvW0I7OkOleT7MVILI/g/pTMLje3RkVnkkURl4TOqtNXf9O
 r293r6ZM/mblF4HXr8Dgc2CzFWoq4SLmgv2L/oEMRYBDO9HTCwIE5nM16Trs3wk4wdr1qT+C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291996>

Hi Dave,

On Tue, 19 Apr 2016, David Turner wrote:

>  unmap:
> +	istate->mmap = NULL;
>  	munmap(mmap, mmap_size);
>  	die("index file corrupt");
>  }
> [...]
> @@ -1698,6 +1705,10 @@ int discard_index(struct index_state *istate)
>  	free(istate->cache);
>  	istate->cache = NULL;
>  	istate->cache_alloc = 0;
> +	if (istate->keep_mmap && istate->mmap) {
> +		munmap(istate->mmap, istate->mmap_size);
> +		istate->mmap = NULL;
> +	}
>  	discard_split_index(istate);

Just curious: any reason why the first hunk munmap()s after resetting the
field to NULL and the second hunk does it in the opposite order?

Ciao,
Dscho
