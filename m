From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/5] Add convenient function to do automatic garbage collection
Date: Sat, 19 May 2012 11:56:40 +0700
Message-ID: <CACsJy8A-gaQFP_X+f4t_WaLG9Gn0b8e1YmH3gF4jmPhqW8m5xw@mail.gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <1337171377-26960-1-git-send-email-pclouds@gmail.com> <1337171377-26960-2-git-send-email-pclouds@gmail.com>
 <xmqqvcjt15g5.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Fernando Vezzosi <buccia@repnz.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 06:57:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVbjB-0002H9-6a
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 06:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab2ESE5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 00:57:13 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:49306 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab2ESE5M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 00:57:12 -0400
Received: by weyu7 with SMTP id u7so2180358wey.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 21:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=l4qNNd2CShfxWYLUtqB8peCviU0mO6pE17PZmaWqHZU=;
        b=VhEXYdO4G4NiGRcJKxm3oAmJVse0qo3uWDoIQe2+fPZDulBYN+9mMsVqanoiOeN2K4
         uTPdjug25/Y8CsF0x832OYhSPmKPCf6nPNTqeOzOk2MhW656fwfYbNDTwZ2JHTEFTY8V
         dvEsfmX334zM4Dz6VqDEheZKXqq4HHIdrq8FlQbBqI2HchS8OVHGOyX/ruPiBhy6iY7n
         exkf7/gbwrdeq+O07zHJdwkhDkMTO3mZRCX5Cb8aJFzEugSTkn59QxFDtqL+TCRif9gP
         2xDHQbVrYixy1VfQqbFRZ9DivzZukz5yHoKo94qeGSf39j0I39qdaXzLsMwWXKUUSHF8
         hZnw==
Received: by 10.180.99.70 with SMTP id eo6mr7415234wib.17.1337403431076; Fri,
 18 May 2012 21:57:11 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Fri, 18 May 2012 21:56:40 -0700 (PDT)
In-Reply-To: <xmqqvcjt15g5.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198014>

On Sat, May 19, 2012 at 5:37 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> This function also avoids forking most of the time by performing som=
e
>> check in process.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ...
>> @@ -64,6 +66,10 @@ static int gc_config(const char *var, const char =
*value, void *cb)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return git_config_s=
tring(&prune_expire, var, value);
>> =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (cb && !strcmp(var, cb)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auto_gc =3D git_config_b=
ool(var, value);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 }
>
> This does not look like "add convenient function for auto-gc" nor "av=
oid
> forking"; it is something else that is not explained.

It takes care of "foo.autogc" config key in commands that allows to
suppress auto gc. But yes, commit message can use some improvement.
--=20
Duy
