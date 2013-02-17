From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2] read_directory: avoid invoking exclude machinery on
 tracked files
Date: Sun, 17 Feb 2013 10:49:56 -0500
Message-ID: <20130217154956.GA2395@padd.com>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
 <1360999078-27196-1-git-send-email-pclouds@gmail.com>
 <20130216181110.GA27233@padd.com>
 <CACsJy8C9SGJxwnm1E2N_KyEMg5-MzDt2B+SrX7rygn8X1qq4Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 16:50:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U76VY-0002du-Gz
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 16:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617Ab3BQPuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 10:50:02 -0500
Received: from honk.padd.com ([74.3.171.149]:53414 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab3BQPuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 10:50:01 -0500
Received: from arf.padd.com (unknown [50.124.137.41])
	by honk.padd.com (Postfix) with ESMTPSA id 8828260E6;
	Sun, 17 Feb 2013 07:50:00 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0488A225F6; Sun, 17 Feb 2013 10:49:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACsJy8C9SGJxwnm1E2N_KyEMg5-MzDt2B+SrX7rygn8X1qq4Wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216398>

pclouds@gmail.com wrote on Sun, 17 Feb 2013 11:39 +0700:
> On Sun, Feb 17, 2013 at 1:11 AM, Pete Wyckoff <pw@padd.com> wrote:
> > pclouds@gmail.com wrote on Sat, 16 Feb 2013 14:17 +0700:
> >> Finally some numbers (best of 20 runs) that shows why it's worth all
> >> the hassle:
> >>
> >> git status   | webkit linux-2.6 libreoffice-core gentoo-x86
> >> -------------+----------------------------------------------
> >> before       | 1.097s    0.208s           0.399s     0.539s
> >> after        | 0.736s    0.159s           0.248s     0.501s
> >> nr. patterns |    89       376               19          0
> >> nr. tracked  |   182k       40k              63k       101k
> >
> > Thanks for this work.  I repeated some of the tests across NFS,
> > where I'd expect to see bigger differences.
> 
> This is about reducing CPU processing time, not I/O time. So no bigger
> differences is expected. I/O time can be reduced with inotify, or fam
> in nfs case because inotify does not support nfs.

Numbers from the last mail were core.preloadindex=true.  Here's
"time" output from average runs:

    stock = 0m2.28s user 0m4.18s sys 0m11.28s elapsed 57.39 %CPU
    duy   = 0m1.25s user 0m4.43s sys 0m7.45s elapsed 76.41 %CPU

With this huge repo, preloadindex may be stressing directory
cache behavior on the NFS server or client.  Your patch helps
both CPU and wait time by avoiding the 6000-odd open() of
non-existent .gitignore.

With core.preloadindex=false, it's a 1 sec speedup, all from CPU:

    stock = 0m2.18s user 0m1.59s sys 0m7.78s elapsed 48.45 %CPU
    duy   = 0m1.17s user 0m1.63s sys 0m6.91s elapsed 40.59 %CPU


		-- Pete
