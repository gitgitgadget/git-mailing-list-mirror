From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Including git-describe info as version strings for generic "-v"
 output
Date: Sun, 22 Jan 2012 17:03:41 +0100
Message-ID: <4F1C335D.7020802@dirk.my1.cc>
References: <CAG_NL2So7cf6o+en9ktHGr94Eu5WJ9giWq6OmSxK+ZL4RdtaGA@mail.gmail.com> <7vd3acbtn3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Harry portobello <harryportobello@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 17:05:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rozuj-0002Kr-AG
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 17:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab2AVQEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 11:04:39 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:52395 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab2AVQEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 11:04:38 -0500
Received: from [217.87.115.113] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1RoztO-00044f-Vu; Sun, 22 Jan 2012 17:03:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vd3acbtn3.fsf@alter.siamese.dyndns.org>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188965>

Am 21.01.2012 23:03 schrieb Junio C Hamano:
> Harry portobello <harryportobello@gmail.com> writes:
> 
>> I hope the subject makes sense -- I'll explain what I'm trying to do.
> 
> Perhaps take a look at GIT-VERSION-GEN that is part of the Git source?


At work, we have the same "problem". I solved it like so:

version.h:
----------------------------------------------
#ifndef __version_h__
#define __version_h__

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Returns a version string as defined with the -D compiler switch.
 */
char const * software_version();

#ifdef __cplusplus
}
#endif

#endif
----------------------------------------------


version.c:
----------------------------------------------
#include "version.h"

char const * software_version()
{
    return SW_VERSION;
}
----------------------------------------------

And then make sure that ONLY version.c gets compiled like this:

gcc -DSW_VERSION=\"$(git describe --dirty)\" \
    [other options] \
    -c version.c -o version.o

Actually I use Scons to build my software (not Make). Scons
automatically keeps track of dependencies and changed compiler switches
between its runs. Thus it will re-compile version.c if the output of
git-describe changes. That's why Scons users must make sure that the
-D-switch is given only to version.c (else Scons would re-compile ALL
files because of the different argument to -D).

If you are using Make then make sure that version.c gets compiled
always. The drawback is that your app will be re-linked with every
single Make run.

That's why I prefer Scons: it calculates the dependencies on a checksum
basis. If the *contents* of version.c together with the compiler options
didn't change, it won't re-compile it. Furtermore: if the *contents* of
version.o didn't change, it won't re-link. Timestamps don't matter to
Scons. But that's another topic :-)

HTH
    Dirk
