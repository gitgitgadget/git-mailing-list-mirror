From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Sun, 20 Jan 2008 23:46:32 -0500
Message-ID: <20080121044632.GH24004@spearce.org>
References: <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net> <alpine.LSU.1.00.0801181948060.5731@racer.site> <alpine.LSU.1.00.0801182055340.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 05:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGoZ3-0002MH-MG
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 05:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975AbYAUEqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 23:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756979AbYAUEqi
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 23:46:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57256 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972AbYAUEqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 23:46:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JGoY9-0007TJ-Kw; Sun, 20 Jan 2008 23:46:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C115F20FBAE; Sun, 20 Jan 2008 23:46:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801182055340.5731@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71218>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> [PATCH] Fall back to po2msg when msgfmt is unavailable
> 
> diff --git a/git-gui/Makefile b/git-gui/Makefile
> index c109eab..c7921e7 100644
> --- a/git-gui/Makefile
> +++ b/git-gui/Makefile
> @@ -210,7 +211,8 @@ $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
>  update-po:: $(PO_TEMPLATE)
>  	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
>  $(ALL_MSGFILES): %.msg : %.po
> -	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
> +	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1) || \
> +	$(QUIET_MSGFMT0)$(PO2MSG) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)

That will cause the QUIET_MSGFMT0 script to echo twice; once
when we try to run msgfmt and again when we fallback to po2msg.

That messes with the user's display and won't look very nice coming
out of a supposedly quiet make.

In other words this is probably better:

+	$(QUIET_MSGFMT0)($(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< || \
+	$(PO2MSG) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< )$(QUIET_MSGFMT1)

But it is a lot uglier to read, and I tend to not like subshells.

-- 
Shawn.
