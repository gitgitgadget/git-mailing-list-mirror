From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Thu, 30 Aug 2007 12:17:26 -0400
Message-ID: <9e4733910708300917w46d25c61n387e89dc3b2985f9@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
	 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
	 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
	 <20070815053231.GJ27913@spearce.org>
	 <alpine.LFD.0.999.0708151500510.5415@xanadu.home>
	 <alpine.LFD.0.999.0708300005110.16727@xanadu.home>
	 <alpine.LFD.0.999.0708300033540.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Martin Koegler" <mkoegler@auto.tuwien.ac.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 18:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQmiB-00016r-MG
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 18:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292AbXH3QRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 12:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756743AbXH3QRe
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 12:17:34 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:38763 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbXH3QRd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 12:17:33 -0400
Received: by nz-out-0506.google.com with SMTP id s18so436525nze
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 09:17:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VqQXjQkyukJGQWKmv3wSVXenIgIPp5DOv/ELR/RYBD547yCeyWQ99SjaTOg5enyo4bxelDa0khMP+89n3FBBny4tlT0kl6pZ8vsaeXxR1SjbLKYIH7lSqcKFUiUmZ0sVs1SpEV7VCal0ZD6WOAsZc7JrJQ8W1yyopLgHocix5aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kk6W7kLZ01gldesIRVeQk9a9hMUA0QlVSN3pazY2NAXwDRcWefyCREZlAlBmG7GEIY61iccWVybvXsLjmDvySk5xUoOUVe1EWhzHYvVCjOKxa1RVbsYY1ELvIE574gXxafCiFM+9uBk/8fnuMSJewv3dzRPwIYeNf/wsxNjWTWU=
Received: by 10.114.149.2 with SMTP id w2mr10746wad.1188490652092;
        Thu, 30 Aug 2007 09:17:32 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Thu, 30 Aug 2007 09:17:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708300033540.16727@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57050>

Practicing on the kernel, without the patch:
Q6600 with 4GB RAM

jonsmirl@terra:/home/linux$ time git repack -a -f --window=200 --depth=200
Generating pack...
Counting objects: 518288
Done counting 546466 objects.
Deltifying 546466 objects...
 100% (546466/546466) done
Writing 546466 objects...
 100% (546466/546466) done
Total 546466 (delta 452329), reused 0 (delta 0)
Pack pack-04c98effa112233951acbb2d8486eefac17a5a97 created.

real    16m27.752s
user    16m23.829s
sys     0m2.192s

With the patch it didn't balance very well. First two threads finished
in 2min, thrid in 5min, fourth in 10min.

So for fun I set it up to 16 threads, that kept all fours cores
running until the end. It added 1:20 in overhead, but it finished in
5m vs 16:30 unthreaded. Threading is an obvious win for this code.

jonsmirl@terra:/home/linux$ time git repack -a -f --window=200 --depth=200
Generating pack...
Counting objects: 502267
Done counting 546466 objects.
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
Deltifying 545660 objects...
   6% (34104/545660) done
   6% (34099/545660) done
   1% (6929/545660) donee
   5% (30037/545660) done
   6% (34101/545660) done
   4% (25222/545660) done
   6% (34102/545660) done
   3% (19999/545660) done
   6% (34102/545660) done
   4% (27203/545660) done
   6% (34102/545660) done
   4% (23377/545660) done
   6% (34042/545660) done
   6% (34099/545660) done
   6% (32740/545660) done


real    5m0.360s
user    17m41.822s
sys     0m5.596s
jonsmirl@terra:/home/linux$


-- 
Jon Smirl
jonsmirl@gmail.com
