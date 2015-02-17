From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 11:12:21 +0100
Message-ID: <54E31405.5040502@gnu.org>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org> <xmqqiof163kk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:12:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNf8r-0008Ky-VH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 11:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbbBQKM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 05:12:29 -0500
Received: from mail-we0-f176.google.com ([74.125.82.176]:50082 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbBQKM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 05:12:27 -0500
Received: by mail-we0-f176.google.com with SMTP id x3so34000729wes.7
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 02:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=01ROX55o8pI6GONh1d3coLWGE40FT8UTfXwdX94VFC8=;
        b=t2CFhGuKMsOZZ6YUaTzsDDeSEhzzj1aJwSmAEvHxkkblojDDV/CdHylj6xcxHIx5L5
         f2cPxRVmRyZ7rZI+y/x5ilwFAuQIjrF20Z86GGRBYWcooDXNFGi/Or2TZ10ERejFhI/X
         BK2XmsXuoA5s3x3k/XNwPHw5TNTpJ/dVa3fgODeHWonlWbWMR3cvo6wH80hTEslJGLA0
         ikHnp9c6Q8bW7KMIn2zaDmlHdZeIb0IgDxJp644gXAC65sE/R1hwDA1PvlIMv5d2euhA
         SMPZO6BSWz/127HuqxLlWTU+UVCv1YShevuOUSpc85xe6v+TjW+2EYfXW+zIEDqKOx2t
         KhiA==
X-Received: by 10.194.82.136 with SMTP id i8mr57504259wjy.99.1424167946068;
        Tue, 17 Feb 2015 02:12:26 -0800 (PST)
Received: from [172.20.10.4] ([5.170.246.153])
        by mx.google.com with ESMTPSA id di11sm23478452wid.8.2015.02.17.02.12.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2015 02:12:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqiof163kk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263940>



On 16/02/2015 20:47, Junio C Hamano wrote:
> Paolo Bonzini <bonzini@gnu.org> writes:
> 
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> After updating to git 2.3.0, "git request-pull" is stubbornly complaining
>> that I lack a matching tag on the remote side unless I pass the third
>> argument.  But I did prepare and push a signed tag.
> 
> A few questions.
> 
>  - what old version did you update from?  I think the "correct
>    over-eager dwimming" change was from v2.0 days.

I upgraded from 1.9.  My workflow is to make a signed tag, push it and
do "git request-pull origin/master <url>".

My branches have a different name locally vs. remotely (e.g.
"kvm-master" and "kvm-next" locally vs. refs/heads/master and
refs/heads/next remotely) exactly to avoid overeager matching in
git-request-pull.  I only ever want to request pulls based on signed tags.

>  - what exactly do you mean by "stubbornly complain"?  I think we
>    say something about HEAD not matching the HEAD over there, which
>    I think is bogus (we should instead say things about the branch
>    you are on and the branch over there with the same name) and is
>    worth fixing.

I tried both "git checkout kvm-next" and "git checkout tags/for-linus",
and it still complains.

What you refer to is, I think, fixed by patch 3.  The find_matching_ref
script does not work if its first argument is HEAD.  So patch 3 is
probably an improvement anyway for the "matching branch name" case, even
if my usecase involves tags rather than branches.

> An earlier 024d34cb (request-pull: more strictly match local/remote
> branches, 2014-01-22) deliberately disabled over-eager DWIMming when
> the $3-rd argument _is_ given.

I agree with that change.

> One part of me feel that not giving the $3-rd argument should behave
> the same way as if you gave the name of the current branch as the
> $3-rd argument.

This works well for workflows where you do pull requests based on
branches.  However Linus strongly encourages using signed tags.

I certainly can adjust my workflow for this.  For example I can add
something like this to my .gitconfig

	[request-pull]
		dwim = tags/for-linus

and add an alias that uses "git config request-pull.dwim" as the third
argument (other projects I work on obviously use different tag names :).

While similar, the two patches are different:

1) The usage of "git show-ref --heads --tags" looked like a feeble
attempt at DWIMming tags.  But I can see how that is supposed to work
only if $3 is specified.  Adding a usage of "git tag --points-at" would
go against the intentions of 024d34cb.  Perhaps restrict DWIMming to
signed and annotated tags only, through a new option to "git tag"?

2) Patch 3 makes sense independent of patch 2 and, as mentioned above,
it is probably a bugfix anyway.

> On the other hand, I can also understand (not necessarily agree
> with) a view that not giving the $3-rd argument is an explicit
> user's wish to us to DWIM as much as we want.  But again, that
> directly contradicts with the desire of 024d34cb.
> 
> So,... I dunno.

I don't know either.  Based on your answer, it seems like you are
focusing mostly on a branch-based workflow; the two definitely have
different requirements for DWIMming (since you cannot get a tag name via
"git symbolic-ref" for example).  On the other hand most of the
un-DWIMming changes were done by Linus who works a lot with (other
people's) signed tags...

Paolo
