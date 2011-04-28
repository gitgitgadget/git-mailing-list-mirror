From: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 10:18:17 +0200
Message-ID: <20110428081817.GA29344@pcpool00.mathematik.uni-freiburg.de>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428003541.GA18382@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ralf Baechle <ralf@linux-mips.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 10:40:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFMlx-0000pD-59
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 10:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab1D1IkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 04:40:21 -0400
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:35495
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932124Ab1D1IkS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 04:40:18 -0400
X-Greylist: delayed 1312 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Apr 2011 04:40:18 EDT
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1QFMQT-0004td-FH; Thu, 28 Apr 2011 10:18:17 +0200
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1QFMQT-0007eC-Ct; Thu, 28 Apr 2011 10:18:17 +0200
Content-Disposition: inline
In-Reply-To: <20110428003541.GA18382@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172323>

* Ralf Baechle <ralf@linux-mips.org> [110428 02:35]:
> On Wed, Apr 27, 2011 at 04:32:12PM -0700, Junio C Hamano wrote:
> 
> > > +static inline int is_null_sha1(const unsigned char *sha1)
> > >  {
> > > -	return memcmp(sha1, sha2, 20);
> > > +	const unsigned long long *sha1_64 = (void *)sha1;
> > > +	const unsigned int *sha1_32 = (void *)sha1;
> > 
> > Can everybody do unaligned accesses just fine?
> 
> Misaligned accesses cause exceptions on some architectures which then
> are fixed up in software making these accesses _very_ slow.  You can
> use __attribute__((packed)) to work around that but that will on the
> affected architectures make gcc generate code pessimistically that is
> slower than not using __attribute__((packed)) in case of proper
> alignment.  And __attribute__((packed)) only works with GCC.

Even __attribute__((packed)) usually does not allow arbitrary aligned
data, but can intruct the code to generate code to access code
misaligned in a special way. (I have already seen code where thus
accessing a properly aligned long caused a SIGBUS, because it was
aligned because being in a misaligned packed struct).

In short: misaligning stuff works on x86, everywhere else it is disaster
waiting to happen. (And people claiming compiler bugs or broken
architectures, just because they do not know the basic rules of C).

	Bernhard R. Link
