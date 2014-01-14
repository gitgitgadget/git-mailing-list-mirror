From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/6] read-cache: new extension to mark what file is watched
Date: Tue, 14 Jan 2014 08:25:33 +0700
Message-ID: <CACsJy8D7F9TK_1sPLS0kN_wCi971iZoUeznQZ=H_oXjiWkq=Gg@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389524622-6702-3-git-send-email-pclouds@gmail.com> <20140113170222.GA18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 02:26:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2slf-0003ka-43
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 02:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbaANB0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jan 2014 20:26:06 -0500
Received: from mail-qe0-f46.google.com ([209.85.128.46]:39922 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbaANB0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 20:26:05 -0500
Received: by mail-qe0-f46.google.com with SMTP id 8so1560852qea.19
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 17:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Y2dCHG/dBnKKMGzZOhGMYFUCvxE/yWnZvCwuOSPeQdg=;
        b=Wxhxdzuee0jhVqp8WCkb32EfApt6V/IJNbsWpZTK7kQB5bnWB+YsUbxLJRaYuPBm+6
         uNKVljJfqNEM4pP3N7v3yXPzyLoTx/skhVycCiTLXwmlSfevGDtkHQuOGoVmvgpqzhT5
         LwZ2/5uDuSxFppQyo727vW3Xv834DGpMitzVVCDi7SXQszMT5LsjewdeyVzJdt3eIeT6
         SsVtiMGGNXJ9vYznfsZZ7CZVMejAd+zYaPzbrcp7iPSaLn3E5bM4KnCHdujAIvdGVQsr
         IiVhUX1AJGxnvlKi0t1RP+GkGQXaMcg5nJTLBMo1rRl/FThlDeexLugnI6YM54AonKLr
         7ELg==
X-Received: by 10.49.12.78 with SMTP id w14mr44834978qeb.79.1389662763364;
 Mon, 13 Jan 2014 17:26:03 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 13 Jan 2014 17:25:33 -0800 (PST)
In-Reply-To: <20140113170222.GA18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240384>

On Tue, Jan 14, 2014 at 12:02 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> If an entry is "watched", git lets an external program decide if the
>> entry is modified or not. It's more like --assume-unchanged, but
>> designed to be controlled by machine.
>>
>> We are running out of on-disk ce_flags, so instead of extending
>> on-disk entry format again, "watched" flags are in-core only and
>> stored as extension instead.
>
> Makes sense.
>
> Care to add a brief description of the on-disk format for
> Documetnation/technical/index-format.txt as well?

Sure, in the reroll after I fix inotify bugs that make the test suite f=
ail.

>> +static void read_watch_extension(struct index_state *istate, uint8_=
t *data,
>> +                              unsigned long sz)
>> +{
>> +     int i;
>> +     if ((istate->cache_nr + 7) / 8 !=3D sz) {
>> +             error("invalid 'WATC' extension");
>> +             return;
>> +     }
>> +     for (i =3D 0; i < istate->cache_nr; i++)
>> +             if (data[i / 8] & (1 << (i % 8)))
>> +                     istate->cache[i]->ce_flags |=3D CE_WATCHED;
>> +}
>
> So the WATC section has one bit per index entry, encoding whether tha=
t
> entry is WATCHED.  Makes sense.
>
> Do I understand correctly that this patch just takes care of the
> bookkeeping for the CE_WATCHED bit and the actual semantics will
> come in a later patch?

Correct.
--=20
Duy
