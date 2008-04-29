From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 16:41:52 +0400
Message-ID: <20080429124152.GB6160@dpotapov.dyndns.org>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Henrik Austad <henrikau@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Tue Apr 29 14:43:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqpAk-0002uO-AC
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 14:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbYD2MmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 08:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYD2MmA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 08:42:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7688 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbYD2Ml7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 08:41:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so13774nfc.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=sCFimoMBDohRuFNe8D/NNDJ0HQIvBBKvc2nTbkEv8F0=;
        b=fm1oSiyZcogRum4WfjqMdb9CPgVo0puHWPhHrAcYPdP2B821PFIyXPeomrKI3Y3BVFKv0rIn7eAl4SJga9AekfuBvVqUffhhrtz2tb7hRa+O9A9fEsPS4+RLou95JuBa7LGccff6rkLzCrbefHTuHgQPKY5Ay/RAXBKu4SsynuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=sp+Y6qZpnxYPWJcPfuxVpLlxsqlkNOK3xBE5oM9TGosQ9DEwtFww/uxq+QXatTGHkK9heax3H+aLT4dqhheI2UF4ONqTxm7bNoOLaL+abMxo9SlYam5CLoQXROC5wAdfglbwGFFa+U2w1dtl8ze9sXiCcHesKR45ZNy3sfPjVpM=
Received: by 10.78.173.20 with SMTP id v20mr4542727hue.100.1209472917459;
        Tue, 29 Apr 2008 05:41:57 -0700 (PDT)
Received: from localhost ( [85.141.191.242])
        by mx.google.com with ESMTPS id 11sm6727125hug.15.2008.04.29.05.41.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Apr 2008 05:41:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804281829.11866.henrikau@orakel.ntnu.no>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80680>

On Mon, Apr 28, 2008 at 06:29:07PM +0200, Henrik Austad wrote:
> 
> As discussed in [1], SHA-1 is not as secure as it once was (and this was in 
> 2005), and I'm wondering - are there any plans for migrating to another 
> hash-algorithm? I.e. SHA-2, whirlpool..

SHA-1 is broken in the sense that it requires computation less than
finding a collision  by brute force (2^80). It is still very costly and
AFAIK no one yet has found a single collision for SHA-1 yet, but even if
such a collision is found, the question is how it can be exploit?

This collision cannot be used to replace any existing code in Git. The
only way to exploit this collision is to submit a patch based on one
sequence to the maintainer and it should look legitimate to be accepted
and then create another blob with malicious code based on the other
sequence, so the second blob has the same SHA-1 then anyone who pulls
from you will get malicious code.

However, it is tricky to create these two blobs -- one which should pass
inspection and look like as a real improvement but the other one that
should do what you want. All what you have is two sequences of 20 bytes
with the same SHA-1 and you have no control over them. For some binary
files, it is possible by including both good and bad contents in the
submitted blob and using one sequence in the right place to hide the bad
part and make only the good one active/visible. Then the other blob will
be almost the same but contains the other sequence, which is used to
activate the bad part. This can work if the maintainer cannot see
everything but only the "visible" part. However, I don't think you can
do anything like that with _source_ code, which is inspect. And if
submitted code is not reviewed, there is nothing that can protect you
from malicious code getting into the repository (and even worse it will
get directly into the official repository!).

So, I don't think we have to worry much about possibility a collision
attack, but only about preimage attacks; and a preimage attack on SHA-1
is far away from reality.

Dmitry
