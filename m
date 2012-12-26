From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/2] log: grep author/committer using mailmap
Date: Wed, 26 Dec 2012 22:12:16 +0100
Message-ID: <CALWbr2xW6r5ysJ8KQZa1eGYehG8ZbEp6K+s5JkG2goK9ef7rcA@mail.gmail.com>
References: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
	<1356195512-4846-2-git-send-email-apelisse@gmail.com>
	<7vr4mcobpu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 22:12:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnyHF-0003vx-DA
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 22:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005Ab2LZVMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 16:12:19 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43334 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab2LZVMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 16:12:18 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so4356360eek.19
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kJbZzUAlI4geINd5pFvw+8DLHpGqYwNYOhzBu1JZpv8=;
        b=FNMhSibuqScOSb+mi7XWEkWOVJ+qsBNyNIzhKj5EZ4RR5F3yGfcaJDnUV1Y8jqA+fl
         pvxmRL+/jIZHXe0hViVM90sosv927wBy35QWRDEuv0dz5ThlV3RNVPyZADx6qpcIOaiz
         5Ocu6PhrO9QnYKlFoZ0lrWEfMaqtQGsbDx1ybvPRqZbBTzBF61Yp7i8GbWnc+LbOis9h
         mhKvw5hKHgTL565OJtuXTq7UzhtNmETJWJc/SmBFRA85+L7tiUv2jM5m1QuDbKKVWuZ3
         I6liXv90Rbpw7x7hFSYmRBO9DcFAkHjikzVFpr9m6MDe5SqbAvBbTHYg7Iif/o3bTsfg
         Rnrg==
Received: by 10.14.178.196 with SMTP id f44mr72713674eem.14.1356556336987;
 Wed, 26 Dec 2012 13:12:16 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 26 Dec 2012 13:12:16 -0800 (PST)
In-Reply-To: <7vr4mcobpu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212156>

>>
>> +static int commit_rewrite_authors(struct strbuf *buf, const char *what, struct string_list *mailmap)
>> +{
>> +     char *author, *endp;
>> +     size_t len;
>> +     struct strbuf name = STRBUF_INIT;
>> +     struct strbuf mail = STRBUF_INIT;
>> +     struct ident_split ident;
>> +
>> +     author = strstr(buf->buf, what);
>> +     if (!author)
>> +             goto error;
>
> This does not stop at the end of the header part and would match a
> random line in the log message that happens to begin with "author ";
> is this something we would worry about, or would we leave it to "fsck"?

The only worrying case would be:
 - commit doesn't have "\nauthor" in the header (can that happen
without corruption?)
 - commit has "\nauthor" in the commit log
 - This line from commit log contains an <email> (split_ident_line works)
Then, I guess it's going to replace the name in the commit log.

Otherwise, it would not replace anything, as there is no author to
replace anyway.

It looks like most mechanisms using mailmap would have the same issue.

>> +     author += strlen(what);
>> +     endp = strstr(author, "\n");
>
> Using strchr(author, '\n') would feel more natural.  Also rename
> "author" to "person" or something, as you would be using this
> function for the committer information as well?

Both fixed

>> +     if (!endp)
>> +             goto error;
>> +
>> +     len = endp - author;
>> +
>> +     if (split_ident_line(&ident, author, len)) {
>> +     error:
>> +             strbuf_release(&name);
>> +             strbuf_release(&mail);
>> +
>> +             return 1;
>
> We usually signal error by returning a negative integer.  It does
> not matter too much in this case as no callers seem to check the
> return value from this function, though.

Fixed, or would you rather see it `void` ?

>> +     }
>> +
>> +     strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
>> +     strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
>> +
>> +     map_user(mailmap, &mail, &name);
>> +
>> +     strbuf_addf(&name, " <%s>", mail.buf);
>> +
>> +     strbuf_splice(buf, ident.name_begin - buf->buf,
>> +                   ident.mail_end - ident.name_begin + 1,
>> +                   name.buf, name.len);
>
> Would it give us better performance if we splice only when
> map_user() tells us that we actually rewrote the ident?

My intuition was that the cost of splice belongs to "memoving", when the
size is different. Yet, Fixed, as it removes two copies.
