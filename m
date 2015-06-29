From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 03/11] ref-filter: implement '--points-at' option
Date: Tue, 30 Jun 2015 01:07:42 +0530
Message-ID: <CAOLa=ZSMkcyp5zPbWTJVj5xoDb3OUojgAzUukbjmr5vmKsLSNw@mail.gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com> <1435222633-32007-3-git-send-email-karthik.188@gmail.com>
 <xmqqmvzibegt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 21:38:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9etA-00051R-GY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 21:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbbF2Tij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 15:38:39 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36375 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbbF2TiM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 15:38:12 -0400
Received: by oigb199 with SMTP id b199so125735830oig.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nUU/JUIiunugVVLDf4nn4ENW4MOrVglxAT1dIYN50bg=;
        b=DSuHCYNsYzu3IeXPLbtB243ZsQ/qMfh86T1GQPZFAqPsiZutIf3prlHMpYrp9K8GDY
         csMKKuPkx3Z3u+IY2tuaiR+oPqPMA9n3LUKOnuTbbaUVYmPhfqBro0LfTdNyeSIPr0aj
         MzdL51DY814iw+IOiu0RIq29QswaFlpfo4K7aENGK2DAsuw79nsXlsnFjB54NmMc3aFj
         mJy6cfjk3iV66tAybzjqDffreBeoAQq/3yacHuu5xBT/BmuW7LVVy3O7jzCDxs1Qzoxf
         +Pk+Owy8DNlKrIEsGEouSve+UnYUIxf65BN9kAC9pR5+kAu8NfVXNLFQL94CaZrUbPNu
         1X+Q==
X-Received: by 10.60.35.8 with SMTP id d8mr15412099oej.37.1435606691591; Mon,
 29 Jun 2015 12:38:11 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 29 Jun 2015 12:37:42 -0700 (PDT)
In-Reply-To: <xmqqmvzibegt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272996>

On Mon, Jun 29, 2015 at 11:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +/*
>> + * Given a ref (sha1, refname) see if it points to one of the sha1s
>> + * in a sha1_array.
>> + */
>> +static int match_points_at(struct sha1_array *points_at, const unsigned char *sha1,
>> +                        const char *refname)
>> +{
>> +     struct object *obj;
>> +
>> +     if (!points_at || !points_at->nr)
>> +             return 1;
>> +
>> +     if (sha1_array_lookup(points_at, sha1) >= 0)
>> +             return 1;
>> +
>> +     obj = parse_object_or_die(sha1, refname);
>> +     if (obj->type == OBJ_TAG &&
>> +         sha1_array_lookup(points_at, ((struct tag *)obj)->tagged->sha1) >= 0)
>> +             return 1;
>> +
>> +     return 0;
>> +}
>> +
>
> Interesting.  I think the change done while copying the code does
> not change anything from the original (other than that the helper
> lost its ability to return the peeled object name), and I think you
> shouldn't make any change while copying the code that would change
> the benaviour, but I notice a few things that we might want to keep
> in mind and revisit them later (i.e. might be a good idea to add
> NEEDSWORK comment to record them near the function):

Reverted the change.
OK will do and add this, I will work on this after GSoC is done.
But like you said I'll add a comment so if someone wants to they can
work on it for now.

>
>  - The original only peeled one level of indirection, so does this
>    implementation.  But is that really what we want, I wonder?
>
>    After doing:
>
>    $ git tag -a -m 'annotated' atag $commit
>    $ git tag -a -m 'annotated doubly' dtag atag
>
>    atag^0, dtag^0 and $commit all refer to the same commit object.
>    Do we want to miss dtag with --point-at=$commit?
>
>  - As we are in for-each-ref (or eventually tag -l) that is walking
>    the cached refs, we may know what refname peels to without
>    parsing the object at all.  Could it be more efficient to ask
>    peel_ref() for the pointee without doing parse_object()
>    ourselves?
>

Shouldn't both these scenarios be solved together by using peel_ref()?

After what you said I just tried a hacked up version of using peel_ref()
rather than parsing the object, tried it out on the Linux tree.

$time git tag -l --points-at=HEAD~501
git tag -l --points-at=HEAD~501  0.03s user 0.01s system 97% cpu 0.044 total

*Using the modified version which uses peel_ref() *
$time ../git/git tag -l --points-at=HEAD~501
../git/git tag -l --points-at=HEAD~501  0.01s user 0.02s system 90%
cpu 0.033 total

This was the average of around 5 tests, Might not be the best way to check, but
I'm sure there's an improvement.

Thanks :)

-- 
Regards,
Karthik Nayak
