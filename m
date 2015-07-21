From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 9/9] tag.c: implement '--merged' and '--no-merged' options
Date: Wed, 22 Jul 2015 00:58:53 +0530
Message-ID: <CAOLa=ZQ9PHfppqbMzrhfTKQws-Goz7SGPSE2S-WNwMWxUC0fwQ@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437256837-13378-1-git-send-email-Karthik.188@gmail.com> <1437256837-13378-3-git-send-email-Karthik.188@gmail.com>
 <CAP8UFD0EXgt7ijdv2cY-HGuqcwjz=Z3-8KV7Xqk=-EBRp-QrGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:29:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdEF-0003pg-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbbGUT3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:29:24 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33865 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbbGUT3X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:29:23 -0400
Received: by obre1 with SMTP id e1so121940170obr.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x4JdAAPmJdyn536Hcb0Ou7tF0ME2mir73g4ayOdvYNw=;
        b=h/zB1Cu5yEsZ6MUW3UCmHcRSZx1SnSrZvbIkt3WCUQ6tArfeRL2vDt8n7h1zHMturI
         aTMTqXNSono0uGvbton726ijNIsfTzmOi1qwLsJiYdaqR35nTGnw1DWU0i7EVR3CDQX1
         phfMw64m5aNfdgWa3NJnEIBupipLa2bNUigKEoYVPGX373ytFFWhxB8LMxYo+nj5nbaN
         XBxHfE+HcVyB76yWUmi46RuVOru7r+v5jHWyjXU7S4zIxzkrQmjbeKqJ4co2L6ilcDCD
         z+6Xs/HTKf19r2LNqdI0309x7Nzc8ye9hTKB8tYm+Z0HyIVFjNwYcZBFGg1Mce+HdTWr
         z6ZA==
X-Received: by 10.202.200.151 with SMTP id y145mr31477505oif.111.1437506962943;
 Tue, 21 Jul 2015 12:29:22 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 21 Jul 2015 12:28:53 -0700 (PDT)
In-Reply-To: <CAP8UFD0EXgt7ijdv2cY-HGuqcwjz=Z3-8KV7Xqk=-EBRp-QrGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274401>

On Mon, Jul 20, 2015 at 12:50 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Jul 19, 2015 at 12:00 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Using 'ref-filter' APIs implement the '--merged' and '--no-merged'
>> options into 'tag.c'. The '--merged' option lets the user to only
>> list tags merged into the named commit. The '--no-merged' option
>> lets the user to only list tags not merged into the named commit.
>> If no object is provided it assumes HEAD as the object.
>>
>> Add documentation and tests for the same.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-tag.txt | 10 +++++++++-
>>  builtin/tag.c             |  6 +++++-
>>  t/t7004-tag.sh            | 27 +++++++++++++++++++++++++++
>>  3 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 16e396c..74ed157 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -14,7 +14,7 @@ SYNOPSIS
>>  'git tag' -d <tagname>...
>>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>>         [--column[=<options>] | --no-column] [--sort=<key>] [--format=<format>]
>> -       [<pattern>...]
>> +       [(--merged | --no-merged) [<commit>]] [<pattern>...]
>
> Maybe [--[no-]merged [<commit>]] instead of [(--merged | --no-merged)
> [<commit>]].
>

Looks better. will use.

>>  'git tag' -v <tagname>...
>>
>>  DESCRIPTION
>> @@ -169,6 +169,14 @@ This option is only applicable when listing tags without annotation lines.
>>         `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
>>         The fields are same as those in `git for-each-ref`.
>>
>> +--merged [<commit>]::
>> +       Only list tags whose tips are reachable from the
>> +       specified commit (HEAD if not specified).
>> +
>> +--no-merged [<commit>]::
>> +       Only list tags whose tips are not reachable from the
>> +       specified commit (HEAD if not specified).
>
> Here also you could write something like:
>
> +--[no-]merged [<commit>]::
> +       Only list tags whose tips are reachable, or not reachable
> +       if --no-merged is used, from the specified commit
> +       (HEAD if not specified).
>
>>
>>  CONFIGURATION
>>  -------------
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index cae113b..0fa1d31 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -23,7 +23,7 @@ static const char * const git_tag_usage[] = {
>>         N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
>>         N_("git tag -d <tagname>..."),
>>         N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
>> -               "\n\t\t[<pattern>...]"),
>> +               "\n\t\t[--merged [<commit>]] [--no-merged [<commit>]] [<pattern>...]"),
>
> [--[no-]merged [<commit>]] here too.
>
> Thanks,
> Christian.

Here too, thanks :)

-- 
Regards,
Karthik Nayak
