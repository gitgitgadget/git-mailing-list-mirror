From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 6/6] git submodule add: Fix naming clash handling
Date: Sat, 13 Sep 2008 13:32:38 +0200
Message-ID: <8c5c35580809130432r11e986e5u4c7300d62ca2896f@mail.gmail.com>
References: <20080912210817.31628.69014.stgit@localhost>
	 <20080912210924.31628.61593.stgit@localhost>
	 <7v63p0n5pv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org,
	"Mark Levedahl" <mlevedahl@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 13:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeTNs-00028p-LI
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 13:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYIMLcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 07:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbYIMLcl
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 07:32:41 -0400
Received: from el-out-1112.google.com ([209.85.162.177]:48173 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbYIMLck (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 07:32:40 -0400
Received: by el-out-1112.google.com with SMTP id z25so587752ele.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=T3EqKbPolqH845fYIWtLrxvBVkr/17ha6GkKUnwZxcc=;
        b=U2+Hw8eh8J+bipMsP2A4UjORULXbiy2TGR3siJ9JAwdnR7L6mbn6sWUVFzhVTCfNcX
         m/AW8wK+FPBVJOnHrdST2eufpT495RuYICMmZI69uyCUBwg+8EI5cOf6/Zyf0dtX2UfR
         PiMyyNCLXl4BrxfEorfCG4w/hdLb8dZZCKpJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=trPb2be7DPl82BA/4rh8JdeQEdCAI2lDpodYrkonM/HwegSaa6em4RuaWaB4rSXqJg
         0B4vbfqOjFmh1svyxWgBuNBwtLFKwom/rHhahgaqOviUkJGy5SKeO7Ib51CuY9oT0bPt
         tS+4LprDOZQdTQ1z1vwpgqDfiAZxjCsEcCkak=
Received: by 10.150.156.9 with SMTP id d9mr7576888ybe.24.1221305558727;
        Sat, 13 Sep 2008 04:32:38 -0700 (PDT)
Received: by 10.150.181.12 with HTTP; Sat, 13 Sep 2008 04:32:38 -0700 (PDT)
In-Reply-To: <7v63p0n5pv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95798>

On Sat, Sep 13, 2008 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Petr Baudis <pasky@suse.cz> writes:
>
>> This patch fixes git submodule add behaviour when we add submodule
>> living at a same path as logical name of existing submodule. This
>> can happen e.g. in case the user git mv's the previous submodule away
>> and then git submodule add's another under the same name.
>
> In short, name "example" was used to name the submodule bound at path
> "init" in earlier tests, and the new one adds another submodule whose name
> and path are both "example" and makes sure they do not get mixed up (and
> the original code did mix them up).
>
>>  git-submodule.sh           |   15 ++++++++++++---
>>  t/t7400-submodule-basic.sh |   11 +++++++++++
>>  2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 1c39b59..3e4d839 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -201,10 +201,19 @@ cmd_add()
>>       git add "$path" ||
>>       die "Failed to add submodule '$path'"
>>
>> -     git config -f .gitmodules submodule."$path".path "$path" &&
>> -     git config -f .gitmodules submodule."$path".url "$repo" &&
>> +     name="$path"
>> +     if git config -f .gitmodules submodule."$name".path; then
>> +             name="$path~"; i=1;
>> +             while git config -f .gitmodules submodule."$name".path; do
>> +                     name="$path~$i"
>> +                     i=$((i+1))
>> +             done
>> +     fi
>> +
>> +     git config -f .gitmodules submodule."$name".path "$path" &&
>> +     git config -f .gitmodules submodule."$name".url "$repo" &&
>>       git add .gitmodules ||
>> -     die "Failed to register submodule '$path'"
>> +     die "Failed to register submodule '$path' (name '$name')"
>>  }
>
> The logic of the fix seems to be correct, but shouldn't the test be like
> this instead?
>
>        if git config -f .gitmodules "submodule.$name.path" >/dev/null
>        then
>
> The same thing for "git config" used in the "while" loop.

Yeah, redirecting to /dev/null seems like a good idea.


> Also I am not sure if name="$path~" is a good idea for two reasons:
>
>  - name suffixed with tilde and number looks too much like revision
>   expression.
>
>  - A, A~, A~1, A~2... looks ugly; A, A-0, A-1, A-2,... (or start counting
>   from 1 or 2) I would understand.

I'd just exit with an informative error if submodule.$name already
exists in .git/config.


> By the way, I noticed that cmd_add does not seem to cd_to_toplevel, and
> accesses .gitmodules in the current working directory.  Isn't this a bug?

Not really, since `git submodule` must be executed from the toplevel
($SUBDIRECTORY_OK is undefined, so the cd_to_toplevel in cmd_sync and
cmd_summary seems to be noops).

--
larsh
