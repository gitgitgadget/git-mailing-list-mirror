From: Sergey Organov <s.organov@javad.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Wed, 01 Apr 2015 14:27:28 +0300
Message-ID: <87vbhgks0v.fsf@javad.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<871tkblapv.fsf@javad.com> <55147D27.1060204@kdbg.org>
	<87lhidlebw.fsf@javad.com>
	<xmqqh9t1rv0r.fsf@gitster.dls.corp.google.com>
	<xmqq8uedrtdb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 13:27:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdGo4-0000Oa-IO
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 13:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbbDAL1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 07:27:32 -0400
Received: from mail.javad.com ([54.86.164.124]:49048 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbbDAL1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 07:27:31 -0400
Received: from osv (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 9EB0861108;
	Wed,  1 Apr 2015 11:27:30 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84)
	(envelope-from <sorganov@gmail.com>)
	id 1YdGnw-0006yY-W2; Wed, 01 Apr 2015 14:27:29 +0300
In-Reply-To: <xmqq8uedrtdb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 Mar 2015 10:04:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266601>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I wonder if it will be the right way to get a correct result to
>> apply the difference to go from B to Z on top of an old commit when
>> you are side-porting.
>>
>> Imagine you want to backport the same X-Y history by redoing the
>> merge Z on top of another child of O (i.e. A's sibling).  That is,
>> you start from this:
>>
>>
>>          X---Y
>>         /     \
>>    O---A---B---Z---
>>     \
>>      M---N
>>
>> and would want to create this:
>>     
>>     
>>    O           X'--Y'
>>     \         /     \    
>>      M---N---A'--B'--Z'--
>>
>> As long as everything down to the merge-base of the parents of the
>> original merge (in this example, merge-base across Y and B that are
>> Z's parents, which is A) is being transplanted, "apply the
>> difference going from B to Z, on top of B', to obtain Z'" should
>> work, I would think.
>
> And just after I send the message because I needed to catch a bus, I
> notice that there is a problem.
>
> Actually, "replay diff going from B to Z instead of merging" must be
> done very carefully.  Imagine when Y in the original history were a
> cherry-pick of M.  What you would be creating would look more like
> this instead:
>      
>     O           X'--.
>      \         /     \    
>       M---N---A'--B'--Z'--
>
> because Y' becomes a no-op, as the transplanted history already has
> M applied.  But the original "diff going from B to Z" has the effect
> of M already in there.  You would end up adding the same hunk twice
> without noticing. You somehow need to come up with a way to deal
> with this.

Nope. It seems like cherry-pick takes care of that:

[SCRIPT]
git init t; cd t; git config rerere.enabled false

cat > a <<EOF
Line01
Line02
Line03
Line04
Line05
Line06
Line07
Line08
Line09
EOF

git add a
git commit -aqm "A"

git checkout -b two-chunks
sed -i -e 's/Line04/Line04_1/' a
sed -i -e 's/Line08/Line08_1/' a
git commit -aqm "A_04_08_1"

git checkout master
sed -i -e 's/Line04/Line04_1/' a
git commit -aqm "A_04_1"

git cherry-pick two-chunks

git log --oneline
cat a
[/SCRIPT]

What do I miss?

-- Sergey.
