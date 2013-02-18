From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] read_directory: avoid invoking exclude machinery on tracked
 files
Date: Mon, 18 Feb 2013 17:42:17 +0100
Message-ID: <512259E9.6070703@gmail.com>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com> <7vd2w1wmdo.fsf@alter.siamese.dyndns.org> <CACsJy8A6oBjbaX=3iQcSxcwed28KLTk_tN+iuWDLsC512Z2V1Q@mail.gmail.com> <7vd2w1gyok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 17:42:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Tnj-0004g1-13
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 17:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab3BRQmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 11:42:22 -0500
Received: from mail-ea0-f172.google.com ([209.85.215.172]:52116 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab3BRQmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 11:42:21 -0500
Received: by mail-ea0-f172.google.com with SMTP id f13so2452477eaa.17
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wZb/9Gt1hTVS6oNlx1puU61WGIP7TgMhCV3QSE8r5T0=;
        b=uLiyIVwctx3c0+C+WW9C+z7nFtnIpFJP/jG+PB5R40dztkW5Eb2pDMAiOAVLO5yu5X
         HzsY32ytgDpd/blizPWFaFXIGWN1gwLZNVLCVd/dmX7gDISkLOwGmAEe78tkpYusfbgp
         pfixkBA1Thgf20xwEr7bksKyp+nQ81ikI0cCI70HP4bCfWjg+QVdTtNQWnxyahOV7kqK
         zmqxdqQynSRWbdhU5nr/2rGLTi/vXM7tSLGEW0ip9KhUuJziJbozDpV8qFT+iThdxEBu
         jTeG9MZdqDkO5CQsOoBbH2MzGrLAh7xTa4gO8ONswHvtl53lcpPzSt23dsQPU9Fu3JG2
         SEig==
X-Received: by 10.14.219.129 with SMTP id m1mr46294950eep.16.1361205740012;
        Mon, 18 Feb 2013 08:42:20 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id r4sm55000863eeo.12.2013.02.18.08.42.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 08:42:18 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vd2w1gyok.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216484>

Am 15.02.2013 20:32, schrieb Junio C Hamano:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> On Fri, Feb 15, 2013 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> In the current code, we always check if a path is excluded, and when
>>> dealing with DT_REG/DT_LNK, we call treat_file():
>>>
>>>  * When such a path is excluded, treat_file() returns true when we
>>>    are not showing ignored directories. This causes treat_one_path()
>>>    to return path_ignored, so for excluded DT_REG/DT_LNK paths when
>>>    no DIR_*_IGNORED is in effect, this change is a correct
>>>    optimization.
>>>
>>>  * When such a path is not excluded, on the ther hand, and when we
>>>    are not showing ignored directories, treat_file() just returns
>>>    the value of exclude_file, which is initialized to false and is
>>>    not changed in the function.  This causes treat_one_path() to
>>>    return path_handled.  However, the new code returns path_ignored
>>>    in this case.
>>>
>>> What guarantees that this change is regression free?
>>
>> If you consider read_directory_recursive alone, there is a regression.
>> The return value of r_d_r depends on path_handled/path_ignored. With
>> this patch, the return value will be different.
> 
> That is exactly what was missing from the proposed log message, and
> made me ask "Do all the callers that reach this function in their
> callgraph, when they get path_ignored for a path in the index,
> behave as if the difference between path_ignored and path_handled
> does not matter?"  Your answer seems to be
> 
>  - r-d-r returns 'how many paths in this directory match the
>    criteria we are looking for', unless check_only is true.  Now in
>    some cases we return path_ignored not path_handled, so we may
>    return a number that is greater than we used to return.
> 
>  - treat_directory, the only user of that return value, cares if
>    r-d-r returned 0 or non-zero; and
> 
>  - As long as we keep returning 0 from r-d-r in cases we used to
>    return 0 and non-zero in cases we used to return non-zero, exact
>    number does not matter.  Overall we get the same result.
> 
> I think all of the above is true, but I have not convinced myself
> that r-d-r with the new code never returns 0 when we used to return
> non-zero.
> 

treat_directory calls read_directory_recursive in tow cases:

1.) The directory is not in the index.

---8<---
switch (directory_exists_in_index(dirname, len-1)) {
case index_nonexistent:
	if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
		break;
}
...
---8<---


The directory is not in the index if there are no tracked files in the directory. I.e. cache_name_exists will always be false in this case, so the change won't affect the result of r_d_r.


2.) The directory is in the index but is ignored.

---8<---
switch (directory_exists_in_index(dirname, len-1)) {
case index_directory:
	if ((dir->flags & DIR_SHOW_OTHER_DIRECTORIES) && exclude)
		break;
}

if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
	...
}
if (!(dir->flags & DIR_SHOW_IGNORED) &&
    !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
	return show_directory;
if (!read_directory_recursive(dir, dirname, len, 1, simplify))
	return ignore_directory;
return show_directory;
---8<---


With exclude==true, only one r_d_r call is reachable, and only if either DIR_SHOW_IGNORED or DIR_HIDE_EMPTY_DIRECTORIES is set.

2a) DIR_SHOW_IGNORED is set: the patch already checks !(dir->flags & DIR_SHOW_IGNORED), so the result of r_d_r is not affected.

2b) DIR_HIDE_EMPTY_DIRECTORIES is set and DIR_SHOW_IGNORED is not set: the directory is already ignored, so all files in the directory should be ignored, too. It doesn't matter whether treat_one_path returns path_ignored because of the excluded() check or cache_name_exists().


Therefore, I think the patch (v0) is regression-free.



As a side note, I'm quite confused why we would ever want to evaluate .gitignore patterns on tracked files at all, as gitignore(5) clearly states "Files already tracked by git are not affected". There is 'git-ls-files --cached --ignored', although this doesn't seem to process .gitignore files but expects exclude patterns on the command line...
