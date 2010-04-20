From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fix checkout of large files to network shares under 
 Windows XP
Date: Tue, 20 Apr 2010 22:49:16 +0200
Message-ID: <4BCE134C.8090802@lsrfire.ath.cx>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx> <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 22:49:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4KO1-0000GV-Em
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 22:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab0DTUt2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 16:49:28 -0400
Received: from india601.server4you.de ([85.25.151.105]:49668 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0DTUt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 16:49:27 -0400
Received: from [10.0.1.100] (p57B7F4C7.dip.t-dialin.net [87.183.244.199])
	by india601.server4you.de (Postfix) with ESMTPSA id 712E62F805A;
	Tue, 20 Apr 2010 22:49:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145396>

Am 20.04.2010 14:42, schrieb Sebastian Schuberth:
>> Shouldn't the loop be left in the successful case, too?  write(2) is
>> allowed to write less than requested, so the caller already needs to
>> deal with that case anyway.
>=20
> I prefer to make the wrapper as transparent as possible. If a direct
> call to write would not write less than requested, the wrapper should
> not either.

After the call failed, we don't know how many bytes would have been
written had it succeeded.

But I agree with Albert's reasoning to use the knowledge of a working
chunk size in order to minimize the number of write(2) calls.  Otherwis=
e
we'd have to search for a working size again and again, generating lots
of failing calls.

> I've updated work/issue-409 in 4msysgit.git accordingly.

This patch doesn't help in the test case I cobbled together quickly.
It's a Windows XP SP3 client on VMWare mapping a file share exported by
a Netapps filer, over a VPN.  It's very slow, and I admit that it's a
weird setup.  I wouldn't actually use it that way, but couldn't find
another file share momentarily.

I can check out a 1MB file, but checking out a 32MB file fails.  I've
added a fprintf() to the loop and I can see that it's halving the size
and retries, as intended, until it eventually hits zero.

The file is created using the correct file size (32MB), though.The firs=
t
failed write(2) call needs to be undone somehow before we can try again=
,
it seems.  Do we have to seek back or truncate the file?

Replacing the body of mingw_write() with the following line allows me t=
o
check out the 32MB file, by the way:

	return write(fd, buf, min(count, 1024 * 1024));

Ren=C3=A9
