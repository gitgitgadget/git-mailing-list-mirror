From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [BUG] git submodule update is not fail safe
Date: Sat, 05 Jan 2013 15:07:09 +0100
Message-ID: <50E8338D.4080703@web.de>
References: <50E74145.4020701@gmail.com> <7vzk0osjli.fsf@alter.siamese.dyndns.org> <50E83001.9000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	"W. Trevor King" <wking@drexel.edu>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:07:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrUPS-0006A6-Tu
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 15:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722Ab3AEOHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 09:07:19 -0500
Received: from mout.web.de ([212.227.17.12]:62339 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab3AEOHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 09:07:18 -0500
Received: from [192.168.178.41] ([91.3.188.151]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MbyMU-1Tbbya17DC-00JHw0; Sat, 05 Jan 2013 15:07:11
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50E83001.9000505@gmail.com>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:T7UemnThlL9Q6ANGdLe5coEMDTB7hTfCkhiD5JBABpV
 GZ5GPZ9BKTEh7iXJwvXDpgI2Loz/Sp3wupqnUn4hJz5vWIg1mr
 Lfld6R0sqxoGHDOYtjgp+xXIknbpktp1VG4t3M4G2h/7f2zvGn
 I0DO6mH1c2FjYXAXGltYrhcY8REg5SeJ3PLUq3TmXHkX5GbSFX
 X+G8AD3kBum2A92rgZazQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212693>

Am 05.01.2013 14:52, schrieb Manlio Perillo:
> Il 04/01/2013 22:51, Junio C Hamano ha scritto:
>> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>>> $ git submodule update --init
>>> ...
>>> Submodule 'roms/vgabios' (git://git.qemu.org/vgabios.git/) registered
>>> for path 'roms/vgabios'
>>> fatal: unable to connect to anongit.freedesktop.org:
>>> anongit.freedesktop.org[0: 131.252.210.161]: errno=Connection timed out
>>>
>>> Unable to fetch in submodule path 'pixman'
>>>
>>> $ git submodule update --init
>>> fatal: Needed a single revision
>>> Unable to find current revision in submodule path 'pixman'
>>>
>>> The problem is easy to solve: manually remove the pixman directory;
>>> however IMHO git submodule update should not fail this way since it may
>>> confuse the user.
> 
>> Sounds like a reasonable observation.  Jens, Heiko, comments?
> 
> I have found another, related problem.
> 
> Today I tried to update qemu submodules again, however the command
> failed with an "obscure" error message:
> 
> $ git submodule update pixman
> fatal: Needed a single revision
> Unable to find current revision in submodule path 'pixman'
> 
> 
> The pixman submodule is the one that I failed to update in the very begin.
> The problem is not with the pixman or qemu repository: if I clone again
> qemu (with the --recursive option), all is ok.
> 
> The problem is with the private working copy (in .git/modules/pixman)
> being corrupted:
> 
> $git log
> fatal: bad default revision 'HEAD'.
> 
> The HEAD file contains "ref: refs/heads/master", but the refs/heads
> directory is empty.

Yep, as I explained in my other email the partially set up
.git/modules/pixman is the reason for the trouble you have.

> By the way: since git submodule is a porcelain command, IMHO it should
> not show to the user these low level error message; at least it should
> give more details.
> As an example, in this case it could say something like:
> 
>   the local module "pixmap" seems to be corrupted.
>   Run xxx to remove the module and yyy to create it again.
> 
> The ideal solution is, for submodule update, to never leave an
> incomplete directory; that is: the update command should be atomic.

I agree that submodule update should not leave an inconsistent state.
In that case you wouldn't see any low level error messages (which I
think is ok if something the porcelain didn't expect to happen occurs,
like it did here).
