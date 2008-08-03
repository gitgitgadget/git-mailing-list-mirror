From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/3] git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'
Date: Sun, 3 Aug 2008 12:09:29 +0200
Message-ID: <58FBF585-377C-40A7-818E-6B47F8FD2EB8@zib.de>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de> <20080727212405.GA10075@spearce.org> <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de> <1217756103.48957bc76eda2@webmail.nextra.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 03 12:10:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPaXr-0008VM-Cg
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 12:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYHCKJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 06:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbYHCKJc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 06:09:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:38098 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbYHCKJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 06:09:31 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m73A9Bln018556;
	Sun, 3 Aug 2008 12:09:21 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db91b8e.pool.einsundeins.de [77.185.27.142])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m73A9AjI017129
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 3 Aug 2008 12:09:10 +0200 (MEST)
In-Reply-To: <1217756103.48957bc76eda2@webmail.nextra.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91221>


On Aug 3, 2008, at 11:35 AM, Johannes Sixt wrote:

> Zitat von Steffen Prohaska <prohaska@zib.de>:
>>
>> On Jul 27, 2008, at 11:24 PM, Shawn O. Pearce wrote:
>>
>>> Steffen Prohaska <prohaska@zib.de> wrote:
>>>> The new execdir has is two levels below the root directory, while
>>>> the old execdir 'bin' was only one level below.  This commit
>>>> adapts the discovery of oguilib that uses relative paths
>>>> accordingly.
>>> ...
>>>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>>>> index 940677c..baccd57 100755
>>>> --- a/git-gui/git-gui.sh
>>>> +++ b/git-gui/git-gui.sh
>>>> @@ -52,7 +52,9 @@ catch {rename send {}} ; # What an evil  
>>>> concept...
>>>> set oguilib {@@GITGUI_LIBDIR@@}
>>>> set oguirel {@@GITGUI_RELATIVE@@}
>>>> if {$oguirel eq {1}} {
>>>> -	set oguilib [file dirname [file dirname [file normalize $argv0]]]
>>>> +	set oguilib [file dirname \
>>>> +	             [file dirname \
>>>> +	              [file dirname [file normalize $argv0]]]]
>>>> 	set oguilib [file join $oguilib share git-gui lib]
>>>
>>> Hmmph.  This actually comes up incorrectly on my system.  The issue
>>> appears to be `git --exec-path` gives me $prefix/libexec/git-core,
>>> and git-gui installs its library into $prefix/libexec/share, which
>>> is wrong.  It should have gone to $prefix/share.
>>
>> I am not seeing this problem because I am installing using the
>> toplevel makefile, which sets and exports sharedir to $prefix/share.
>>
>>
>>> I wonder if this is better.  Your other two patches seem fine.
>>>
>>> --8<--
>>> [PATCH] git-gui: Correct installation of library to be $prefix/share
>>>
>>> We always wanted the library for git-gui to install into the
>>> $prefix/share directory, not $prefix/libexec/share.  All of
>>> the files in our library are platform independent and may
>>> be reused across systems, like any other content stored in
>>> the share directory.
>>>
>>> Our computation of where our library should install to was broken
>>> when git itself started installing to $prefix/libexec/git-core,
>>> which was one level down from where we expected it to be.
>>>
>>> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
>>> ---
>>> Makefile |    3 +++
>>> 1 files changed, 3 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index b19fb2d..f72ab6c 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -32,6 +32,9 @@ endif
>>> ifndef gitexecdir
>>> 	gitexecdir := $(shell git --exec-path)
>>> endif
>>> +ifeq (git-core,$(notdir $(gitexecdir)))
>>> +	gitexecdir := $(patsubst %/,%,$(dir $(gitexecdir)))
>>> +endif
>>
>> But gitexecdir has the correct value, no?  gitexecdir is used
>> at several places in the makefile.  It seems wrong to strip
>> 'git-core' from gitexecdir.  But I must admit that I do not
>> understand all the details of git-gui's Makefile.  So maybe
>> you know better.
>>
>> Isn't only the computation of sharedir based on gitexecdir wrong?
>>
>>> ifndef sharedir
>>> 	sharedir := $(dir $(gitexecdir))share
>>
>>
>> and could be replaced with this (instead of your patch):
>>
>>  ifndef sharedir
>> +ifeq (git-core,$(notdir $(gitexecdir)))
>> +       sharedir := $(dir $(patsubst %/,%,$(dir $(gitexecdir))))share
>> +else
>>         sharedir := $(dir $(gitexecdir))share
>>  endif
>> +endif
>
> This is not good enough in my environment.

This only fixes the installation directory.


> I run git-gui effectivly with
>
>   wish $prefix/libexec/git-core/git-gui
>
> (and I have $PATH set up to contain $bindir, but not $gitexecdir),  
> and this
> needs the original hunk with the three [file dirname ... ], because  
> $argv0
> points to $prefix/libexec/git-core/git-gui.

The original hunk fixes the discovery of oguilib, i.e.
from $prefix/libexec/git-core/git-gui to $prefix/share/git-gui/lib

I didn't recognize that the the 'three [file dinames ...]' have
not been applied because I had this change already in 4msysgit
(and still have).  Apologies for not checking this more carefully.


> I thought I understood what's going on, but I don't anymore.
>
> Mybe the relative discovery of oguilib must be conditional on the  
> "git-core"
> part as well, just like you discover sharedir?

Hmm... you are right.  If we want to maintain compatibility
with *both* directory layouts, obviously all computations
that depend on the layout need to be conditional on it.

	Steffen
