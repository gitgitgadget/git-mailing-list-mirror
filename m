From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 15:50:15 +0100
Message-ID: <vpqa9u4pgew.fsf@grenoble-inp.fr>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin> <vpqr4ngsdjl.fsf@grenoble-inp.fr>
	<CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
	<vpqehjgscv3.fsf@grenoble-inp.fr>
	<CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Igor Lautar <igor.lautar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 15:50:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td017-0002Bc-LN
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 15:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab2KZOuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 09:50:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48090 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754526Ab2KZOuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 09:50:19 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qAQEg5Cq013879
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Nov 2012 15:42:05 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Td00l-0007fp-Fz; Mon, 26 Nov 2012 15:50:15 +0100
In-Reply-To: <CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
	(Igor Lautar's message of "Mon, 26 Nov 2012 14:58:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 26 Nov 2012 15:42:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAQEg5Cq013879
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1354545727.03467@vjBMFuWBvY6PP7eLWFQjmg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210454>

[ Jumping back in time ]

Igor Lautar <igor.lautar@gmail.com> writes:

>> Try this:
>>
>> commit=<sha1 of your merge commit>
>> # Show diff with first parent:
>> git diff "$commit" "$commit"^1
>> # Show diff with second parent:
>> git diff "$commit" "$commit"^2
>
> Yes, change is shown in commit^2, but actual file after merge does not have it.

My commands had the wrong order. It should have been git diff
"$commit"^2 "$commit". So, it showed the reverse of the modification
introduced by the commit. If you see your change here, it means the
change was reverted by the merge.

My understanding of the situation up to now is:

M
|\
A C
|/
B

($commit = M, $commit^1 = A and $commit^2 = B)

Your file had a content (say, "old") at revision B. It changed content
(say, to "new") at revision C, and at some point. A did not change it so
it had the content "old". Then you merged, expected the merge commit M
to get content "new", and actually got "old".

So, your history looks like:

M (old)
| \
|  `---.
|       \
A (old)  C (new)
|       /
|  .---'
| /
|/
B (old)

and "git diff C M" shows the diff between new and old.

Something went wrong during the merge, I guess it used an ancestor (B
above) that had "new" as content. I don't see how this happened (rather
clearly, your history is more complex than my example above), but
"GIT_MERGE_VERBOSITY=5 git merge" will show you which common ancestor
was used, it may help.

What's possible is that someone had already merged the branch containing
"new", got conflicts, and resolved it in favor of "old" somewhere in the
history of your master branch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
