From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Difficulty adding a symbolic link, part 3
Date: Fri, 2 Aug 2013 08:54:42 +0700
Message-ID: <CACsJy8BSRE9L+K1BA6XUsaMviLxSEGGZsuj23J-AoYC2OxputQ@mail.gmail.com>
References: <201307312029.r6VKT4vC023100@hobgoblin.ariadne.com>
 <CACsJy8DZ11zFEgL_vZ-kG2tuwodU=vBJZqZxUPWtYh9u8o-_Tg@mail.gmail.com> <201308011500.r71F03HJ008579@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 02 03:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V54aR-0005rz-CN
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 03:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab3HBBzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 21:55:17 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34703 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab3HBBzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 21:55:16 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so173925obb.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 18:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9f5u4P4oDbKog4Z0VNOB7KMUwodyAnCFN3qwfCywivI=;
        b=sjUQR/Q5D6YbB2SN+OsqZd+GecQ2w0Yfnws9p4NKv++O11nTME0BIZJXZgV9DZfuW7
         UVqDzUEHEZo6s/6C8NKnSTjD6wZlVindhTJS0cW9TdzL97xDWyfVvG7kg/GP2d+feCCD
         SyQThPI4KWJ8KVWwQ1Jljj/cp5ypEMtB9E1dbx9pJoiM1w7+9OUG3TdXxsx+bcPci6OG
         llwUTwHb/78SVLuXKRCA4KT9fTYo1YpYIUyu4e2UnDP22DkhCOSL3PUK4aw8l+jn5Qh3
         Y9/D2Mxm/nn44WmPooJ8pl0PCAI4+OEjf1wOq7GQZyIyaY3GXZ90ifk1GOkivxydG0Bo
         Fpxw==
X-Received: by 10.182.79.201 with SMTP id l9mr3586837obx.61.1375408512428;
 Thu, 01 Aug 2013 18:55:12 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 1 Aug 2013 18:54:42 -0700 (PDT)
In-Reply-To: <201308011500.r71F03HJ008579@freeze.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231512>

On Thu, Aug 1, 2013 at 10:00 PM, Dale R. Worley <worley@alum.mit.edu> wrote:
>> From: Duy Nguyen <pclouds@gmail.com>
>
>> > Can someone give me advice on what this code *should* do?
>>
>> It does as the function name says: given cwd, a prefix (i.e. a
>> relative path with no ".." components) and a path relative to
>> cwd+prefix, convert 'path' to something relative to cwd. In the
>> simplest case, prepending the prefix to 'path' is enough. cwd is also
>> get_git_work_tree().
>>
>> I agree with you that this code should not resolve anything in the
>> components after 'cwd', after rebasing the path to 'cwd' (not just the
>> final component). Not sure how to do it correctly though because we do
>> need to resolve symlinks before cwd. Maybe a new variant of real_path
>> that stops at 'cwd'?
>>
>> We may also have problems with resolve symlinks before cwd when 'path'
>> is relative, as normalize_path_copy() does not resolve symlinks. We
>> just found out emacs has this bug [1] but did not realize we also have
>> one :-P.
>
> Thanks for the detailed information.  It seems to me that the minimum
> needed change is that the handling of relative and absolute paths
> should be made consistent.

Agreed.

>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/231268
>
> That problem isn't so much a matter of not resolving symlinks but
> rather the question of what ".." means.  In the case shown in that
> message, the current directory *is* {topdir}/z/b, but it was entered
> with "cd {topdir}/b" -- and the shell records the latter as the value
> of $PWD.  (Actually, the bash shell can handle symbolic-linked
> directories *either* way, depending on whether it is given the "-P"
> option.)
>
> When Emacs is given the file name "../a/file", does the ".." mean to
> go up one directory *textually* in the pathspec based on $PWD
>
> "{topdir}/b/../a/file" -> "{topdir}/a/file" (which does not exist)
>
> or according to the directory linkage on the disk (where the ".."
> entry in the current directory goes to the directory named {topdir}/z,
> which does contain a file a/file.  It looks like Emacs uses the first
> method.
>
> The decision of which implementation to use depends on the semantics
> you *want*.  As I noted, bash allows the user to choose *either*
> interpretation, which shows that both semantics are considered valid
> (by some people).

We pass paths around, the semantics must be one that others expect,
not what we want. For one, the kernel seems to resolve symlinks first,
then "..". We use chdir() and getcwd() provided by the kernel. We need
to agree with it on ".." semantics.
-- 
Duy
