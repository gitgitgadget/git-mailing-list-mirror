From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sun, 02 Feb 2014 12:37:16 +0100
Message-ID: <52EE2DEC.4030400@web.de>
References: <20140131202142.GA9731@mule>	<1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>	<1391306351-13237-4-git-send-email-martinerikwerner@gmail.com>	<CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com>	<20140202111330.GB14729@mule> <871tzl2209.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	"martinerikwerner@gmail.com >> Martin Erik Werner" 
	<martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 12:37:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9vN1-0004Kv-Fz
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 12:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbaBBLh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 06:37:28 -0500
Received: from mout.web.de ([212.227.17.11]:61407 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbaBBLhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 06:37:20 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Leca2-1VSaO31NYk-00qSM8 for <git@vger.kernel.org>;
 Sun, 02 Feb 2014 12:37:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <871tzl2209.fsf@fencepost.gnu.org>
X-Provags-ID: V03:K0:Jhfq9cQ4zqJlFlds8uIPbXcIkwUVJkRt0s1D1HAI8BZhLFPv3+Y
 2IAYlmxii5xHKdnxCPFG0fKxBKqxvbLn4TqqZ2mghlS51pRaixzrcfcEucMg37OFZXOtjlP
 jsQFIj4P/eMpxt97Q9V99+oUFTTSSqy7WxD+N0K5yFeW1Fbpwk1iKNVDhX80yPg+e337Jun
 u5mSttOtkmGhb/uu72hIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241364>

On 2014-02-02 12.21, David Kastrup wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
> 
>> On Sun, Feb 02, 2014 at 09:19:04AM +0700, Duy Nguyen wrote:
>>> On Sun, Feb 2, 2014 at 8:59 AM, Martin Erik Werner
>>> <martinerikwerner@gmail.com> wrote:
>>>> +       /* check if work tree is already the prefix */
>>>> +       if (strncmp(path, work_tree, wtlen) == 0) {
>>>> +               if (path[wtlen] == '/')
>>>> +                       memmove(path, path + wtlen + 1, len - wtlen);
>>>> +               else
>>>> +                       /* work tree is the root, or the whole path */
>>>> +                       memmove(path, path + wtlen, len - wtlen + 1);
>>>> +               return 0;
>>>> +       }
>>>
>>> No the 4th time is not the charm yet :) if path is "/abc/defghi" and
>>> work_tree is "/abc/def" you don't want to return "ghi" as the prefix
>>> here.
>>
>> Ah indeed, this should catch that:
>>
>> diff --git a/setup.c b/setup.c
>> index 2270bd4..5817875 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -32,9 +32,11 @@ static inline int abspath_part_inside_repo(char *path)
>>  	if (strncmp(path, work_tree, wtlen) == 0) {
>>  		if (path[wtlen] == '/')
>>  			memmove(path, path + wtlen + 1, len - wtlen);
>> -		else
>> +		else if (path[wtlen - 1] == '/' || path[wtlen] == '\0')
> 
> Is wtlen guaranteed to be nonzero?
> 
Another comment:
The "raw" comparison with '/' is probably working well on all
POSIX/Linux/Unix systems.

To be more portable, the macro
is_dir_sep()
can be used:

if (is_dir_sep(path[wtlen]))
