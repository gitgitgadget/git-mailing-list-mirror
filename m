From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/4] t6000lib: workaround a possible dash bug
Date: Wed, 26 Sep 2007 16:41:44 +0800
Message-ID: <20070926084144.GA11582@gondor.apana.org.au>
References: <11486091793385-git-send-email-normalperson@yhbt.net> <11486091792604-git-send-email-normalperson@yhbt.net> <20070921132808.GB9778@gondor.apana.org.au> <20070921204511.GA10079@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 10:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaSTh-0004iy-Ul
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 10:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbXIZImf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 04:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbXIZIme
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 04:42:34 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:3075 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751190AbXIZIme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 04:42:34 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1IaSTJ-0005vM-Vk; Wed, 26 Sep 2007 18:42:18 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1IaSSm-00031j-00; Wed, 26 Sep 2007 16:41:44 +0800
Content-Disposition: inline
In-Reply-To: <20070921204511.GA10079@muzzle>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59219>

On Fri, Sep 21, 2007 at 01:45:11PM -0700, Eric Wong wrote:
>
> I tried to reproduce it on a quick script using shell functions,
> multiple arguments, spaces in the $a variable.., but haven't
> been successful.  However, reverting the below patch still
> causes errors in the latest git test suite.

Ah I see, it's a function.  Unfortunately POSIX requires
shell functions to have the variable assignment properties
of special built-ins.  So

	X=value func

has the same properties as

	X=value :

In other words, the value assigned to X (and any subsequent
values assigned within the function) persists after the call.
Also, the variable X is not exported unless it's already been
exported.

This is pretty lame but it's how the original Korn shell did
things and POSIX has adopted that.  Bash's POSIX mode tries
to balance things by both making the value persist and exporting
X.  Unfortunately this is buggy too as it causes X to continue
to be exported after the function returns.

So the bottom-line is that your patch is the correct solution
after all :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
