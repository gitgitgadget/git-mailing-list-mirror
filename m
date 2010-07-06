From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git submodule: add submodules with git add -f <path>
Date: Tue, 06 Jul 2010 23:51:14 +0200
Message-ID: <4C33A552.5060008@web.de>
References: <1278098521-5321-1-git-send-email-avarab@gmail.com> <1278351183-18734-1-git-send-email-avarab@gmail.com> <7vmxu572w5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 23:51:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWG30-0007mD-7s
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 23:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab0GFVvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 17:51:17 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:37367 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab0GFVvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 17:51:16 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0B10616ACA258;
	Tue,  6 Jul 2010 23:51:15 +0200 (CEST)
Received: from [80.128.117.219] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OWG2s-0006xY-00; Tue, 06 Jul 2010 23:51:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7vmxu572w5.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19zyW3BNpFDRuJ7omVxJQ6/3ANdgBa+JIpXEhPj
	xbxk/w233tGkxmDlX15hynB/K3nxJ1sUmR39a6tcPdBf6Uyoxy
	f7yt+c3wtdAQGVZtUrLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150412>

Am 06.07.2010 04:36, schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>=20
>> Resubmitting this as a non-RFC.
>=20
> I don't recall any negative nor supporting discussion on this one.  W=
ill
> queue in 'pu' to see if people who do care about submodules complain.

=46irst: I think this patch fixes a bug. Without it "git submodule add"
leaves the work tree in an inconsistent state when either .gitmodules
or the submodule path are ignored: the submodule is checked out and
populated but the path and/or a new .gitmodules file is not added to
the index. And even worse: The advice of the failed "git add" called
from the script that using "-f" might help is misleading here, as
"git submodule add" doesn't know this option.

But while I think adding the --force option to the "git add .gitmodules=
"
makes perfect sense (as the submodule can't be successfully added until
it is recorded in this file and there is really no point in ignoring
=2Egitmodules when you decide to use submodules), I'm not so sure about
what to do when the submodule path itself is ignored.

I see two possible behaviors here:

a) We just ignore .gitignore and add the submodule anyways (which is
   what this patch does)

b) We do the same a "git add <ignored file>" does: Print an error
   message, maybe even tell the user to use a - still to be added -
   "--force" (or "-f") option and exit. But without checking out the
   submodule first nor adding or changing .gitmodules.

IMHO b) is more consistent with the current behavior of "git add". And
when you later decide that the submodules files should live in the
superproject and you drop the submodule, the then probably still
present entry in .gitignore might really shoot you in the foot when
you add new files there and they won't show up because they are still
ignored.

What do others think?
