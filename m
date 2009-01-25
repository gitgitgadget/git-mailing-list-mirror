From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 1/2] tree.c: allow read_tree_recursive() to traverse 
	gitlink entries
Date: Sun, 25 Jan 2009 13:30:48 +0100
Message-ID: <8c5c35580901250430q68a09150x863f15438336a0eb@mail.gmail.com>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
	 <1232844726-14902-2-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901251225250.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 13:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR4AA-0004Vj-Ic
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 13:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbZAYMau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 07:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZAYMau
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 07:30:50 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:50220 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbZAYMat (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 07:30:49 -0500
Received: by wa-out-1112.google.com with SMTP id v33so330514wah.21
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F7tlSW0yz1Pw103p6H235mKIA7jNimobVbfUAlfOw04=;
        b=VAAkP2uCR7gMlZFAyVs5sxgJkkLMyApgK6hNUcWBkqLJNafbGc7jhlO6H9pf86dTIK
         YUw4Cs0AaOGw/8nDmu0lOnARxj3r0Oj2p8+yExhsi2955E41ZZkub75iycur6d7TgFiO
         kYAl0jW0ysKLUmEcmYVfP+bYM46+AaFNHk4VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fJawQM/V/B2/1zUU+7unrh7onal4m2tWp85TKQz+S4YWrQwUC7PdsAa+yE5zO3tGBY
         4IniSQi6IeMGkl9u9KTs+D3XAm+x8ddW7I7CCo/Vc44w4CVJmeahHjFi2xts8V+jvw4y
         87lyAJLWFqOF54xFYnSKiKSNNfYXTh+U2xROU=
Received: by 10.114.148.19 with SMTP id v19mr6725995wad.71.1232886648454; Sun, 
	25 Jan 2009 04:30:48 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901251225250.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 25, 2009 at 12:43, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 25 Jan 2009, Lars Hjemli wrote:
>
>> This functionality can be used to allow inter-repository operations, but
>> since the current users of read_tree_recursive() does not yet support
>> such operations, they have been modified where necessary to make sure
>> that they never return READ_TREE_RECURSIVE for gitlink entries (hence no
>> change in behaviour should be introduces by this patch alone).
>
> s/\(introduce\)s/\1d/

Thanks

>
>> diff --git a/archive.c b/archive.c
>> index 9ac455d..e6de039 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -132,7 +132,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>>               err = write_entry(args, sha1, path.buf, path.len, mode, NULL, 0);
>>               if (err)
>>                       return err;
>> -             return READ_TREE_RECURSIVE;
>> +             return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
>
> You do not need the parentheses around the conditional:
>
>        $ git grep 'return (.*?' *.c | wc -l
>        14
>        gene099@racer:~/git (rebase-i-p)$ git grep 'return [^(]*?' *.c | wc -l
>        41
>
> Note that the 14 matches include 9 false positives.

Ok, will fix.

>
>> diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
>> index 5b63e6e..fca4631 100644
>> --- a/builtin-ls-tree.c
>> +++ b/builtin-ls-tree.c
>> @@ -68,13 +68,8 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
>>                *
>>                * Something similar to this incomplete example:
>>                *
>> -             if (show_subprojects(base, baselen, pathname)) {
>> -                     struct child_process ls_tree;
>> -
>> -                     ls_tree.dir = base;
>> -                     ls_tree.argv = ls-tree;
>
> I wondered how that could ever have compiled...
>
> Until I inspected the file (which is different in junio/next from what you
> based your patch on; your patch is vs junio/master).

Yes, sorry for not mentioning that.


>
>> @@ -131,6 +131,34 @@ int read_tree_recursive(struct tree *tree,
>>                       if (retval)
>>                               return -1;
>>                       continue;
>> +             } else if (S_ISGITLINK(entry.mode)) {
>> +                     int retval;
>> +                     struct strbuf path;
>
> s/;/ = STRBUF_INIT;/

I skipped the STRBUF_INIT since I used strbuf_init() below, but...


>
>> +                     unsigned int entrylen;
>> +                     struct commit *commit;
>> +
>> +                     entrylen = tree_entry_len(entry.path, entry.sha1);
>> +                     strbuf_init(&path, baselen + entrylen + 1);
>> +                     strbuf_add(&path, base, baselen);
>> +                     strbuf_add(&path, entry.path, entrylen);
>> +                     strbuf_addch(&path, '/');
>
> Why not
>                        strbuf_addf(&path, "%.*s%.*s/", baselen, base,
>                                entrylen, entry.path);

...with this cute fix the STRBUF_INIT is required. Will fix.

Thanks for the review.

--
larsh
