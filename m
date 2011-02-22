From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] rev-list: new --cherry-pick=loose option
Date: Mon, 21 Feb 2011 21:54:55 -0500
Message-ID: <AANLkTi=dvkf3_Bkn0tCruDmYSnqYSGLQ55-NhCEuysnF@mail.gmail.com>
References: <1298317769-65830-1-git-send-email-jaysoffian@gmail.com> <7vfwrghqjp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 03:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PriPT-00054F-D1
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 03:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab1BVCz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 21:55:26 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51970 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab1BVCzZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 21:55:25 -0500
Received: by iwn34 with SMTP id 34so120922iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 18:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=d+dRu/9k3yvq1g6yiPfPfhCFygYls0vJE0fduiGgqRs=;
        b=mvZnjGkefDUtXamrsPywpV3Ty0UwfHDJtcLKswBhrS3c0bimYAFoDhYWTrNyJEu0XN
         kFRwDiA6SXxHAiRzkvQswmtELQKUNjaBtkQq976o8K9NgtYKl4oTUAjOlx+bb3XmAjz2
         O7QkD1zktelH0u134C7Jyi0mfOMLFFDu01hbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kSRt1XDjCWjqvJ5L2Rmm2jOPdHu6D7UaGjjUlumh/zRXjSSsxR7kEn+j+wyx1G5/h5
         xS9omxFVl78eF89yNuOi9cG9aJIdKEsCMuWJpTu03s/EJD34xoEq/pCbP8t2PawfSxi/
         RJ5iLOLOVcB5em+ojt9OVm2bbGMfXmaRQEdcY=
Received: by 10.42.225.4 with SMTP id iq4mr2912120icb.110.1298343325172; Mon,
 21 Feb 2011 18:55:25 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 21 Feb 2011 18:54:55 -0800 (PST)
In-Reply-To: <7vfwrghqjp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167524>

On Mon, Feb 21, 2011 at 7:16 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Thoughts?
>
> I am personally not very interested in this particular "author, times=
tamp,
> title and nothing else" implementation, as that is probably too loose=
 (in
> many projects, title by itself is not descriptive enough) to be safe.

Well, right, it's not title by itself, it's title + authorship. I am
scratching my head at a project that would have commits identical in
author, timestamp, and title.

> Also people would probably want other loose modes with varying degree

Initially I thought this too and was going to let it take pretty-print
specifiers (--cherry-pick=3Dformat:...), but I can't see which other
metadata would be useful. Maybe the commit body, but if there were
conflicts, that's something that would have very likely been changed
to add a Conflicts: section.

> (e.g. throwing in the list of touched paths to your mix might make it=
 a
> bit safer), so "loose" feels a bit too broad a word to give to this
> particular implementation (iow, it does not say in what way it is loo=
se).

Throwing in touched paths does make it safer, but for my use case is
too strict for some commits (I sometimes have to account for file
renames when I cherry-pick).

>> @@ -65,8 +79,13 @@ static struct patch_id *add_commit(struct commit =
*commit,
>> =C2=A0 =C2=A0 =C2=A0 unsigned char sha1[20];
>> =C2=A0 =C2=A0 =C2=A0 int pos;
>>
>> - =C2=A0 =C2=A0 if (commit_patch_id(commit, &ids->diffopts, sha1))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> + =C2=A0 =C2=A0 if (ids->loose) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (commit_patch_id_loos=
e(commit, sha1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return NULL;
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (commit_patch_id(comm=
it, &ids->diffopts, sha1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return NULL;
>> + =C2=A0 =C2=A0 }
>
> If the purpose of the patch is to stir the discussion, it is fine to =
have
> any crappy "here is a strawman" algorithm as an example of an alterna=
tive
> patch ID computation, but one thing it _should_ do well is to show wh=
ere
> the necessary change should be hooked into, and I think the above "if=
"
> statement is placed in a wrong function. =C2=A0If you change commit_p=
atch_id()
> to take a pointer to the whole ids instead of just &ids->diffopts, it=
 can
> decide how the "commit patch ID" is computed without affecting the
> callers, no?

Good idea.

> And then we could instead introduce patch-id-algo=3D<foo>, and instea=
d of
> "loose" call this particular algorithm "authorship-subject" or someth=
ing.
> Coming up with a pluggable interface to let the end user compute patc=
h
> equivalence might be a plus.

I think it's premature to make it pluggable. I was hoping that with
this mode (loose) and the existing mode (strict), the extremes would
be covered. And then we'd wait and see what latent demand might exist
for other modes. :-)

I just don't feel like I know enough about what "the end user" wants
to come up with a reasonably general scheme.

(The best I can come up with that's pluggable and not horribly
expensive is something like open bi-directional pipes to an external
process that gets fed diffs and returns patch-ids.)

> Certain patch equivalence might not be easy to define by "do they has=
h to
> the same small value" but by "here are two patches---compare them and=
 tell
> me if they are equivalent". =C2=A0If we can update the code to suppor=
t that
> kind of patch equivalence it would be great, but it is not within the
> reach/scope of this patch (not a complaint, but something you may wan=
t to
> tackle next).

More than I can bite off at the moment.

j.
