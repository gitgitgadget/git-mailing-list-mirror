From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated submodules
Date: Sat, 07 Jul 2012 14:51:34 +0200
Message-ID: <4FF830D6.7080708@web.de>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de> <7v1ukppear.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 14:52:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnUV2-0005HN-0q
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 14:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab2GGMvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 08:51:49 -0400
Received: from mout.web.de ([212.227.17.12]:55722 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab2GGMvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 08:51:48 -0400
Received: from [192.168.178.48] ([91.3.183.25]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MddFQ-1SQSLn3Z3k-00Pmcs; Sat, 07 Jul 2012 14:51:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7v1ukppear.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:KsFGgbtOn+97vLHB43VgQ4GmqnI96poMOjyM9Awksdh
 HUGHx12wiHSuwbIkiImCHcpuT4b0fy7rY3lTaxfcYY2WqiaNhj
 18BjgcT988Mk+tWAMP81t1/MBupXqheQZW5o6LvAluv4k2mO9T
 kVKfUeGW6lii0k+D5/D5R1GSHdyuTqujWvoTsBDKtnMKGtjWRU
 UhMP74zwEv9xtkBIsZvWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201162>

Am 06.07.2012 08:57, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> Also apply the same policy as for regular files and
>> require forcing when the submodules HEAD is different than what is
>> recorded in the index. 
> 
> I think the "policy" for regular files is that "git rm $path" errors
> out to avoid losing information in $path.  Even if the HEAD in the
> submodule points at the same commit as recorded in the index, if the
> submodule directory has other changes that (cd $path && git status)
> would report, we would not want to remove it, no?
>
> I am not sure if the difference between $path/.git/HEAD and :$path
> (the version in the index) matters.  Maybe it does, maybe it
> doesn't.

Doh. I don't know how I got the idea it would be so, but a quick
test with checkout and rebase showed they ignore if a submodules
HEAD is different from the commit recorded. So plain rm should do
the same as long as it doesn't touch the submodule work tree and
I'll remove checking the HEAD from patch 1. I'll prepare v2 which
will also include an updated commit message.

> One possible sane behaviour of "git rm $path" might be:
> 
>  - If --force is given, remove it from the index and from the
>    working tree (i.e. "rm -rf $path"), but use the "gitfile"
>    facility to save $path/.git away to $GIT_DIR/modules/$name; error
>    out if the submodule directory $path cannot be removed like this.
>    We would probably want to remove "submodule.<name>.*" entries in
>    .gitmodules for <name> for which "submodule.<name>.path" matches
>    the $path.
> 
>  - If --cached is given, remove it from the index if the version in
>    the index match either HEAD or the $path/.git/HEAD, without
>    touching the working tree.  This is consistent with what happens
>    to a regular file.
> 
>  - If neither --force nor --cached is given, run an equivalent of
>    (cd $path && git status), and also check if $path/.git/HEAD
>    matches the index version.  Error out if the submodule directory
>    is dirty (again I am not sure about this part).  If the submodule
>    directory is clean, do the same as the case with --force.

What you describe here is exactly how I think "git submodule rm" and
"git rm --recurse-submodules" should behave.

The questions remaining for me are:

* What should a "git rm --no-recurse-submodules" do?

  I think it should try to follow the policy git core commands use:

  - don't touch the submodule's work tree

  - remove the submodule directory if it is empty and warn if not
    (currently it dies if not, to change that to a warning is the
    subject of patch 1)

  The more difficult question is if it should remove the submodule
  entry from .gitmodules (patch 2). As that file is part of the
  superproject's work tree and core git already learned to read
  configuration options for status, diff and fetch from it I think
  it's a good idea to help the user by doing so (but maybe we should
  make this configurable and/or add an option to enable/disable it).
  But on the other hand maybe users expect this only to happen when
  they use "git submodule rm" and "git rm" should leave .gitmodules
  alone?

* What should the default behavior of "git rm" be.

  I tend to think that as all other core git commands never
  manipulate a submodule's work tree without the --recurse-submodules
  option, rm should do the same. So I think we should default to
  the --no-recure-submodules case described above to not surprise the
  user. That makes checking the submodule for modifications unnecessary
  until the --recure-submodules option is implemented.


Does that make sense?
