From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Wed, 3 Aug 2011 15:52:16 +0200
Message-ID: <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:53:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qobsc-0001Wq-Eb
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab1HCNw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 09:52:58 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34651 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab1HCNw4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 09:52:56 -0400
Received: by pzk37 with SMTP id 37so104249pzk.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lhoiVfMXzjpgrQ6Qt8wqxrvlvVkQGqyLRzg7zY/fr8M=;
        b=DVZPCEn4x9tW6IauW80Ju8PwntLI4CGWt4HaJB3Jn42CHjDVBn8ugfYDvgSVdyqaQi
         WWwEQJnYcVKZBk/1YAjCeiWxCGQPz8sJsIXbeDGSlDSpnhbJhUAACQv0u70pONb0H4l+
         f0UpJJ+juu2C7Yx8h6UdP82E9YjxbpXwp/HnY=
Received: by 10.142.153.5 with SMTP id a5mr1870863wfe.121.1312379576053; Wed,
 03 Aug 2011 06:52:56 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Wed, 3 Aug 2011 06:52:16 -0700 (PDT)
In-Reply-To: <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178579>

Heya,

On Mon, Jul 25, 2011 at 01:17, Junio C Hamano <gitster@pobox.com> wrote=
:
> In other words, I am not opposed to an effort to give the callers to =
the
> "pending objects" machinery a better way to discover what the user to=
ld us
> from the command line, giving them more than just "at the end of the
> UNINTERESTING marking here are the objects listed on the command line=
 and
> you can look at their flags". =C2=A0For example, some commands may wa=
nt to tell
> "a..b" and "^a b" apart, and other commands may want to tell what "a"=
 was
> when the user asked for exotic things like "a^@" or "a^!".

I agree that such might be useful, but since we currently do not need
something as advanced as that, I'm hesitant to implement something
(far) more advanced than what we need (YAGNI [0]). So I'm thinking
that perhaps there's a suitable middle ground where we stick with the
current flags approach until someone needs something more advanced so
as to make sure that it's implemented in a way that meets an actual
implementer need?

On Sun, Jul 24, 2011 at 21:23, Junio C Hamano <gitster@pobox.com> wrote=
:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>
>> =C2=A0void add_pending_object(struct rev_info *revs, struct object *=
obj, const char *name)
>> =C2=A0{
>> - =C2=A0 =C2=A0 add_pending_object_with_mode(revs, obj, name, S_IFIN=
VALID);
>> + =C2=A0 =C2=A0 add_pending_object_with_mode(revs, obj, name, S_IFIN=
VALID, 0);
>> =C2=A0}
>
> This seems utterly broken. =C2=A0For example, fmt-merge-msg.c adds "^=
HEAD" and
> of course the flags on the object is UNINTERESTING. Has all the calle=
rs of
> add_pending_object() been verified? Why is it passing an unconditiona=
l 0
> and not !!(obj->flags & UNINTERESTING) or something?

If I understand correctly (and it's not unlikely that I don't), the
'flags' field is used to store the actual flags (not just a boolean).
Would the following be appropriate?

+ =C2=A0 =C2=A0 add_pending_object_with_mode(revs, obj, name, S_IFINVAL=
ID, obj->flags);

Hopefully Dscho remembers enough of our hacking to be able to answer
that question.

If it is, do you still think it's "utterly broken" or would that be
something we can work with?

[0] http://c2.com/xp/YouArentGonnaNeedIt.html

--=20
Cheers,

Sverre Rabbelier
