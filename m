From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 06/17] revert: Eliminate global "commit" variable
Date: Wed, 13 Jul 2011 12:27:58 +0530
Message-ID: <CALkWK0k3muAi_h7GRqgJ9vY8SwHK40-AwMdjA=uCDO8Ng4utCA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-7-git-send-email-artagnon@gmail.com> <20110712174518.GB14120@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 08:58:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtOq-0003ak-5c
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 08:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961Ab1GMG6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 02:58:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37860 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab1GMG6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 02:58:19 -0400
Received: by wwe5 with SMTP id 5so5670229wwe.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZH82gtM4zs0sFG3aiJebVCisZGFyJ5D2TCXoZzA3IDQ=;
        b=nrrtCHVGjVGxur3J/2pChuX32qshWXHpnczOvjsOOLulB3dW+XUskUgMT2onn5tLKL
         vkLK6hLiQBYfcwqad31CGYV81qDCjJD3OpO1Y8kIJHO7WcWH2QPK9n9GkRwnh+5Wnqn/
         6peFyEZYuuDz2hAVambQoQGBUtsz7UiSw1JyE=
Received: by 10.216.187.75 with SMTP id x53mr4811465wem.92.1310540298116; Tue,
 12 Jul 2011 23:58:18 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Tue, 12 Jul 2011 23:57:58 -0700 (PDT)
In-Reply-To: <20110712174518.GB14120@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176999>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Since we want to develop the functionality to either pick or revert
>> individual commits atomically later in the series, make "commit" a
>> variable to be passed around explicitly as an argument for clarity.
>
> The above explanation is not so clear to me, but the patch looks good=
=2E
> Isn't the idea something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit =3D grab_a_nice_commit();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D do_pick_commit();
>
> being just an unpleasant API relative to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D do_pick_commit(grab_a_nice_commit(=
));
>
> because in the latter it is more obvious which commit is being
> cherry-picked? =C2=A0Likewise with the functions it calls.
>
> Or perhaps the idea is that eventually we will want to expose somethi=
ng
> like do_pick_commit to other translation units, but a static variable
> like "commit" would not be appropriate for exposing. =C2=A0Or that we=
 save
> a word of global memory. =C2=A0Or that this way if do_pick_commit or =
a
> function it calls ever ends up recursing by mistake it won't get
> broken. =C2=A0Or that we can use multiple threads some day. =C2=A0Or.=
=2E.
>
> Oh, the uncertainty! :) =C2=A0It is not clear to me what any of the a=
bove
> have to do with wanting the functionality to replay an individual
> commit atomically. =C2=A0By the way, what does pickiing or reverting =
a
> commit atomically mean, and how is it different from ordinary
> cherry-picks?

Right.  How about this?

revert: Eliminate global "commit" variable

=46unctions which act on commits currently rely on a file-scope static
variable to be set before they're called.  Consequently, the API and
corresponding callsites are ugly and unclear.  Remove this variable
and change their API to accept the commit to act on as additional
argument so that the callsites change from looking like

commit =3D prepare_a_commit();
act_on_commit();

to looking like

commit =3D prepare_a_commit();
act_on_commit(commit);

This change is also in line with our long-term goal of exposing some
of these functions through a public API.

-- Ram
