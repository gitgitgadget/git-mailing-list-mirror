From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf
 has not been set
Date: Wed, 23 Jul 2008 11:02:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807231051200.2830@eeepc-johanness>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 11:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLaEh-0008E0-M4
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 11:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbYGWJBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 05:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbYGWJBQ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 05:01:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:35314 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbYGWJBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 05:01:15 -0400
Received: (qmail invoked by alias); 23 Jul 2008 09:01:13 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp034) with SMTP; 23 Jul 2008 11:01:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Yrwd3zJGYW/09UmDSLpgNpEtAd+SkWVLE129jQM
	VsVO0fepq+3t0T
X-X-Sender: user@eeepc-johanness
In-Reply-To: <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89612>

Hi,

On Wed, 23 Jul 2008, Steffen Prohaska wrote:

> On Jul 23, 2008, at 3:31 AM, Johannes Schindelin wrote:
> 
> >When a file's crlf attribute is explicitely set, it does not make sense 
> >to ignore it when adding the file, just because the config variable 
> >core.autocrlf has not been set.
> 
> Your patch is not about core.autocrlf unset, but about 
> core.autocrlf=false.

No, no, no!

It is about autocrlf _unset_, i.e. when the user was _not_ explicit!

> >The alternative would be risking to get CR/LF files into the repository 
> >just because one user forgot to set core.autocrlf.
> 
> Git could help the user *and* the maintainer of the repository if we
> chose core.autocrlf=input as the default on Unix.

NO!

The machinery behind core.autocrlf _does_ slow down Git, even if only by a 
few percent.  But with patch queues as maintainers of busy projects 
encounter frequently, this makes a difference.

So no, I am _totally_ opposed to punishing Unix users for Windows' faults.  
Totally.

> >diff --git a/convert.c b/convert.c
> >index 78efed8..d038d2f 100644
> >--- a/convert.c
> >+++ b/convert.c
> >@@ -126,7 +126,7 @@ static int crlf_to_git(const char *path, const char *src,
> >size_t len,
> > struct text_stat stats;
> > char *dst;
> >
> >-	if ((action == CRLF_BINARY) || !auto_crlf || !len)
> >+	if ((action == CRLF_BINARY) || (!auto_crlf && action < 0) || !len)
> 
> I think we should strictly follow the documentation, so this should read
> 
> +       if ((action == CRLF_BINARY) || (!auto_crlf && action != CRLF_INPUT) ||
> !len)

NO!

Your version would break action == CRLF_TEXT.

> >diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> >index 1be7446..0bb3e6f 100755
> >--- a/t/t0020-crlf.sh
> >+++ b/t/t0020-crlf.sh
> >@@ -436,4 +436,14 @@ test_expect_success 'invalid .gitattributes (must not
> >crash)' '
> >
> >'
> >
> >+test_expect_success 'attribute crlf is heeded even without core.autocrlf' '
> >+
> >+	echo "allcrlf crlf=input" > .gitattributes &&
> >+	git config --unset core.autocrlf &&
> 
> You should set core.autocrlf explicitly to false:
> 
>   git config core.autocrlf false

But this is _not_ what I want!  I want it to be _unset_.  Yes, at the 
moment, auto_crlf is initialized to 0.  But I do not _care_ what it is 
set.  I want this test to succeed when the user did _not_ set autocrlf.

> Otherwise the test would pick up the user's global default.

It will not.  We went to great pains not to pick up global defaults in the 
test suite.

> ... and we should verify that we only treat crlf=input specially, but not
> "crlf".

Umm... Why?  Why should a file marked "crlf=true" be allowed to be checked 
in _with_ CRs?

Ciao,
Dscho
