From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] add: Use struct argv_array in run_add_interactive()
Date: Mon, 17 Mar 2014 05:28:05 -0400
Message-ID: <CAPig+cQVLd9kxa1gV1GpWN=NBt8DvVo9uKNDTdjwzjF7wCt67g@mail.gmail.com>
References: <53243620.8080401@gmail.com>
	<87a9cqxtcy.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Fabian Ruch <bafain@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Mar 17 10:28:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPTqA-0005kF-86
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 10:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbaCQJ2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 05:28:08 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:38296 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbaCQJ2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 05:28:06 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so4980452yha.10
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gzpL77NgzMx4nNcnpYbyWDzm3aC8Ui7SyHl8IfzLkPo=;
        b=hDpxbfGFuD9b/jVHP5SFc9Hi0rSbCDNso7UTeUR84NfMmZmaLjLJ7CMCIPtC7y4zsc
         RUUS1flMrGa7t251/uOn5WI2lALifq2ClQYhZnzyVXgMh/iODTMyKX4o6nE6UiLdOg+8
         X5WSF62rWxurIRGzt/xMPwVE9tJC6Ic8M7GCIOMRD8Y8WgC5juOVlq0TGJzum5Di9Vj8
         yhAJQKSJoc9v1ITOFdDdU7d4pGa6SNatOGS9rZ6dXGzsVd81s/41CudOoUbT42Ji25Zk
         NGIpzyhekcJAFo2keafiRXSMgeU3WzNe9f3uhuP4b++fcAwMgiMHXy+Fb+NKkRKWwdVX
         dPKg==
X-Received: by 10.236.132.48 with SMTP id n36mr127887yhi.149.1395048485777;
 Mon, 17 Mar 2014 02:28:05 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 02:28:05 -0700 (PDT)
In-Reply-To: <87a9cqxtcy.fsf@thomasrast.ch>
X-Google-Sender-Auth: 7iIHaLEm8nWGl0fDuNZp1cp0DJY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244235>

On Sun, Mar 16, 2014 at 7:42 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Fabian Ruch <bafain@gmail.com> writes:
>
>> run_add_interactive() in builtin/add.c manually computes array bounds
>> and allocates a static args array to build the add--interactive command
>> line, which is error-prone. Use the argv-array helper functions instead.
>>
>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>
> Thanks, this is a nicely done cleanup.

I second that. Nicely done. You didn't give reviewers any opportunity
to provide constructive feedback. :-)

>> ---
>>  builtin/add.c | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index 4b045ba..459208a 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -15,6 +15,7 @@
>>  #include "diffcore.h"
>>  #include "revision.h"
>>  #include "bulk-checkin.h"
>> +#include "argv-array.h"
>>
>>  static const char * const builtin_add_usage[] = {
>>       N_("git add [options] [--] <pathspec>..."),
>> @@ -141,23 +142,21 @@ static void refresh(int verbose, const struct pathspec *pathspec)
>>  int run_add_interactive(const char *revision, const char *patch_mode,
>>                       const struct pathspec *pathspec)
>>  {
>> +     int status, i;
>> +     struct argv_array argv = ARGV_ARRAY_INIT;
>>
>> -     args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
>> -     ac = 0;
>> -     args[ac++] = "add--interactive";
>> +     argv_array_push(&argv, "add--interactive");
>>       if (patch_mode)
>> -             args[ac++] = patch_mode;
>> +             argv_array_push(&argv, patch_mode);
>>       if (revision)
>> -             args[ac++] = revision;
>> -     args[ac++] = "--";
>> +             argv_array_push(&argv, revision);
>> +     argv_array_push(&argv, "--");
>>       for (i = 0; i < pathspec->nr; i++)
>>               /* pass original pathspec, to be re-parsed */
>> -             args[ac++] = pathspec->items[i].original;
>> +             argv_array_push(&argv, pathspec->items[i].original);
>>
>> -     status = run_command_v_opt(args, RUN_GIT_CMD);
>> -     free(args);
>> +     status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
>> +     argv_array_clear(&argv);
>>       return status;
>>  }
