From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a test for a problem in "rebase --whitespace=fix"
Date: Tue, 09 Feb 2010 13:58:28 -0800
Message-ID: <7vzl3i137f.fsf@alter.siamese.dyndns.org>
References: <4B6E7564.7040109@gmail.com>
 <7vtytsevsd.fsf@alter.siamese.dyndns.org>
 <6672d0161002071444lba0f751w3e7e33043e1ec2e8@mail.gmail.com>
 <7vbpg060qx.fsf@alter.siamese.dyndns.org>
 <6672d0161002072337r2ad002adq69f4c686da8cdf09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ney6Y-0002jw-Ho
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 22:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0BIV6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 16:58:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0BIV6f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 16:58:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 628B898964;
	Tue,  9 Feb 2010 16:58:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Eg42VT1VjxL1
	Yoh0R8X4PQzT41M=; b=GjqHRNJjUtKDfxZaRwpsWigWuRB4M29vsw2NqsqZZuos
	FAhC5KB3eIDrb+6FVK51YHbW6oUo+Tqv1gg95ce1TnDH9d0QdjsdowcbF87SqO28
	OZC0JT0CnmmjmsU1MzunIWju7WZAofvccF8rM82wcMblVC9mmtyf4nMFBEp3a/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=a8WRiu
	bSGAwmnRjRWDto0yIQ+8jvhxzDOUNUB+cnWLNfTdb/v6Doqbwq/Xx2ebKWykszgD
	FcA98i4qO45gPcpL9hRxQGu09wmt22MEB2rCMVsYVO4xCFPDlnkyKyLJ9IxrLg6s
	GqfC+wPhubQMiCi+ihDQZMyfo6LoXAhEHXZlk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C3F79895E;
	Tue,  9 Feb 2010 16:58:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44DC99895C; Tue,  9 Feb
 2010 16:58:30 -0500 (EST)
In-Reply-To: <6672d0161002072337r2ad002adq69f4c686da8cdf09@mail.gmail.com>
 (=?utf-8?Q?=22Bj=C3=B6rn?= Gustavsson"'s message of "Mon\, 8 Feb 2010
 08\:37\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 43F4088A-15C6-11DF-A1E7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139447>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> I see at least two possible ways to implement that:
>
> 1. Have "git rebase" give "git apply" a special option so that it
> will apply patches beyond the end of file (and trusting the
> line numbers in the chunks).
>
> 2. Having "git rebase" remember the number of blanks line that
> was removed in each previous file in previous fixed commits
> and add them back just before invoking "git apply".

I actually changed my mind after thinking about it a bit more.

I think you should be able to do the same thing as we already do in
git-apply inside match_fragment(), and without involving any "rebase"
specific hacks nor options, the result will cover most of the real-life
use cases.

The existing logic in the function says "We were told to find a locatio=
n
in the img (i.e. the text being patched) where preimage appears.  We wi=
ll
replace the copy of the preimage in img with the corresponding postimag=
e.
Unfortunately, the preimage does not exactly match, but if we consider
that we may have applied earlier patches with whitespace=3Dfix, we can =
see
that the given preimage matches with this location in our img except fo=
r
whitespace differences."

When it finds the place that "fuzzily" matches the preimage, it adjusts
the given preimage to match what we have (i.e. pretends that the patch
sender sent a patch based on a version of the text with whitespace fixe=
s
we made in ours already applied), and then let the common logic replace
that copy of preimage with postimage in img.

The hunk is applied successfully, and we are happy.

Using the same logic, your "a/b/c trail" -> "a/b/c gap d/e/f" example
would work like this.

After applying the first patch with blank-at-eof, we will have "a/b/c" =
(no
trailing blanks) in img.

The second patch comes.  It looks like this:

    @@ -l,3 +k,6 @@
     b
     c
    =20
    +d
    +e
    +f
   =20
This tells you to match "'b c blank' at the end" (lack of trailing cont=
ext
would trigger match_end hint, I think).  So you go ahead and look at yo=
ur
img, which is "a/b/c" (no trailing blanks).  It does not match.

Just like existing logic in match_fragment() knows that the img might h=
ave
undergone whitespace fixes, your new logic would realize that with an
addition of one empty line to make your img "a/b/c blank", the preimage=
 of
this hunk matches the way as you are told to search.

At that point, you adjust the preimage to match what we have (the logic=
 is
exactly the same as blank-at-eol case---adjust the patch to pretend tha=
t
they started with a whitespace-corrected version we have).  This would
make the hunk look like this:

    @@ -l,2 +k,6 @@
     b
     c
    +
    +d
    +e
    +f

and by applying that adjusted hunk, you will get the expected result,
namely, "a/b/c gap d/e/f".

Notice that we did all that without ever looking at 'l' and 'k' (hunk
offsets)?

I'd like to see this logic (and only this logic, without relying on the
diff hunk offset numbers at all) done first, because it is very much in
line with what we already do, and more importantly, because it is a mor=
e
general solution that is applicable outside the context of rebase.

This of course will not catch the case where you used to have added ton=
s
of blanks at the end in the earlier patch (and losing sight of how many
blanks you removed while applying it).  You would need to build a speci=
al
case that probably relies on the diff hunk offset, and trigger that
additional logic in rebase (i.e. the caller that _knows_ the hunk offse=
ts
are reliable).  That special case may not involve a change to "git appl=
y"
at all, as you suggested as an alternative (2), as you can do that all
inside "git rebase".  But I'd rather like to see a solution that does n=
ot
rely on the special case as one patch that is independent from rebase, =
and
the special case built on top of it, as a separate patch.

After all, if you _are_ applying with whitespace=3Dfix and blank-at-eof=
 is
in effect, it is very likely that the nature of the contents in that pa=
th
is something that blank lines in the middle does not matter except for
readability (e.g. something like .git/config file format); the fact tha=
t
it is safe to strip the blank-at-eof strongly suggests that blanks do n=
ot
have semantic meaning and are there purely for readability.  In content=
s
of such a nature, it would not matter if you lost indeterminate number =
of
blank lines in the middle by applying two patches, the first one leavin=
g
100 blank lines at the end and then the second one adding some non-blan=
k
lines at the end.  It might even turn out to be a moot point to worry
about the special case hack if that is the case.
