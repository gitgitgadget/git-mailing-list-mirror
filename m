From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFD: should git rev-parse exit with non-zero status if ref@{n} is
 not valid?
Date: Thu, 19 Aug 2010 09:02:32 +1000
Message-ID: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
References: <AANLkTi=Ktz=ARx0qUqB0844aYuq8BbqYUM8g726r9o5t@mail.gmail.com>
	<7vsk2b8x2t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 01:02:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlreZ-000090-2n
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 01:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab0HRXCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 19:02:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55530 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab0HRXCd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 19:02:33 -0400
Received: by qwh6 with SMTP id 6so1058965qwh.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+Nx02M+zEfX086PP/jQAfATBFNw1zK0wpc4EKirD0bQ=;
        b=hKFMYq4i7pKLFrYNiuWkDHOSyYNtirR7DB9suZTUJYv77UB+R+rsk6BLDwxNq1gRK6
         pnEMqDq2ngUTDfvt/ao8t5ApL8MWTikNNZ50Q6yKHMhU1+8IwqSHnRoAbx3YTy8gKpcw
         jYLlqb0QJfsfYh0A7uSFiiFAZHV9jDcgVqNOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uJjpO6ux15xyMOzgjPJTMEasBCsJrZZBqWJ0mwyCiZgbog3h/gMDdN4KnTGaJE+k8x
         tOIYpOD5StzfE7rQjhysNheSVREqVryHKbKd+SrUjwI/QPCcBTgKLTnqF6p4bTFHX5LE
         GvgcYjgUgQD0NgQCd1cLqAaKgWWl17JCtMOAE=
Received: by 10.229.224.146 with SMTP id io18mr6518208qcb.171.1282172552080;
 Wed, 18 Aug 2010 16:02:32 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Wed, 18 Aug 2010 16:02:32 -0700 (PDT)
In-Reply-To: <7vsk2b8x2t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153892>

Thanks for that. Not quite sure why yet, but the error message is
duplicated. I wonder also if the free() call at the end of the
function needs to be duplicated before the early return?

Anyway, I am happy to look at this. Would you prefer this to be
delivered as a separate patch or can I re-roll it at the base of
detached-stash? (I realise I have to re-roll v5 anyway, because some
of the later tests don't quite reflect the intent (e.g. ! git stash
stash@{0} should be ! git stash drop stash@{0}).

jon.

On Thu, Aug 19, 2010 at 6:50 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> I understand why ref@{time-spec} might behave this way, but I reckon
>> that if you ask for ref@{n} for n > N-1, where N is the length of th=
e
>> reflog, then you should either get empty output and a non-zero statu=
s
>> (preferred) or a ref@{N-1} on the output with a status code of zero
>> and a warning message (less optimal, IMHO).
>
> Yeah, the behaviour of ref@{...} syntax parser is way suboptimal:
>
> =C2=A0 =C2=A0$ git rev-parse --verify jch@{99999}; echo $?
> =C2=A0 =C2=A0warning: Log for 'jch' only has 1368 entries.
> =C2=A0 =C2=A0cfb88e9a8d4926b0011ae2dd67e1f57a98f4b768
> =C2=A0 =C2=A00
>
> It even knows that it is running off the cut-off point; it should jus=
t
> cause the caller to notice that fact. =C2=A0I don't think changing it=
 to error
> out should cause any harm to existing callers.
>
> It may just be the matter of doing something like this (totally
> untested)...
>
> =C2=A0sha1_name.c | =C2=A0 12 +++++-------
> =C2=A01 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 4af94fa..c1e51c9 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -342,7 +342,7 @@ static int get_sha1_1(const char *name, int len, =
unsigned char *sha1);
>
> =C2=A0static int get_sha1_basic(const char *str, int len, unsigned ch=
ar *sha1)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 static const char *warning =3D "warning: refna=
me '%.*s' is ambiguous.\n";
> + =C2=A0 =C2=A0 =C2=A0 static const char *warn_msg =3D "warning: refn=
ame '%.*s' is ambiguous.\n";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *real_ref =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int refs_found =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int at, reflog_len;
> @@ -390,7 +390,7 @@ static int get_sha1_basic(const char *str, int le=
n, unsigned char *sha1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (warn_ambiguous_refs && refs_found > 1)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, wa=
rning, len, str);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, wa=
rn_msg, len, str);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (reflog_len) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nth, i;
> @@ -426,14 +426,12 @@ static int get_sha1_basic(const char *str, int =
len, unsigned char *sha1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (read_ref_a=
t(real_ref, at_time, nth, sha1, NULL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&co_time, &co_tz, &co_cnt)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (at_time)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "warnin=
g: Log for '%.*s' only goes "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warning("Log for '%.*s' only goes "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"=
back to %s.\n", len, str,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
how_date(co_time, co_tz, DATE_RFC2822));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "warnin=
g: Log for '%.*s' only has "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%d ent=
ries.\n", len, str, co_cnt);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("Log for '%.*s' only h=
as "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0"%d entries.\n", len, str, co_cnt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
>
