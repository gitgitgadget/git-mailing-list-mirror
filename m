From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 07/48] t6039: Ensure rename/rename conflicts leave index
 and workdir in sane state
Date: Mon, 8 Aug 2011 11:59:19 -0600
Message-ID: <CABPp-BEKTnOdib=KdKWMkEhEBrUUth2prn_r2N=bEbu0ZoD+6A@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<1307518278-23814-8-git-send-email-newren@gmail.com>
	<7vaacbb1jn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 19:59:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqU6q-0002KL-CF
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 19:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab1HHR7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 13:59:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61769 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1HHR7V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 13:59:21 -0400
Received: by fxh19 with SMTP id 19so5605167fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=a1G0iXse7ZuWXrJM8uyYE23i6UwuUroPvYIhe2IIBvM=;
        b=kijPfPdRYn0JkXurqDzgZvQN+UaNQMpDXiMoZlXTZw9ryQTto5BAMsoz+7u/0Bq7Rm
         XDULVpHhFQMUQ6y+KSBjZzNCL++GjtsQdeXqA0NCzYupPDOdcB9h4N66BLdglEMv7wuJ
         VMHJ1E28lcyjEHSULBo6S1WH4S83KJQ3tF2G4=
Received: by 10.204.140.134 with SMTP id i6mr1552523bku.189.1312826359549;
 Mon, 08 Aug 2011 10:59:19 -0700 (PDT)
Received: by 10.204.50.143 with HTTP; Mon, 8 Aug 2011 10:59:19 -0700 (PDT)
In-Reply-To: <7vaacbb1jn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178966>

On Mon, Jul 18, 2011 at 5:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> +# Test for all kinds of things that can go wrong with rename/rename=
 (2to1):
>> +# =C2=A0 Commit A: new files: a & b
>> +# =C2=A0 Commit B: rename a->c, modify b
>> +# =C2=A0 Commit C: rename b->c, modify a
>> +#
>> +# Merging of B & C should NOT be clean. =C2=A0Questions:
>> +# =C2=A0 * Both a & b should be removed by the merge; are they?
>> +# =C2=A0 * The two c's should contain modifications to a & b; do th=
ey?
>> +# =C2=A0 * The index should contain two files, both for c; does it?
>> +# =C2=A0 * The working copy should have two files, both of form c~<=
unique>; does it?
>> +# =C2=A0 * Nothing else should be present. =C2=A0Is anything?
>
> What is the most useful thing to leave in the index and in the workin=
g
> tree for the person who needs to resolve such a merge using the worki=
ng
> tree, starting from B and merging C? The above "Questions" lists what=
 the
> current code might try to do but I am not sure if it is really useful=
=2E For
> example, in the index, you would have to stuff two stage #1 entries (=
"a"
> from A and "b" from A) for path "c", with stage #2 ("c" from B) and s=
tage
> #3 ("c" from C) entries, and represent what B tried to do to "a" (in =
the
> above you said "rename a->c" but it does not have to be a rename with=
out
> content change) and what C tried to do to "b" in the half-conflicted
> result that is in a single file "c". Because the result are totally
> unrelated files (one side wants a variant of original "a" there, the =
other
> side wants a variant of "b"), such a half-merge result is totally use=
less
> to help the person to come up with anything.
>
> Also renaming "c" to "c~<unique>", if they do not have corresponding
> entries in the index to let you check with "git diff", would make the
> result _harder_ to use, not easier. So if you are going to rename "c"=
 to
