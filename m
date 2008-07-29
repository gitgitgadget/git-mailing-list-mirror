From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2 v2] run-command (Windows): Run dashless "git <cmd>" (solves part of problem with system_path)
Date: Tue, 29 Jul 2008 07:51:42 +0200
Message-ID: <10AD8BDA-72E8-437D-8CFC-CDD71BB016F8@zib.de>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de> <1217308647-23673-1-git-send-email-prohaska@zib.de> <20080729052459.GC11947@spearce.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:52:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNi8g-0003hI-1H
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYG2Fvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbYG2Fvi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:51:38 -0400
Received: from mailer.zib.de ([130.73.108.11]:43249 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbYG2Fvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:51:36 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6T5pLCP003024;
	Tue, 29 Jul 2008 07:51:26 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9068d.pool.einsundeins.de [77.185.6.141])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6T5pJdi003800
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 29 Jul 2008 07:51:20 +0200 (MEST)
In-Reply-To: <20080729052459.GC11947@spearce.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90584>


On Jul 29, 2008, at 7:24 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>> We prefer running the dashless form, so we should use it in MinGW's
>> start_command(), too.
> ...
>> - We have non-builtins that are implemented in C, e.g. fast-import.c.
>>   These non-builtins will still compute wrong paths.
>
> This feels wrong to me.  fast-import probably won't be adversly
> impacted by not being able to read /etc/gitconfig, unless the user
> has set something like core.deltaBaseCacheLimit and is doing an
> incremental import.  But other non-builtins may be impacted.
>
> It feels like we're fixing this in the wrong place.  If the issue
> is we don't find our installation directory correctly, we should
> find our installation directory correctly, not work around it by
> calling builtins through the git wrapper.

For builtins it is not a work around but a real solution.  The
solution however needs to be tested without builtins installed
in libexec/git-core.   Note that Unix runs builtins using the
git wrapper too (see execv_git_cmd), so the patch makes the MinGW
port behaving more like the Unix version.

My patch however does not solve the problem for non-builtins, so I agree
that we are not fixing the real problem.

Maybe we could do the following:

  - Add a switch RELOCATABLE_PREFIX to the Makefile.

  - If RELOCATABLE_PREFIX is defined, system paths will not be
    interpreted as is, but a prefix will be computed at runtime.  For
    example, if git is installed in /some/patch/bin/git, then
    system_path("/etc") will return "/some/path/etc".

  - As Dscho proposed, system_path() needs to be intelligent enough
    to find the prefix for executables located either in bindir or in
    gitexecdir.

Adding a switch to the Makefile would make the relocation magic
explicit, instead of relying on relative paths.  This has also the
advantage that we can just use the default paths for gitexecdir,
template_dir, ... , instead of overriding them in MINGW section of the
Makefile.  We only would set RELOCATABLE_PREFIX there.  Actually some
more work is needed because prefix is used for defining system paths and
also for defining the installation directory.  Maybe we could add
installprefix to explicitly distinguish between the two purposes.

         Steffen
