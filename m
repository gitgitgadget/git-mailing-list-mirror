From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] send-pack: don't send a thin pack when the server doesn't
 support it
Date: Tue, 8 Oct 2013 18:29:09 +0700
Message-ID: <CACsJy8AHAbDuz3yhsjJfRQUGg1zzx6qqoAf=1oNhbX1xPVithg@mail.gmail.com>
References: <1381221884-27048-1-git-send-email-cmn@elego.de> <CACsJy8AQ-719sbUfJW98q_HYit7ePfB6oN3v7XTX6fvC7HnixA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Oct 08 13:29:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTVU3-0007E6-4M
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 13:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab3JHL3n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Oct 2013 07:29:43 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:34720 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab3JHL3k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 07:29:40 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so7357927oag.40
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hTEP/HjpZMqgF1WwiCVb0HOr6lzBXDK5wm/RRHGBrj4=;
        b=JQhXy9SetLxMSJukuAlsQ25yyTEfgcd+x64UyKYdut9u0TVlpj16T46nRcgAQ50uFW
         YvrZBear208pasGvTj/PO1Kr7kMm55qhSxocQs5SM9Rs3ZP45blTmfSnsY+Yslr3qZs6
         OTSnqJrtirfkfAvoJ9dIRtDwcV+oNqzNTSZvA4rQZIJTWS0e1VpKDnPu6Tk18i9KP8Fc
         ezs7ETk+nvn7ue2ffpegJaCD0OYM0dQKdVSJUC90Qxp6djNhuB2sZC3RDm4dUD3BX6hM
         kj1tHWsXAkfRPzmKQNlHqroqZl2gdqH3OX7cE6vVPqp8LitVa6SxyJ2LZGCV9byHva46
         pG6w==
X-Received: by 10.182.117.195 with SMTP id kg3mr822863obb.17.1381231779938;
 Tue, 08 Oct 2013 04:29:39 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Tue, 8 Oct 2013 04:29:09 -0700 (PDT)
In-Reply-To: <CACsJy8AQ-719sbUfJW98q_HYit7ePfB6oN3v7XTX6fvC7HnixA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235770>

On Tue, Oct 8, 2013 at 4:44 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Oct 8, 2013 at 3:44 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.d=
e> wrote:
>> diff --git a/send-pack.c b/send-pack.c
>> index 7d172ef..7b88ac8 100644
>> --- a/send-pack.c
>> +++ b/send-pack.c
>> @@ -205,6 +205,8 @@ int send_pack(struct send_pack_args *args,
>>                 quiet_supported =3D 1;
>>         if (server_supports("agent"))
>>                 agent_supported =3D 1;
>> +       if (!server_supports("thin-pack"))
>> +               args->use_thin_pack =3D 0;
>
> Hmm.. I think this introduces a regression in C Git because
> receive-pack never advertises "thin-pack" and so "git push" from now
> on will never send thin packs. It's too late now to add thin-pack to
> receive-pack

Or maybe it's not that late. How about you go with your patch and add
thin-pack capability to receive-pack too?

When new "git push" is used against old server, thin pack is disabled.
But that's not a big deal (I hope). The difference is traffic
increases a bit more, but cpu consumption on the server side is also a
bit less. Pushes are usually small, unless you do initial push, which
is complete anyway. So a bit more or less does not really matter in
practice.

We could mitigate the regression a bit by checking agent string and
enable thin-pack for those versions even if thin-pack is not
advertises. That goes back to v1.7.12. We may do the same for some
other popular git servers. And this hack is maintained like 3-4 years,
enough time for new versions to be deployed, then removed.

Hmm?
--=20
Duy
