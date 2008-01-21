From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Mon, 21 Jan 2008 10:37:23 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211034040.5731@racer.site>
References: <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net> <alpine.LSU.1.00.0801181948060.5731@racer.site> <alpine.LSU.1.00.0801182055340.5731@racer.site>
 <20080121044632.GH24004@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 11:38:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGu2b-0007RM-VG
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 11:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758904AbYAUKhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 05:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758814AbYAUKhk
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 05:37:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:40094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758868AbYAUKhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 05:37:40 -0500
Received: (qmail invoked by alias); 21 Jan 2008 10:37:38 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp049) with SMTP; 21 Jan 2008 11:37:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DYCcV+UPD4LY11tCUvSoOq/A9pSLhbGgJX9P/xj
	5ixLl9pqEbBnuv
X-X-Sender: gene099@racer.site
In-Reply-To: <20080121044632.GH24004@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71257>

Hi,

On Sun, 20 Jan 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > [PATCH] Fall back to po2msg when msgfmt is unavailable
> > 
> > diff --git a/git-gui/Makefile b/git-gui/Makefile
> > index c109eab..c7921e7 100644
> > --- a/git-gui/Makefile
> > +++ b/git-gui/Makefile
> > @@ -210,7 +211,8 @@ $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
> >  update-po:: $(PO_TEMPLATE)
> >  	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
> >  $(ALL_MSGFILES): %.msg : %.po
> > -	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
> > +	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1) || \
> > +	$(QUIET_MSGFMT0)$(PO2MSG) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
> 
> That will cause the QUIET_MSGFMT0 script to echo twice; once when we try 
> to run msgfmt and again when we fallback to po2msg.
> 
> That messes with the user's display and won't look very nice coming out 
> of a supposedly quiet make.
> 
> In other words this is probably better:
> 
> +	$(QUIET_MSGFMT0)($(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< || \
> +	$(PO2MSG) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< )$(QUIET_MSGFMT1)
> 
> But it is a lot uglier to read, and I tend to not like subshells.

It was exactly this ugliness which made me not do it.

Note: There might be yet a better way.  Instead of trying each and every 
time, we could detect the presence of msgfmt with something like this:

+ifeq $(shell msgfmt2 2>/dev/null >/dev/null; echo $?) = 127
+	MSGFMT = $(TCL_PATH) po/po2msg.sh
+endif

This is not tested, yet, tough,

Ciao,
Dscho
