From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Thu, 25 Apr 2013 12:50:42 -0500
Message-ID: <CAMP44s0FHnm0xeSuzVNxVhn_rMQ=oKqoDxCU+OWGKPNOxmnGyA@mail.gmail.com>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net>
	<5178C583.6000703@viscovery.net>
	<7vehdy7j5f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 19:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQJk-0005eN-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 19:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118Ab3DYRuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 13:50:44 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:41710 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932483Ab3DYRuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 13:50:44 -0400
Received: by mail-la0-f51.google.com with SMTP id fh20so2867834lab.10
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DdYb14dOZZcqJePfvSvNxpNwClJ/rmCHXdJJynHAlFs=;
        b=l3wE0eTNtJ5C/MCcm0zN5CS4xeLB/rxHkWJuE748kuwSylHoGqtSgxPhgshV+MkKav
         QgyVzWTjKqeIUByNNKVkzO4wCj6s5zpwHg6J3v1j8ZceDDFoHKvZD3fiS4/ZzN/WTcCz
         j7w8x3Ed40BXr7JdTb7SGnF9GJFL3vNTkgMlXN3ObzY9TyrE/pKNY2xq5qJ/tyZVfFTG
         tR1vy4//vr+ucK5z3NR7squSkAxLBHBelBflfkRR3Vyw8xCfFXCud9/n0PdlJKdRh1ge
         nMnBix77WaQTlwvmhb7NLXboLEzby+E9cG2Lx7YbWr96Ggp4FAqHznocLyXkqcnFMVpm
         l9Wg==
X-Received: by 10.112.22.198 with SMTP id g6mr16277426lbf.135.1366912242724;
 Thu, 25 Apr 2013 10:50:42 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 10:50:42 -0700 (PDT)
In-Reply-To: <7vehdy7j5f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222401>

On Thu, Apr 25, 2013 at 9:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> Bash on Windows does not implement process substitution.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>> ...
>> Here is a fix. It assumes that the list of refs after the import is
>> a superset of the refs before the import. (Can refs be deleted
>> via fast-import?)
>>
>>  git-remote-testgit | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/git-remote-testgit b/git-remote-testgit
>> index 23c9d40..e99d5fa 100755
>> --- a/git-remote-testgit
>> +++ b/git-remote-testgit
>> @@ -91,13 +91,15 @@ do
>>
>>               git fast-import "${testgitmarks_args[@]}" --quiet
>>
>> -             after=$(git for-each-ref --format='%(refname) %(objectname)')
>> -
>>               # figure out which refs were updated
>> -             join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
>> -             while read ref a b
>> +             git for-each-ref --format='%(refname) %(objectname)' |
>> +             while read ref a
>>               do
>> -                     test $a == $b && continue
>> +                     case "$before" in
>> +                     *"$ref $a"*)
>> +                             continue
>
> This just like the original 'join' depends on the two output from
> for-each-ref to be sorted the same way, which is true and fine.  But
> I wonder one thing.  When $before has this in it:

I wonder if we should bother with this at all. The purpose of the code
was mainly to show to users that they should report the success only
if the refs have been updated, but the code is becoming more
obfuscated, a comment should do the trick. And then, we can just
report success for all the refs (and explain in the comment why).

-- 
Felipe Contreras
