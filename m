From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] fast-export: don't parse all the commits
Date: Fri, 3 May 2013 19:06:29 -0500
Message-ID: <CAMP44s09KqFuXPf=3qG42jzChnNBoiXdStME6Ga7EzY7uwF88Q@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-4-git-send-email-felipe.contreras@gmail.com>
	<7vd2t7ybin.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 04 02:06:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYPzn-0001Pf-Mh
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761496Ab3EDAGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:06:31 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:45653 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756356Ab3EDAGb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:06:31 -0400
Received: by mail-la0-f42.google.com with SMTP id fq13so1980659lab.1
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=N+XlZOzDig0elCC71JNRLTKE8AKMTsZ9Uncjd2IF85s=;
        b=uXR8BcFcKmIepxVOf45utNmMBfLdlCdPmX8fkASHcZzAZQkYguIW1Dc3phD7/0TTCe
         Ras0ok0oDOVglri1NgQcNeIKuHQSEtOWVVXaU3Yg9SreQv1S1AS/jWJzxnUDJyuRNz9z
         NeKZmDjYtATiJPN4eaQJxgcOq1Rkz2y0EFOoKNHZsfTShdQ2AwKhJ7OO/vroALUsen0f
         8Ix7ZnL9GqnLPFk5bup/aCUVWUFdt2zzm/qa/kN9q5kf0uasgMRh28lgcf0VetfoRxZO
         KT//sv97BWLri3G0iamUM2dtwWaXLOJ9Zmh/XwVfVYkB7CPSvI8c64/LrQ8IcYsJx9kB
         xwHQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr5016689lbb.8.1367625989422;
 Fri, 03 May 2013 17:06:29 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 3 May 2013 17:06:29 -0700 (PDT)
In-Reply-To: <7vd2t7ybin.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223340>

On Fri, May 3, 2013 at 4:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We don't need the parsed objects at this point, merely the information
>> that they have marks.
>>
>> Seems to be three times faster in my setup with lots of objects.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin/fast-export.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index a5b8da8..3c5a701 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -636,7 +636,7 @@ static void import_marks(char *input_file)
>>                       /* only commits */
>>                       continue;
>>
>> -             object = parse_object(sha1);
>> +             object = lookup_unknown_object(sha1);
>
> This updates the parse_object() moved by the previous patch. At this
> point in the codeflow, unlike the original, we already _know_ the
> object must be a commit; wouldn't an equivalent of:
>
>         object = &(lookup_commit(sha1)->object)
>
> be more correct here?

Maybe, if we want to run some extra code we don't care about.

The only actual difference is that object->type will be OBJ_COMMIT,
but a) this is not going to be used anywhere, and b) we can set that
ourselves.

In fact, my original code was:

	object = lookup_object(sha1);
	if (!object)
		object = create_object(sha1, OBJ_COMMIT, alloc_object_node());

But I figured there's no need for those extra lines of code.

-- 
Felipe Contreras
