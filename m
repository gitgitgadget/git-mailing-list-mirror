From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 3/4] mergetool--lib: Add functions for finding available tools
Date: Sun, 27 Jan 2013 15:45:08 -0800
Message-ID: <CAJDDKr6eTN6FE6mF_6boXBzw5TqmA6f5+7V0S6nQSkhQKZAmCg@mail.gmail.com>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
	<1359321886-80523-4-git-send-email-davvid@gmail.com>
	<7v8v7ecicm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzbun-0007Vk-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874Ab3A0XpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:45:12 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36814 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848Ab3A0XpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:45:10 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so1407991wgb.32
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 15:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=cMhzkQTbjibQFb7Q6d1okjvdERQUrjjR7WJ5Xsv0tfw=;
        b=kxLce0U3IP2E+bbntBbNH6wJoexdGrIqENySNyTrRXZVYCgDvTiThppoNcCBm06+Qf
         tA4Sxf+F2idnY7ZOrwCVqmODmeltG+skfqXhm12SutpL2ggxSluRmh5sDf40P2F61nCU
         19Sz3V9XRlBcS7qfe6XvOeEqhbqQ4hqXJ3DBSTF9abEIZcWo48dQetCoZ3DweD12YLNh
         16AXb7xf0nB5DjFu4hX6G7vGP5SFXgokPhPKqSaUXTBNsxV2+VAynmuLrNK1H3vn/oJn
         vx22pqEdAbOCBWU8qG403ALwKKbT9oyEleZZL6PCr40nZpQrYb19LmUMa962hXhQ9E/0
         PL2g==
X-Received: by 10.194.119.5 with SMTP id kq5mr18030860wjb.48.1359330309063;
 Sun, 27 Jan 2013 15:45:09 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Sun, 27 Jan 2013 15:45:08 -0800 (PST)
In-Reply-To: <7v8v7ecicm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214755>

On Sun, Jan 27, 2013 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> +filter_tools () {
>> +     filter="$1"
>> +     prefix="$2"
>> +     (
>> +             cd "$MERGE_TOOLS_DIR" &&
>> +             for i in *
>> +             do
>> +                     echo "$i"
>> +             done
>> +     ) | sort | while read tool
>> +     do
>> +             setup_tool "$tool" 2>/dev/null &&
>> +             (eval "$filter" "$tool") &&
>> +             printf "$prefix$tool\n"
>> +     done
>> +}
>> +
>>  diff_mode() {
>>       test "$TOOL_MODE" = diff
>>  }
>> @@ -199,27 +226,13 @@ list_merge_tool_candidates () {
>>  }
>>
>>  show_tool_help () {
>> -     unavailable= available= LF='
>> -'
>> -     for i in "$MERGE_TOOLS_DIR"/*
>> -     do
>> -             tool=$(basename "$i")
>> -             setup_tool "$tool" 2>/dev/null || continue
>> -
>> -             merge_tool_path=$(translate_merge_tool_path "$tool")
>> -             if type "$merge_tool_path" >/dev/null 2>&1
>> -             then
>> -                     available="$available$tool$LF"
>> -             else
>> -                     unavailable="$unavailable$tool$LF"
>> -             fi
>> -     done
>> -
>>       cmd_name=${TOOL_MODE}tool
>> +     available=$(filter_tools 'mode_ok && is_available' '\t\t')
>> +     unavailable=$(filter_tools 'mode_ok && ! is_available' '\t\t')
>>       if test -n "$available"
>>       then
>>               echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
>> -             echo "$available" | sort | sed -e 's/^/ /'
>> +             printf "$available"
>
> This may happen to be safe as available will not have anything with
> a per-cent % in it, but is not a good discipline in general.
>
>         printf "%s" "$available"
>
> If you are giving filter_tools an optional "prefix-per-line", I do
> not think it is too much of a stretch to introduce another optional
> "perfix for the whole thing" and let this call site say something
> like this:
>
>         cmd_name=${TOOL_MODE}tool
>         show_tool_names 'mode_ok && is_available' '\t\t' \
>                 "'git $cmd_name --tool=<tool>' may be set to one of these:"
>         show_tool_names 'mode_ok && !is_available' '\t\t' \
>                 "These are valid but not available:"
>
> without any of the above logic (and the same for unav).  It may look like this:
>
> show_tool_names () {
>         condition=${1?condition} per_line_prefix=${2:-} preamble=${3:-}
>
>         ( cd "$MERGE_TOOLS_DIR && ls -1 * ) |
>         while read toolname
>         do
>                 if setup_tool "$toolname" 2>/dev/null && (eval "$condition")
>                 then
>                         if test -n "$preamble"
>                         then
>                                 echo "$preamble"
>                                 preamble=
>                         fi
>                         printf "%s%s\n" "$prefix" "$toolname"
>                 fi
>         done
> }

Thanks guys.  I'll re-roll this soon.
-- 
David
