From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v14 04/16] Refactor quote_path_relative, remove unused params
Date: Tue, 25 Jun 2013 19:39:55 +0800
Message-ID: <CANYiYbHCJWhm9sVwaOrjZ+K6SYhssFmSt4XEqXWXhkZ=8KCqmQ@mail.gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<c7b9df81fad6a5b87400ae7beb6e6c2b7d48a67b.1372087065.git.worldhello.net@gmail.com>
	<7vd2rb8gmc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 13:40:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrRbM-0003ui-5Q
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 13:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771Ab3FYLj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 07:39:57 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:50997 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3FYLj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 07:39:56 -0400
Received: by mail-wi0-f175.google.com with SMTP id m6so673414wiv.14
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rrvekzDkZEHBllZw5HsWjL580RUof0BRb/5n2P1Jrcs=;
        b=cYncD97ROc0mgdf1QlyhWquAA3aV5H7yooazr3YFjDNEcEc9nXOaEmj7lnOYhk+I36
         CBTFrlBcVGlQ2YNtDJacpmPws8fodLg0ZlpFLg3t53Wx7WVbwrcNFSsedwvXfE99HrY6
         Vrl5GrKB7Rngiyq4H2Z5gdtBO/Ei+5tXcO9ufFww/rPeS3Uyjf3EwtKl4GuuUnGX3SCu
         26SHzB9wJQYkdI9Xnfaw9+Gio3rG6JoSqZFDHDdlVqIYi5GhY45303iLXGFf04bJZ+u0
         rIl/l1pIQX0qopfvGwvgq3LpwjZlIJCStKKU/MmFEg/7CCp+f2ATsTgYMGY44BU9BYQT
         M0zw==
X-Received: by 10.194.249.129 with SMTP id yu1mr20229225wjc.10.1372160395550;
 Tue, 25 Jun 2013 04:39:55 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Tue, 25 Jun 2013 04:39:55 -0700 (PDT)
In-Reply-To: <7vd2rb8gmc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228956>

2013/6/25 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> After substitute path_relative() in quote.c with relative_path() from
>> path.c, parameters (such as len and prefix_len) are obsolete in function
>> quote_path_relative(). Remove unused parameters and change the order of
>> parameters for quote_path_relative() function.
>> ...
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index 04e39..f77f95 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -262,7 +262,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>                               if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
>>                                       errors++;
>>                               if (gone && !quiet) {
>> -                                     qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
>> +                                     qname = quote_path_relative(directory.buf, prefix, &buf);
>>                                       printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
>
> This one needed a bit closer look to make sure directory.len is
> already pointing at the end of directory.buf (it is) to verify that
> this is a safe conversion.  Everywhere else we lost either -1 or
> strlen() of the string we feed quote_path() and quote_path_relative()
> so they look fine.

When tracking in "remove_dirs(&directory, prefix, rm_flags, dry_run,
quiet, &gone)",
there are some suspect strbuf_setlens, like:

        strbuf_setlen(path, len);
        strbuf_addstr(path, e->d_name);

and at the end of remove_dirs, there is:

        strbuf_setlen(path, original_len);

So both the but and len will be restored in the end, and directory.len always
points to strlen of directory.buf.

So it's safe for the following refactor:

-                                     qname =
quote_path_relative(directory.buf, directory.len, &buf, prefix);
+                                     qname =
quote_path_relative(directory.buf, prefix, &buf);



-- 
Jiang Xin
