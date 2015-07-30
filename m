From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] git-am: flag suspiciously old or futuristic commits
Date: Thu, 30 Jul 2015 11:07:37 -0400
Message-ID: <55BA3DB9.7020700@windriver.com>
References: <1438207297-11686-1-git-send-email-paul.gortmaker@windriver.com> <CAGZ79kY7i95cXE3o=1kr40uFYhwijNkOoOJs6wa7msqvW8xvzg@mail.gmail.com> <CA+P7+xqcWKVnyL-+chiBLJn2TBJwPuy4WG2H1yS_hCN2cx=KNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 17:10:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKpTE-0005TB-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbbG3PKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:10:00 -0400
Received: from mail.windriver.com ([147.11.1.11]:52111 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbG3PJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:09:59 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t6UF7c3t019994
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 30 Jul 2015 08:07:38 -0700 (PDT)
Received: from [128.224.56.57] (128.224.56.57) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.235.1; Thu, 30 Jul 2015
 08:07:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CA+P7+xqcWKVnyL-+chiBLJn2TBJwPuy4WG2H1yS_hCN2cx=KNw@mail.gmail.com>
X-Originating-IP: [128.224.56.57]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274989>

On 2015-07-30 12:35 AM, Jacob Keller wrote:
> On Wed, Jul 29, 2015 at 3:20 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Jul 29, 2015 at 3:01 PM, Paul Gortmaker
>> <paul.gortmaker@windriver.com> wrote:
>>> The linux kernel repository has some commits in it with dates from
>>> the year 1970 and also 2030 (and possibly others).  We probably shouldi
>>> warn people when the dates look suspect.
>>>
>>> For commits in the future,  note that a committer in Australia
>>> could commit on New Years Day, and send it to a maintainer in North
>>> America and that would trip the notification on the maintainer's
>>> New Years Eve.  But that is unlikely, and the note is still
>>> correct; that the commit is from a future year.
>>>
>>> For commits in the past, I chose a somewhat arbitrary 30 year
>>> limit, which will allow stuff from post 1985; the thought being
>>> that someone might want to import an old repo into git from some
>>> other SCM.  We could alternatively set it to 5, which would then
>>> catch computers with a dead CMOS battery, at the risk of pestering
>>> the hypothetical museum curator of old bits.
>>>
>>> Sample output:
>>>
>>> paul@builder:~/git/linux-head$ grep Date: *patch
>>> future.patch:Date: Sat, 18 Jul 2037 21:22:19 -0400
>>> past.patch:Date: Sat, 18 Jul 1977 21:22:19 -0400
>>>
>>> paul@builder:~/git/linux-head$ git am future.patch
>>> note: commit is from future year 2037.
>>> Applying: arch/sh: make heartbeat driver explicitly non-modular
>>> paul@builder:~/git/linux-head$ git reset --hard HEAD~ > /dev/null
>>> paul@builder:~/git/linux-head$ git am past.patch
>>> note: commit is from implausibly old year 1977.
>>> Applying: arch/sh: make heartbeat driver explicitly non-modular
>>> paul@builder:~/git/linux-head$
>>>
>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>> ---
>>>  git-am.sh | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/git-am.sh b/git-am.sh
>>
>> [+cc paul tan, who rewrote am in c as a GSoC project.]
>>
>>> index 3af351ffaaf3..ff6deb8047a4 100755
>>> --- a/git-am.sh
>>> +++ b/git-am.sh
>>> @@ -766,6 +766,21 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
>>>                 stop_here $this
>>>         fi
>>>
>>> +       if test -n "$GIT_AUTHOR_DATE"
>>> +       then
>>> +               THIS_YEAR=`date +%Y`
>>> +               TOO_OLD=$(expr $THIS_YEAR - 30)
>>> +               TOO_NEW=$(expr $THIS_YEAR + 1)
>>> +               GIT_AUTHOR_YEAR=`date -d "$GIT_AUTHOR_DATE" +%Y`
>>
>> Would it make sense to not operate on year but on unix time, so the problem
>> you mentioned in the commit message goes away?
>>
>> Another thought:
>> Having this check in am seems a bit arbitrary to me (or rather
>> workflow adapted ;) as
>> we could also check in commit or pull (not sure if I actually mean the
>> fetch or merge thereof)
>>
> 
> I think this makes most sense in am, as it is most likely to show up,
> in my mind, due to a format-patch mistake. If we do it during pull,
> would we just warn? how would we reject commits? that doesn't really
> fit..

So, it turns out this breaks t3400-rebase test since I was not aware
of the git internal date format (which that test suite uses).

And on top of that, in talking with a *BSD user, it seems the "-d"
flag isn't universal.  Over in that camp it means set DST offset. :(

So while I think the idea is sound, and worthwhile, scripting it will
become a lot more cumbersome and klunky.  If git-am becomes C, then
it would be easier to handle there, I think....

Paul.
--

> 
> We can't do it during commit, as obviously the broken machine will
> likely not be able to notice it at all.. We could check remotes during
> push but that doesn't solve this either..
> 
> Maybe just emitting a warning during a fetch or am (since am doesn't
> use pull) would make the most sense?
> 
> I don't think we can reject things when doing a fetch though, but we could warn.
> 
> Regards,
> Jake
> 
