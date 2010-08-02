From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Mon, 02 Aug 2010 12:02:10 +0200
Message-ID: <vpqwrs9nxi5.fsf@bauges.imag.fr>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<4C52E6E1.20101@xiplink.com> <vpqd3u53sd2.fsf@bauges.imag.fr>
	<AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 12:06:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfruE-0000MK-Fo
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 12:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab0HBKCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 06:02:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41390 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab0HBKCR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 06:02:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o729pkAJ011653
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 11:51:46 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OfrqV-00042v-1M; Mon, 02 Aug 2010 12:02:11 +0200
In-Reply-To: <AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Sat\, 31
 Jul 2010 13\:56\:09 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Aug 2010 11:51:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o729pkAJ011653
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281347509.6701@9vEH1YV3AzIRMpeFm/3oDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152401>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jul 30, 2010 at 15:24, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>
>>>> The name of the command may be subject to discussions. I've chosen
>>>> "run", but maybe "shell" would be OK too. In both cases, it doesn'=
t
>>>> allow the one-letter version since both "r" and "s" are already us=
ed.
>>>
>>> "exec" with one-letter "x"?
>>
>> Thanks, that sounds good, yes. Any other thought?
>
> I like "exec".

Yes, it's the best proposal IMHO. "x" is very often associated to
"execute", and I'd rather keep away from punctuation/shift combo.
There have been discussions in the past about giving "!" a semantics
(like "fixup!" for a variant of "fixup"). Let's keep this as an option
for the future by not using ! now.

> I think the docs need to elaborate on the environment the "exec"
> command gets executed in, what's its current working directory for
> instance? Wherever I happened to run git-rebase from? the project
> root?

That's a good question. My original patch was running the command from
the toplevel, which is the natural way to implement it. I've changed
my mind to execute the command from the place where "git rebase -i"
was started (which means this has to be memorized in a temporary file
to be persistant accross "git rebase --continue"). I think this makes
more sense for the user, and I've actually already been biten by the
old behavior, running "rebase -i" from a doc/ subdirectory, and
wondering why my "exec make" was rebuilding the code itself.

This comes with at least one drawback: if directory from which the
rebase was started didn't exist in the past, then we can't do a simple
"cd" to it. My implementation re-creates the directory temporarily, so
that the command can run, and cleans it up afterwards. The only really
problematic case is when the directory can not be created (like
directory/file conflict). It this case, the command is not ran, and
the script exits.

> your if ! eval .. error message also exits with 0, surely that should
> exit with 1?

I'm now exiting with the same status as the command itself in case of
failure.

New version follows. It should hopefully look more like a real patch
than an RFC now.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
