From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Tue, 17 Feb 2015 09:51:38 +0100
Message-ID: <vpqr3tozzs5.fsf@anie.imag.fr>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
	<vpqiof14qu8.fsf@anie.imag.fr>
	<13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, tboegi@web.de
To: Fairuzan Roslan <fairuzan.roslan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:51:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNdsi-0007kY-Jl
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 09:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292AbbBQIvo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2015 03:51:44 -0500
Received: from mx1.imag.fr ([129.88.30.5]:45642 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809AbbBQIvo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 03:51:44 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1H8pbUc015179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Feb 2015 09:51:37 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1H8pcbO020833;
	Tue, 17 Feb 2015 09:51:38 +0100
In-Reply-To: <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com> (Fairuzan
	Roslan's message of "Tue, 17 Feb 2015 11:22:28 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 17 Feb 2015 09:51:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1H8pbUc015179
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1424767899.2894@iO/kz/K86eWRfludkRRyEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263937>

=46airuzan Roslan <fairuzan.roslan@gmail.com> writes:

> $ git clone https://github.com/robbyrussell/oh-my-zsh.git
> Cloning into 'oh-my-zsh'...
> remote: Counting objects: 11830, done.
> remote: Total 11830 (delta 0), reused 0 (delta 0)
> Receiving objects: 100% (11830/11830), 2.12 MiB | 481.00 KiB/s, done.
> Resolving deltas: 100% (6510/6510), done.
> warning: unable to unlink /Volumes/installer/oh-my-zsh/.git/objects/p=
ack/tmp_pack_zjPxuc: Operation not permitted

This should be fixable from Git itself, by replacing the calls to
"unlink" with something like

int unlink_or_chmod(...) {
	if (unlink(...)) {
		chmod(...); // give user write permission
		return unlink(...);
	}
}

This does not add extra cost in the normal case, and would fix this
particular issue for afp shares. So, I think that would fix the biggest
problem for afp-share users without disturbing others. It seems
reasonable to me to do that unconditionnally.

> $ rm -rf oh-my-zsh/.git/objects/pack/tmp_*
> rm: oh-my-zsh/.git/objects/pack/tmp_idx_oUN1sb: Operation not permitt=
ed
> rm: oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: Operation not permit=
ted

What happens if you do "rm -fr oh-my-zsh/.git/objects/pack/" (i.e.
remove the directory, not the files)?

If you can still remove the directory, then I'd say the solution above
could be sufficient: the user isn't supposed to interfer with the
content of .git/objects other than by using Git, and if he or she does,
then asking a chmod prior to an rm seems reasonable.

If you can't, then it's another problematic use-case (basically, you
can't just "rm -fr" a whole clone), and then it deserves at least an
opt-in configuration to get writable pack files.

(Unfortunately, I suspect we're in the later case)

> If you insist on setting the tmp idx & pack file permission to 0444 a=
t
> least give it a u+w permission whenever you try to unlink and rename
> it so it won=E2=80=99t fail.

Yes. In case you hadn't guessed, this is precisely what I had in mind
when I asked "Is it a problem when using Git [...] or when trying to
remove files outside Git?".

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
