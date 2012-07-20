From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 7/7] rebase (without -p): correctly calculate patches to rebase
Date: Fri, 20 Jul 2012 08:58:15 -0700
Message-ID: <CAOeW2eEMQrmSwS4ziTWetrWxkS-CTCPrJrzchCb1ZnqmaFhW7g@mail.gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-6-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-7-git-send-email-martin.von.zweigbergk@gmail.com>
	<1342596455-17046-8-git-send-email-martin.von.zweigbergk@gmail.com>
	<50091469.5030307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Knut Franke <Knut.Franke@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:58:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFav-00077b-Mm
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab2GTP6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:58:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55596 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab2GTP6P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:58:15 -0400
Received: by pbbrp8 with SMTP id rp8so6343645pbb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2Uz/4MYcCnYbuGy1hD/75xVBYZ/MzKEs+YB0QI4S6vQ=;
        b=EXJDVOORhKS0KrO97vMLZj57eUkm5L/5pGJqc8FsrxcApff8RiMZa4hxtVn17QhOGu
         NGh/XUavRILg8r+7QNtVb291BZX5M7HWsebSa8FDBqfGbP9LnGPlfMI+flG79PnalcJi
         Y8syNM/aoa2QfnuhUovQS1D0A8aXVvcISTqKeb0ykzmIjRkcL4T7qsI/RpkmkyPiXViY
         7gRL7Vk384NBFGDRQSlVPqFj+Zr+fjbfxHMOimx2sZUF3CKOgKZ2Fc3a82fGXo3i7ghd
         AtuuIspcPMeRpls0zF1EUGs1HePNsMqzrF50AtadzoRnC+B77gVrBCFoRIJmuuqzxIKl
         twPQ==
Received: by 10.68.203.66 with SMTP id ko2mr15003376pbc.84.1342799895540; Fri,
 20 Jul 2012 08:58:15 -0700 (PDT)
Received: by 10.68.236.138 with HTTP; Fri, 20 Jul 2012 08:58:15 -0700 (PDT)
In-Reply-To: <50091469.5030307@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201785>

On Fri, Jul 20, 2012 at 1:18 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 7/18/2012 9:27, schrieb Martin von Zweigbergk:
>> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
>> index 37c1b23..fe3fdd1 100644
>> --- a/git-rebase--am.sh
>> +++ b/git-rebase--am.sh
>> @@ -16,11 +16,9 @@ skip)
>>       ;;
>>  esac
>>
>> -test -n "$rebase_root" && root_flag=--root
>>  test -n "$keep_empty" && git_am_opt="$git_am_opt --keep-empty"
>> -git format-patch -k --stdout --full-index --ignore-if-in-upstream \
>> -     --src-prefix=a/ --dst-prefix=b/ \
>> -     --no-renames $root_flag "$revisions" |
>> +generate_revisions |
>> +sed -e 's/\([0-9a-f]\{40\}\)/From \1 Mon Sep 17 00:00:00 2001/' |
>>  git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
>>  move_to_original_branch
>
> Just curious (as all tests pass): What does this do? It looks like
> format-patch is not called anymore and git-am sees only SHA1s. Does it
> force git-am to cherry-pick the patches?

That probably deserves to be mentioned in the commit message. Or maybe
in as a comment in the code. Either way, since 0fbb95d (am: don't call
mailinfo if $rebasing, 2012-06-26), 'git am --rebasing' never looks at
anything but the sha1, so most of the output from 'git format-patch'
is currently ignored. It doesn't do cherry-pick, though, but runs 'git
diff-tree' and other commands and then feeds the result to 'git
apply', just like a regular 'git am' invocation would.

Martin
