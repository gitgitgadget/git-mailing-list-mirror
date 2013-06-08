From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 05:24:00 -0500
Message-ID: <CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 12:24:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlGJc-0003K7-BI
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 12:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab3FHKYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 06:24:04 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:49683 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab3FHKYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 06:24:02 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so4904629lbh.7
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PSnvb8N49IVsGj1hVn3KxWEbJn22eyPW1LBYdkuWpCQ=;
        b=U/V4GrFYF3Gl+C4cExiykRpvw/LDIwFNjewO0VLkWNQzexBAc866Y8owFX1Xsjmcoe
         Bgq5pLstR5MAurYCictWhSuDZeyAm5xDKMsk9ydg9eiUSVKcViOcrGJCbiwSTvvLPNaK
         P/Q/ylqetxwesdQLFrYqiJN32v+KLYX3/om0hMdlUqQKEW4OvrzPs2iblatR3gfFHSTV
         pEUQB1+w/1wszbUb8Jb9fZCb9Mfhx+3GoR7zavhMqdgUxJXo2DxV3ZNues9OZSA2wbD3
         l2Xj0Ws1LZMvfJ/uBrDADTBeVTutc1Ge+mr3WIt9i9zMccGtj3q15Vf16FiSeJ9STDiS
         xtaA==
X-Received: by 10.152.43.136 with SMTP id w8mr1114860lal.63.1370687040724;
 Sat, 08 Jun 2013 03:24:00 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 03:24:00 -0700 (PDT)
In-Reply-To: <CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226798>

On Fri, Jun 7, 2013 at 10:29 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>> index a5e69f3..ff370a3 100755
>> --- a/t/t3420-rebase-autostash.sh
>> +++ b/t/t3420-rebase-autostash.sh
>> @@ -71,8 +71,7 @@ testrebase() {
>>                 test_must_fail git rebase$type related-onto-branch &&
>>                 test_path_is_file $dotest/autostash &&
>>                 ! grep dirty file3 &&
>> -               rm -rf $dotest &&
>> -               git reset --hard &&
>> +               git rebase --abort &&
>>                 git checkout feature-branch
>>         '
>
> Incorrect.  I don't assume that --abort works yet, in this test.

Yes you do. The rest of the tests expect that the previous rebase has
been aborted.

In fact, all the tests depend on the previous test finishing
correctly, which is not the way tests should be written.

--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -70,7 +70,7 @@ testrebase() {
                echo dirty >>file3 &&
                test_must_fail git rebase$type related-onto-branch &&
                test_path_is_file $dotest/autostash &&
-               ! grep dirty file3 &&
+               false ! grep dirty file3 &&
                rm -rf $dotest &&
                git reset --hard &&
                git checkout feature-branch

# failed 19 among 22 test(s)

Doing 'rm -rf $dotest' is even worst than 'git rebase --abort',
because it relies on the implementation of 'git rebase', which might
need to remove more files than $dotest.

This wouldn't be a problem if the tests were implemented correctly,
but they are not, so 'git rebase --abort' is the only sane option.

-- 
Felipe Contreras