> "c-B" and "c-C", at least it would make much more sense to have in th=
e
> index:
>
> =C2=A0- "c-B", with stage #1 ("a" from A), stage #2 ("c" from B) and =
stage #3
> =C2=A0 ("a" from C);
> =C2=A0- "c-C", with stage #1 ("b" from A), stage #2 ("b" from B) and =
stage #3
> =C2=A0 ("c" from C); and
> =C2=A0- No "a" nor "b" in the index nor in the working tree.
>
> no?
>
> That way, you could run "git diff" to get what happened to the two
> variants of "a" and "b" at the content level, and decide to clean thi=
ngs
> up with:
>
> =C2=A0 =C2=A0$ git diff ;# view content level merge
> =C2=A0 =C2=A0$ edit c-B c-C; git add c-B c-C
> =C2=A0 =C2=A0$ git mv c-B c-some-saner-name
> =C2=A0 =C2=A0$ git mv c-C c-another-saner-name
> =C2=A0 =C2=A0$ edit other files that refer to c like Makefile
> =C2=A0 =C2=A0$ git commit

That sounds very interesting.  My first thought is that you'd have to
do the same thing in the case of a D/F conflict, but I notice that
later in the patch series you asked for exactly that.  The idea
certainly has potential, though I might need to think it through a
little more.

> To take it one step further to the extreme, it might give us a more
> reasonable and useful conflicted state if we deliberately dropped som=
e
> information instead in a case like this, e.g.:
>
> =C2=A0- We may want to have "a" at stage #1 (from A) in the index;
> =C2=A0- No "a" remains in the working tree;
> =C2=A0- "b" at stage #1 (from A), stage #2 (from B) and stage #3 ("c"=
 from C);
> =C2=A0- "b" in the working tree a conflicted-merge of the above three=
;
> =C2=A0- "c" at stage #1 ("a" from A), stage #2 (from B), and stage #3=
 ("a" from
> =C2=A0 C); and
> =C2=A0- "c" in the working tree a conflicted-merge of the above three=
=2E
>
> Note that unlike the current merge-recursive that tries to come up wi=
th a
> temporary pathname to store both versions of C, this would ignore "mv=
 b c"
> on the A->C branch, and make the conflicted tentative merge asymmetri=
c
> (merging B into C and merging C into B would give different conflicts=
),
> but I suspect that the asymmetry may not hurt us.
>
> Whether the merger wants to keep "c" that was derived from "a" (in li=
ne
> with the HEAD) or "c" that was derived from "b" (in line with MERGE_H=
EAD),
> if the result were to keep both files in some shape, the content leve=
l
> edit, renaming of at least one side, and adjusting other files that r=
efer
> to it, are all required anyway, e.g.
>
> =C2=A0 =C2=A0$ git diff ;# view content level merge
> =C2=A0 =C2=A0$ edit b c; git add b c
> =C2=A0 =C2=A0$ edit other files that refer to c line Makefile (the co=
ntent C's
> =C2=A0 =C2=A0 =C2=A0change wants is now in "b").
> =C2=A0 =C2=A0$ git commit
>
> would be a way to pick "c" as "c-some-saner-name" and "b" as
> "c-another-saner-name" in the previous workflow, but needs much less
> typing. The complexity of the workflow would be the same if the final
> resolution is to take what one side did and dropping the other's work=
,
> I think.

I think the asymmetry is slightly confusing and could become
problematic.  If we decide to turn on break detection, then we would
hit problems in a scenario such as:

Commit A: files a, b are present
Commit B: rename a->c, add an unrelated a
Commit C: rename b->c, add an unrelated b

In that case, "undoing" the rename as you suggest gives us a conflict
with other content that was added at the path.


Also, as mentioned above, D/F conflicts hit similar cases where we
need to rename the path in the working copy.  If we try to handle them
similarly to how you are suggesting for the rename/rename(2to1) case,
we can do so in some cases but hit problems in others.  For example,
take a rename/delete conflict with D/F conflicts:

Commit A: file a is present
Commit B: rename a -> df, possibly also modifying it
Commit C: delete a, add files a/foo and df/bar

We can't use either the path 'df' or 'a' for recording the content.  I
think the rules become too confusing for "selectively undoing renames"
and it'd be easier to just use <bad-dest-path>~<unique> in all cases.
However, I think your suggestion to move index stage information to
these uniquely renamed paths could probably work and may be useful.
