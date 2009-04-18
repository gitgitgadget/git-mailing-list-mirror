From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be
 deleted
Date: Sat, 18 Apr 2009 22:58:47 +0200
Message-ID: <20090418225847.54862bdf@gmail.com>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7v4owsfktw.fsf@gitster.siamese.dyndns.org>
	<20090413230351.7cbb01f5@gmail.com>
	<7v1vrwdyxx.fsf@gitster.siamese.dyndns.org>
	<20090417192324.3a888abf@gmail.com>
	<7vskk6y2tl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 23:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvHeH-0006ro-LV
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 23:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbZDRU6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbZDRU6y
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 16:58:54 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:39869 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbZDRU6x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 16:58:53 -0400
Received: by bwz7 with SMTP id 7so621694bwz.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=neGi2hfpSWjROPSmB55KGmPHGhFCvxFMsJ+IX8jxBNo=;
        b=P6zHFD1xXNdeX8UWxm0emBnAyswhrNnZb0OmlhLTc2/H0CE1KbFetuFOAts2lSQuzW
         4xcL8yKJeA2KwTO2cwCC1z2u3xyqK1VvrQo9wDjh/j/FqL3FRXwBWzHmQtmOLcqN9tqZ
         b/t6Sy1n2kOjD8WZpplnLRfnhDB3HAfR1kVik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=I1jW7+YWVXPlG5cqczCEjF7UbcTiwXSdU2t/tOFtEv3sCrxtR9Tb04XDqyxSOCLkzF
         3aQjh3sC1xMfGh+/Nuow2EzELE1JUsaNLsU+f3i055hvss7wFh/3FvQIybJmx3WganVy
         38cLQHzAHE4cOUqSVgoUZBKpzb/1KpDFHWzWY=
Received: by 10.204.116.11 with SMTP id k11mr3737419bkq.48.1240088331047;
        Sat, 18 Apr 2009 13:58:51 -0700 (PDT)
Received: from localhost (77-253-158-167.adsl.inetia.pl [77.253.158.167])
        by mx.google.com with ESMTPS id h2sm2298203fkh.29.2009.04.18.13.58.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 13:58:50 -0700 (PDT)
In-Reply-To: <7vskk6y2tl.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116866>

Junio C Hamano <gitster@pobox.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>  =20
>> ... However, there are some cases when these two
>> rules may cause problems:
>>
>> patch #1: rename A to B
>> patch #2: rename C to A
>> patch #3: modify A
>>
>> Should patch #3 modify B (which was A) or A (which was C)?
>>
>> patch #1: rename A to B
>> patch #2: rename B to A
>> patch #3: modify A
>> patch #4: modify B
>>
>> Which files should be patched by #3 and #4?
>>
>> In my opinion both #3 and #4 should fail (or both should succeed) --
>> with my patch only #3 will work and #4 will be rejected, because in
>> #2 B was marked as deleted. =20
>=20
> Both of the examples above cannot be emitted as a single commit by
> format-patch; the user is feeding a combined patch.  Perhaps renames
> in each example sequence were came from one git commit but
> modifications are from separate commit or handcrafted "follow-up"
> patch.

Yes, that's true. In "normal" case, renames and modifications should be
handled properly and (generally) aren't subject of this discussion.

>
> There are two stances we can take:
>=20
>  (1) The user knows what he is doing.
>=20
>      In the first example, if he wanted the change in #3 to end up in
> B, he would have arranged the patches in a different order, namely, 3
> 1 2, but he didn't.  We should modify A (that came from C).
>=20
>  (2) In situations like these when it is unusual and there is no
> clear and unambiguous answer, the rule has always been "fail and ask
> the user to clean up", because silently doing a wrong thing in an
> unusual situation that happens only once in a while is far worse than
>      interrupting the user and forcing a manual intervention.
>=20
>      In the first example, there is no clear answer.  Perhaps all
> three patches were independent patches (the first two obviously came
> from git because only we can do renames, but they may have been
> separate commits), and the user may have reordered them (or just
> picked a random order because he was linearizing a history with a
> merge).
>=20
> The second one is even iffier.  If we _know_ that originally patch #1
> and #2 came from the same commit, then they represent swapping
> between A and B, but if they came from different git commits, and if
> the user picked patches in a random order, it may mean something
> completely different.

The problem here is that there are at least two patches which touch the
same file(s) and it is impossible to say which patches should be handle=
d
atomically. However, there is no easy way to specify renames as a
single patch. A diff containing swapping of three files looks like this=
:

	diff --git a/file2 b/file1
	similarity index 100%
	rename from file2
	rename to file1
	diff --git a/file3 b/file2
	similarity index 100%
	rename from file3
	rename to file2
	diff --git a/file1 b/file3
	similarity index 100%
	rename from file1
	rename to file3

BTW: it applies correctly :).

>=20
> I am somewhat tempted to say that we should fail all of them,
> including the original "single patch swapping files" brought up by
> Linus.

I may agree that difficult scenarios should be rejected, but I will
also say that git-apply should always accept git-diff output.

>=20
> BUT
>=20
> Can we make use simple rule to detect problematic cases?
>=20
>  - An input to git-apply can contain more than one patch that affects
> a path; however
>=20
>    - you cannot create a path that still exists, except for a path
> that _will_ be renamed away or removed (your patch fixes this by
> adding this "except for..." part to loosen the existing rule);
>=20
>    - you cannot modify a path in a separate patch if it is involved
> in an either side of a rename (this will catch the ambiguity of patch
> #3 in your first example and #3 and #4 in your second example);

What should happen in following situation:

patch #1: modify A
patch #2: rename A to B

#2 should fail? Now it creates new B which is a copy of A before
applying any patches and modifies A according to #1.

AFAIC, copies and renames are handled differently from normal
modifications (in_fn_table() is not used for them, but
add_to_fn_table() is, so "rename patches don't look in the past, but
have influence upon the future").

>=20
>  - In addition:
>=20
>    - the same path cannot be renamed from more than once (this will
> catch concatenation of two git generated patches);
>=20
> With such a change, I think we can keep the safety of "when there are
> more than one plausible outcomes, the tool shouldn't silently decide,
> nor make progress that the user later needs to undo and redo", while
> allowing a sane use of rename patches generated out of a git commit.
>=20
>=20

Do you mean that patches which break above rules should be
skipped when "--reject" is set, as other failures? Or that
whole git-apply should fail regardless of "--reject"?


Michal Kiedrowicz
