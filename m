From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 03/16] list-files: show paths relative to cwd
Date: Sat, 14 Mar 2015 18:25:41 +0700
Message-ID: <CACsJy8CjcCuDC8X9E5iko2b8xykBAwMY1JupYx1dzpnf5p5ghg@mail.gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
 <1425896314-10941-4-git-send-email-pclouds@gmail.com> <xmqqsid929rb.fsf@gitster.dls.corp.google.com>
 <xmqqoanx29ei.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 12:26:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWkCv-00024w-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 12:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbbCNL0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 07:26:13 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34798 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbCNL0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 07:26:12 -0400
Received: by iecsl2 with SMTP id sl2so137692194iec.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2jx8F8hju4D4OprMd0BfFqixO+RTIyaa3aAThpuevuQ=;
        b=knklmYAwyFlu9vQ2LzDLqOqW+xL30jJlVEF+aMXR/IzgLvRysFHi3w/bkI46Ywp8t7
         rm42tkcAmLbit2jRNftu9G2DgYyauYvk74EXoEum5aN5+xb/HDpMiP8+y0URInh71ydN
         UKs8Fo5XphQO/Btr+xPlU+ey9gJvZw7kXMuxYndC/fwb37drxJWm3Ab3jgfpQe8fjaVR
         7zxUulKhAfVVF4zqwFR1Gjn5AOIMR43cCK8VyaG7QhIUeclUWkd+hpuh1Fbq/3ZLKGcf
         6y6SgqfRI8hZqRZo1ZK4HhD4HMk9sXJhY3cqyXjKEIAAd8d+mS/otPl/OP3OsbZzuffj
         ER6w==
X-Received: by 10.42.87.131 with SMTP id y3mr9255423icl.45.1426332371520; Sat,
 14 Mar 2015 04:26:11 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sat, 14 Mar 2015 04:25:41 -0700 (PDT)
In-Reply-To: <xmqqoanx29ei.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265447>

On Fri, Mar 13, 2015 at 4:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>  static struct pathspec pathspec;
>>>  static const char *prefix;
>>> @@ -22,7 +23,7 @@ static void add_one(struct string_list *result, const char *name)
>>>      struct strbuf sb = STRBUF_INIT;
>>>      struct string_list_item *item;
>>>
>>> -    strbuf_addstr(&sb, name);
>>> +    quote_path_relative(name, prefix_length ? prefix : NULL, &sb);
>>>      item = string_list_append(result, strbuf_detach(&sb, NULL));
>>>      item->util = (char *)name;
>>>  }
>>
>> Hmph, wouldn't it make it more cumbersome and problematic to do
>> things like this here in add_one() phase?  I am imagining that the
>> endgame of this program will be
>>
>>     - populate_cached_entries() reads from the data source (at this
>>       step, there is just "the index"), calling add_one() whose
>>       responsibility is to record the paths that are interesting
>>       to an in-core structure;
>>
>>     - perform some interesting filtering, annotating, ordering,
>>       etc. (at this step, there is none) yet to come;
>>
>>     - display() will iterate over the result and then format the
>>       result.
>>
>> For example, if you do the "quote" thing too early, don't codepaths
>> in the later phases have to worry about item->string not matching
>> the original pathname anymore?  If you want to do something like
>> "/bin/ls -t", you may have to lstat() the paths for each item, but
>> if these store a path relative to the prefix, wouldn't you have to
>> prepend the prefix again before running lstat()?
>>
>> I am just wondering if this prefix-stripping and quoting belongs to
>> the output phase, not the input phase.
>
> Hmph, another interpretation of this patch is that your item->string
> are not the true filenames but the result of applying some
> interesting processing to the filenames and the true filenames are
> kept in item->util.  Is that what is going on?

Exactly. We would need to sort and stuff later on, so true filenames
are preserved in util->item. A cleaner way is perhaps carry all
metadata in item->util and item->string remains true filename, then do
all the formatting, coloring for all strings just before displaying.
It seems a lot varying data to carry around.

> If that is the case, it sort of makes sense to me, even though it
> would feel a bit unusual way to use the string-list.
>
> Thanks.



-- 
Duy
