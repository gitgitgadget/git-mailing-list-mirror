From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCHv3] submodule update: allow custom update command
Date: Wed, 3 Jul 2013 11:26:13 +1200
Message-ID: <CAFOYHZC1xMt2eqaNm0vtLVJ3X2TNjRxa3sEjBPmHVeHrQmSc4A@mail.gmail.com>
References: <7vehbii6un.fsf@alter.siamese.dyndns.org>
	<1372759974-19765-1-git-send-email-judge.packham@gmail.com>
	<51D3064C.80901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 03 01:26:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9xj-0006E0-2z
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 01:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab3GBX0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 19:26:14 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62138 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab3GBX0N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 19:26:13 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so3994894pdj.40
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I6u/DqPyjLjY0580pKx8Img0oBmQS6WU2yKxs3X8U2M=;
        b=r/MDHTpb9nutJbKVMFknEqNCoOD/5XUbQ/dTJkWZswr/UL6n2PhXiBRCc1qzBOXlZ9
         o5kTynOmjT0oKXumYUtwimGByHcqMmko0E7jFD29fFSbLmoTKk1Ym6XYgS/EVWCdgt+e
         +GboF9L4FYaxgZ1viArbwMCzmqeDQfCofNZBjIZwDQnuAiQK2eXgjsAGT0SeLhwiPxNB
         9p6LRBra9IQZOdkotrWPgNeKooSgMm1ike9aU8KapQ2mzN8SaZ3ANWgoyiMJC+3hxBSM
         m45a5lyjPeLWGx1eNMrJYpxb37hMsNpxs+gsj0cTX2hUjnci4qbq+Tv5oFanSFcvGpQe
         SPWA==
X-Received: by 10.66.41.48 with SMTP id c16mr93629pal.34.1372807573105; Tue,
 02 Jul 2013 16:26:13 -0700 (PDT)
Received: by 10.70.71.133 with HTTP; Tue, 2 Jul 2013 16:26:13 -0700 (PDT)
In-Reply-To: <51D3064C.80901@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229449>

On Wed, Jul 3, 2013 at 4:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 02.07.2013 12:12, schrieb Chris Packham:
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -159,7 +159,9 @@ update::
>>       This will make the submodules HEAD be detached unless `--rebase` or
>>       `--merge` is specified or the key `submodule.$name.update` is set to
>>       `rebase`, `merge` or `none`. `none` can be overridden by specifying
>> -     `--checkout`.
>> +     `--checkout`. Setting the key `submodule.$name.update` to `!command`
>> +     will cause `command` to be run. `command` can be any arbitrary shell
>> +     command that takes a single argument, namely the sha1 to update to.
>>  +
>>  If the submodule is not yet initialized, and you just want to use the
>>  setting as stored in .gitmodules, you can automatically initialize the
>> @@ -172,6 +174,7 @@ If `--force` is specified, the submodule will be checked out (using
>>  `git checkout --force` if appropriate), even if the commit specified in the
>>  index of the containing repository already matches the commit checked out in
>>  the submodule.
>> ++
>>
>>  summary::
>>       Show commit summary between the given commit (defaults to HEAD) and
>
> I'm not sure this change is necessary ;-)
>

Not necessary because it should be documented in
Documentation/config.txt instead, or not necessary because it's a
niche feature that doesn't need to be advertised?

>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index eb58c8e..a7c2375 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -799,6 +799,12 @@ Maybe you want to use 'update --init'?")"
>>                               say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged in '\$sha1'")"
>>                               must_die_on_failure=yes
>>                               ;;
>> +                     !*)
>> +                             command="${update_module#!}"
>> +                             die_msg="$(eval_gettext "Unable to exec '\$command \$sha1' in submodule path '\$prefix\$sm_path'")"
>
> Hmm, "Unable to exec" does not quite cut it, as the command was executed
> but returned an error, right? Maybe something like this:
>
>    Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'
>

Will include in v4 once I write some tests.
