From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Mon, 10 Dec 2007 21:25:26 -0500
Message-ID: <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 03:26:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1uot-0001SX-P8
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 03:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbXLKCZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 21:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbXLKCZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 21:25:28 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:20737 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXLKCZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 21:25:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3710134wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 18:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3Ys9o5cIhSWELy70c/Lv5y2DkJYSVh2fSPf3DCm+Q/I=;
        b=edCNr6b2H6rYe+DRXzaIJQgMRdglVnkpzRVjrvTRkQyA8adr1sDnFIIq72wZCvZuSnECBkryzSsAF8WP3pDsNdzpElFeFfQv6ZlyWZSdC1P2AEr63bzq8/1tpYCtnouyrtTuzPe9q94uW5g6SP2Y+IVdZMIlzNVWpcPimHynjzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVJrmpgQcwicU+RiDnfJRxEaTwpuGiF61EYDpUGlK4FjcFpL+8yxx3BuD3CiFieajRglLXs1ztiHq1qtUopvzy0yil3n1MMVWUBl4BXrMLK81CgKJGNxBEJZu8IsxLKh3DGvp6lMKQdm8dml1Qc2oI3y3/+YDtBMkSgfX6/8/JI=
Received: by 10.114.193.1 with SMTP id q1mr4518315waf.1197339926597;
        Mon, 10 Dec 2007 18:25:26 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 18:25:26 -0800 (PST)
In-Reply-To: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67776>

New run using same configuration. With the addition of the more
efficient load balancing patches and delta cache accounting.

Seconds are wall clock time. They are lower since the patch made
threading better at using all four cores. I am stuck at 380-390% CPU
utilization for the git process.

complete seconds RAM
10%   60    900M (includes counting)
20%   15    900M
30%   15    900M
40%   50    1.2G
50%   80    1.3G
60%   70    1.7G
70%   140  1.8G
80%   180  2.0G
90%   280  2.2G
95%   530  2.8G - 1,420 total to here, previous was 1,983
100% 1390 2.85G
During the writing phase RAM fell to 1.6G
What is being freed in the writing phase??

I have no explanation for the change in RAM usage. Two guesses come to
mind. Memory fragmentation. Or the change in the way the work was
split up altered RAM usage.

Total CPU time was 195 minutes in 70 minutes clock time. About 70%
efficient. During the compress phase all four cores were active until
the last 90 seconds. Writing the objects took over 23 minutes CPU
bound on one core.

New pack file is: 270,594,853
Old one was: 344,543,752
It still has 828,660 objects


On 12/7/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Using this config:
> [pack]
>         threads = 4
>         deltacachesize = 256M
>         deltacachelimit = 0
>
> And the 330MB gcc pack for input
>  git repack -a -d -f  --depth=250 --window=250
>
> complete seconds RAM
> 10%  47 1GB
> 20%  29 1Gb
> 30%  24 1Gb
> 40%  18 1GB
> 50%  110 1.2GB
> 60%  85 1.4GB
> 70%  195 1.5GB
> 80%  186 2.5GB
> 90%  489 3.8GB
> 95%  800 4.8GB
> I killed it because it started swapping
>
> The mmaps are only about 400MB in this case.
> At the end the git process had 4.4GB of physical RAM allocated.
>
> Starting from a highly compressed pack greatly aggravates the problem.
> Starting with a 2GB pack of the same data my process size only grew to
> 3GB with 2GB of mmaps.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
