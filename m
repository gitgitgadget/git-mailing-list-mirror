From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 12:14:44 -0400
Message-ID: <9e4733910608210914s1157f47eta821584928ce4dd5@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
	 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
	 <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
	 <20060821070609.GC24054@spearce.org>
	 <Pine.LNX.4.64.0608211036150.3851@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 18:15:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFCQO-0000yU-T9
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 18:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWHUQOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 12:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWHUQOt
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 12:14:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:5967 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750970AbWHUQOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 12:14:49 -0400
Received: by nz-out-0102.google.com with SMTP id 14so288896nzn
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 09:14:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ooqfWyCtaEeP/Lqlh0jo3QmPdNkwVLFbJqa0tqHLcIpCWnYYDC+pe3Z3IUCngIaQYFpCVlANKYWRe+ae982Zcmf+kYNQdnx/kRdRS8ehNP29LWoH2NzAvTngqpeLBiswQ/X9jhejWenK/V5wa6aeAjMsgiuz9LGq1fjH5U6Tq0E=
Received: by 10.65.251.1 with SMTP id d1mr6993164qbs;
        Mon, 21 Aug 2006 09:14:48 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Mon, 21 Aug 2006 09:14:44 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608211036150.3851@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25803>

How about making the length of delta chains an exponential function of
the number of revs? In Mozilla configure.in has 1,700 revs and it is a
250K file. If you store a full copy every 10 revs that is 43MB
(prezip) of data that almost no one is going to look at. The chains
lengths should reflect the relative probability that someone is going
to ask to see the revs. That is not at all a uniform function.

Personally I am still in favor of a two pack system. One archival pack
stores everything in a single chain and size, not speed, is it's most
important attribute. It is marked readonly and only functions as an
archive; git-repack never touches it. It might even use a more compact
compression algorithm.

The second pack is for storing more recent revisions. The archival
pack would be constructed such that none of the files needed for the
head revisions of any branch are in it. They would all be in the
second pack.

After time the second pack may grow large and another archival pack
can be created. The first one would still be maintained in it's
readonly form. git could be optimized to always search for objects in
non-archival packs before even opening the index of an archival one.

This may be a path to partial repositories. Instead of downloading the
real archival pack I could download just an index for it. The index
entries would be marked to indicate that these objects are valid but
not-present.

-- 
Jon Smirl
jonsmirl@gmail.com
