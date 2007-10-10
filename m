From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] git-gui: add mingw specific startup wrapper
Date: Wed, 10 Oct 2007 08:55:28 +0200
Message-ID: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de>
References: <20071010053728.GM2137@spearce.org> <11919958073204-git-send-email-prohaska@zib.de> <20071010062218.GP2137@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 08:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfVSk-0001gu-8U
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 08:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbXJJGyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 02:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbXJJGyF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 02:54:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:33987 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820AbXJJGyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 02:54:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9A6rxY2012157;
	Wed, 10 Oct 2007 08:53:59 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1aa1f.pool.einsundeins.de [77.177.170.31])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9A6rwfu005280
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 10 Oct 2007 08:53:58 +0200 (MEST)
In-Reply-To: <20071010062218.GP2137@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60468>


On Oct 10, 2007, at 8:22 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>
>> diff --git a/git-gui/Makefile b/git-gui/Makefile
>> @@ -128,6 +128,7 @@ ifeq ($(uname_S),Darwin)
>>  endif
>>  ifneq (,$(findstring MINGW,$(uname_S)))
>>  	NO_MSGFMT=1
>> +	GITGUI_WINDOWS_WRAPPER := YesPlease
>>  endif
>
> I don't have this context in my Makefile so I can't apply this
> additional line here.  Can someone package up the patch that
> introduces the MINGW case above with a proper commit message,
> so I can apply it in front of this patch?
>

You need the patch
"git-gui: set NO_MSGFMT to force using pure tcl replacement in msysgit"
that I'll send in a follow-up mail. Apologies for forgetting about that.


>>  install: all
>> @@ -246,6 +257,9 @@ ifdef GITGUI_MACOSXAPP
>>  	$(QUIET)$(INSTALL_A0)'Git Gui.app' $(INSTALL_A1) '$(DESTDIR_SQ)$ 
>> (libdir_SQ)'
>>  	$(QUIET)$(INSTALL_X0)git-gui.tcl $(INSTALL_X1) '$(DESTDIR_SQ)$ 
>> (libdir_SQ)'
>>  endif
>> +ifdef GITGUI_WINDOWS_WRAPPER
>> +	$(QUIET)$(INSTALL_X0)git-gui.tcl $(INSTALL_X1) '$(DESTDIR_SQ)$ 
>> (libdir_SQ)'
>> +endif
>>  	$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL_R0)$p $ 
>> (INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)' &&) true
>>  	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(msgsdir_SQ)' $(INSTALL_D1)
>>  	$(QUIET)$(foreach p,$(ALL_MSGFILES), $(INSTALL_R0)$p $ 
>> (INSTALL_R1) '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
>
> I think you missed the entry in the uninstall and clean targets.

fixed.


>> diff --git a/git-gui/windows/git-gui.sh b/git-gui/windows/git-gui.sh
>> @@ -0,0 +1,16 @@
>> +#!/bin/sh
>> +# Tcl ignores the next line -*- tcl -*- \
>> +exec wish "$0" -- "$@"
>> +
>> +if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
>> +	cd [lindex $argv 1]
>> +	set argv [lrange $argv 2 end]
>> +	incr argc -2
>> +}
>
> Maybe we should just support this option directly in git-gui.
> Today we also support doing something like this by setting the
> GIT_DIR environment variable into a non-bare repository; see the
> "# repository setup" block of git-gui.sh.

would definitely be easier. It is an option that can be useful in  
general.
I'll not take care of this right away.

>> +set gitguidir [file dirname [info script]]
>> +regsub -all ";" $gitguidir "\\;" gitguidir
>> +set env(PATH) "$gitguidir;$env(PATH)"
>> +unset gitguidir
>> +
>> +source [file join [file dirname [info script]] git-gui.tcl]
>
> Hmmph.  The install target was going into libdir but the above
> source doesn't seem to read from there, its loading from the same
> location as the git-gui wrapper script.  You msys guys probably
> don't have $(libdir) == $(gitexecdir), do you?

Thanks for spotting that. I decided to put git-gui.tcl into
$(gitexecdir) with permissions 644.

A series of two patches will follow.

	Steffen
