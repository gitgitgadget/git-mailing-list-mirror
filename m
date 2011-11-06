From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] grep: detect number of CPUs for thread spawning
Date: Sun, 6 Nov 2011 09:50:50 -0500
Message-ID: <20111106145050.GA4219@arf.padd.com>
References: <1320502568-14085-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 15:51:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN43p-0001GX-1r
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 15:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab1KFOu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 09:50:56 -0500
Received: from honk.padd.com ([74.3.171.149]:52892 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab1KFOuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 09:50:55 -0500
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id C7C0C29E1;
	Sun,  6 Nov 2011 06:50:54 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 223B6313DA; Sun,  6 Nov 2011 09:50:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1320502568-14085-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184914>

avarab@gmail.com wrote on Sat, 05 Nov 2011 14:16 +0000:
> From: Eric Herman <eric@freesa.org>
> 
> Change the number of threads that we spawn from a hardcoded value of
> "8" to what online_cpus() returns.
> 
> Back in v1.7.0-rc1~19^2 when threaded grep was introduced the number
> of threads was hardcoded at compile time to 8, but this value was only
> used if online_cpus() returned greater than 1.
> 
> However just using 8 threads regardless of the actual number of CPUs
> is inefficient if we have more than 8 CPUs, and potentially wasteful
> if we have fewer than 8 CPUs.

I agree with the need to exploit >8 CPUs, but I lose a lot of
performance when limiting the threads to the number of physical
CPUs.

Tests without your patch on master, just changing "#define
THREADS" from 8 to 2.  On a 2-core Intel Core2 Duo.

Producing lots of output:

    8 threads:

	$ time ~/u/src/git/bin-wrappers/git grep f > /dev/null
	0m14.02s user 0m3.64s sys 0m11.93s elapsed 148.07 %CPU
	$ time ~/u/src/git/bin-wrappers/git grep f > /dev/null
	0m13.86s user 0m3.70s sys 0m11.82s elapsed 148.57 %CPU

    2 threads:

	$ time ~/u/src/git/bin-wrappers/git grep f > /dev/null
	0m15.14s user 0m3.52s sys 0m24.22s elapsed 77.05 %CPU
	$ time ~/u/src/git/bin-wrappers/git grep f > /dev/null
	0m14.85s user 0m3.79s sys 0m24.20s elapsed 77.05 %CPU

Producing no output:

    8 threads:

	$ time ~/u/src/git/bin-wrappers/git grep unfindable-string
	0m1.14s user 0m3.68s sys 0m5.17s elapsed 93.22 %CPU
	$ time ~/u/src/git/bin-wrappers/git grep unfindable-string
	0m1.28s user 0m3.56s sys 0m5.15s elapsed 94.22 %CPU

    2 threads:

	$ time ~/u/src/git/bin-wrappers/git grep unfindable-string
	0m1.36s user 0m3.64s sys 0m16.82s elapsed 29.75 %CPU
	$ time ~/u/src/git/bin-wrappers/git grep unfindable-string
	0m1.38s user 0m3.66s sys 0m16.81s elapsed 30.04 %CPU

My workdir is on NFS, where even though the repository is fully
cached, the open()s must go to the server.  Using more threads
than CPUs makes it more likely that some thread isn't blocked.

You could add a #threads knob, but then we'd have to get
everybody on NFS to set that properly.  Or take a look at
preload_index() to see how it guesses at how many threads it
needs.

		-- Pete
