From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 2/4] Submodules: Add the lib-submodule-update.sh
 test library
Date: Thu, 17 Apr 2014 23:08:06 +0200
Message-ID: <535042B6.7040800@web.de>
References: <5331B6F6.60501@web.de> <5331B741.6000606@web.de> <20140417164138.GP21805@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:08:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WatXm-0000aV-AU
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 23:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbaDQVIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2014 17:08:21 -0400
Received: from mout.web.de ([212.227.15.4]:51771 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbaDQVIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 17:08:19 -0400
Received: from [192.168.178.41] ([79.193.68.183]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LkEaw-1XCzB62riU-00cCWI; Thu, 17 Apr 2014 23:08:14
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140417164138.GP21805@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:JKtXXeAe6ONM9sPyRi1G+4Z77hzVzb+kF5z/NfnIaSAlGEQV407
 S0/efCbD2UocOT1yAhFos7/Ta8Ut+aN5zNcKOrKv+XukrfjE46ffqgxMy4V7zngyKqWYw0A
 qrlFrIRyXvaz4Pr8qOg+JbaCjiU9AvRT5jvnJG6Hmqzv9BwQ5GUDSEY0gKDXaKyfDTXTaOF
 yebtbDndWda1xSY5tccLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246451>

Am 17.04.2014 18:41, schrieb W. Trevor King:
> On Tue, Mar 25, 2014 at 06:05:05PM +0100, Jens Lehmann wrote:
>> *) When a submodule is replaced with a tracked file of the same name
>>    the submodule work tree including any local modifications (and
>>    even the whole history if it uses a .git directory instead of a
>>    gitfile!) is simply removed.
>> =E2=80=A6
>> I think the first bug really needs to be fixed, as that behavior is
>> extremely nasty. We should always protect work tree modifications
>> (unless forced) and *never* remove a .git directory (even when
>> forced).
>=20
> I think this should be covered by the usual =E2=80=9Cdon't allow chec=
kouts
> from dirty workdirs unless the dirty-ing changes are easily applied t=
o
> the target tree=E2=80=9D.

Nope, the target tree will be removed completely and everything in
it is silently nuked. It should be allowed with '-f', but only if
the submodule contains a gitfile, and never if it contains a .git
directory (which is just what we do for rm too).

> Are we waiting to land this series (or a successor) before starting o=
n
> a fix for this issue?

I think so, as this bug is there for a long time (so I see no urge
to fix it very soon) and my test harness is intended to document
this current bug (and then soon its fix).

>> *) Forced work tree updates happily manipulate files in the
>>    directory of a submodule that has just been removed in the
>>    superproject (but is of course still present in the work tree due
>>    to the way submodules are currently handled). This becomes
>>    dangerous when files in the submodule directory are overwritten
>>    by files from the new superproject commit, as any modifications
>>    to the submodule files will be lost) and is expected to also
>>    destroy history in the - admittedly unlikely case - the new
>>    commit adds a file named ".git" to the submodule directory.
>> =E2=80=A6
>> I'm not so sure about the second one. Even though I believe the
>> current behavior is not correct (switching commits should never mess
>> around in a submodule directory)
>=20
> This should also be covered by the usual =E2=80=9Cdon't allow checkou=
ts from
> dirty workdirs unless the dirty-ing changes are easily applied to the
> target tree=E2=80=9D.  We don't implement this yet, but I'd like to f=
orce
> users to move any about-to-be-clobbered state from their submodule
> into .git/modules/<name>/ (via commits or stashes) before allowing
> them to begin the checkout.  Once we've ensured that the state is
> preserved out-of-tree, then clobber away ;).

I'm intending to fix this in the recursive checkout series, as I'm
a) not sure if any users currently depend on that for a submodule
to directory transition and b) recursive checkout is the place to
consistently care about submodule modifications (the submodule
script doesn't do that and it is impossible to change that without
causing trouble to a lot of users.
