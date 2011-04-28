From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 22:32:05 +0200
Message-ID: <20110428203205.GD24755@elte.hu>
References: <20110428093703.GB15349@elte.hu>
 <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi>
 <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi>
 <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
 <20110428123617.GA2062@elie>
 <20110428133708.GA31383@elte.hu>
 <20110428151409.GA32025@elte.hu>
 <BANLkTim90XOLRBPtVCXFb1ptkmUvHGRqeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:35:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFXvv-0000LB-M2
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 22:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab1D1Uf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 16:35:26 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55643 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab1D1UfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 16:35:25 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1QFXse-0008PZ-Ed
	from <mingo@elte.hu>; Thu, 28 Apr 2011 22:32:08 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 2C02B3E2514; Thu, 28 Apr 2011 22:32:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTim90XOLRBPtVCXFb1ptkmUvHGRqeg@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172404>


* Erik Faye-Lund <kusmabite@gmail.com> wrote:

> Thanks. I also timed on my end (on Windows), and I came to the same 
> conclusion (but the improvements of your original was somewhat smaller in my 
> end; could be due to the test-case). It seems like the early-out wasn't the 
> only reason your original patch performed faster. It could be that memcmp 
> (probably) didn't get inlined, and the extra function call outweighs the 
> complexity. [...]

Function calls arent that heavy really. My measurements identified the 
following effects:

 - profiling of stalled cycles clearly pinpointed the REP MOV string 
   instruction.

 - the patched code had less branch-misses - the clearer and inlined open-coded 
   loop is probably easier for the CPU to speculate along - while REP MOV 
   string ops are 'opaque' and the result might be harder to speculate.

So i think the main benefit of my patch is that it avoids the REP MOV 
instruction.

Thanks,

	Ingo
