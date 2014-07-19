From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Make locked paths absolute when current directory is changed
Date: Sat, 19 Jul 2014 19:40:48 +0700
Message-ID: <CACsJy8CpoOCw+3Q5AZk+cuXsUcoqW3hoHS9mX_=VuYtu8638+w@mail.gmail.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com> <xmqqmwc6mueh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 14:41:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Tx9-0004ov-Rd
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 14:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbaGSMlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 08:41:21 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:62359 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbaGSMlU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 08:41:20 -0400
Received: by mail-qc0-f170.google.com with SMTP id c9so4314774qcz.1
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=X7pcncjxZFaU/aM+yUzO4b8CMVXMgIKymUMBiuNxWyM=;
        b=YDBIdSEGQGVq7Sli4x0W1qt2saJDPIuDoKav4bqvUOHXa7dTmwrPZPtxN6NxXHZFY8
         CY6K7pj79dPIRx0nXN6dYm5yfeXRMeBAIM2c1xzxVyDmo9uuEVJk3RZrm5aOeuiI+bI0
         9fBd/VqLRTLbC9f2uezuYRg/NfhAaAAHPT7aH6fBlM/NUiN/+4ID1+xi2UUHDWSAlE2t
         jBZ3mKKvN5KX+QiVJa7A0M1mVXQDcw9Z0CdCfytaokOKUyhaOy3AF7hDX62dkomhdhGF
         nd5AloAq1iBToxxvRSzue5u3/iVgfYHXT2PP6jMy8Bs3CH917qqC2lBG7EhndV6s6Mzp
         T8ZQ==
X-Received: by 10.224.15.72 with SMTP id j8mr19964636qaa.8.1405773678623; Sat,
 19 Jul 2014 05:41:18 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 19 Jul 2014 05:40:48 -0700 (PDT)
In-Reply-To: <xmqqmwc6mueh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253877>

On Sat, Jul 19, 2014 at 12:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +             abspath = absolute_path(lk->filename);
>> +             if (strlen(abspath) >= sizeof(lk->filename))
>> +                     warning("locked path %s is relative when current directory "
>> +                             "is changed", lk->filename);
>
> Shouldn't this be a die() or an error return (which will kill the
> caller anyway)?

We don't know for sure there will be a die() or something to trigger
the roll back (or commit). If the chdir() is temporary, absolute path
not fitting in PATH_MAX chars is not fatal because cwd will be
reverted before commit/rollback. A better solution is probably avoid
PATH_MAX in lk->filename. But yeah, changing it to die() is safer
(especially when cwd is moved permanently for some options in
update-index and read-tree)

>> @@ -636,6 +636,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
>>               die_errno("Unable to read current working directory");
>>       offset = len = strlen(cwd);
>>
>> +     make_locked_paths_absolute();
>
> Just being curious, but this early in the start-up sequence, what
> files do we have locks on?

We don't know. For most builtin commands, the setup is done early and
we can be sure of no locks. Some commands (especially non-builtin) can
still delay calling setup_git_directory() until later and they might
do something in between, so better be safe than sorry.
-- 
Duy
