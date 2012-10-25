From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] fix 'make test' for HP NonStop
Date: Thu, 25 Oct 2012 12:21:44 +0200
Message-ID: <002e01cdb29a$893593f0$9ba0bbd0$@schmitz-digital.de>
References: <001e01cdb061$c25f6380$471e2a80$@schmitz-digital.de> <20121025095826.GM8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:22:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRKZz-0001vC-VF
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767Ab2JYKWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:22:11 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:50628 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422736Ab2JYKWK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 06:22:10 -0400
Received: from DualCore (dsdf-4db53cfd.pool.mediaWays.net [77.181.60.253])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MSpj3-1Tsf983GDN-00SVMI; Thu, 25 Oct 2012 12:21:53 +0200
In-Reply-To: <20121025095826.GM8390@sigill.intra.peff.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQI2sQMOQ5ANofWD9kSBDc7fafINHQKHXgBmluOSE/A=
Content-Language: de
X-Provags-ID: V02:K0:XY00ZP8c1FVX3tJ55x8wD7gb2Is0h5yRlmO37flA2gQ
 Mbnz+hbp3LbhFTeH5Pd0wEENVrZ+bjpDSqXuBkKXHvFMSpzMUp
 bXRVYZTQB70P++mHqWqxHlMswwdEcQ7PmWi54WKW96pa2F0mj9
 9IdxD6BggQ5qS44U+hHiwguiyfkra6tP5udnEHXzQxrFUcRQzb
 Q3YNsRQaxN2CQHQO2yzyqxV5zPDOGXIf8jSW171Z3pTKaoonBW
 qoFNvKgzIe7w/s/rWs2/r7bgEp6qKXS9KeU1ZNtJIvYXeeJIfJ
 8W9fvVhzutT3rsKygynSQ/zUiV3wTqUjUbyCiomIVpm+2aZClX
 oK4sh3q+xhjhKydgajqQc8GJdG/+MiHrEvMK15G+J+ED/6QyJR
 wmzmS1824ZEEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208382>

> From: Jeff King [mailto:peff@peff.net]
> Sent: Thursday, October 25, 2012 11:58 AM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] fix 'make test' for HP NonStop
> 
> On Mon, Oct 22, 2012 at 04:30:17PM +0200, Joachim Schmitz wrote:
> 
> > +	# for 'make test'
> > +	# some test don't work with /bin/diff, some fail with /bin/tar
> > +	# some need bash, and some need ${prefix}/bin in PATH first
> > +	SHELL_PATH=${prefix}/bin/bash
> > +	SANE_TOOL_PATH=${prefix}/bin
> 
> This feels a little too specific to go in our Makefile. Do we have any
> reason to think that where you are installing git is going to be the
> same place you have bash and other sane tools? Wouldn't this mean that
> things work when you run "make" but mysteriously break when you run
> "make prefix=/my/local/install/of/git"?

Well, "make" won't break (I think), but "make test" very well might.

Well, so far all OpenSource packages ported to HP NonStop (at least the ones on ituglib.connect-community.org) use prefix=/usr/local and there is no intention to change that.
A few (bash, vim, coreutils, tar, gzip, bzip2) get delivered with the system meanwhile (rather than having to be downloaded and installed by the customer) and live in /usr/corutiles. Still more are needed (e.g. diff , make).
The next lines in my patch cater for that, it is missing though an automatic switch.
Such a switch would be possible, using 'uname -r' and 'uname -v', but pretty convoluted

Pseudo code:
If (`uname -r` = J06 && `uname -v` >= 14) || (`uname -r`= H06 && `uname -v` >= 25)
	SHELL_PATH=/usr/coreutils/bin/bash
	SANE_TOOL_PATH=/usr/coreutils/bin:${prefix}/bin
else
	SHELL_PATH=${prefix}/bin/bash
	SANE_TOOL_PATH=${prefix}/bin
endif	

I didn't deem it worth the effort. As mentioned it'd most likely still need stuff from /usr/local/bin

And someone wanting prefix somewhere else could still do
PATH=/usr/local/bin:$PATH make prefix=/my/local/install/of/git 
And so find what's need in either the 1st or 2nd path of PATH

Bye, Jojo
