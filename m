From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/4] notes: preserve object type given by "add -C"
Date: Sat, 12 May 2012 13:58:23 +0700
Message-ID: <CACsJy8AYwBdfywuOQ7t873Hc-Sjv3Fnx77s+1VmKWbSXts77-Q@mail.gmail.com>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
 <1336699506-28388-2-git-send-email-pclouds@gmail.com> <7vzk9eju4m.fsf@alter.siamese.dyndns.org>
 <CACsJy8Avusvu9LJeg1L=OZ9=qW+FaqbNWfA_rrZJUY_3WqfhOg@mail.gmail.com> <7vzk9ehqr8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 12 08:59:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST6Ik-00018Z-4A
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 08:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab2ELG64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 02:58:56 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:32798 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab2ELG6z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 02:58:55 -0400
Received: by weyu7 with SMTP id u7so795636wey.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 23:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5awYnbTqAFVbIOD25Ma63c7424Fok220DDVbbVus1Is=;
        b=cWVtLp4AaVLBe41K3QXMg86q3RL9m7vt4JMmtSxhX+KTT7A4KcbGJ2ai1jw0aaXL/u
         dpTZO2wUapuzsL4q/1PHQFsJKou03fCYK4XzuyzReoeAaFVpMhyC19HEmMMgRG0SKEgg
         fHrXgHA6EpP55qkldvuFNxXtEHQMi0DINrq8F1iVI6b5TZWClE0RiglpAopgtG6oZ6It
         PLvqwb05NmP6zTfwBrnEFdHasD1VZRzdqgzMNhXCnrunG/gQgNozduCV5tJrXJrOAx5Q
         N+ftuZZhRvAxH868qmCOJBXQsOGAVjf32xboKlv5lc7+kQnG9FQqymYnV0oTBsjJsU+L
         db6w==
Received: by 10.180.97.3 with SMTP id dw3mr2129618wib.19.1336805933867; Fri,
 11 May 2012 23:58:53 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Fri, 11 May 2012 23:58:23 -0700 (PDT)
In-Reply-To: <7vzk9ehqr8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197713>

On Sat, May 12, 2012 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Sat, May 12, 2012 at 4:16 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> ...
>>> It is not automatically "converting"; as far as the notes subsystem=
 is
>>> concerned, the data you throw at it to be associated with an object=
 the
>>> note annotates has always been uninterpreted stream of bytes. If an
>>> application wants to store the raw representation of a commit objec=
t
>>> including the log message and its header, it has every right to exp=
ect
>>> that it can use "git cat-file commit $argument_to_the_C_option" as =
the
>>> source of that uninterpreted stream of bytes, doesn't it?
>>
>> Some part of git-notes expects this stream of bytes to be textual,
>> human readable. In that case, "git notes add -C commit/tag"'s stuffi=
ng
>> a blob with the given commit/tag content to notes tree may make sens=
e.
>> Personally I'd rather stuff the commit/tag object instead so no new
>> blobs are created. The end result is the same: read_sha1_file() alwa=
ys
>> return correct text, so does "git notes show".
>
> No, the end result is definitely not the same.
>
> There are two important characteristics of "uninterpreted byte stream=
" the
> above thinking is not taking into consideration:
>
> =C2=A0(1) we do not interpret what the application stores; and
> =C2=A0(2) the application is *not* limited by our type system.
>
> Suppose the application happens to want to stuff the contents it took=
 from
> a commit object, and "add -C $objecname" is a convenient way to do so=
=2E =C2=A0We
> have recorded it as "blob" because it is uninterpreted stream of byte=
s. If
> you record that as a leaf note in the note tree, does that mean the n=
ote
> tree now suddenly have a submodule? =C2=A0Hell, no.
>
> What if the application wanted to record the contents of a tree objec=
t
> instead? =C2=A0How would that affect the fan-out mechanism the note s=
ubsystem
> uses to hash the 40-hexadecimal object names? =C2=A0After descending =
the notes
> tree to consume the object name to reach the leaf node, it still find=
s
> even more level hanging below. =C2=A0Not very careful "list all objec=
t names
> that have notes attached in this note tree" implementation may end up
> descending into the tree object, because of this patch. =C2=A0Another=
 bad
> implication of such a change is that suddenly we would start includin=
g all
> the subobjects in that tree object when computing the reachability of=
 the
> notes tree.

Hmm.. you are right. Consider this series dropped.

>
> The application needs to have a way to tell what is in the data it st=
ores
> anyway, because it is not necessarily "enhancing git" kind of applica=
tion
> that talks about relationships between git objects. =C2=A0And it may =
do so
> either by convention (e.g. my "notes/amlog" notes tree only records a
> single-line text that is a Message-Id header of the original patch e-=
mail
> commits came from) or by having its own way to identify the applicati=
on
> specific data type (e.g. json, pickle, protobuf, etc.). =C2=A0It is p=
ointless
> to say "Git object types can be stored natively, but there is only on=
e
> type of blob so the application needs to find a way to coax the types=
 of
> data it wants to store itself." =C2=A0It needs to do so anyway, and h=
aving
> native and standardized way only for git object types does not improv=
e the
> system. =C2=A0It only ties our hands going forward because we need to=
 define
> what it _means_ to store non-blob types in the notes tree, and suppor=
t
> that forever.
>
> So this 1/4 patch is _not_ a bugfix at all. =C2=A0It breaks perfectly=
 good
> current storage semantics without no good reason.
>
> For that matter, as long as $EDITOR is set to something appropriate f=
or
> the application specific data, there is no reason to forbid editing,
> either.
>
> The only sensible safety against "oops, I forgot that this notes tree
> stores binary gunk" I can think of offhand that won't cripple sensibl=
e use
> case is to sample the data to see if it is binary and ask confirmatio=
n,
> similar to how "less" asks "frotz may be a binary file. See it anyway=
?",
> and do so only when we are spewing it to the terminal.



--=20
Duy
