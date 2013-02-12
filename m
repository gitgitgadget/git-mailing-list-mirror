From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 23:00:34 +0000
Message-ID: <20130212230034.GA22779@river>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com>
 <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:01:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Or7-0005Bu-8A
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758507Ab3BLXA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:00:58 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:38707 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757784Ab3BLXA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:00:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 167BFCDA5D7;
	Tue, 12 Feb 2013 23:00:56 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svpCgiFmtIQx; Tue, 12 Feb 2013 23:00:54 +0000 (GMT)
Received: from river (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EEABFCDA5D1;
	Tue, 12 Feb 2013 23:00:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216216>

On Tue, Feb 12, 2013 at 02:45:34PM -0800, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > John Keeping wrote:
> >
> >>   Documentation/Makefile: fix inherited {html,info,man}dir
> >
> > This doesn't seem to have hit the list.
> 
> More importantly, 
> 
> >> When using the top-level install-doc target the html, info and man
> >> target directories are inherited from the top-level Makefile by the
> >> documentation Makefile as relative paths, which is not expected and
> >> results in the files being installed in an unexpected location.
> 
> I am not sure what problem it is trying to address.  During every
> cycle "make doc && make install-man install-html" is run for all
> integration branches and it didn't cause any problems.
> 
> A wild guess.  John, are you using config.mak.autogen?

Close - plain config.mak.

I set $prefix there and ran "make install-doc".  That installed the man
pages in Documentation/share/man/ in my Git source directory.

> I _think_ exporting mandir/html/infodir from the top-level Makefile
> is wrong to begin with.  We should drop the "export mandir" from
> there.
> 
> Giving them unusual meaning (e.g. "mandir = share/man") is already
> bad and that needs to be fixed by limiting this "oh, on some
> platforms we compile-in GIT_MAN_PATH as a relative path to an
> unspecified place" insanity only to where -DGIT_MAN_PATH=<path> is
> defined.  The path used there does not help the building and
> installation of the documentation at all, so the variable used for
> the purpose of giving that <path> should not be named the same way
> as the variable used on Documentation/Makefile to name the real path
> in the first place.
> 
> Perhaps rename these to runtime_{man,html,info}dir or something and
> make sure {man,html,info}dir are defined as the real paths whose
> default values begin with $(prefix)?

Would it be sensible to define the values for these variables (with
absolute paths) in a separate top-level file like config.mak.uname
(defaults.mak maybe?) and include that in both Documentation/Makefile
and Makefile, then calculate the relative path from $(prefix) to
$({man,html,info}dir) for the compiled-in values.


John
