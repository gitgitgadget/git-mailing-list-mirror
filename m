From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/18] revert: Don't create invalid replay_opts in parse_args
Date: Mon, 1 Aug 2011 23:07:22 +0530
Message-ID: <CALkWK0n2j_jFzkwF_QrVUejchnh=zEbUkGxH1_EyhjjZLj3FPA@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-11-git-send-email-artagnon@gmail.com> <201107311431.26187.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:37:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwR3-0005up-FB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab1HARho convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 13:37:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54856 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab1HARhm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 13:37:42 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so5885367wwe.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+S4qGDzEX5QooQNg/Dko2MsLmA+SJL/oXULjlAz6oRw=;
        b=MzzAdSFQKis2WqamtdVB027ZDxJKgKdcusW3noCjPIPX3fTjsfSyQuetM0e+bmmuU0
         9xMLbKKXs6DgDSQH0vSNXsdIY+0TvROaxuzz6mwshvJPABzXAVx9Zn7cUuc80iKG+EkL
         Ca6Qgp5NrfcWAUbr1Mqrh5Rrhs4N90ShAv9qA=
Received: by 10.216.172.201 with SMTP id t51mr312782wel.79.1312220262164; Mon,
 01 Aug 2011 10:37:42 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 1 Aug 2011 10:37:22 -0700 (PDT)
In-Reply-To: <201107311431.26187.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178360>

Hi Christian,

Christian Couder writes:
> On Wednesday 27 July 2011 05:19:07 Ramkumar Ramachandra wrote:
>> +static void verify_opt_compatible(const char *me, const char *base_=
opt,
>> ...) +{
>> + =C2=A0 =C2=A0 const char *this_opt;
>> + =C2=A0 =C2=A0 va_list ap;
>> + =C2=A0 =C2=A0 int set;
>> +
>> + =C2=A0 =C2=A0 va_start(ap, base_opt);
>> + =C2=A0 =C2=A0 while ((this_opt =3D va_arg(ap, const char *))) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set =3D va_arg(ap, int);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (set)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("%s: %s cannot be used with %s"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 me, this_opt, base_opt);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 va_end(ap);
>> +}
>
> Question: returning in the middle of va_start() - va_end() may not be=
 ok with
> some compilers, but I don't know how safe it is to exit()?

Interesting observation.  Even if it's not a problem, I suppose
there's no harm in putting a va_end before the die() statement --
Valgrind will probably be happier anyway.

>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Sequence of picks finished successfully; cle=
anup by
>> + =C2=A0 =C2=A0 =C2=A0* removing the .git/sequencer directory
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 strbuf_reset(&buf);
>> + =C2=A0 =C2=A0 strbuf_addf(&buf, "%s", git_path(SEQ_DIR));
>> + =C2=A0 =C2=A0 remove_dir_recursively(&buf, 0);
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>
> The "strbuf_reset(&buf)" is not needed. But a "strbuf_release(&buf)" =
could be
> added before the return.

Right, thanks.  Fixed.

-- Ram
