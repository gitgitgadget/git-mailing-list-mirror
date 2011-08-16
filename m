From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] commit: check return value of lookup_commit()
Date: Tue, 16 Aug 2011 20:22:27 +0700
Message-ID: <CACsJy8AusStKNWuw3j740r4Nc0FhzR+jJZJNaesxn68pr7dTqA@mail.gmail.com>
References: <1313422716-26432-1-git-send-email-pclouds@gmail.com> <7vei0mlg8d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 15:23:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtJbl-0003uB-TI
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 15:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab1HPNW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 09:22:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46596 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab1HPNW6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 09:22:58 -0400
Received: by bke11 with SMTP id 11so3711695bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DNSiGuspB7j3JhfUcypnMVERhexitlQQWfhSSD12xkA=;
        b=nIjyOKNzWLPoNTli9LHPrHWNQpptiT6r1+XBZpwAIBJ05QWEOwjbAwNAhAv5rkWHD2
         sMfHQeyaliz1sgSjuWbCNp027HtOUNj2XaB/PCoDhvXWJwQ0PKWwOOl4MKWmlGO9RiVV
         6ilrSR/rqi2dVF7HmoD5BL2g7qPPQ6DSKDRoA=
Received: by 10.204.174.130 with SMTP id t2mr956481bkz.383.1313500977393; Tue,
 16 Aug 2011 06:22:57 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Tue, 16 Aug 2011 06:22:27 -0700 (PDT)
In-Reply-To: <7vei0mlg8d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179445>

2011/8/16 Junio C Hamano <gitster@pobox.com>:
> The change itself looks good to me but a point and a half to think ab=
out:
>
> =C2=A0- In this if/elseif/.../else cascade, everybody except for the
> =C2=A0 "initial_commit" case needs to make sure that head_sha1 points=
 at a
> =C2=A0 valid commit and get an commit object. Hoisting the scope of t=
he
> =C2=A0 variable "commit" one level in your patch is good, but it woul=
d make it
> =C2=A0 easier to read and the future code modification much less erro=
r prone
> =C2=A0 if (1) you called lookup_commit() and checked for errors befor=
e
> =C2=A0 entering this if/elseif/... cascade, and (2) you renamed this =
variable
> =C2=A0 to "head_commit".

But then I would need to avoid die()ing in "initial_commit" case. So
it becomes two related condition blocks (head_commit check and the
if/elseif...), more error prone to me.

> =C2=A0- Whether we like it or not, many people have a broken reimplem=
entations
> =C2=A0 of git that can put a non-commit in HEAD, and they won't be fi=
xed
> =C2=A0 overnight. Instead of erroring out, would it be nicer of us if=
 we just
> =C2=A0 warned, unwrapped the tag and used the tagged commit instead?

How about replacing those lookup_commit() with this? It would tolerate
tag-in-branch case, but also warn users that something's gone wrong.

struct commit *lookup_expect_commit(const unsigned char *sha1,
				    const char *ref_name)
{
	struct commit *c =3D lookup_commit_reference(sha1);
	if (!c)
		die(_("could not parse %s"), ref_name);
	if (hashcmp(sha1, c->object.sha1))
		warning(_("%s %s is not a commit!"),
			ref_name, sha1_to_hex(sha1));
	return c;
}
--=20
Duy
