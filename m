From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/4] status: show more info than "currently not on any branch"
Date: Fri, 8 Mar 2013 18:04:38 +0700
Message-ID: <CACsJy8CnDoMRzR5ifH3+0AKRLfzrNpkc3-NOxoA85SiRUb40ng@mail.gmail.com>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-1-git-send-email-pclouds@gmail.com> <1362572482-20570-4-git-send-email-pclouds@gmail.com>
 <7vzjygpcd5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 12:05:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDv7J-0002zb-8a
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 12:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366Ab3CHLFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 06:05:10 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:62066 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab3CHLFJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Mar 2013 06:05:09 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so1836309oag.18
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=s2QBFMvrhHhQ4g/eAgfA/qJ2RjXDKSgNFb4lnT8IjQM=;
        b=FkkunVndPu7RgxqYNqD7tGRbLj8/Tnp1FaMJlaihGsTB9JPIJHZ/34qFGpgYfGic9a
         KdGVeQJc7nGz8BkrpELM5KEx8m7/gTOXvhMy01FrK2LxTaZT4MVb8uZtN8re4pYAzxir
         cxI5EuhqXKfAB8JXT04yUs/HUNOnPsZW3Nufv+q9NQzuJQjvHvdkqjqWag6Afpa49Da9
         ZglikJT1wPktL4r5gyDn7adlTj90Zlx6ISc2efDI7LciDVkh9BSXJXK5esRjcggJEHLV
         u9nDF+us2NQd5675Ks/vCB3Qp6F7VRjpNX1Y4MYmP1ebz4O98ODzuXJeOYYSXYNiCKq2
         JjXg==
X-Received: by 10.60.29.72 with SMTP id i8mr1145258oeh.93.1362740708390; Fri,
 08 Mar 2013 03:05:08 -0800 (PST)
Received: by 10.76.27.200 with HTTP; Fri, 8 Mar 2013 03:04:38 -0800 (PST)
In-Reply-To: <7vzjygpcd5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217661>

On Thu, Mar 7, 2013 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +static void wt_status_get_detached_from(struct wt_status_state *sta=
te)
>> +{
>> +     struct grab_1st_switch_cbdata cb;
>> +     struct commit *commit;
>> +     unsigned char sha1[20];
>> +     char *ref =3D NULL;
>> +
>> +     strbuf_init(&cb.buf, 0);
>> +     if (for_each_recent_reflog_ent("HEAD", grab_1st_switch, 4096, =
&cb))
>> +             for_each_reflog_ent("HEAD", grab_1st_switch, &cb);
>> +     if (!cb.buf.len)
>> +             return;
>
> Is this correct?  What if the recent entries (i.e. the tail 4k) of
> the HEAD reflog did not have *any* checkout?  Your callback never
> returns non-zero, so as long as the HEAD reflog is sufficiently
> long, for_each_recent_reflog_ent() will return 0 to signal success,
> and you do not dig deeper by retrying the full reflog for HEAD,
> missing the checkout that exists before the final 4k, no?
>
> It should be more like this, I would think:
>
>         for_each_recent_reflog_ent();
>         if (!found)
>                 for_each_reflog_ent();
>         if (!found)
>                 return;

Yes. This "recent" optimization is tricky.

> Using cb.buf.len as the "found" marker may be correct, but I found
> it a bit subtle to my taste, without explanation.  Adding an
> explicit bit to "struct grab_1st_switch_cbdata" would be cleaner and
> more resistant to future changes, I think.

OK

>
>> +
>> +     if (dwim_ref(cb.buf.buf, cb.buf.len, sha1, &ref) =3D=3D 1 &&
>> +         (commit =3D lookup_commit_reference_gently(sha1, 1)) !=3D =
NULL &&
>> +         !hashcmp(cb.nsha1, commit->object.sha1)) {
>
> That feels unnecessarily expensive.  Why not hashcmp before checking
> the type of the object to reject the case where the ref moved since
> the last checkout early?
>
> For that matter, does this even need to check the type of the object
> that currently sits at the ref?  Isn't it sufficient to reject this
> case by seeing if sha1 is the same as cb.nsha1?

nsha1 is always a commit sha-1, sha-1 could be a tag sha-1 that refers
to the same commit. hashcmp before lookup is a good idea. Although I
don't think it's expensive in the big picture. When HEAD is not
detached, we show "<n> commits ahead of @{u}" which is way more
expensive than this. As long as "git status" on detached HEAD does not
use up all the time that "git status" on branches normally does, I
think we're fine.
--=20
Duy
