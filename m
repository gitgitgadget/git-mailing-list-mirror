From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] revert: report fine-grained error messages from insn
 parser
Date: Sun, 8 Jan 2012 15:33:18 -0600
Message-ID: <20120108213318.GQ1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-6-git-send-email-artagnon@gmail.com>
 <20120108200748.GJ1942@burratino>
 <CALkWK0mStgcb4EBB+ni9fisDJY=13cJZWCTEcgfyOUyAXbc=tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:28:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk0Hp-0005gS-53
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab2AHV2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 16:28:12 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64048 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab2AHV2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 16:28:12 -0500
Received: by iaeh11 with SMTP id h11so5763416iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 13:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FI8DA0lcSPYfkh9pQKKkGdz20/CRINkl/sNaQILVO3c=;
        b=rVdyWTEAaWsnrSMgSqJI2vXXmypd1j0l5FCORpS+OojVKaafgBWmzEgAWUps/zb1JM
         zcSEFC+yN4jg6tikusUmhCjsd3vfsrqlYlbo5elJMOp5W3yx7/cDhSzfbwnisKoWcQvu
         QbV0FN38+gnBJNdDBI+BCzSN4F2u/w6urDrjM=
Received: by 10.50.183.199 with SMTP id eo7mr16521480igc.5.1326058091665;
        Sun, 08 Jan 2012 13:28:11 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gh7sm120392103igb.1.2012.01.08.13.28.10
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 13:28:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mStgcb4EBB+ni9fisDJY=13cJZWCTEcgfyOUyAXbc=tA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188141>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:
>> Ramkumar Ramachandra wrote:

>>> =C2=A0 =C2=A0 =C2=A0 /* Eat up extra spaces/ tabs before object nam=
e */
>>> - =C2=A0 =C2=A0 padding =3D strspn(bol, " \t");
>>> - =C2=A0 =C2=A0 if (!padding)
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>>> - =C2=A0 =C2=A0 bol +=3D padding;
>>> + =C2=A0 =C2=A0 bol +=3D strspn(bol, " \t");
[...]
> Not a bugfix: since I have to report sensible error messages now, I
> changed the "pick" and "revert" checks to "pick " || "pick\t" and
> "revert " || "revert\t" -- then, I can report "invalid action" if it
> doesn't match instead of a useless "missing space after action".

Ah, I forgot that the "if (!padding)" check noticed errors like

	picking foo

before.  So this is just a code cleanup, with no functional effect.

However, you can still report "invalid action" with the old code
structure --- it would just mean duplicating an error message in the
code, since you reach the same conclusion by two code paths.  So it's
a relevant cleanup, but I'd still suggest lifting it into a patch that
comes before so future readers can assure themselves that it introduces
no functional change instead of being confused.

[...]
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("%s:%d: =
Not a valid commit: %.*s"),
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 todo_file, lineno, (int)error_len, bol);
>>> + =C2=A0 =C2=A0 }
>>
>> Hmm, this one can be emitted even when there was no corruption or
>> internal error, because the user removed a commit she was
>> cherry-picking and the gc-ed before a "git cherry-pick --continue".
>> Alternatively, it can happen because the repository has grown very
>> crowded and what used to be an unambiguous commit name no longer is
>> one (not enough digits). =C2=A0Will the error message be intuitive i=
n these
>> situations?
>
> Something like "Unable to look up commit: %s" perhaps?

My "alternatively" was bogus --- lookup_commit_reference takes a (raw)
full commit name as its argument.

I dunno.  The question was not actually rhetorical --- I just meant
that it's worth thinking about these cases.  There are a few cases:

 - missing object
 - object is present but corrupt
 - object is a blob, not a commit

In the second case, there's an error message printed describing the
problem, but in the other two there isn't.  The other callers tend to
say "not a valid <foo>" or "could not lookup commit <foo>, so I guess

	error: .git/sequencer/todo:5: not a valid commit: 78a89f493

would be fine.

Except that this focusses on the .git/sequencer/todo filename which
would leave the person debugging astray.  It is not that
=2Egit/sequencer/todo contains a typo (that would have been caught by
get_sha1), but that it referred to a bad object or non-commit.  Maybe
something in the direction of

	error: cannot pick 78a89f493 because it is not a valid commit

would be more helpful.

Is this the right moment to report that error?  Will the operator be
happy that we errored out right away before cherry-picking anything
and wasting the human's time in assisting with that process, or will
she be unhappy that inability to do something later that she might
have been planning on skipping anyway prevented making progress right
away?  (I'm not sure what the best thing to do is --- I guess some
advice like

	hint: to abort, use cherry-pick --abort
	hint: to skip or replace that commit, use cherry-pick --edit

would help.)

Thanks for some food for thought.
Jonathan
