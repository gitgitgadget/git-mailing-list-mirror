From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sun, 11 May 2014 06:34:19 +0530
Message-ID: <536ECC93.1070102@gmail.com>
References: <536E2C19.3000202@gmail.com> <xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 03:04:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjIBw-0000qe-UQ
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 03:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbaEKBE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 21:04:26 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38769 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbaEKBEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 21:04:25 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so5099086pdj.24
        for <git@vger.kernel.org>; Sat, 10 May 2014 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bibzQguMW1gCx/kIb0BI0RFqy7mudf6HEicFTpVDrkk=;
        b=JM1mThmggka2INeZ3aC4KKYs+6nfADL3bSOJb7b5MucCcbPKHzI0T1bu/2VmlhXH9x
         QYBP37dakDXPnfE5pl9MNY3glC+jtN67WY2t3CrfpVCJDe21CSzQji7G18BllWdh/L5u
         etpcA01vlG8kYDw9ZBjEktCZxLztxGV4zsdem96Oue19dapQEevLy+ljR/Fbl7hzh7e/
         3B7MTKEInd5eK65MczTAgD8aXWarYZ4Ov6I1c0y6LKprTPm1930s4MYu1gdzezciBiOu
         0R0l4dnuq29VnD4vDyzew85k+TcADK9jOiHxkeKkd1sDKUigjUOGrugnW4rZC822OSY7
         LMzQ==
X-Received: by 10.66.189.201 with SMTP id gk9mr37800460pac.25.1399770265036;
        Sat, 10 May 2014 18:04:25 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.208.79])
        by mx.google.com with ESMTPSA id yj6sm28539244pab.19.2014.05.10.18.04.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 May 2014 18:04:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248668>

On 05/11/2014 02:32 AM, Junio C Hamano wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> Is there a trick to optimising a push by telling the receiver to pick up
>> missing objects from some other repo on its own server, to cut down even
>> more on network traffic?
>>
>> So, hypothetically,
>>
>>      git push user@host:repo1 --look-for-objects-in=repo2
>>
>> I'm aware of the alternates mechanism, but that makes the dependency on
>> the other repo sort-of permanent.
>
> In the direction of fetching, this may be give a good starting point.
>
>      http://thread.gmane.org/gmane.comp.version-control.git/243918/focus=245397

That's an interesting thread and it's recent too.  However, it's about
clone (though the intro email mentions other commands also).

I'm specifically interested in push efficiency right now.  When you
"fork" someone's repo to your own space, and you push your fork to the
same server, it ought to be able to get most of the common objects from
disk (specifically, from the repo you forked), and only what extra you
did from the network.

Clones do have a workaround (clone with --reference, then repack, as you
said in that thread), but no such workaround exists for push.

> In the direction of pushing, theoretically you could:
>
>   - define a new capability "look-for-objects-in" to pass the name of
>     the repository from "git push" to the "receive-pack";
>
>   - have "receive-pack" temporarily borrow from the named repository
>     (if the policy on the server side allows it), and accept the push;
>
>   - repack in order to dissociate the receiving repository from the
>     other repository it temporarily borrowed from.
>
> which would be the natural inverse of the approach suggested in the
> "Can I borrow just temporarily while cloning?" thread.
>
> But I haven't thought things through with respect to what else need
> to be modified to make sure this does not have adverse interaction
> with simultaneous pushes into the same repository, which would make
> it harder to solve for "receive-pack" than for "clone/fetch".

I'll leave it in your capable hands :-)  My C coding days are long gone!

I do have a way to do this in gitolite (haven't coded it yet; just
thinking).  Gitolite lets you specify something to do before git-*-pack
runs, and I was planning something like this:

terminology: borrow, borrower repo, reference repo

"borrow = relaxed" mode

     1.  check if the user has read access to the reference repo; skip
         the rest of this if he doesn't

     2.  from reference repo's "objects", find all directories and
         "mkdir" them into borrower's objects directory, then find all
         files and "ln" (hardlink) them. This is presumably what "clone
         -l" does.

     This method is close to constant time since we're not copying
     objects.

     It has the potential issue that if an object existed in the
     reference repo that was subsequently *deleted* (say, a commit that
     contained a password, which was quickly overwritten when
     discovered), and the attacker knows the SHA, he can get the commit
     out by sending an commit that depends on it, then fetching it back.

     (He could do that to the reference repo directly if he had write
     access, but we'll assume he doesn't, so this *is* a possible
     attack).

"borrow = strict" mode

     1.  (same as for "relaxed" mode)

     2.  actually *fetch* all refs from the reference repo to the
         borrower (into, say, 'refs/borrowed'), then delete all those
         refs so you just have the objects now.

     Unlike the previous method, this takes time proportional to the
     delta between borrower and reference, and may load the system a bit,
     but unless the reference repo is highly volatile, this will settle
     down. The point is that it cannot be used to get anything that the
     user doesn't already have access to anyway.

I still have to try it, but it sounds like both these would work.

I'd appreciate any comments though...

regards
sitaram
