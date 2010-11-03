From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Wed, 03 Nov 2010 21:11:27 +0000
Message-ID: <877hgunmdc.fsf@fox.patthoyts.tk>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 22:18:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDkio-0001El-Mu
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 22:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab0KCVSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 17:18:13 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:59987 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880Ab0KCVSM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 17:18:12 -0400
Received: from [172.23.144.249] (helo=asmtp-out5.blueyonder.co.uk)
	by smtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PDkiZ-00085h-W2; Wed, 03 Nov 2010 21:18:05 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PDkcC-0006xM-Gs; Wed, 03 Nov 2010 21:11:28 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2F4E7218FE; Wed,  3 Nov 2010 21:11:27 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com> (Erik
	Faye-Lund's message of "Wed, 3 Nov 2010 17:31:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160641>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>Here's hopefully the last iteration of this series. The previous version
>only got a single complain about a typo in the subject of patch 14/15, so
>it seems like most controversies have been settled.

I pulled this win32-daemon branch into my msysgit build tree and built
it. I get the following warnings:

    CC daemon.o
daemon.c: In function 'service_loop':
daemon.c:674: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
daemon.c:676: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
daemon.c:681: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
daemon.c:919: note: initialized from here
daemon.c:679: warning: dereferencing pointer 'sin_addr' does break strict-aliasing rules
daemon.c:675: note: initialized from here
daemon.c:691: warning: dereferencing pointer 'sin6_addr' does break strict-aliasing rules
daemon.c:682: note: initialized from here

Otherwise it builds clean. The daemon running on Windows7 seems to be
working fine for both ipv4 and ipv6 connections (I tried both).

However, monitoring the resource usage in procexp it looks like there is
a handle leak. Each 'git ls-remote' over ipv6 is gaining 16 handles that
do not appear to be released. They're all process handles for dead
processes it looks like, so possibly there is a missing waitpid() or
something similar for the 'git daemon -serve' subprocess. Doing this
over ipv4 leaks 2 handles per request.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
