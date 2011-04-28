From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 12:36:50 +0200
Message-ID: <20110428103650.GA18530@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <20110427231748.GA26632@elie>
 <20110428063625.GB952@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Fr?d?ric Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:37:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFOas-0003Lv-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 12:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab1D1KhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 06:37:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53419 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab1D1KhD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 06:37:03 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFOaa-0004ZH-No
	from <mingo@elte.hu>; Thu, 28 Apr 2011 12:36:55 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E0D043E2514; Thu, 28 Apr 2011 12:36:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110428063625.GB952@elte.hu>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172348>


* Ingo Molnar <mingo@elte.hu> wrote:

> Having said that, it would be nice if someone could test these two patches on a 
> modern AMD box, using the perf stat from here:
> 
>   http://people.redhat.com/mingo/tip.git/README
> 
>   cd tools/perf/
>   make -j install
> 
> and do something like this to test git gc's performance:
> 
>   $ perf stat --sync --repeat 10 ./git gc
> 
> ... to see whether these speedups are generic, or somehow Intel CPU specific.

To follow up on this angle, i've now tested both 'git gc' performance 
improvement patches on an Opteron box:

 #
 # Before:
 #

 Performance counter stats for './git gc' (10 runs):

       6400.903957 task-clock               #    0.977 CPUs utilized            ( +-  0.09% )
             1,537 context-switches         #    0.000 M/sec                    ( +-  3.12% )
               118 CPU-migrations           #    0.000 M/sec                    ( +-  7.08% )
            40,879 page-faults              #    0.006 M/sec                    ( +-  0.03% )
    14,768,724,649 cycles                   #    2.307 GHz                      ( +-  0.09% )
     9,185,135,676 instructions             #    0.62  insns per cycle          ( +-  0.08% )
     1,883,860,739 branches                 #  294.312 M/sec                    ( +-  0.16% )
        99,800,253 branch-misses            #    5.30% of all branches          ( +-  0.34% )

        6.548348691  seconds time elapsed  ( +-  1.01% )

 #
 # After:
 #

 Performance counter stats for './git gc' (10 runs):

       6078.191492 task-clock               #    0.979 CPUs utilized            ( +-  0.09% )
             1,511 context-switches         #    0.000 M/sec                    ( +-  2.85% )
               104 CPU-migrations           #    0.000 M/sec                    ( +-  6.29% )
            41,410 page-faults              #    0.007 M/sec                    ( +-  0.04% )
    14,024,602,415 cycles                   #    2.307 GHz                      ( +-  0.09% )
     <not counted> stalled-cycles          
    11,364,757,635 instructions             #    0.81  insns per cycle          ( +-  0.06% )
     2,612,173,056 branches                 #  429.762 M/sec                    ( +-  0.09% )
       109,257,789 branch-misses            #    4.18% of all branches          ( +-  0.74% )

        6.209749362  seconds time elapsed  ( +-  0.51% )

So they bring an about +5.3% improvement.

Thanks,

	Ingo
