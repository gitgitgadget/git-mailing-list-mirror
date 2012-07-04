From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH 0/2] Teach rm to better handle submodules
Date: Wed, 04 Jul 2012 22:43:19 +0200
Message-ID: <4FF4AAE7.40604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 22:44:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmWQZ-0006sJ-Fu
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 22:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239Ab2GDUnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 16:43:53 -0400
Received: from mout.web.de ([212.227.15.3]:60090 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab2GDUne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 16:43:34 -0400
Received: from [192.168.178.48] ([91.3.155.233]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LwI2w-1Rk5Bq0qPW-018IWy; Wed, 04 Jul 2012 22:43:25
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
X-Provags-ID: V02:K0:y1wCewNfgD7SGkLoObSJOUP0vciGtJd60eM7UN7aWcR
 wjepJ0KodLrB42J0wCvzxkwUR1WvBR4ffoTo+UZn1osRi8FeHw
 Hg72Df0u7eyNDtbrETsmAnA7LL547ePWagidGVi7TztQsu/g3I
 bQqpztRCTqqbCdW7864HEUb+WOahxX9REBs0o4Y+dafx07XJIH
 TFD18yIIZvcD/KDE/QKxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201015>

This is a follow-up to gmane thread 200564 about teaching "git
submodule" the "rm" command. It has the intention to only having
to add a small amount of new code to the submodule script while
handling the heavy lifting in core git.

With this series I also intend to make submodule handling a bit
easier for users by teaching "git rm" to remove the submodule
section from the .gitmodules file, no matter if the submodule is
populated or not. Not being able to do that because the section
is not found there or the .gitmodules file is already deleted
will only issue a warning (with the intent to make the user aware
that "git rm" would do that for him in case he did that himself).

The first patch introduces a change in behavior: Using rm on a
populated submodule will not error out anymore but just issue a
warning instead (In a subsequent series I intend to teach rm the
--recurse-submodule option to really remove the submodule when
its .git is a gitfile. Then the usual checks for a submodule to
not accidentally loose any changes will be added, for now it just
compares the submodules HEAD to the commit recorded in the index).
Me thinks this change should be ok as it makes a former failing
call succeed, but maybe others disagree here.

The second patch removes the corresponding submodule section from
.gitmodules, which should be done when removing a submodule so it
can be done by git itself to help the user ("git submodule add"
automatically adds it, so "git [submodule] rm" should also remove
it).

This series adds some extra cost to a "git rm" because of the
parsing of the .gitmodules file and keeping track of which of the
to-be-deleted entries are submodules, but I don't expect that to
be noticeable. Parsing .gitmodules is needed in the long run
anyways to detect submodules whose work tree is configured to be
removed automatically (or not) and the extra 'is_submodule' flag
is only added for the files to be removed and setting and testing
it is fast.

I would appreciate if someone with more knowledge of the index
api than I have to review the stage_updated_gitmodules() in patch
2 to see if I'm doing something stupid there.

Opinions?


Jens Lehmann (2):
  rm: don't fail when removing populated submodules
  rm: remove submodules from the index and the .gitmodules file

 builtin/rm.c         | 42 +++++++++++++++++---------
 submodule.c          | 55 ++++++++++++++++++++++++++++++++++
 submodule.h          |  2 ++
 t/t3600-rm.sh        | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t7610-mergetool.sh |  6 ++--
 5 files changed, 172 insertions(+), 17 deletions(-)

-- 
1.7.11.1.105.g9f6831b
