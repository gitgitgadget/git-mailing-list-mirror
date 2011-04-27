From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 01:10:12 +0200
Message-ID: <20110427231012.GA17807@elte.hu>
References: <20110427225114.GA16765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFDvY-00010L-U0
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 01:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760157Ab1D0XNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 19:13:44 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51174 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757148Ab1D0XNn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 19:13:43 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1QFDs7-0005q8-32
	from <mingo@elte.hu>; Thu, 28 Apr 2011 01:10:20 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id B35543E250F; Thu, 28 Apr 2011 01:10:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110427225114.GA16765@elte.hu>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172288>


* Ingo Molnar <mingo@elte.hu> wrote:

> I suspect 'git fsck' got faster as well, but i have not measured that.

It got faster a bit:

 #
 # Before:
 #

 $ perf stat --sync --repeat 5 ./git fsck >/dev/null

 Performance counter stats for './git fsck' (5 runs):

      32011.163574 task-clock               #    0.998 CPUs utilized            ( +-  0.08% )
                46 context-switches         #    0.000 M/sec                    ( +-  2.77% )
                 0 CPU-migrations           #    0.000 M/sec                    ( +-  0.00% )
            60,279 page-faults              #    0.002 M/sec                    ( +- 12.21% )
   102,597,312,322 cycles                   #    3.205 GHz                      ( +-  0.08% )
    27,303,254,781 stalled-cycles           #   26.61% of all cycles are idle   ( +-  2.51% )
   152,359,589,474 instructions             #    1.49  insns per cycle        
                                            #    0.18  stalled cycles per insn  ( +-  0.03% )
    13,225,673,730 branches                 #  413.158 M/sec                    ( +-  0.06% )
     1,226,749,384 branch-misses            #    9.28% of all branches          ( +-  0.08% )

       32.083499222  seconds time elapsed  ( +-  0.07% )

 #
 # After:
 #

 Performance counter stats for './git fsck' (5 runs):

      31605.868825 task-clock               #    0.998 CPUs utilized            ( +-  0.08% )
                42 context-switches         #    0.000 M/sec                    ( +-  3.92% )
                 0 CPU-migrations           #    0.000 M/sec                    ( +-100.00% )
            62,979 page-faults              #    0.002 M/sec                    ( +- 14.72% )
   101,297,181,916 cycles                   #    3.205 GHz                      ( +-  0.08% )
    27,173,614,721 stalled-cycles           #   26.83% of all cycles are idle   ( +-  0.49% )
   155,074,859,385 instructions             #    1.53  insns per cycle        
                                            #    0.18  stalled cycles per insn  ( +-  0.01% )
    14,132,018,558 branches                 #  447.133 M/sec                    ( +-  0.02% )
     1,207,054,592 branch-misses            #    8.54% of all branches          ( +-  0.03% )

       31.675135938  seconds time elapsed  ( +-  0.08% )

so there's a +1.3% speedup.

But git fsck stalls are dominated by libz and other external libraries:

# Events: 30K stalled-cycles
#
# Overhead  Command          Shared Object                        Symbol
# ........  .......  .....................  ............................
#
    36.13%      git  libz.so.1.2.5          [.] 0x90be          
    18.27%      git  libc-2.13.90.so        [.] __memcpy_ssse3_back
    13.68%      git  libcrypto.so.1.0.0d    [.] sha1_block_data_order
     5.85%      git  libz.so.1.2.5          [.] inflate
     4.69%      git  git                    [.] lookup_object
     4.58%      git  libz.so.1.2.5          [.] adler32
     4.30%      git  libz.so.1.2.5          [.] 0xc280          
     2.19%      git  libc-2.13.90.so        [.] _int_malloc

So those dominate execution time.

	Ingo
