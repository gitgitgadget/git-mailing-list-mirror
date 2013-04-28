From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: allow cloning local paths with colons in them
Date: Sun, 28 Apr 2013 07:19:29 +0700
Message-ID: <CACsJy8DEMrv08D3wGvebV+W73TA8eTH58KHybXpQQbsSJ5NKZA@mail.gmail.com>
References: <20130422153516.GB11886@sigill.intra.peff.net> <1367033778-13923-1-git-send-email-pclouds@gmail.com>
 <7vip37u11a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Niedier <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, fsckdaemon@gmail.com,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 02:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWFLt-0002cw-Fn
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 02:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3D1AUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Apr 2013 20:20:00 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:40806 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab3D1AT7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Apr 2013 20:19:59 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so5128307oag.36
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=334fq385AYaeqUcC9JqiYt9rkll0xDBPx01Ru1dqkF8=;
        b=NNJqzQHjtNcxKCS7ykg30PYFGW1aNBwpQK1vziknjiSPm1NpVnJzvduvhaqglIosYE
         5akRkfwxkbSTBM3dDgcdmP2ogMEUmNH2p8KnCDtMmPf5zP8Nb53gQI97hC4Lmili749s
         wKQz1cw94KsE3vyOOIcDW2iA3NooL20IPD0vVhbFtceVsobREjTylZY8xTLOZFv/9y02
         kRiGOF2MRUuGhLD6pSRylr5uLHMvKslJAJIYJlXTZf8N/2sXTyUYE8zVifuFSCqR2tNQ
         o4omvdFfCmYpFZZ7CXidSDfvmzfnBBGcKxmFo+4teHDuvkXPo+SN+tEd9+O28TE+t7Fb
         EI5A==
X-Received: by 10.60.83.103 with SMTP id p7mr49942oey.130.1367108399272; Sat,
 27 Apr 2013 17:19:59 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sat, 27 Apr 2013 17:19:29 -0700 (PDT)
In-Reply-To: <7vip37u11a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222718>

On Sun, Apr 28, 2013 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> diff --git a/connect.c b/connect.c
>> index f57efd0..b568f10 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -551,8 +551,11 @@ struct child_process *git_connect(int fd[2], co=
nst char *url_orig,
>>       path =3D strchr(end, c);
>>       if (path && !has_dos_drive_prefix(end)) {
>>               if (c =3D=3D ':') {
>> -                     protocol =3D PROTO_SSH;
>> -                     *path++ =3D '\0';
>> +                     if (!strchr(url, '/') || strchr(url, '/') >=3D=
 path) {
>> +                             protocol =3D PROTO_SSH;
>> +                             *path++ =3D '\0';
>> +                     } else
>> +                             path =3D end
>>               }
>
> That was fairly hard to grok. Is that equivalent to this?
>
>                 if (c =3D=3D ':' && path < strchrnul(host, '/')) {
>                         /* is the first slash past the colon? */
>                         protocol =3D PROTO_SSH;
>                         *path++ =3D '\0';
>                 } else {
>                         path =3D end;
>                 }
>

The original code is already hard to grok so I may be mistaken here.
But I think it's not the same. For the case when c =3D=3D '/', it will =
do
"path =3D end;", which is unintended. It should keep the current "path"
value (i.e. =3D=3D strchr(end, '/')). The use of "strchrnul(host, '/')"=
 is
good though.
--
Duy
