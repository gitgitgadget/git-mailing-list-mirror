From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] win32: syslog: prevent potential realloc memory leak
Date: Sun, 25 Jan 2015 22:38:39 +0100
Message-ID: <CABPQNSbCF7P23K+uj00PmjJkr=19t=W5wCN0-jweBJYEWgUWRw@mail.gmail.com>
References: <1418463676-1753-1-git-send-email-arjun024@gmail.com> <xmqqbnn4eqay.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Mike Pape <dotzenlabs@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 22:39:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFUtx-0004oA-GY
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 22:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbbAYVjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2015 16:39:22 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:44587 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbAYVjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 16:39:20 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so5647417iec.12
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 13:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qAvwbv+ZHyUTgfPlIYHrH+YpHw3WjRf+mUO27I3hzro=;
        b=l5ZuQYJRf8YOFjEMLYQHi5r7aHCJZXy10m836Is6FpdAyE0x1GlDmtzJfqH51WXAjk
         SeIckuKNnSg0245v7iNUFIES4dtjEdptZ1gOtvIr8ceQHN7MlA0GGQ9QrGAkN1wj9EWR
         r//mipRwpslzG5defza6H2syot9I1ofC7c9e07e99vAaF91s3QkQUk+AcC+aYyyKKd3t
         okja9YnCIdm0dXiUXGEpY1A7VOBlO1/rFB/QP9TMClhwApyr3eIYYObvQyj0pc0Ycie0
         vD0153bOmSdnJ3NoZEv7Wr2alPOhU4TeZBLEoc48pt27odrDaTgh+4KoQi5iqQ7Ooxbn
         t7VQ==
X-Received: by 10.50.108.108 with SMTP id hj12mr13094371igb.47.1422221959295;
 Sun, 25 Jan 2015 13:39:19 -0800 (PST)
Received: by 10.64.240.139 with HTTP; Sun, 25 Jan 2015 13:38:39 -0800 (PST)
In-Reply-To: <xmqqbnn4eqay.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263022>

Sorry for very late reply. I had a bug in my mail rules that caused
this email to skip my inbox. That should be fixed now.

On Mon, Dec 15, 2014 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Arjun Sreedharan <arjun024@gmail.com> writes:
>
>> use a temporary variable to free the memory in case
>> realloc() fails.
>>
>> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
>> ---
>>  compat/win32/syslog.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
>> index d015e43..3409e43 100644
>> --- a/compat/win32/syslog.c
>> +++ b/compat/win32/syslog.c
>> @@ -16,7 +16,7 @@ void openlog(const char *ident, int logopt, int facility)
>>  void syslog(int priority, const char *fmt, ...)
>>  {
>>       WORD logtype;
>> -     char *str, *pos;
>> +     char *str, *str_temp, *pos;
>>       int str_len;
>>       va_list ap;
>>
>> @@ -43,9 +43,11 @@ void syslog(int priority, const char *fmt, ...)
>>       va_end(ap);
>>
>>       while ((pos = strstr(str, "%1")) != NULL) {
>> +             str_temp = str;
>>               str = realloc(str, ++str_len + 1);
>>               if (!str) {
>>                       warning("realloc failed: '%s'", strerror(errno));
>> +                     free(str_temp);
>>                       return;
>>               }
>
> Hmm, the original, 088d8802 (mingw: implement syslog, 2010-11-04),
> that introduced the special casing for %1, says:
>
>     Syslog does not usually exist on Windows, so implement our own
>     using Window's ReportEvent mechanism.
>
>     Strings containing "%1" gets expanded into them selves by
>     ReportEvent, resulting in an unreadable string. "%2" and above
>     is not a problem.  Unfortunately, on Windows an IPv6 address can
>     contain "%1", so expand "%1" to "% 1" before reporting. "%%1" is
>     also a problem for ReportEvent, but that string cannot occur in
>     an IPv6 address.
>
> It is unclear why it says '"%2" and above is not a problem' to me.
> Is that because they expand to something not "an unreadable string",
> or is that because in the original developer's testing only "%1" was
> observed?

%2 would expand to the first argument (this is a varargs-type
interface), but such an argument does not exist, so no expansion is
being performed.

> It also says "%%1" is a problem, and it does not occur in
> an IPv6 address, but that would suggest that every time a new caller
> is added to syslog(), this imitation of syslog() can break, as there
> is nothing that says the new caller must be reporting something
> about an IP address.  Perhaps this loop should cleanse what it
> passes to ReportEvent() a bit more aggressively by expanding all "%"
> to "%-sp" or something)?

This suspicion is somewhat justified; I only did %1 because that was
the only one that had any theoretical way of being hit at the time the
patch was written. However, a quick test reveals that we currently
expand "%%1" to "%% 1", which is not problematic. And that makes sense
from looking at the code also.

However, removing the hunk and running the code reveals that Windows
no longer does that ugly recursive expansion. I'm sure it did when I
wrote the code, because I did test it. So it seems at least Windows
8.1 is less insane about this.

> Regardless of that funny %1 business, I notice in
>
>     http://msdn.microsoft.com/en-us/library/windows/desktop/aa363679%28v=vs.85%29.aspx
>
> that each element of lpStrings array that is passed to ReportEvent()
> is limited to 32k or so.  Wouldn't it make it a lot simpler if we
> removed the dynamic allocation and use a fixed sized 32k buffer here
> (and truncate the result as necessary)?  That would make the "leak"
> disappear automatically.

That's a very good point. Yes, I think that makes more sense.

> Having said all that, if we were to still go with the current code
> structure, "str_temp" should be scoped inside the loop, as there is
> no need to make it available to the remainder of the function, I
> think.  Also writing this way may make the intention more clear.
>
>         while (...) {
>                 char *new_str = realloc(str, ...);
>                 if (!new_str) {
>                         free(str);
>                         return;
>                 }
>                 memmove(... to shuffle ...);
>
> And after starting to write the above, I notice that the current
> code around realloc may be completely bogus.  It goes like this:
>
>         while ((pos = strstr(str, "..."))) {
>                 str = realloc(str, ...);
>                 if (!str) { warn and bail; }
>                 memmove(pos + 1, pos + 1, ...);
>                 pos[1] = ' ';
>         }
>
> If realloc() really allocated a new string, then pos that points
> into the original str has no relation to the reallocated str, so
> memmove() is not shuffling the string to make room for the SP in the
> string that will be given to ReportEvent() at all, no?  This seems
> to be a bug introduced by 2a6b149c (mingw: avoid using strbuf in
> syslog, 2011-10-06).
>
> It makes me wonder if this codepath ever triggers in the first
> place.

IIRC, this hunk was really just written out of fear because IPv6
addresses might contain %1, and I don't think it has ever been proven
to be possible to trigger out in the wild. But of course, other
call-sites could do the same thing.
