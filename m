From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH 1/2] MSVC: Do not close stdout to prevent a
 crash
Date: Sat, 19 Nov 2011 21:11:48 +0100
Message-ID: <4EC80D84.2010202@kdbg.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com,
	kusmabite@gmail.com, Johannes.Schindelin@gmx.de
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 21:11:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRrGY-0003Lr-9S
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab1KSULx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:11:53 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:19754 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753352Ab1KSULx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 15:11:53 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7829E130045;
	Sat, 19 Nov 2011 21:11:49 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D59CF19F440;
	Sat, 19 Nov 2011 21:11:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <1321710345-2299-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185704>

Am 19.11.2011 14:45, schrieb Vincent van Ravesteijn:
> When compiled with MSVC, git crashes on Windows when calling
> fstat(stdout) when stdout is closed. fstat is being called at the end of
> run_builtin and this will thus be a problem for builtin command that close
> stdout. This happens for 'format-patch' which closes stdout after a call to
> freopen which directs stdout to the format patch file.

This crash happens because of the some drainbramage in the MS's newer C
runtime: Its functions never return EINVAL (like fstat should in this
case), but it is assumed that cases where EINVAL should be returned are
programming errors, and the application is redirected, via an "invalid
agument handler" to abort() instead. (It is advertized as a security
feature.)

> To prevent the crash and to prevent git from writing cruft into the patch
> file, we do not close stdout, but redirect it to "nul" instead.

A more robust solution is to add invalidcontinue.obj to the linker
command line. This installs an invalid argument handler that does not
abort, and restores a sane behavior.

-- Hannes
