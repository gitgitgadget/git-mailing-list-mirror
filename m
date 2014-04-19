From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/5] completion: fix completion of certain aliases
Date: Fri, 18 Apr 2014 20:26:58 -0500
Message-ID: <5351d0e2951ca_364af2f2ec6f@nysa.notmuch>
References: <E1WZEWT-0002R7-1d@iramx2.ira.uni-karlsruhe.de>
 <xmqqmwfnoe7m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?R8OhYm9yIFN6ZWRlcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Apr 19 03:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbKDb-0001kC-P4
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 03:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbaDSBhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2014 21:37:19 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:59752 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaDSBhR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 21:37:17 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so2359931oag.17
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zuUUvz0224rC97I8u29TSNGQIkCerI7YCUuevgqy4P8=;
        b=Wvpd1Iu1Ak9+HFpg1BKmVxi9C0pjmwwA5I7UU2TOT2b9vt3Y/3HBaJS8pqqzo96g+9
         Zwqm7X1RbJ+KDTMHZN1x0TqZW62UXWNDYzLu/Hp9you0DjMb6VBW451asFG5BSRPRnXA
         AC5pnnBGC1YDxfo4QFBmY8dnIYUGR0ogMFFYb7b37yhwegRQvBV7GhB6kPZWHHWm04RV
         BpxU+hJ/lgxcqo4lLfS4Gu2HdtBYhuURifytrNviPHT4y5Vp5qOVqJER2OGksvHjkvh8
         OGr0aQ7zljfZA8Mm742bvKd/Qzko95BVc24Qz639FPp1sJrh0svZLFgxDdiv8CqHxebL
         SrhA==
X-Received: by 10.182.117.162 with SMTP id kf2mr3362747obb.7.1397871437205;
        Fri, 18 Apr 2014 18:37:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm133453300oej.5.2014.04.18.18.37.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Apr 2014 18:37:16 -0700 (PDT)
In-Reply-To: <xmqqmwfnoe7m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246499>

Junio C Hamano wrote:
> G=C3=A1bor Szeder <szeder@ira.uka.de> writes:
>=20
> > words[] is just fine, we never modify it after it is filled by
> > _get_comp_words_by_ref() at the very beginning.
>=20
> Hmph.  I would have understood if the latter were "we never look at
> it (to decide what to do)".  "we never modify it" does not sound
> like an enough justification behind "words[] is just fine"---maybe I
> am not reading you correctly.
>=20
> > The root of the problem is that the expected position of the name
> > of the git command in __git_complete_remote_or_refspec() is
> > hardcoded as words[1], but that is not the case when:
> >
> >   1) it's an alias, as in Felipe's example: git p ori<TAB>,
> >   because while the index is ok, the content is not.
> >
> >   2) in presence of options of the main git command: git -c
> >   foo=3Dbar push ori<TAB>, because the index is off.
> >
> >   3) the command is a shell alias for which the user explicitly
> >   set the completion function with __git_complete() (at his own
> >   risk): alias gp=3D"git push"; __git_complete gp _git_push; gp
> >   ori<TAB> Neither the index nor the content are ok.
> >
> > Fixing the hard-coded indexing would only solve 2) but not 1) and
> > 3), as it obviously couldn't turn the git or shell alias into a
> > git command on its own.
> >
> > Felipe's patch only deals with 1), as it only kicks in in case of
> > a git alias.

Which is the far more common use-case, and the problem I've seen people=
 report
multiple times in multiple media.

> Yeah, do completions for commands (not just for the ones that use
> remote-or-refspec Felipe's patch addresses) have trouble with the
> latter two in general?  If that is the case,...
>=20
> > Communicating the name of the git command to
> > __git_complete_remote_or_refspec() by its callers via a new
> > variable as suggested by Junio, or perhaps by an additional
> > parameter to the function is IMHO the right thing to do, because,
> > unless I'm missing something, it would make all three cases work.
>=20
> ... while the above analysis may be correct, taking Felipe's patch
> to address only (1) and leaving a solution to the more general
> words[1] problem for other patches on top might not be too bad an
> approach.
>=20
> Unless
>=20
>  (A) remote-or-refspec thing is the primary offender, and other
>      commands do not suffer from the words[1] problem, in which case
>      I tend to agree that an additional parameter would be the way
>      to go (there are only a few callers of the function); or

Since I already fixed the problem (all 3) years ago[1], you can take a =
look at
the patch and see which commands which use a hard-coded index value mig=
ht have
real issues. My guess is that it's more than just remote-or-refspec, bu=
t I
don't have the incentive to look deeper into this (the issue is solved =
for me).

>  (B) even if words[1] problem is more widespread, such a more
>      general solution to all three issues can be coded cleanly and
>      quickly, without having to have Felipe's patch as a stop-gap
>      measure.

I already sent two patches, one that solves all the problems, and one t=
hat
solves the most important one.

I would gladly revisit my old patch and see which of those changes are =
really
necessary and solve a real issue, *if* I knew the resulting patch would=
n't get
the same road-blockers as the old one did; namely being held to higher
standards than the current code.

I say it's more important to fix the real issues real people have than =
hold on
to arbitrary standards which might force the bug to remain present for =
years
just because some variable was not documented in the original patch (ju=
st like
all other variables in the script)... But that's just me.

[1] http://thread.gmane.org/gmane.comp.version-control.git/197226

--=20
=46elipe Contreras