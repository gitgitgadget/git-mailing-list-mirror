From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 2/2] connect: improve check for plink to reduce false
 positives
Date: Sat, 25 Apr 2015 18:03:22 +0200
Message-ID: <553BBACA.70704@web.de>
References: <20150423231403.GC274681@vauxhall.crustytoothpaste.net> <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net> <1429914505-325708-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	jakanapes@gmail.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 18:03:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym2YL-0001Hf-A5
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 18:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031625AbbDYQDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 12:03:33 -0400
Received: from mout.web.de ([212.227.17.11]:55636 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030227AbbDYQDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 12:03:32 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Maaur-1Z1E193fmT-00K5Dj; Sat, 25 Apr 2015 18:03:27
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1429914505-325708-2-git-send-email-sandals@crustytoothpaste.net>
X-Provags-ID: V03:K0:khO2de2tzcMPA4c1SrI22zdiNYSF02ub/PqpP7UpGzx6WvhZB63
 Cp16VEOG80usSxRhtD4qi0XW2vr444U0R3rs6fNA7k0fmQ9pAFQPrWXjPYuU0O7o8xkZH3v
 SkWvVCyW/OhRkfWbewBYvDS3GNinVxwwbFjeqBAW9Uhw7DTWn3B0ms2WDL2W/d63pl/xk5s
 YzA6/os0TPIU63OgpYKXg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267790>

On 2015-04-25 00.28, brian m. carlson wrote:
> The git_connect function has code to handle plink and tortoiseplink
> specially, as they require different command line arguments from
> OpenSSH.  However, the match was done by checking for "plink"
> case-insensitively in the string, which led to false positives when
> GIT_SSH contained "uplink".  Improve the check by looking for "plink" or
> "tortoiseplink" (or those names suffixed with ".exe") in the final
> component of the path.
> 
(I'm not sute if the commit message describes the problem deep enough
for readers which are not familar with all the details of the original
report):
A feature implemented for Windows may break things for e.g. Linux users)
The following may read exaggerated, so please read it as a suggestion.

The git_connect function has code to handle plink and tortoiseplink
specially, as they require different command line arguments compared to
OpenSSH (-P instead of -p, tortoiseplink uses -batch), commit 36ad53ffee6ed.
The special handling is only needed for Windows, and a sloppy
case-insensitve search for "plink" will trigger that an the extra
parameter "-batch" is added to the command line.

This was observed on a Linux system where a command line including
"/uplink_deploy/" was used.

There are different ways to improve the situation:
(The following mentions only plink, but assumes that tortoiseplink is handled
 similar)
a) Disable the plink/tortoiseplink special handling on non-Windows systems
b) Tighten the search for plink:
   Allow basename() == plink || !!strcasestr(ssh, "plink.exe")
c) Tighten the search for plink:
   Allow basename() == plink || !!strcasestr(ssh, "plink.exe")
d) Tighten the check for tortoiseplink.
   Today we set "int putty" to true when plink is found, and -batch
   is set when tortoiseplink is not found.
   This fixes the reported bug, but still has the -P problem.
e) Unix users typically use shell scripts and could use GIT_SSH_COMMAND.
   Declare the GIT_SSH as not-well-documented (and to obsolete ?) for non-Windows systems,


This patch implements c):
Extract the basename and compare it to plink, plink.exe respective
tortoiseplink/tortoiseplink.exe

Note that there is a slight risk of breakage for Windows users:
Strings like "myplink" or "plink-0.83" are no longer accepted.

-------------
I would probably vote for a), as Unix/Linux/Mac OS users don't use plink/tortoiseplink
at all. 
-------------
What about adding test-cases in t5601,
this will ease the documentation later.
f:/util/plink
/c/util/plink.exe
f:/util/tortoiseplink
/c/util/tortoiseplink.exe
/usr/local/uplink/sshwrapper.sh


Other opinions, other thoughts ?
