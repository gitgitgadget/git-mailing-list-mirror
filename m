From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 06/11] run-command: add kill_async() and 
	is_async_alive()
Date: Fri, 27 Nov 2009 17:04:31 +0100
Message-ID: <40aa078e0911270804i1a828ea6we1611047d37869f7@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
	 <200911262246.13342.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 17:04:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE3JH-00028z-DY
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 17:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbZK0QE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbZK0QE1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 11:04:27 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:57362 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbZK0QE0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 11:04:26 -0500
Received: by ewy19 with SMTP id 19so1561963ewy.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jvJoT5ZpBAapHCGbRe2vWAW9QkLwFIOP/GQdtjqDndo=;
        b=knxu6TqGU3ldTatsrATmYOXwAcKPZrq9MRomnG+lAKqDW8mwaiZS+yLXmZKnnzlh3z
         ZAweTU68MMvz0P44hJgW/uLq10nWEI7OkD2PagarDw4L1lZl3Z1yJBg6FwOnVTSpXaal
         HC5Sf1VFnlVnkRAwTwOxt2Jr7/Ayqk/UCSJmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Mw8TfjkrKDIPx4ew47blsxEwMWMX15HV64jpp1buc4spW0PtKSPGEkQzbx60xmQO/H
         ksltlUMA2LHBj83ZjMux5vTE3hn5KuSJAbVLNLTHuVwkLD9aubzuVYMibXOZJRzQ83DD
         3KW00Q1KYhf1J09DjZyP3gqqUA95RMa7Z1VL4=
Received: by 10.216.85.197 with SMTP id u47mr376087wee.133.1259337871406; Fri, 
	27 Nov 2009 08:04:31 -0800 (PST)
In-Reply-To: <200911262246.13342.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133907>

On Thu, Nov 26, 2009 at 10:46 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
>> +int kill_async(struct async *async)
>> +{
>> +#ifndef WIN32
>> + =A0 =A0 return kill(async->pid, SIGTERM);
>> +#else
>> + =A0 =A0 DWORD ret =3D 0;
>> + =A0 =A0 if (!TerminateThread(async->tid, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D error("killing thread failed: %lu"=
, GetLastError());
>
> Ugh! Did you read the documentation of TerminateThread()?
>
> We need to kill processes/threads when we detect that there are too m=
any
> connections. But TerminateThread() is such a dangerous function that =
we
> cannot pretend that everything is good, and we continue to accept
> connections.
>

Ouch, this is nasty. Something else needs to be done.

> Unless we find a different solution, I would prefer to punt and die i=
nstead.
>

Do you really think it's better to unconditionally take down the
entire process with an error, instead of having a relatively small
chance of stuff blowing up without any sensible error? I'm not 100%
convinced - but let's hope we'll find a proper fix.

>> + =A0 =A0 else if (!GetExitCodeThread(async->tid, &ret))
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D error("cannot get thread exit code=
: %lu", GetLastError());
>
> What should the exit code be good for? The return value of this funct=
ion can
> only be -1 (failure, could not kill) or 0 (success, process killed).
>

I thought wait_or_whine() returned the exit-code, so I wanted to be
somewhat consistent. But even if it does (haven't checked), it's
probably not be worth it - I'll remove this for the next iteration.

--=20
Erik "kusma" Faye-Lund
