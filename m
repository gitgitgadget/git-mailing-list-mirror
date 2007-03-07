From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: do not optimize when DEBUG=1
Date: Wed, 7 Mar 2007 13:37:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703071319520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703062249540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EE854E.210EDAFF@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 13:37:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOvOl-00029U-AK
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 13:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbXCGMhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 07:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbXCGMhU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 07:37:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:41854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965133AbXCGMhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 07:37:17 -0500
Received: (qmail invoked by alias); 07 Mar 2007 12:37:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 07 Mar 2007 13:37:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JM01cCw+JS7i+C3Gp4W3HGGVWrx1wfP9V+JCnt1
	NzSLeaWLu1duxt
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EE854E.210EDAFF@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41667>

Hi,

On Wed, 7 Mar 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > You can do that now by removing just the object files containing the
> > code you want to debug, and saying "make DEBUG=1".
> > [...]
> > -CFLAGS = -g -O2 -Wall
> > +CFLAGS = -g -Wall
> > +ifndef DEBUG
> > +       CFLAGS += -O2
> > +endif
> 
> I think the shortcut to remove just the interesting object file does not 
> work because Makefile notices (the GIT-CFLAGS rule) that there are "new 
> flags or prefix", and so recompiles everything.

That is unfortunatley true, and was hidden in my test by something 
completely unrelated.

I do something completely different now:

@@ -846,7 +841,8 @@ TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):\
 
 GIT-CFLAGS: .FORCE-GIT-CFLAGS
 	@FLAGS='$(TRACK_CFLAGS)'; \
-	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
+	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" -a \
+		    -z "$(IGNORE_GIT_CFLAGS)"; then \
 		echo 1>&2 "    * new build flags or prefix"; \
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi

... and in my config.mak, there is

ifdef DEBUG
	ALL_CFLAGS := $(filter-out -O2,$(ALL_CFLAGS))
	IGNORE_GIT_CFLAGS = YesPlease
endif

I'm happy now.

Ciao,
Dscho
