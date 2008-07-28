From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/3] git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'
Date: Mon, 28 Jul 2008 07:01:59 +0200
Message-ID: <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de> <20080727212405.GA10075@spearce.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:03:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNKsu-00066h-2J
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbYG1FB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbYG1FB4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:01:56 -0400
Received: from mailer.zib.de ([130.73.108.11]:59213 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbYG1FBz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 01:01:55 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6S51feF010730;
	Mon, 28 Jul 2008 07:01:46 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83842.pool.einsundeins.de [77.184.56.66])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6S51aLs029509
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 28 Jul 2008 07:01:36 +0200 (MEST)
In-Reply-To: <20080727212405.GA10075@spearce.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90402>


On Jul 27, 2008, at 11:24 PM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>> The new execdir has is two levels below the root directory, while
>> the old execdir 'bin' was only one level below.  This commit
>> adapts the discovery of oguilib that uses relative paths
>> accordingly.
> ...
>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index 940677c..baccd57 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -52,7 +52,9 @@ catch {rename send {}} ; # What an evil concept...
>> set oguilib {@@GITGUI_LIBDIR@@}
>> set oguirel {@@GITGUI_RELATIVE@@}
>> if {$oguirel eq {1}} {
>> -	set oguilib [file dirname [file dirname [file normalize $argv0]]]
>> +	set oguilib [file dirname \
>> +	             [file dirname \
>> +	              [file dirname [file normalize $argv0]]]]
>> 	set oguilib [file join $oguilib share git-gui lib]
>
> Hmmph.  This actually comes up incorrectly on my system.  The issue
> appears to be `git --exec-path` gives me $prefix/libexec/git-core,
> and git-gui installs its library into $prefix/libexec/share, which
> is wrong.  It should have gone to $prefix/share.

I am not seeing this problem because I am installing using the
toplevel makefile, which sets and exports sharedir to $prefix/share.


> I wonder if this is better.  Your other two patches seem fine.
>
> --8<--
> [PATCH] git-gui: Correct installation of library to be $prefix/share
>
> We always wanted the library for git-gui to install into the
> $prefix/share directory, not $prefix/libexec/share.  All of
> the files in our library are platform independent and may
> be reused across systems, like any other content stored in
> the share directory.
>
> Our computation of where our library should install to was broken
> when git itself started installing to $prefix/libexec/git-core,
> which was one level down from where we expected it to be.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> Makefile |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b19fb2d..f72ab6c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -32,6 +32,9 @@ endif
> ifndef gitexecdir
> 	gitexecdir := $(shell git --exec-path)
> endif
> +ifeq (git-core,$(notdir $(gitexecdir)))
> +	gitexecdir := $(patsubst %/,%,$(dir $(gitexecdir)))
> +endif

But gitexecdir has the correct value, no?  gitexecdir is used
at several places in the makefile.  It seems wrong to strip
'git-core' from gitexecdir.  But I must admit that I do not
understand all the details of git-gui's Makefile.  So maybe
you know better.

Isn't only the computation of sharedir based on gitexecdir wrong?

> ifndef sharedir
> 	sharedir := $(dir $(gitexecdir))share


and could be replaced with this (instead of your patch):

  ifndef sharedir
+ifeq (git-core,$(notdir $(gitexecdir)))
+       sharedir := $(dir $(patsubst %/,%,$(dir $(gitexecdir))))share
+else
         sharedir := $(dir $(gitexecdir))share
  endif
+endif

	Steffen
