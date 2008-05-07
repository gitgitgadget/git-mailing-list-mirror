From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 07 May 2008 15:14:26 +0200
Message-ID: <4821AB32.8090700@viscovery.net>
References: <1210149355875-git-send-email-mike@abacus.co.uk>	 <4821992F.4060201@viscovery.net> <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 15:15:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtjUT-0002ii-Si
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 15:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbYEGNOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 09:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbYEGNOf
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 09:14:35 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62902 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYEGNOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 09:14:30 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JtjTV-0006uC-RP; Wed, 07 May 2008 15:14:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A754169F; Wed,  7 May 2008 15:14:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81436>

Mike Ralphson schrieb:
> 2008/5/7 Johannes Sixt <j.sixt@viscovery.net>:
>>  I'm trying this patch on AIX 4.3.3 (sigh!) with gcc3. I get this:
>>
>>  git-compat-util.h:209:1: warning: "fopen" redefined
>>  In file included from git-compat-util.h:51,
>>                  from builtin.h:4,
>>                  from git.c:1:
>>  /usr/local/lib/gcc-lib/powerpc-ibm-aix4.3.2.0/3.2.1/include/stdio.h:110:1:
>>  warning: this is the location of the previous definition
>>
>>  Line 110 in ...include/stdio.h is inside a #ifdef _LARGE_FILES section and
>>  says:
>>
>>  #define fopen fopen64
>>
>>  Did you also get this warning? Is _LARGE_FILES support solved in a
>>  different way on 5.3?
> 
> The warning (I get rather a lot of them) is caused by the
> compat/fopen.c included when FREAD_READS_DIRECTORIES is defined. I
> tried moving the #undef fopen to git-compat-util.h but that resulted
> in a broken build and me reaching the end of my limited ability with
> c.
> 
> In file included from cache.h:4,
>                  from daemon.c:1:
> git-compat-util.h:209:1: warning: "fopen" redefined
> In file included from git-compat-util.h:51,
>                  from cache.h:4,
>                  from daemon.c:1:
> /opt/freeware/lib/gcc-lib/powerpc-ibm-aix5.3.0.0/3.3.2/include/stdio.h:110:1:
> warning: this is the location of the previous definition

So you we in the same boat.

> The warnings are harmless, though untidy.
> I don't believe it's anything to do with _LARGE_FILES. Could you try
> building first with one commented out, then the other? I don't think I
> have access to a 4.3.3 box any more.

Untidy, yes; harmless: not necessarily. It has a lot to do with _LARGE_FILES.

The #define fopen in git-compat-util.h essentially defeats the effect of
_LARGE_FILES as far as fopen() calls are concerned: If
FREAD_READS_DIRECTORIES is not defined, fopen() would be redirected to
fopen64(), but when it is defined, it is redirected to git_fopen(), which
in turn uses fopen() instead of fopen64() (due to the #undef in
compat/fopen.c).

This might be dangerous if some other function of the f*64() family uses
the FILE* that the fopen() call returned. I don't know if there is such a
usage pattern somewhere in git.

Why did you need _LARGE_FILES in the first place?

-- Hannes
