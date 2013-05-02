From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Hold an 'unsigned long' chunk of the sha1 in obj_hash
Date: Thu, 2 May 2013 10:52:04 +0200
Message-ID: <87vc71u5l7.fsf@linux-k42r.v.cablecom.net>
References: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
	<20130501204947.GA12789@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 02 10:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXpFO-0005OF-EG
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 10:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab3EBIwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 04:52:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:53515 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab3EBIwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 04:52:08 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 2 May
 2013 10:51:58 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 2 May 2013 10:52:03 +0200
In-Reply-To: <20130501204947.GA12789@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 1 May 2013 16:49:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223181>

Jeff King <peff@peff.net> writes:

> It _might_ still be advantageous to do your patch on top, but I suspect
> it will diminish the returns from your patch (since the point of it is
> to probe less far down the chain on average).

No, mine makes it slower again.  Apparently the increased size is no
longer worth it.  You'll need a wide window to read this:

Test                                  next              tr/hash-speedup            jk/hash-speedup             both-hash-speedup        
----------------------------------------------------------------------------------------------------------------------------------------
0001.1: rev-list --all                0.66(0.63+0.02)   0.66(0.63+0.03) -0.4%      0.66(0.63+0.03) -0.6%       0.66(0.62+0.03) -0.6%    
0001.2: rev-list --all --objects      4.12(4.05+0.05)   3.81(3.74+0.06) -7.6%***   3.50(3.43+0.05) -15.1%***   3.56(3.49+0.05) -13.7%***
----------------------------------------------------------------------------------------------------------------------------------------

Note that the scripts always generate the percentages and significance
w.r.t. the first column.  Comparing yours with both instead gives

Test                               jk/hash-speedup   both-hash-speedup     
---------------------------------------------------------------------------
0001.1: rev-list --all             0.66(0.63+0.03)   0.66(0.62+0.03) +0.0% 
0001.2: rev-list --all --objects   3.50(3.43+0.05)   3.56(3.49+0.05) +1.6%*
---------------------------------------------------------------------------

which is still significant (in the statistical p=5% sense).

For kicks I also ran some other tests, which generally show that the
speedups are limited to this specific workload:

Test                                  next              tr/hash-speedup          jk/hash-speedup         both-hash-speedup     
-------------------------------------------------------------------------------------------------------------------------------
3201.1: branch --contains             0.76(0.74+0.02)   0.75(0.73+0.02) -1.0%*   0.77(0.74+0.02) +0.7%   0.76(0.73+0.02) -0.7% 
4000.1: log -3000 (baseline)          0.12(0.09+0.02)   0.12(0.10+0.02) +3.2%    0.12(0.10+0.01) +0.0%   0.12(0.10+0.02) +3.2% 
4000.2: log --raw -3000 (tree-only)   0.53(0.47+0.05)   0.52(0.46+0.05) -0.9%    0.53(0.46+0.06) +0.0%   0.52(0.45+0.06) -0.9% 
4000.3: log -p -3000 (Myers)          2.39(2.23+0.14)   2.38(2.23+0.13) -0.4%    2.38(2.23+0.14) -0.4%   2.38(2.23+0.13) -0.5% 
4000.4: log -p -3000 --histogram      2.43(2.28+0.13)   2.43(2.28+0.13) -0.0%    2.43(2.28+0.13) -0.1%   2.43(2.28+0.14) +0.1% 
4000.5: log -p -3000 --patience       2.72(2.57+0.12)   2.74(2.59+0.12) +0.7%    2.72(2.57+0.13) +0.2%   2.74(2.59+0.13) +0.8%.
-------------------------------------------------------------------------------------------------------------------------------

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
