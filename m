From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Makefile: abort on shells that do not support ${parameter%word}
 expansion
Date: Tue, 06 Sep 2011 15:30:33 -0500
Message-ID: <4KpnoijSRGBLoF4pZj7c1eShQRupu7h-gkSjM2Ej6nnefH-n7qWuAkoY4CEocEsJb6XCaqhrtHT3uQL2W3DKu0yJ1rAh-UxeXocbOTvMhBw@cipher.nrlssc.navy.mil>
References: <7vbouzxy7g.fsf@alter.siamese.dyndns.org> <RSBDfxxpq50B8raodg0TA26S3QuHAy1YIJsAy6F4U0luolR_nfBc83hs9i2B3xAWjXI-EHymM00@cipher.nrlssc.navy.mil> <2i2CfjMHrXZ7dV7ciebqx3PjO-cpw8QIplKjdcx_bGmGt8jgFr3efDXeMJMcn_I9ZH6X71aBdaO7vGiRBQuhbukGEWFJZQuvWtq079u0KYQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com, David Barr <davidbarr@google.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:30:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R12ID-0005vt-85
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab1IFUap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 16:30:45 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:57417 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040Ab1IFUao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:30:44 -0400
Received: by mail3.nrlssc.navy.mil id p86KUYTc024517; Tue, 6 Sep 2011 15:30:34 -0500
In-Reply-To: <2i2CfjMHrXZ7dV7ciebqx3PjO-cpw8QIplKjdcx_bGmGt8jgFr3efDXeMJMcn_I9ZH6X71aBdaO7vGiRBQuhbukGEWFJZQuvWtq079u0KYQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Sep 2011 20:30:33.0811 (UTC) FILETIME=[D4083A30:01CC6CD3]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180833>

On 09/06/2011 02:32 PM, Brandon Casey wrote:
> 
> FYI:
> It should be possible to test this patch on a modern system by doing
> something like:
> 
>    make SHELL_PATH=/bin/false
> 
> and you should see something like this:
> 
>    make: *** [please_set_SHELL_PATH_to_a_more_modern_shell] Error 1
> 
> But beware, GNU make 3.81 seems to have a bug which sends it into an
> infinite loop.

Just a clarification, I didn't mean you'd actually be able to test
the patch for correctness, but the above would at least allow you to
stress the code path.

But, with the Makefile in its current form (patch or no patch) the
above still works.  Setting SHELL_PATH=/bin/false produces the desired
error message.

There still appears to be a bug in make 3.81 which is triggered when
using an ancient shell, it just manifests itself in a different way
using our current Makefile.  Right now, make 3.81 will enter an
infinite loop when it tries to include the GIT-VERSION-FILE.  When
something like /bin/sh on Solaris processes the GIT-VERSION-GEN
script, it produces the following incorrect string in the
GIT-VERSION-FILE:

   GIT_VERSION = $(expr $(echo $(git describe --match v[0-9]* --abbrev=4 HEAD 2>/dev/null) | sed -e s/-/./g) : v*\(.*\))

which then becomes part of the Makefile when GIT-VERSION-FILE is
included on line 264.  GNU make then begins to print the following
to the terminal repeatedly:

   GIT_VERSION = $(expr $(echo $(git describe --match v[0-9]* --abbrev=4 HEAD 2>/dev/null) | sed -e s/-/./g) : v*\(.*\))

GIT-VERSION-FILE should really have a dependency on
shell_compatibility_test since it calls GIT-VERSION-GEN which may use
shell features that are not provided by the configured shell.  If that
dependency is added so that the GIT-VERSION-FILE rule looks like this:

   GIT-VERSION-FILE: shell_compatibility_test FORCE
   	@$(SHELL_PATH) ./GIT-VERSION-GEN
   -include GIT-VERSION-FILE

_then_, we get the behavior I described originally, where

   make SHELL_PATH=/bin/false

sends the make process into an infinite loop, with no output to the
terminal.

Either way, with GNU make 3.81, you get an infinite loop when you use
a shell that should trigger our error message.

-Brandon
