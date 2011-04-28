From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 02:35:41 +0200
Message-ID: <20110428003541.GA18382@linux-mips.org>
References: <20110427225114.GA16765@elte.hu>
 <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 02:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFFCx-00055c-6s
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 02:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab1D1Afq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 20:35:46 -0400
Received: from eddie.linux-mips.org ([78.24.191.182]:50534 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab1D1Afp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 20:35:45 -0400
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491141Ab1D1Afl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2011 02:35:41 +0200
Content-Disposition: inline
In-Reply-To: <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172297>

On Wed, Apr 27, 2011 at 04:32:12PM -0700, Junio C Hamano wrote:

> > +static inline int is_null_sha1(const unsigned char *sha1)
> >  {
> > -	return memcmp(sha1, sha2, 20);
> > +	const unsigned long long *sha1_64 = (void *)sha1;
> > +	const unsigned int *sha1_32 = (void *)sha1;
> 
> Can everybody do unaligned accesses just fine?

Misaligned accesses cause exceptions on some architectures which then
are fixed up in software making these accesses _very_ slow.  You can
use __attribute__((packed)) to work around that but that will on the
affected architectures make gcc generate code pessimistically that is
slower than not using __attribute__((packed)) in case of proper
alignment.  And __attribute__((packed)) only works with GCC.

  Ralf
