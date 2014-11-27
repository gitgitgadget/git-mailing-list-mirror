From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 2/3] mailmap: use higher level string list functions
Date: Thu, 27 Nov 2014 14:57:10 -0500
Message-ID: <CAPig+cRNuuDDBV0-TwANuiv+f_c1mfXp2Q4rF1Sj5mtJoLoqHQ@mail.gmail.com>
References: <CAPig+cQ_4A-0LOgXXG5qLeHOev+g8KMq5osKz34AFijGuyRidQ@mail.gmail.com>
	<1416887054-27204-1-git-send-email-sbeller@google.com>
	<CAO2U3QjNua2HvJKLnq80mPFEp931yLzHKENKo-LHm4CFZWRhBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 20:57:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu5Bk-0002PO-MU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 20:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbaK0T5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 14:57:12 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:55705 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbaK0T5L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 14:57:11 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so5041707iec.39
        for <git@vger.kernel.org>; Thu, 27 Nov 2014 11:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DfaSpRCHgb55c6HN/V56VbHQuSVSPdr9yFyVyzM/Udw=;
        b=XOfKqew00oQxz8uoHbD97q4q6z6w92nhgbWL1t7KMxrS80SdttZlcT2gz8czzps0H+
         GfFRq27K0lfi2/Mr8PlIk+ZVo0t20057jMMessU7YFrDaUZFkvnQ+NZ0+dsE/r1H1T4e
         Uf9Si8fOE/UgIzslKPGsPgLoX3wcBdDdbceTvcveJWHc1iCCLCObsNP+L5+WFCKCkjbl
         G0nvEWCSK0S1UDqiB50d4TeCxxPfteS/MamZbmzOvhD30/VD3d8rJXdq95uM8N3FWxpg
         UrADYQ+0PWeM+eQlQFEuR+kbStck7DetskqtiVJICGq0wA2ystMJuo/CRImX2D/4PbiL
         aaOA==
X-Received: by 10.107.46.167 with SMTP id u39mr21891271iou.82.1417118230600;
 Thu, 27 Nov 2014 11:57:10 -0800 (PST)
Received: by 10.107.137.66 with HTTP; Thu, 27 Nov 2014 11:57:10 -0800 (PST)
In-Reply-To: <CAO2U3QjNua2HvJKLnq80mPFEp931yLzHKENKo-LHm4CFZWRhBA@mail.gmail.com>
X-Google-Sender-Auth: xw5VoFtAkKBTNsvU_4bPwBimTV0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260352>

On Thu, Nov 27, 2014 at 1:44 PM, Michael Blume <blume.mike@gmail.com> wrote:
> The variable index seems to be unused/uninitialized now -- it's still
> printed in debug messages, but if I'm reading correctly, its contents are
> going to be nonsense.

Nice catch.

(Aside: Please don't top-post on this list [1].)

[1]: https://lkml.org/lkml/2005/1/11/111


> On Mon Nov 24 2014 at 7:48:27 PM Stefan Beller <sbeller@google.com> wrote:
>>
>> No functional changes intended. This commit makes use of higher level
>> and better documented functions of the string list API, so the code is
>> more understandable.
>>
>> Note that also the required computational amount should not change
>> in principal as we need to look up the item no matter if it is already
>> part of the list or not. Once looked up, insertion comes for free.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> Changes since Version 1:
>> * Remove declaration-after-statement.
>>
>> Changes Version 1 to Version 2:
>> * typo in commit message
>>
>>  mailmap.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/mailmap.c b/mailmap.c
>> index 81890a6..3b00a65 100644
>> --- a/mailmap.c
>> +++ b/mailmap.c
>> @@ -71,6 +71,7 @@ static void add_mapping(struct string_list *map,
>>                         char *old_name, char *old_email)
>>  {
>>         struct mailmap_entry *me;
>> +       struct string_list_item *item;
>>         int index;
>>
>>         if (old_email == NULL) {
>> @@ -78,15 +79,10 @@ static void add_mapping(struct string_list *map,
>>                 new_email = NULL;
>>         }
>>
>> -       if ((index = string_list_find_insert_index(map, old_email, 1)) <
>> 0) {
>> -               /* mailmap entry exists, invert index value */
>> -               index = -1 - index;
>> -               me = (struct mailmap_entry *)map->items[index].util;
>> +       item = string_list_insert(map, old_email);
>> +       if (item->util) {
>> +               me = (struct mailmap_entry *)item->util;
>>         } else {
>> -               /* create mailmap entry */
>> -               struct string_list_item *item;
>> -
>> -               item = string_list_insert_at_index(map, index, old_email);
>>                 me = xcalloc(1, sizeof(struct mailmap_entry));
>>                 me->namemap.strdup_strings = 1;
>>                 me->namemap.cmp = namemap_cmp;
>> --
>> 2.2.0.rc3
