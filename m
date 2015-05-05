From: Danny Lin <danny0838@gmail.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Wed, 6 May 2015 01:20:08 +0800
Message-ID: <CAMbsUu6xZrMu_jrV=jR4XNLf1UXLApBiAWJiWJuKRb4xN90QJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 19:20:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpgW3-0001AC-Gj
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbbEERUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 13:20:11 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36179 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761784AbbEERUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 13:20:09 -0400
Received: by qgeb100 with SMTP id b100so84761250qge.3
        for <git@vger.kernel.org>; Tue, 05 May 2015 10:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Wt6vnqGUCdsdiMBStWUGNDnsv0SO26J3dPMp0m+1Iec=;
        b=TVVhMe6Z7ZfNtI+XeCSTzSjyhWzT1uzzPagOab/zfqxg+Hu3vmlkV2HKpfL8aMN6gX
         lkkduJyVIsmpAEDbujvkgHwMb0OKnSTAQKCTIZiZEzrgiBnERbIQ0gr0qfnwPNRvKmix
         a5zLwbISHJdmIbDJr2iI455jbWALS8Emo0TjZTBjNNvxNMDmzimfcg75cYHFRJs6kwUw
         Tbs8kZi/SWwIRr9iGoraD/VfQ9nGVVy+YxBrvNfdCoxcGTP8DSj4jDNsWQ/0qCpw2pU0
         JtbgfkPnvQ1QoZudFYA6RwIa7EcYjIPpA/t4MZJse/H+ufLblJdT9995d/T0QVpEWqQE
         1/dQ==
X-Received: by 10.55.21.31 with SMTP id f31mr58262611qkh.95.1430846408551;
 Tue, 05 May 2015 10:20:08 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Tue, 5 May 2015 10:20:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268398>

2015-05-05 5:14 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Danny Lin <danny0838@gmail.com> writes:
>
>> From dc549b6b4ec36f8faf9c6f7bb1e343ef7babd14f Mon Sep 17 00:00:00 2001
>> From: Danny Lin <danny0838@gmail.com>
>> Date: Mon, 4 May 2015 14:09:38 +0800
>> Subject: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
>
> Please do not use multipart/mixed attachments, but instead inline
> your patch.  When doing so, please drop all these four lines above.
>
Oops. How to drop the lines? I'm using Gmail and don't know the way to go.

>>
>> cmd_split() prints the info message using "say -n", which
>> makes no sense and could cause the linefeed be trimmed in
>> some cases. This patch fixes the issue.
>
> I think this was written knowing that "say" is merely a thin wrapper
> of "echo" (which is a bad manner but happens to be correct) and
> assuming that everybody's "echo" understands "-n" (which is not a
> good assumption) to implement "progress display" that shows the "N
> out of M done" output over and over on the same physical line.
>
> So,... contrary to your "makes no sense" claim, what it tries to do
> makes perfect sense to me, even though its execution seems somewhat
> poor.
>
The original version has a CR (yes, it's CR, not LF) at the end of the
"say -n" string, which is weird. If it's meant to print a linefeed, we should
remove the CR and use "say". If it's meant not to print a linefeed, we still
should remove the CR.

CR makes the shell behave weird, sometimes a linefeed is shown and
sometimes not.

For example, in my shell (git version 2.3.7.windows.1), I frequently get
a crowded message like this:

$ git subtree split -P subdir/
1/3 (0)2/3 (1)3/3 (2)c9ad5da42e2bc00c76616207fe73978887656235

While sometimes like this:
$ git subtree split -P subdir/
1/3 (0)2/3 (1)
3/3 (2)
c9ad5da42e2bc00c76616207fe73978887656235

The two behaviors happen almost randomly, at least I cannot predict.


>> ---
>>  contrib/subtree/git-subtree.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index fa1a583..28a1377 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -599,7 +599,7 @@ cmd_split()
>>       eval "$grl" |
>>       while read rev parents; do
>>               revcount=$(($revcount + 1))
>> -             say -n "$revcount/$revmax ($createcount)"
>> +             say "$revcount/$revmax ($createcount)"
>>               debug "Processing commit: $rev"
>>               exists=$(cache_get $rev)
>>               if [ -n "$exists" ]; then
