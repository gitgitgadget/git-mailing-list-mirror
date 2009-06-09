From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 9 Jun 2009 23:55:49 +0200
Message-ID: <200906092355.51244.jnareb@gmail.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org> <m3prdd4t6s.fsf@localhost.localdomain> <4A2E7BA7.8000901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 23:57:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME9KE-0005cV-KE
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 23:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbZFIVz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 17:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbZFIVz4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 17:55:56 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:34526 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218AbZFIVzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 17:55:54 -0400
Received: by ewy6 with SMTP id 6so374723ewy.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 14:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+aaCE7tiF+N4YNOH/VDMQ5nwBWdojg250KTcxuulyKs=;
        b=j5XxVgdTopjPZxnMKGMrVpgx+l2hx0e1n2pr8kV0/9zJsR+ZzK4r5puppiwznYD/V9
         406tXQf1Vk2QTCK4DGn5CT5xSDASAWDxe9aKT0uf/g6tlOwoJC47li6hTSNLuMgNYnkr
         +Kg6Zi3JDuU2ewx0eaITZYfmThtajXtGjDPuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q+4oG1GozEOS33O1A5xvGCmZ8eK0H4PkNaVB4XBWk0hGoBqpzlpm92H7Wj0CIp5vJO
         HPh71cjW83YEYdQgPpjmw3k/Mb9EFf3X4RTbhxxCbWLU7oU7MRh6MHlR8kpMUlrTMyUe
         ++uR3NTTFN7aTgrQ4p9A0G8L/8Kycc68zdGi0=
Received: by 10.210.28.4 with SMTP id b4mr751628ebb.28.1244584555148;
        Tue, 09 Jun 2009 14:55:55 -0700 (PDT)
Received: from ?192.168.1.13? (abvq34.neoplus.adsl.tpnet.pl [83.8.214.34])
        by mx.google.com with ESMTPS id 24sm172562eyx.53.2009.06.09.14.55.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 14:55:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A2E7BA7.8000901@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121229>

On Tue, 9 June 2009, H. Peter Anvin wrote:
> Jakub Narebski wrote:
> > 
> > By the way, I have asked question about best algorithm for "bisect skip"
> > on StackOverflow[1], but didn't get (yet) any good responses...
> > 
> > [1]: http://stackoverflow.com/questions/959324/
> > 
> 
> I don't think there is a "best" algorithm, but I concur with the poster
> that said broken commits tend to cluster.

Well, I guess that there might be, at least if we had some reasonable
assumption on probability distribution of bad commits.


Note: the idea sketched below is just handwaving currently...

Let us assume that we are currently at some untestable commit. Let us
also assume that we have some halfway reasonable model of probability
that a given commit is untestable, given it distance from known
untestable commit. "git rev-list --bisect-all" (or its inner equivalent)
would give us list of commits in the searched range, sorted in 
descending order by distance from edges (endpoints) of range:

  commit    "goodness" 
  --------------------
  c21d2e5*  (dist=60)
  94d6d14   (dist=59)
  ccb06f4   (dist=59)
  d1a1610   (dist=58)
  d4bf4b4   (dist=58)
  16c5646   (dist=57)

Let us assume that "c21d2e5" is untestable, and that we can easily 
calculate distance from it, substituting 0/0 (undef) if a commit
is not in straight line from "c21d2e5".

  commit    "goodness"  d
  -------------------------
  c21d2e5*  (dist=60)   0
  94d6d14   (dist=59)   1
  ccb06f4   (dist=59)   --
  d1a1610   (dist=58)   --
  d4bf4b4   (dist=58)   2
  16c5646   (dist=57)   3

Let us also assume that we have some model of probability that a commit
is untestable. In the example below numbers are ad hoc, and unrealistic.

  commit    "goodness"  d   P(untestable)
  ----------------------------------------
  c21d2e5*  (dist=60)   0   100%
  94d6d14   (dist=59)   1    75%
  ccb06f4   (dist=59)   --    0%
  d1a1610   (dist=58)   --    0%
  d4bf4b4   (dist=58)   2    33%
  16c5646   (dist=57)   3    25%

We can now calculate average number of bits of information would bring
(IIRC it was HPA and Christian that was writing about 'average information
gain' and 'bits of information at each step'; I don't quote know how it
is to be calculated)

  commit    "goodness"  d   P(untestable)  avg. gain
  ----------------------------------------
  c21d2e5*  (dist=60)   0   100%           0.0001
  94d6d14   (dist=59)   1    75%           0.45
  ccb06f4   (dist=59)   --    0%           0.98
  d1a1610   (dist=58)   --    0%           0.95
  d4bf4b4   (dist=58)   2    33%           0.65
  16c5646   (dist=57)   3    25%           0.66

Here 'avg. gain' numbers are totally handwaving... but the idea is to
pick up as next test point the commit with mist average information
gain.

What do you think of this algorithm (after of course it is made into
proper algorithm :-))?
-- 
Jakub Narebski
Poland
