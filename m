From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2 2/2] object name: introduce '^{/!-<negative pattern>}' notation
Date: Tue, 9 Jun 2015 19:14:23 +0100
Message-ID: <CAAKF_ub5c+2vVmG161O6gnUUeEcNfDUMU=mtn+k0T8bC-9ZHPw@mail.gmail.com>
References: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
 <1433550295-15098-3-git-send-email-wmpalmer@gmail.com> <xmqqbngqcfxd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2O39-0003sr-7O
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbbFISOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:14:49 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36293 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587AbbFISOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:14:47 -0400
Received: by wgbgq6 with SMTP id gq6so19152514wgb.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pj5IWsqXQBQOefOC+bo9S6TX2BN01jlSEfeVqe9amVU=;
        b=1CING/1ZoHlwZKHigY5a3sGx6YDDJr8v8cM+4Wl8aJm01h4P+V5OANHgP4EgU5Dmf9
         R3nM0AkIYvwzDq6BNaC5Q5SaPZ3traHnZIMdYY9vBPaL21juu/stgerDJaCZzYOVfhwi
         LYD+QhUyBTfbjKCenrRVYYQ/gNRFoiEgd9Vdv3/yEYM69w+uEbgY8lmL5uJD8MrtWYgA
         qVmjub/bUYvloApLtCdi/GnnuifLjZKWOdXAEXhUyCokrRoAp0nL7zIBJaJRfKLU48IM
         /HllKERe/azNkQ/urIeuw9YlZRsjelb6pi9C7KfgPjbKqZWWppTDCL/V111Bp07MbGsA
         gzgA==
X-Received: by 10.181.25.234 with SMTP id it10mr266678wid.0.1433873684177;
 Tue, 09 Jun 2015 11:14:44 -0700 (PDT)
Received: by 10.28.170.73 with HTTP; Tue, 9 Jun 2015 11:14:23 -0700 (PDT)
In-Reply-To: <xmqqbngqcfxd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271213>

On Mon, Jun 8, 2015 at 5:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Will Palmer <wmpalmer@gmail.com> writes:
>> diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
>> index e0fe102..8a5983f 100755
>> --- a/t/t1511-rev-parse-caret.sh
>> +++ b/t/t1511-rev-parse-caret.sh
>> @@ -19,13 +19,17 @@ test_expect_success 'setup' '
>>       echo modified >>a-blob &&
>>       git add -u &&
>>       git commit -m Modified &&
>> +     git branch modref &&
>
> This probably belongs to the previous step, no?

As it isn't referenced until the "negative" tests, I didn't bother adding
it in the "verify the way things are" tests. Funny that it was mentioned,
as I *did* originally have it in the first commit, but I moved it to the
commit in which it was first used, so that it would be easier to notice.

>
>> +test_expect_success 'ref^{/!-}' '
>> +     test_must_fail git rev-parse master^{/!-}
>> +'
>
> Hmmmm, we must fail because...?  We are looking for something that
> does not contain an empty string, which by definition does not
> exist.
>
> Funny, but is correct ;-).


This is left-over from the original patch's logic, which included a
short-circuit to avoid an empty regex (as per 4322842 "get_sha1: handle
special case $commit^{/}")... which I now realise perhaps should
have been simply rephrased, rather than ommitted entirely.

I feel like adding something like:
8<----------------------------------------------------------------------
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -737,11 +737,15 @@ static int peel_onion(const char *name, int len,
unsigned char *sha1)

                /*
                 * $commit^{/}. Some regex implementation may reject.
-                * We don't need regex anyway. '' pattern always matches.
+                * We don't need regex anyway. '' pattern always matches,
+                * and '!' pattern never matches.
                 */
                if (sp[1] == '}')
                        return 0;

+               if (sp[1] == '!' && sp[2] == '-' && sp[3] == '}')
+                       return -1;
+
                prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
                commit_list_insert((struct commit *)o, &list);
                ret = get_sha1_oneline(prefix, sha1, list);

---------------------------------------------------------------------->8
...would be the wrong place for this short-circuit check, in light of
discussion around extensibility; so, I'll see how it looks moving that
into get_sha1_oneline(...)

>
>
>> +test_expect_success 'ref^{/!-.}' '
>> +     test_must_fail git rev-parse master^{/!-.}
>> +'
>
> Likewise.  I however wonder if we catch a commit without any message
> (which you probably have to craft with either commit-tree or
> hash-object), but that falls into the "curiosity" not the
> "practicality" category.

A commit with "no message" should indeed by returned by 'master^{/!-.}',
or at least, that is the intent. This test is only meant to cover the
result of there being "no matching commit", however.




In summary: it looks like I'll be sending another one.
