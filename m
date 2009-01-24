From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Sat, 24 Jan 2009 12:28:33 +0100
Message-ID: <200901241228.33690.markus.heidelberg@web.de>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901220113.32711.markus.heidelberg@web.de> <7vmydi4kiz.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 12:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQghl-0005hm-0o
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 12:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbZAXL2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 06:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbZAXL2M
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 06:28:12 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:60814 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZAXL2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 06:28:11 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 28F29F6FCFD1;
	Sat, 24 Jan 2009 12:28:10 +0100 (CET)
Received: from [89.59.96.236] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LQggL-0006XM-00; Sat, 24 Jan 2009 12:28:10 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vmydi4kiz.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18TqKNYtdZMsegvHElwrxoUAo7d+gp5Y06oPZ2f
	u8vf5ypmFubOZ9D6DOypLetq3QoFXOqlod8J5l6hAELBnSYGyt
	B2qjVZvUdetg/vEBvUqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106963>

Junio C Hamano, 23.01.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > Jeff King, 22.01.2009:
> > ...
> >> > ...
> >> > That would probably be better.
> >> 
> >> Do you want to work on it, or should it go into the "yeah, right, one
> >> day" section of my todo list?
> >
> > Yes, feel free to enlarge your todo list :)
> > There are some other things that I want to work on before, so better
> > don't count on me for this. But maybe I'll come up to it, before your
> > todo list pointer reaches this item, who knows.
> 
> Whatever.
> 
> I merged and pushed out these two patches but they seem to break
> format-patch big time if you have ui.color set to auto.
> 
> I will be reverting them out of 'next'.  Grumble.

Damn, sorry for this.

I looked at the code and found this in git_format_config():

	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
		return 0;

Which of course didn't handle color.ui, but that wasn't necessary before
the central color.ui handling from my patch.

So with the following diff it works:

-	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
+	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")
+				       || !strcmp(var, "color.ui")) {

Compared to f3aafa4 (Disable color detection during format-patch,
2006-07-09) and a159ca0 (Allow subcommand.color and color.subcommand
color configuration, 2006-12-13), which introduced !strcmp(var,
"diff.color") resp. !strcmp(var, "color.diff") at this place.

Or with this, which however would be a similar thing to what I tried to
remove from the code.

        git_config(git_format_config, NULL);
+       diff_use_color_default = 0;

format-patch is perhaps the only place where the commit has broken
things, because I didn't find other places, where color config options
were set, but not the corresponding variables. So it seems as if only
format-patch needed code like this to turn off the colors.

Markus
