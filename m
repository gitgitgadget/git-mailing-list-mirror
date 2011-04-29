From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] lookup_object(): Speed up 'git gc' by 12%, by reducing
 hash chain length
Date: Fri, 29 Apr 2011 09:38:25 +0200
Message-ID: <20110429073825.GA16941@elte.hu>
References: <20110427213502.GA13647@elte.hu>
 <7vtydh1r3q.fsf@alter.siamese.dyndns.org>
 <20110429072604.GA16371@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 09:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFiHc-0002UA-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 09:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab1D2Hib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 03:38:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55418 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833Ab1D2Hia (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 03:38:30 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFiHS-00040c-RM
	from <mingo@elte.hu>; Fri, 29 Apr 2011 09:38:28 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E1E033E2510; Fri, 29 Apr 2011 09:38:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110429072604.GA16371@elte.hu>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172432>


* Ingo Molnar <mingo@elte.hu> wrote:

> Find below a debug patch i use to run with a configurable spread.
> 
> Note, i just ran the patch on a different system and there the effect was 
> much less pronounced. So i'd prefer independent confirmation as well that it 
> speeds up things for others as well.
> 
> I'll run more numbers - maybe we are just very sensitive to the exact layout 
> of the object hash and a 16x spread created a different, more optimal layout.

Here are those numbers:

 $ for ((size=2; size<24; size++)); do printf "%5d: " $size; perf stat -e instructions:u -e cycles:u -e task-clock --sync --repeat 10 ./git --object-hash-spread $size gc 2>&1 | grep cycles; done 

    2:      9,362,801,669 cycles:u                 #    2.982 GHz                      ( +-  0.25% )
    3:      9,464,946,158 cycles:u                 #    2.993 GHz                      ( +-  1.17% )
    4:      9,382,214,358 cycles:u                 #    2.981 GHz                      ( +-  0.26% )
    5:      9,373,537,954 cycles:u                 #    2.986 GHz                      ( +-  0.24% )
    6:      9,492,635,404 cycles:u                 #    2.988 GHz                      ( +-  1.25% )
    7:      9,427,037,835 cycles:u                 #    2.982 GHz                      ( +-  0.19% )
    8:      9,311,764,604 cycles:u                 #    2.987 GHz                      ( +-  0.23% )
    9:      9,384,331,920 cycles:u                 #    2.985 GHz                      ( +-  0.27% )
   10:      9,388,460,044 cycles:u                 #    2.983 GHz                      ( +-  0.31% )
   11:      9,374,380,165 cycles:u                 #    2.984 GHz                      ( +-  0.25% )
   12:      9,417,466,827 cycles:u                 #    2.984 GHz                      ( +-  0.27% )
   13:      9,348,550,619 cycles:u                 #    2.982 GHz                      ( +-  0.12% )
   14:      9,369,435,508 cycles:u                 #    2.982 GHz                      ( +-  0.31% )
   15:      9,361,127,598 cycles:u                 #    2.983 GHz                      ( +-  0.27% )
   16:      9,402,077,866 cycles:u                 #    2.987 GHz                      ( +-  0.20% )
   17:      9,390,950,850 cycles:u                 #    2.985 GHz                      ( +-  0.27% )
   18:      9,355,126,542 cycles:u                 #    2.986 GHz                      ( +-  0.30% )
   19:      9,357,143,371 cycles:u                 #    2.974 GHz                      ( +-  0.33% )
   20:      9,372,977,607 cycles:u                 #    2.985 GHz                      ( +-  0.34% )
   21:      9,355,406,722 cycles:u                 #    2.985 GHz                      ( +-  0.45% )
   22:      9,342,730,882 cycles:u                 #    2.982 GHz                      ( +-  0.31% )
   23:      9,372,321,792 cycles:u                 #    2.982 GHz                      ( +-  0.28% )

They are utterly unconvincing - there seems to be no improvement, it's all 
within noise.

Thanks,

	Ingo
