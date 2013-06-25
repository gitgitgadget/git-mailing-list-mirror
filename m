From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v14 03/16] quote.c: remove path_relative, use
 relative_path instead
Date: Tue, 25 Jun 2013 19:09:58 +0800
Message-ID: <CANYiYbGvqHpQpp2UD0nBS5pqeimGE7yDMVYr7q9bGA0hSNNNDw@mail.gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<654b2387c27470c3dc81169e8f43c231aa9504ce.1372087065.git.worldhello.net@gmail.com>
	<7vhagn8gtz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 13:10:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrR8S-0000DU-93
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 13:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab3FYLKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 07:10:01 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:53678 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3FYLKA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 07:10:00 -0400
Received: by mail-wi0-f176.google.com with SMTP id ey16so644077wid.15
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aYxXbZ+TQvW8XL8YTckNd0RGagCDliMX6SRqF9lWv5A=;
        b=ONoZgGBibyhFM+2VB4uPAQmFF2IalIFyu06YzE+1hBG6wLd7rTcv74r/uAoUNODMey
         LhuvUzU85ItpZ/gJs7rlOUWhe/o59ebgT/uzQPWiV+YzKgw7WtVzd/CAOFLTm38abbam
         73r0dkZyYNFZ/OAgk0AvjxNkFUZNhi5P/gUC13Pod+Fo6SN8h2uO4JiTOYUUG54D50IH
         0AQKOMwkp8YpsAcOBy+vPM2uOU70b6Uxq0iaZ/IntMAwNgyKfVOyT/B3Ld0QLXfFGvSJ
         l2qhQWTtbPcs6fbdkPgdFDxjK6lD0CPUx3vpbge5v1kcxgy32Vm9E8bhRTPYJ8ABEapo
         sr1A==
X-Received: by 10.180.82.232 with SMTP id l8mr7394963wiy.23.1372158598563;
 Tue, 25 Jun 2013 04:09:58 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Tue, 25 Jun 2013 04:09:58 -0700 (PDT)
In-Reply-To: <7vhagn8gtz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228955>

2013/6/25 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Since there is an enhanced version of relative_path() in path.c,
>> remove duplicate counterpart path_relative() in quote.c.
>
> There is no nice comparison chart before and after like you had in
> patch 02/16?
>

You mean drawing a table to compare output of path_relative and
relative_path?

I will rewrite the commit log for patch 03/16 like the following. Need
to polish spellings and grammars.

quote.c: substitute path_relative with relative_path

Substitute the function path_relative in quote.c with the function
relative_path. Function relative_path can be treated as an enhanced
and robust version of path_relative.

Outputs of path_relative and it's replacement (relative_path) are the
same for the following cases:

    path      prefix     output of path_relative  output of relative_path
    ========  =========  =======================  =======================
    /a/b/c/   /a/b/      c/                       c/
    /a/b/c    /a/b/      c                        c
    /a/       /a/b/      ../                      ../
    /         /a/b/      ../../                   ../../
    /a/c      /a/b/      ../c                     ../c
    /x/y      /a/b/      ../../x/y                ../../x/y
    a/b/c/    a/b/       c/                       c/
    a/        a/b/       ../                      ../
    x/y       a/b/      ../../x/y                 ../../x/y
    /a/b      (empty)    /a/b                     /a/b
    /a/b      (null)     /a/b                     /a/b
    a/b       (empty)    a/b                      a/b
    a/b       (null)     a/b                      a/b

But if both of the path and the prefix are the same, or the returned
relative path should be the current directory, the outputs of both
functions are different. Function relative_path returns "./", while
function path_relative returns empty string.

    path      prefix     output of path_relative  output of relative_path
    ========  =========  =======================  =======================
    /a/b/     /a/b/      (empty)                  ./
    a/b/      a/b/       (empty)                  ./
    (empty)   (null)     (empty)                  ./
    (empty)   (empty)    (empty)                  ./

But not panic, the callers of path_relative can handle such cases, or
never encounter this issue at all. E.g.

 * In function quote_path_relative, if the output of path_relative is
   empty, append "./" to it, like:

       if (!out->len)
           strbuf_addstr(out, "./");

 * Another caller is write_name_quoted_relative, which is only used by
   builtin/ls-files.c. git-ls-files only show files, so path of files
   will never be identical with the prefix of a directory.

The following differences show that path_relative can not handle
extra slashes properly.

    path      prefix     output of path_relative  output of relative_path
    ========  =========  =======================  =======================
    /a//b//c/ //a/b//    ../../../../a//b//c/     c/
    a/b//c    a//b       ../b//c                  c

And if prefix has no trailing slash, path_relative can not work properly
either. But since prefix always has a trailing slash, so it's not a
problem.

    path      prefix     output of path_relative  output of relative_path
    ========  =========  =======================  =======================
    /a/b/c/   /a/b       b/c/                     c/
    /a/b      /a/b       b                        ./
    /a/b/     /a/b       b/                       ./
    /a        /a/b/      ../../a                  ../
    a/b/c/    a/b        b/c/                     c/
    a/b/      a/b        b/                       ./
    a         a/b        ../a                     ../
    x/y       a/b/       ../x/y                   ../../x/y
    a/c       a/b        c                        ../c
    /a/       /a/b       (empty)                  ../
    (empty)   /a/b       ../../                   ./


>>  void write_name_quoted_relative(const char *name, size_t len,
>>                               const char *prefix, size_t prefix_len,
>>                               FILE *fp, int terminator)
>>  {
>>       struct strbuf sb = STRBUF_INIT;
>>
>> -     name = path_relative(name, len, &sb, prefix, prefix_len);
>> +     name = relative_path(name, prefix, &sb);
>
> Are we sure nobody calls prefix_len pointing into the middle of
> string, not at the end of "prefix"?  This is unsafe for such a
> caller, and to make sure we catch them, we should remove the
> now-unused prefix_len parameter from this function.
>

Next two commits will remove the unused parameters, and
make this series of patches easy to review. But indeed this
commit has flaws, next two commits are fixes. Should I squash
them back?


-- 
Jiang Xin
