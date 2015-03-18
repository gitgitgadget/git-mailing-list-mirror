From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Wed, 18 Mar 2015 19:47:11 +0700
Message-ID: <CACsJy8Beoz=qcHrOG=akCR+gOQRjBcsQHaXdL_=PW70BOf4q3g@mail.gmail.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
 <1426514206-30949-1-git-send-email-pclouds@gmail.com> <5506F3A9.1020704@drmicha.warpmail.net>
 <xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com> <20150317140704.GA7248@lanh> <xmqq1tknpkwd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 13:47:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYDNz-00080S-57
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 13:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbbCRMrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 08:47:43 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34562 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbbCRMrm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 08:47:42 -0400
Received: by iecsl2 with SMTP id sl2so36809624iec.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xnc14YNd63uvgaBp7/2qI1ADch3dgOP0QmecsVQ0kmA=;
        b=hlJHygfm6jNoWt1L/bQI9MhxuNl8ynz/I6kcvgW8OM9i8IDfZ9X74wx9D+3DhhG/jo
         yoUZor8uAuxxIVYjFlY6Ng0G/MyTnqPJ49sYKT4xw0GKnhGUnB3M008DssKaR71UYcHf
         5/RCCVCDXkAK8J21RzPpk9x6f6+xmXEPUVlJFp0/vcJK4qqTEtaGcBIA/npMM2j7vHOx
         2j9LkkDHGddfDVHJIV3qVlHs4IR5MMhzJinNM4TJaKes+gLvG0HG9h6kPYivb7Dy73cc
         IKQMVQah3I6icxngbtU1iCjE9RSD4EEOmJH24VjFxiSUUE/jITCiNALEy2d9Idf342gH
         rJpA==
X-Received: by 10.42.87.131 with SMTP id y3mr39739534icl.45.1426682861254;
 Wed, 18 Mar 2015 05:47:41 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 05:47:11 -0700 (PDT)
In-Reply-To: <xmqq1tknpkwd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265727>

On Wed, Mar 18, 2015 at 12:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Mar 16, 2015 at 09:05:45AM -0700, Junio C Hamano wrote:
>>> The offending one came from eec3e7e4 (cache-tree: invalidate i-t-a
>>> paths after generating trees, 2012-12-16), which was a fix to an
>>> earlier bug where a cache-tree written out of an index with i-t-a
>>> entries had incorrect information and still claimed it is fully
>>> valid after write-tree rebuilt it.  The test probably should add
>>> another path without i-t-a bit, run the same "diff --cached" with
>>> updated expectation before write-tre, and run the "diff --cached"
>>> again to make sure it produces a result that match the updated
>>> expectation.
>>
>> Would adding another non-i-t-a entry help? Before this patch
>> "diff --cached" after write-tree shows the i-t-a entry only when
>> eec3e7e4 is applied. But with this patch we don't show i-t-a entry any
>> more, before or after write-tree, eec3e7e4 makes no visible difference.
>>
>> We could even revert eec3e7e4 and the outcome of "diff --cached" would
>> be the same because we just sort of move the "invalidation" part from
>> cache-tree to do_oneway_diff(). Not invalidating would speed up "diff
>> --cached" when i-t-a entries are present. Still it may be a good idea
>> to invalidate i-t-a paths to be on the safe side. Perhaps a patch like
>> this to resurrect the test?
>
> My unerstanding of what eec3e7e4 (cache-tree: invalidate i-t-a paths
> after generating trees, 2012-12-16) fixed was that in this sequence:
>
>    ...
>
> So reverting the fix obviously is not the right thing to do.  If the
> tests show different results from two invocations of "diff --cached"
> with your patch applied, there is something that is broken by your
> patch, because the index and the HEAD does not change across
> write-tree in that test.

Right. I missed this but I think this is a less important test because
I added a new test to make sure "diff --cached" ("git status" to be
exact) outputs the right thing when i-t-a entries are present.

> If on the other hand the tests show the same result from these two
> "diff --cached" and the result is different from what the test
> expects, that means your patch changed the world order, i.e. an
> i-t-a entry used to be treated as if it were adding an empty blob to
> the index but it is now treated as non-existent, then that is a good
> thing and the only thing we need to update is what the test expects.
> I am guessing that instead of expecting dir/bar to be shown, it now
> should expect no output?

Yes, no output.

> Does adding an non-i-t-a entry help?  It does not hurt, and it makes
> the test uses a non-empty output, making its effect more visible,
> which may or may not count as helping.

But still, if I revert the change in cache-tree.c and force write-tree
to produce valid cache-tree when i-t-a entries are present, this test
still passes incorrectly. This is why I changed the test.
-- 
Duy
