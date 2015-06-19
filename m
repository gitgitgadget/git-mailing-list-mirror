From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 03/31] am: implement skeletal builtin am
Date: Fri, 19 Jun 2015 17:56:33 +0800
Message-ID: <CACRoPnTnajSmiZtfONZdn-a2Jy90NVOQ5qrUm0p75VgY1W4Kwg@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-4-git-send-email-pyokagan@gmail.com>
	<xmqqbngcepb3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 11:56:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5t2O-0005Qr-2r
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 11:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbbFSJ4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 05:56:36 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36320 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbFSJ4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 05:56:35 -0400
Received: by lacny3 with SMTP id ny3so70926215lac.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FR5A/Sbz55f5/L10ySaNsu6/f7Vgr7w4V+83qof7cIU=;
        b=oe9Wosd/YhiGrtcR7xgqRZBHZtjPg8nn7FyabQak2lX2hIcU9D6xjkFcbh+U8V74Iv
         anoorAx0aH7oBS/+1E3C2W6ON4m/74ZKgID8GN9dY3F8JQ8GD+j1YIIymAYmyryRD6uz
         H4j3c0h/ouArUlyuAjhF1E3H1eg3jk31J5Dz3tfLupEb2sRYBjy6lQmhNjqowCb2Gt3D
         QAEvkGbqaFiY01THbw3CfISC2skRa+ajG1CIEeMU93H7eSij4G4i59zdfWDlmwVgE1Du
         61HjSgxQteQkixjvib8j+v8lAuMaocNzJ6/fa+fCusOgbqPm2kY7dIioh+jlw1Yhf4x3
         qw9w==
X-Received: by 10.152.22.99 with SMTP id c3mr17460271laf.32.1434707793753;
 Fri, 19 Jun 2015 02:56:33 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 19 Jun 2015 02:56:33 -0700 (PDT)
In-Reply-To: <xmqqbngcepb3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272118>

On Fri, Jun 19, 2015 at 4:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>> @@ -0,0 +1,28 @@
>> +/*
>> + * Builtin "git am"
>> + *
>> + * Based on git-am.sh by Junio C Hamano.
>> + */
>> +#include "cache.h"
>> +#include "builtin.h"
>> +#include "exec_cmd.h"
>> +
>> +int cmd_am(int argc, const char **argv, const char *prefix)
>> +{
>> +     /*
>> +      * FIXME: Once all the features of git-am.sh have been re-implemented
>> +      * in builtin/am.c, this preamble can be removed.
>> +      */
>
> It's not broken, so "FIXME" is not quite appropriate (and that is
> why I sent you "NEEDSWORK").

OK.

> Also mention that the entry in the
> commands[] array needs "RUN_SETUP | NEED_WORK_TREE" added, I think.

OK.

>> +     if (!getenv("_GIT_USE_BUILTIN_AM")) {
>> +             const char *path = mkpath("%s/git-am", git_exec_path());
>> +
>> +             if (sane_execvp(path, (char **)argv) < 0)
>> +                     die_errno("could not exec %s", path);
>> +     } else {
>> +             prefix = setup_git_directory();
>> +             trace_repo_setup(prefix);
>> +             setup_work_tree();
>> +     }
>> +
>> +     return 0;
>> +}
>> diff --git a/git.c b/git.c
>> index e7a7713..a671535 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -370,6 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>>
>>  static struct cmd_struct commands[] = {
>>       { "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>> +     { "am", cmd_am, NO_SETUP },
>
> NO_SETUP is for things like init and clone that start without a
> repository and then work in the one that they create.  I think
> imitating "archive" or "diff" is more appropriate.

Ah OK. I thought that handle_alias() in git.c would chdir() and set
GIT_DIR because it called setup_git_directory_gently(), and thus
requires NO_SETUP to restore the initial environment, but turns out it
chdir()s back to the original directory, and sets GIT_DIR
appropriately, so we're OK.

Thanks,
Paul
