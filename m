From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Thu, 14 Mar 2013 17:22:35 +0700
Message-ID: <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com> <7vehfj46mu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, artagnon@gmail.com,
	robert.allan.zeh@gmail.com, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Mar 14 11:23:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG5Jw-0003Zw-4H
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 11:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab3CNKXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Mar 2013 06:23:08 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:59918 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab3CNKXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Mar 2013 06:23:07 -0400
Received: by mail-ob0-f173.google.com with SMTP id dn14so1965291obc.4
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=7fmzXuQQE5lNDgyRFeBOByJDyrzmY04rBMWbcZsRRbs=;
        b=xK3aPYAW2rwsOQoBefezRYLzkRcXBiSm6lFw36XxA0gJP+jyX7u1Q5D6lRpytZ8fW3
         VQYPJ9d4qYtorcgUeLYVSF/pG7SZo+X5gSNJDVaFggxaMb1chIKBfZn4OaBnsTHhZpUm
         sgg6mxC9LDtJ+uStSSsM391NRgipycjiDRNkZS02S39CGAFJcBtZd/f7T2sKogQeCi6b
         JA8Z688PY8db9sw6qZgZ8dbchLQjG/M8uIpqgfx9v35XjvZMqP+30hgrlskJ67+Lxpjz
         Im75J79SSrybMIjGtCIJEyhgXPTr3aa5CpeHlwZEKweJO7NAdQpr97PJTy8efUkSbXQM
         jyQg==
X-Received: by 10.60.170.177 with SMTP id an17mr851576oec.62.1363256586075;
 Thu, 14 Mar 2013 03:23:06 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Thu, 14 Mar 2013 03:22:35 -0700 (PDT)
In-Reply-To: <7vehfj46mu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218125>

On Wed, Mar 13, 2013 at 10:21 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
>> +     statusUno::
>> +             If collecting untracked files in linkgit:git-status[1]
>> +             takes more than 2 seconds, hint the user that the opti=
on
>> +             `-uno` could be used to stop collecting untracked file=
s.
> Thanks, I like the idea
> could we make a "de-Luxe" version where
>
> statusUno is an integer, counting in milliseconds?

No problem.

On Wed, Mar 13, 2013 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> The noise this introduces to the test suite is a bit irritating and
> makes us think twice if this really a good change.

I originally thought of two options, this or add an env flag in git
binary that turns this off in the test suite. The latter did not sound
good. But I forgot that we set a fake $HOME in the test suite, we
could disable this in $HOME/.gitconfig, less clutter in individual
tests.

>>  static void wt_status_print_unmerged(struct wt_status *s)
>> +             if (advice_status_uno && s->untracked_in_ms > 2000) {
>> +                     status_printf_ln(s, GIT_COLOR_NORMAL,
>> +                                      _("It took %.2f seconds to co=
llect untracked files."),
>> +                                      (float)s->untracked_in_ms / 1=
000);
>> +                     status_printf_ln(s, GIT_COLOR_NORMAL,
>> +                                      _("If it happens often, you m=
ay want to use option -uno"));
>> +                     status_printf_ln(s, GIT_COLOR_NORMAL,
>> +                                      _("to speed up by stopping di=
splaying untracked files"));
>> +             }
>
> "to speed up by stopping displaying untracked files" does not look
> like giving a balanced suggestion.  It is increasing the risk of
> forgetting about newly created files the user may want to add, but
> the risk is not properly warned.

How about "It took X ms to collect untracked files.\nCheck out the
option -u for a potential speedup"? I deliberately hide "no" so that
the user cannot blindly type and run it without reading document
first. We can give full explanation and warning there in the document.

> I tend to agree that the new advice would help users if phrased in a
> right way.  Do we want them in COLOR_NORMAL, or do we want to make
> them stand out a bit more (do we have COLOR_BLINK ;-)?

There will be false positives (cold cache for example). So yeah
something more standing out is good but it should catch too much
attention. We're currently using red and green in status output. Maybe
this one can take blue.

PS. What about advertising index v4? I sent a patch some time ago to
put an advice in git-clone. I think it's a good place, but we could
place it somewhere else..
--=20
Duy
