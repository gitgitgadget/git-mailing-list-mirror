From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] cache-tree: invalidate i-t-a paths after generating trees
Date: Mon, 10 Dec 2012 18:53:02 +0700
Message-ID: <CACsJy8CW1UGgQcgHa11XP71XZGaTxytrGmJmrtdNvy=N7cUyMw@mail.gmail.com>
References: <1352459040-14452-1-git-send-email-pclouds@gmail.com>
 <1354939803-8466-1-git-send-email-pclouds@gmail.com> <7v7goqcsdy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@jonathonmah.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 12:53:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti1vj-0004K8-LS
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 12:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab2LJLxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Dec 2012 06:53:35 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48837 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab2LJLxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2012 06:53:34 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2177157obb.19
        for <git@vger.kernel.org>; Mon, 10 Dec 2012 03:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+32TRdhCSRxj0rVt9rRC1lfSCfq85ZaZ11gGcWoiCCw=;
        b=MOJkXL+Y5Dbs6HLigCMimH8b0hBfvxCkOqWrJxZpuYPBy6LSZkpGTPwmUXNPM1eGT5
         iP5VDuTGiFD/tZDXuM9wZGoM0nPRQoO7UASSa1NNUJUPLNohYbt2nQa/o2Wdv5jQQ1NW
         Mv47VONzKeEFYvfGpvlvEFA/cdCmDDyJWt5SO26qg/HKhoL7q8Rp6gb2nFcBeXnkn+TV
         8guKKyafTm2jQ4MqThQgyPYBB4b03rdl/5RNyoELmoXynWv7X/HJYXkQd5ys+kwPPz6M
         le34ur6agvEkDHZ/QOFKg0Cvcs7jmyc61CGijhucp61sJe0DDFbyOekpCldiflvq4I8J
         ZwCg==
Received: by 10.60.170.10 with SMTP id ai10mr7565113oec.72.1355140413703; Mon,
 10 Dec 2012 03:53:33 -0800 (PST)
Received: by 10.182.23.11 with HTTP; Mon, 10 Dec 2012 03:53:02 -0800 (PST)
In-Reply-To: <7v7goqcsdy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211254>

On Mon, Dec 10, 2012 at 1:50 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/cache-tree.c b/cache-tree.c
>> index 28ed657..989a7ff 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -248,6 +248,7 @@ static int update_one(struct cache_tree *it,
>>       int missing_ok =3D flags & WRITE_TREE_MISSING_OK;
>>       int dryrun =3D flags & WRITE_TREE_DRY_RUN;
>>       int i;
>> +     int to_invalidate =3D 0;
>>
>>       if (0 <=3D it->entry_count && has_sha1_file(it->sha1))
>>               return it->entry_count;
>> @@ -324,7 +325,13 @@ static int update_one(struct cache_tree *it,
>>                       if (!sub)
>>                               die("cache-tree.c: '%.*s' in '%s' not =
found",
>>                                   entlen, path + baselen, path);
>> -                     i +=3D sub->cache_tree->entry_count - 1;
>> +                     i--; /* this entry is already counted in "sub"=
 */
>> +                     if (sub->cache_tree->entry_count < 0) {
>> +                             i -=3D sub->cache_tree->entry_count;
>> +                             to_invalidate =3D 1;
>> +                     }
>> +                     else
>> +                             i +=3D sub->cache_tree->entry_count;
>
> Hrm.  update_one() is prepared to see a cache-tree whose entry count
> is zero (see the context lines in the previous hunk) and the
> invariant for the rest of the code is "if 0 <=3D entry_count, the
> cached tree is valid; invalid cache-tree has -1 in entry_count.
> More importantly, entry_count negated does not in general express
> how many entries there are in the subtree and does not tell us how
> many index entries to skip.

Yeah I use entry_count for two different things here. In the previous
(unsent) version of the patch I had "entry_count =3D -1" right after "i
-=3D entry_count"

>> +                     if (sub->cache_tree->entry_count < 0) {
>> +                             i -=3D sub->cache_tree->entry_count;
>> +                             sub->cache_tree->entry_count =3D -1;
>> +                             to_invalidate =3D 1;
>> +                     }


which makes it clearer that the use of negative entry count is only
valid within update_one. Then I changed my mind because it says
'negative means "invalid"' in cache-tree.h. So, put "entry_count =3D -1=
"
back or just add another field  to struct cache_tree for this?
--=20
Duy
