From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Tue, 16 Apr 2013 00:17:35 +0200
Message-ID: <vpqli8je8w0.fsf@grenoble-inp.fr>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
	<1365887729-9630-4-git-send-email-artagnon@gmail.com>
	<vpq38us2oov.fsf@grenoble-inp.fr>
	<CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
	<vpqppxvoqsc.fsf@grenoble-inp.fr>
	<7vobdfztz9.fsf@alter.siamese.dyndns.org>
	<CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
	<7vr4ibu14j.fsf@alter.siamese.dyndns.org>
	<CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 00:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URrig-0001Il-BL
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 00:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab3DOWRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 18:17:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49489 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab3DOWRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 18:17:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3FMHXRu022100
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Apr 2013 00:17:33 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1URriR-0008JV-LU; Tue, 16 Apr 2013 00:17:35 +0200
In-Reply-To: <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 23:38:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 16 Apr 2013 00:17:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3FMHXRu022100
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366669054.88597@Ceb6JqgInKAxZH7iLLsEkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221322>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> If "rebase -m" were to be taught to do this, the natural way to do
>> so is to
>>
>>   (1) Prepare the todo the usual way
>>   (2) Do those two commits for index and working tree
>>   (3) Append two insns (exec reset HEAD^ and exec reset --soft
>>       HEAD^) at the end of the rebase todo file.
>
> Er, no.  I don't want to touch the instruction sheet.  It becomes
> especially problematic in -i, when the instruction sheet is
> user-editable.

I do not find this problematic. It shows the user what's going on. It
may be a good idea to append the last instructions after launching the
editor if we want to partially hide it (but it's still going to be
visible with rebase --edit-todo)

>> "rebase--am" could also be told to generate (on the preparation
>> side) and notice (on the application side) a pair of patch files at
>> the end that represent the index state and the working tree state
>> and apply them without making the WIP part into a commit.
>
> Ugh, no.  I don't want to leak the implementation detail of autostash
> into specific rebases.  Why can't I wrap the last statment in
> git-rebase.sh in git stash/ git stash pop like I did with git-pull.sh?

Because "git rebase" needs multiple runs in case of conflicts. You have
to store the information somewhere in the filesystem, not in a variable.
What you need to store is whether you need to unstash, and where you are
in the process (in Junio's version, you may be doing the actual rebase,
or fixing conflicts in index state application, or fixing conflicts in
tree state application, or done). Storing what you have to do and where
you are in the process really sounds like a job for the instruction
sheet, no?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
