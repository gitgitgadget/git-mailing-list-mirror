From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [BUG] git submodule update is not fail safe
Date: Sat, 05 Jan 2013 15:50:22 +0100
Message-ID: <50E83DAE.1080500@web.de>
References: <50E74145.4020701@gmail.com> <7vzk0osjli.fsf@alter.siamese.dyndns.org> <50E83224.2070701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:50:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrV5G-0000pn-UI
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 15:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796Ab3AEOuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 09:50:32 -0500
Received: from mout.web.de ([212.227.17.11]:59389 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574Ab3AEOub (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 09:50:31 -0500
Received: from [192.168.178.41] ([91.3.188.151]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MUFGo-1TRgkf0hFK-00QaqN; Sat, 05 Jan 2013 15:50:23
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50E83224.2070701@web.de>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:8D3V3T8gTha9rsHvPSTA+FpP/BvQ9XD0d4msbF3Ok+U
 xnGt0toJDa+NPQUMIVSZLFts4uKVCCiGP0wuDSr+zB6BYpFf+t
 Jhd3+JdJ8DCyib54FkYXvcScZrH4elEQikW1tqUIatSus4RYAz
 XfjRlPpQ8cnY1jxrUukwfztUR53bmRGHAqjmaehhoan+b5r8Ew
 dGqvWWvizTvCvhSURV7bg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212696>

Am 05.01.2013 15:01, schrieb Jens Lehmann:
> Am 04.01.2013 22:51, schrieb Junio C Hamano:
>> Manlio Perillo <manlio.perillo@gmail.com> writes:
>>
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
>>
>> Sounds like a reasonable observation.  Jens, Heiko, comments?
> 
> The reason seems to be that clone leaves a partial initialized .git
> directory in case of connection problems. The next time submodule
> update runs it tries to revive the submodule from .git/modules/<name>
> but fails as there are no objects in it.
> 
> This looks like a bug in clone to me, as it takes precautions to clean
> up if something goes wrong but doesn't do that in this case. But while
> glancing over the code I didn't find out what goes wrong here.

I dug a bit deeper here and found the reason: In remove_junk() of
builtin/clone.c the junk_git_dir points to the gitfile in the
submodules work tree, not the .git/modules/<name> directory where
clone was told to put the git directory. Will see if I can come up
with a patch soonish ...
