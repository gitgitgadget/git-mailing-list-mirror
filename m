From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [BUG] git submodule update is not fail safe
Date: Sat, 05 Jan 2013 15:01:08 +0100
Message-ID: <50E83224.2070701@web.de>
References: <50E74145.4020701@gmail.com> <7vzk0osjli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrUJb-0000k7-NW
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 15:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab3AEOBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 09:01:17 -0500
Received: from mout.web.de ([212.227.17.11]:57113 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755713Ab3AEOBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 09:01:15 -0500
Received: from [192.168.178.41] ([91.3.188.151]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MJCWU-1TpqPv0lDe-002rQd; Sat, 05 Jan 2013 15:01:09
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vzk0osjli.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:3UicxmrcvNl7j4Ag4TGlIHAQg3zsxROv62o+dax47Zv
 qJpMOTrpYc3FqZID4I+OAykq1Q9pO/f0XkKnUkptJMSST1q1TW
 ouUHXoebT7nj/Ga64ILiPO2VCPI5YsgjAqGpcGezLrZNMeXxCO
 btxeC2/sQA6CUElPhmq4BgqkxtSz30pPr6pEHbfB7d0uukHqF3
 L3V7pFubscVUieRnGs/LQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212690>

Am 04.01.2013 22:51, schrieb Junio C Hamano:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> $ git submodule update --init
>> ...
>> Submodule 'roms/vgabios' (git://git.qemu.org/vgabios.git/) registered
>> for path 'roms/vgabios'
>> fatal: unable to connect to anongit.freedesktop.org:
>> anongit.freedesktop.org[0: 131.252.210.161]: errno=Connection timed out
>>
>> Unable to fetch in submodule path 'pixman'
>>
>> $ git submodule update --init
>> fatal: Needed a single revision
>> Unable to find current revision in submodule path 'pixman'
>>
>> The problem is easy to solve: manually remove the pixman directory;
>> however IMHO git submodule update should not fail this way since it may
>> confuse the user.
> 
> Sounds like a reasonable observation.  Jens, Heiko, comments?

The reason seems to be that clone leaves a partial initialized .git
directory in case of connection problems. The next time submodule
update runs it tries to revive the submodule from .git/modules/<name>
but fails as there are no objects in it.

This looks like a bug in clone to me, as it takes precautions to clean
up if something goes wrong but doesn't do that in this case. But while
glancing over the code I didn't find out what goes wrong here.

If this isn't seen as a bug in clone, we could also remove the
.git/modules/<name> directory in module_clone() of git-submodule.s
h when the clone fails. Manilo, does the following patch remove the
problems you are seeing (after removing .git/modules/pixman manually)?

diff --git a/git-submodule.sh b/git-submodule.sh
index 2365149..4098702 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -208,7 +208,10 @@ module_clone()
                        git clone $quiet -n ${reference:+"$reference"} \
                                --separate-git-dir "$gitdir" "$url" "$sm_path"
                ) ||
-               die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
+               (
+                       rm -rf "$gitdir" &&
+                       die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
+               )
        fi

        # We already are at the root of the work tree but cd_to_toplevel will
