From: =?iso-8859-1?Q?Matthias_A=DFhauer?= <mha1993@live.de>
Subject: [PATCH 0/2] Make stash a builtin
Date: Thu, 28 Jan 2016 20:38:47 +0100
Message-ID: <BLU436-SMTP27D65F59A444FA678FFD8AA5DA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <johannes.schindelin@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 28 20:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOsVH-0001Xk-U0
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 20:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967059AbcA1TpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 14:45:11 -0500
Received: from blu004-omc3s11.hotmail.com ([65.55.116.86]:49226 "EHLO
	BLU004-OMC3S11.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965584AbcA1TpI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 14:45:08 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2016 14:45:07 EST
Received: from BLU436-SMTP27 ([65.55.116.74]) by BLU004-OMC3S11.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Thu, 28 Jan 2016 11:40:06 -0800
X-TMN: [3Jga+3Ka4GskrQ4XeXfEe+0HPbRCgSSV]
X-Originating-Email: [mha1993@live.de]
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdFaAg2JPZ+vMJFjQIuqO1lT2t4fsA==
Content-Language: de
X-OriginalArrivalTime: 28 Jan 2016 19:40:04.0470 (UTC) FILETIME=[AF683960:01D15A03]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285022>

These are the first two Patches in an upcomming series of Patches to
convert git stash into a builtin command. This is mainly based on the
general performance of scripts running inside an interpreter (bash in
this case) running inside a POSIX emulation layer on Windows. Shell,
perl and python scripts are generaly a lot faster on Unix-like systems
compared to Windows systems. That does not mean that Unix-like systems
won't benefit from more native Git commands, but the effect is bigger
on Git for Windows.

These two patches port over the core non-patch part of git-stash into
native code using a separate helper command. This helper command is
intended as a temporary meassure and as such it's subject to change.
For this reason, I did not implement new regression tests, documentation
or localizations for this command.

I meassured the changes in excecution time for the stash related
regression tests on the same hardware running Windows 8.1 and
Kubuntu 15.10. Each result is the difference between the average of five
meassurements (six on Linux, because I lost count on the first run of
meassurements) each before and after these changes. I meassured the
following changes:

Windows:

t3903
real -5,10%
user -0,94%
sys +0,16% (10ms)

t3904
real -0,30%
user -2,98% (20ms)
sys +5,03%

t3905
real -4,03%
user -8,13%
sys +17,42%

t3906
real -2,57%
user +1,94%
sys +1,59%

Linux:

t3903
real +0,63%
user +10,87% (3ms)
sys +4,29% (4ms)

t3904
real -7,29%
user -30,61%
sys +5,77% (4ms)

t3905
real -7,29%
user -33,33% (2ms)
sys +20% (2ms)

t3906
real -0,88%
user -1,08% (1ms)
sys -2,22%

I added the asolute times where I think the difference is below the
meassurement precission (4ms on Linux) and on the two lowest absolute
differences on windows. A full log of all meassurement runs is available
at https://gist.github.com/rimrul/82adf3b368ed633263d2. Please note that
according to Johannes Schindelin, maintainer of Git for Windows, the
meassuring of sys time on Windows is unreliable. With that in mind,
in summary this is a slight increase in performance on Linux, and a more
noticeable increase on Windows.
