From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 16/17] grep: read -f file with strbuf_getline_crlf()
Date: Mon, 4 Jan 2016 13:27:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041321360.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com> <1450303398-25900-17-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:28:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4Ew-0007hR-SM
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbcADM1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:27:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:55964 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbcADM1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:27:48 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LztD9-1aBRhK228B-0153rE; Mon, 04 Jan 2016 13:27:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450303398-25900-17-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:SX/n1TNNzQCjeTx1ZzST/2ANFJJ1lPJxmnk8BMaoRNDvr2PQhtR
 Gd+LqCilreJpXU20J0GJF1K5iF6Ax8mZru2u8LVf79MO9yWB9PuvHUPqSXtx9yMubs4ehvm
 KgqHp+Jv6I3qZWoIEXWhFxCopxWpWltzmW+BMhE3t16ighMJWNFvMgV8XQOnXRJun/SEG5L
 9uruOj/fH6X+fCFpx56NQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e7vvryTBLWg=:/ymFZ2vtFRIPNogcLoF2kV
 VrGGOtD4c69ny1Th7l/IDGwJonoaR2w40rIoyg4/bH8fjMiZZvip82jSJQe4Hf7GQfxC3GFRH
 EdgaffuIM0qeRW+gM15YgVB9WmtM1qqa/lSawaqzo1fLSafTdMKYI6uMW0rtV1hOBngH6a7kY
 sGwp2/OwkEOzAhq4ICDOK4+DhRamWjnkeqlTtgb639lfrsr7e7AFLqdU5hfXjdlg2KSV4mq3A
 GIW3Jcttl9RLgbC7nZrIfmJ6B6aj83yMnNp+FDRlfL8heAaN2jMWIHZ/mq59u0uJOGpJn0OoC
 vAmlkLJVXfUJYf8zlSi2EBqX5Gj715wO10rI4NlFaXR4chaRAEPqsFkn7ksxsZ5RfShNNJCzB
 cjZRe7yjYOW9XPEc5lU8s6DUIHSq8BZvTpqKH0K+hpUWjLjSz4xbtyIf77T3BItI+Atby8DYp
 8fFpcKRS+muuqo+uvd9TVNUTnwvDGroRDNW6HFBuhZ94RH3BKLqdCsVN+za28e2KOfY+/IXw+
 xk32EwC13rCWIrMuYft7kHvpAe5h+VbEvPOkQlGcJDN6qlZBzG13NYjkMUyKdctP4xOWK59xG
 31B6VlA4O1RPkLTcoD3lDpKoc22dkKYv0UJ29OPnyn6HanH/D5T9J78WfohlbEqXpTxiOnLkq
 fBv4ds9AmX+6P8ygznSoW4Bvo39Cpu9KKi+l9HApmNWyIxCIWF9SvwsY1WtNNuYQcF2WqJdzU
 ztRjCmQDuzMX2aCpR/KBdQiC+Mm7pfTuCn+NPRipqMk5NnuDxP7ZB0esBnzVoyJAv+yYZ92U 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283301>

Hi Junio,

On Wed, 16 Dec 2015, Junio C Hamano wrote:

> This is iffy; you may actually be trying to find a line with ^M in
> it on a system whose line ending is LF.  You can of course work it
> around by having a line that has "^M^M^J", let the strbuf_getline_crlf() eat
> the last "^M^J", leaving just the single "^M" as the pattern.

Thanks for being careful.

Having said that, `grep` operates on lines of text, and CR is established
as a non-text byte, so I would argue that the previous behavior was
actually incorrect: if you searched for, say, `abc$` in a CR/LF delimited
file, the outcome would not have met my expectation of correct behavior.

Ciao,
Dscho
