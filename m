From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/2] Teach commit to handle CHERRY_HEAD automatically
Date: Tue, 15 Feb 2011 17:47:35 -0600
Message-ID: <20110215234735.GA18151@elie>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
 <20110215230015.GA17812@elie>
 <AANLkTinZ0ewJy01rV66xMMCKLon=7qz=hoJ3DbtXmtXL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:48:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUcv-0005AO-Ly
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab1BOXsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 18:48:08 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34307 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab1BOXsH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 18:48:07 -0500
Received: by qwa26 with SMTP id 26so609712qwa.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=odQLR02VtHKXZV8XRG7RNVak7ltR3Fxwr6G+DjHuQc4=;
        b=UWzyinIkCfAiDhiji/SWiBVqnfPIb7Clt8GDikoR8o++It/EKTLBC68h/wKfI+GqlJ
         ckWtbmLqramPaWQ+KIgV4osz2QIHLcdh9WeMR1ui5ZVkNGhcLMFQfOvFx9FzpeV9hwJp
         W9TZz8h4t2gvBRdO9W5AWFgWAvo7S46uY8yTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aO1LyNkKasYABgYT3CqXjxSWvWWyZnLz57lrbxfpBvFw64a/oZXV5i6BaDklQMCLTs
         eE3RNABzFFF6I7kqMJv4CJ1h57WwBkDsRBr84rDQU24D0U8xPmp1OB8YNPh/6RhAOSao
         fctgiO2BmqGN3XcIy5TJqb/ROk6VQlnTcxZLs=
Received: by 10.224.47.85 with SMTP id m21mr6910qaf.123.1297813685350;
        Tue, 15 Feb 2011 15:48:05 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.sbcglobal.net [69.209.51.217])
        by mx.google.com with ESMTPS id e29sm3049867qck.27.2011.02.15.15.48.03
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 15:48:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinZ0ewJy01rV66xMMCKLon=7qz=hoJ3DbtXmtXL@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166901>

Hi,

Thanks for a quick response.  Some small clarifications.

Jay Soffian wrote:
> On Tue, Feb 15, 2011 at 6:00 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =C2=A0- "git commit --amend" to say "I'm done fixing the broken thin=
g".
>>
>> =C2=A0- "git commit --fixup=3DHEAD/--squash=3DHEAD" to say "done fix=
ing;
>> =C2=A0 let's look at this again later and squash it when I am less
>> =C2=A0 confused".
>>
>> Both are mistakes if HEAD is the previous and good commit rather tha=
n
>> the broken one. =C2=A0Maybe there is some simple safety that could p=
rotect
>> against them?
>
> As you see below, this is already protected against.

The first mistake is protected against[*], the second left alone.
(The second seems mostly harmless; just mentioning it for reference.)

[*] which I think is my favorite part of this patch

>>> =C2=A0--reset-author::
>>> + =C2=A0 =C2=A0 When used with -C/-c/--amend options, or when commi=
tting after a
>>> + =C2=A0 =C2=A0 a conflicting cherry-pick,
>>
>> or when committing after a conflicted merge, no?
>
> No. The person committing a merge is already the author of the merge,
> why would they use --reset-author?

You're right.  I find myself occasionally doing the following

	git merge --no-commit $branch
	... update version number; walk away for a while  ...
	git commit;	# will this use the old timestamp?
	git commit --amend --reset-author

out of a vague fear, but I think I was just confused.

>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0declare that the autho=
rship of the
>>> + =C2=A0 =C2=A0 resulting commit now belongs of the committer. This=
 also renews
>>> + =C2=A0 =C2=A0 the author timestamp.
>>
>> How does it interact with --author?
>
> No change from before, --author forces the author of the new commit.

Patch below.

[...]
> 		/* Let message-specifying options override CHERRY_HEAD */
>
> I'll make this logic clearer though as I need to address Junio's
> earlier message.

Ah, good to hear.

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cherry_pick)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fprintf(fp,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "#\n"
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# It looks like you may be committing =
a cherry-pick.\n"
>>
>> Aside: shouldn't we suggest some porcelain-ish command (git merge
>> --clear? =C2=A0git commit --no-merge?) to remove .git/MERGE_HEAD ins=
tead of
>> asking the committer to do it?
>
> We have git merge --reset as an alias for reset --merge. Since reset
> --merge takes care of this case too (I think, I'll check) we can
> suggest that for both.

No, I think "git merge --abort" does too much.  If we were ready to
commit, we almost surely have precious staged changes that it would
remove.

The cure to a lingering MERGE_HEAD is still "rm -f .git/MERGE_HEAD",
I fear.  "git commit --no-merge" (meaning "ignore MERGE_HEAD") seems
tempting.

>> How can I get out of this state if I really do want to amend?
>
> git reset, same as it ever was?

Not obvious at all.  Maybe the manpage to cherry-pick could mention
that CHERRY_HEAD is cleared away by git reset?

>> Hmm, what if I have commits F and F' and after trying to cherry-pick=
 F
>> I decide I want the message from F'?
>
> I don't think I understand. commit -c F', or just commit (w/o options=
)
> and you get MERGE_MSG generated by cherry-pick.

I meant the following sequence of operations:

	# by the way, does this set CHERRY_PICK_HEAD?
	git cherry-pick --no-commit F
	git commit -C F-prime

But that was a silly example --- -C takes care of authorship on its
own.  A better example might be

	git cherry-pick --no-commit F
	git commit -F the-message

or

	git cherry-pick --no-commit F
	git commit --amend -C F-prime

> Thanks for the feedback!

Thanks for making it happen. :)
Jonathan
