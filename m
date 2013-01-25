From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Fri, 25 Jan 2013 09:00:16 +0700
Message-ID: <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com> <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 03:01:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyYbM-0008IY-NC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 03:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051Ab3AYCAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 21:00:48 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:37419 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab3AYCAq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 21:00:46 -0500
Received: by mail-ob0-f179.google.com with SMTP id un3so524064obb.10
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 18:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=OUUEj3EO219OTAT1zG/be5EAGl0GRJnydTCS4Q80zo0=;
        b=XnaE/8SyBk4+L0KrDxAfkiMks7RfPzRQyY1KtqwM/iLv6SmTd2B4Sidp9of1YGfxCe
         DOm6VS5SE6oJQFdk+ftYuzasF3jgYiBQYYlqfTkYFZOLW0Hx9/HSxUxcFBusGOVCuqkm
         xPmA9hE+3CqmSMLzWjd1Y+GzvK50sLN41/tA2btYgmLBL1+dhOz42dTRF096koWxCtQQ
         TIJ/+YWHbqqbmawiaUxPxG3jyDwb9CAR/3uRs1hGF4Zk1btm0qE8+BYG1P+pW3zlk9G/
         S3BwhbxQpICqhfCCOoNj5S2gGV8knjmGafI5JgWsUhBZ+87yVUT0up5veXJqtyuWs23f
         hDfg==
X-Received: by 10.182.188.69 with SMTP id fy5mr3214130obc.74.1359079246074;
 Thu, 24 Jan 2013 18:00:46 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 24 Jan 2013 18:00:16 -0800 (PST)
In-Reply-To: <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214479>

On Fri, Jan 25, 2013 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  read-cache.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index fda78bc..4579215 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1720,6 +1720,26 @@ static int ce_write_entry(git_SHA_CTX *c, int=
 fd, struct cache_entry *ce,
>>                             ce->name + common, ce_namelen(ce) - comm=
on);
>>       }
>>
>> +     if (object_database_contaminated) {
>> +             struct object_info oi;
>> +             switch (ce->ce_mode) {
>> +             case S_IFGITLINK:
>> +                     break;
>> +             case S_IFDIR:
>> +                     if (sha1_object_info_extended(ce->sha1, &oi) !=
=3D OBJ_TREE ||
>
> This case should never happen.  Do we store any tree object in the
> index in the first place?

No it was copy/paste mistake (from cache-tree.c, before I deleted it
and added check_sha1_file_for_external_source in 3/7)

>> +                         (oi.alt && oi.alt->external))
>> +                             die("cannot create index referring to =
an external tree %s",
>> +                                 sha1_to_hex(ce->sha1));
>> +                     break;
>> +             default:
>> +                     if (sha1_object_info_extended(ce->sha1, &oi) !=
=3D OBJ_BLOB ||
>> +                                 (oi.alt && oi.alt->external))
>> +                             die("cannot create index referring to =
an external blob %s",
>> +                                 sha1_to_hex(ce->sha1));
>> +                     break;
>> +             }
>> +     }
>> +
>>       result =3D ce_write(c, fd, ondisk, size);
>>       free(ondisk);
>>       return result;
>
> I think the check you want to add is to the cache-tree code; before
> writing the new index out, if you suspect you might have called
> cache_tree_update() before, invalidate any hierarchy that is
> recorded to produce a tree object that refers to an object that is
> only available through external object store.

cache-tree is covered by check_sha1_file_for_external_source() when it
actually writes a tree (dry-run mode goes through unchecked). Even
when cache-tree is not involved, I do not want the index to point to
an non-existing SHA-1 ("git diff --cached" may fail next time, for
example).

> As to the logic to check if a object is something that we should
> refuse to create a new dependent, I think you should not butcher
> sha1_object_info_extended(), and instead add a new call that checks
> if a given SHA-1 yields an object if you ignore alternate object
> databases that are marked as "external", whose signature may
> resemble:
>
>         int has_sha1_file_proper(const unsigned char *sha1);
>
> or something.

Agreed.

> This is a tangent, but in addition, you may want to add an even
> narrower variant that checks the same but ignoring _all_ alternate
> object databases, "external" or not:
>
>         int has_sha1_file_local(const unsigned char *sha1);
>
> That may be useful if we want to later make the alternate safer to
> use; instead of letting the codepath to create an object ask
> has_sha1_file() to see if it already exists and refrain from writing
> a new copy, we switch to ask has_sha1_file_locally() and even if an
> alternate object database we borrow from has it, we keep our own
> copy in our repository.
>
> Not tested beyond syntax, but rebasing something like this patch on
> top of your "mark external sources" change may take us closer to
> that.

Thanks, will incorporate in the reroll.
--=20
Duy
