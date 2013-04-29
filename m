From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2] Add support for -i/--interactive to git-clean
Date: Tue, 30 Apr 2013 00:15:58 +0800
Message-ID: <CANYiYbHKWv6R2vtwG=bTNhj8q0iC4EBt8usC3posBCtYBTXOvA@mail.gmail.com>
References: <7vmwslw1py.fsf@alter.siamese.dyndns.org>
	<2a68239bfd3e6b9ea1842dd8e468ee3d3217af5b.1367079089.git.worldhello.net@gmail.com>
	<vpqwqrl931e.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWqkI-0007s5-Qf
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549Ab3D2QQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:16:01 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37729 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018Ab3D2QQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:16:00 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so2985084wiv.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AGbkN0cjtl41K6DxpKP3crihVNzw4PuM+3qG34XXEpM=;
        b=DX++F5V6RNROCQ6v5i8GA+IJrHdVTP/qVV4cA2o9neCl3xhwhFa3cqu50GxR/+HLlO
         be9dpqaYsyQBiUpwuNjQCDp4m8FWY4RAaJo/oyvRt84F2A6wi45lpXZAfBGxmE/VWgK0
         n9gE8qVba25KtsQ8fzuTsVSFVpmb1NCyoh6y75Q1aodwCEA22VUedOk3o8nVX2wkP3wf
         wQl/oxdDdF4IksSGrLPlWjBXwbxNsAhEdiyf7g16PlnMrKwnFLBEgl5Gtmxo3SKcg9G+
         84PYC8SwfQV1IoJIkn+qYnyb05dT88X9KoujldGj++z1zvQz4+0raTD36N6Y08FVdDmZ
         QmeQ==
X-Received: by 10.194.133.198 with SMTP id pe6mr97855454wjb.9.1367252158395;
 Mon, 29 Apr 2013 09:15:58 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Mon, 29 Apr 2013 09:15:58 -0700 (PDT)
In-Reply-To: <vpqwqrl931e.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222806>

2013/4/29 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Show what would be done and a confirmation dialog before actually
>> cleaning. In the confirmation dialog, the user can input a space
>> separated prefix list, and each clean candidate that matches with
>> one of prefix, will be excluded from cleaning.
>
> That seems a really weird interface. In particular, that means people
> typing "no" or "n" mechanically will have everything not starting with
> "n" or "no" deleted. We've learnt from the "git send-email" interface
> that people (including me ;-) ) do type "yes" mechanically to some
> questions.

Because of this (typing "no" or "n" not stop the whole cleaning),
I write a loop, only when user press Enter (input nothing), begin
to clean files/directories, and there would be a warning if nothing
excluded by the prefix/pattern.

That means when user input "n" or "no", the interactive git-clean
will not delete entries starting with "n" or "no" (instead of delete
nothing), but it still give the user a hint what happened. It will
show the filtered cleaning list or a warning message that there
are no entries starting with "n" or "no" to be filtered out (may be
the warning messages should be cached and displayed in
the end, not at the beginning).

>
> My feeling is that you're doing a bad compromise between a confirmation
> dialog (y/n) and a really interactive command (like "git add -i") with a
> rich interface.

It's not confirmation, but a last chance to save your cleaning files.
The use can input a space-seperated prefixes list, but I think most
people would like to input a space-seperated patterns (like .gitignore).
I try to implement like this, but still need sometime to refector the code.

+                               el = add_exclude_list(&dir, EXC_CMDL,
"exclude by interactive git clean");
+                               add_exclude((*prefix_list)->buf, "",
0, el, -(++i));

git-clean is a simple task, I doubt write a rich interface has no much value,
and make things complicated. But render prompt, error outputs in different
color like interactive git-add is interesting.


>> @@ -34,7 +34,17 @@ OPTIONS
>>  -f::
>>  --force::
>>       If the Git configuration variable clean.requireForce is not set
>> -     to false, 'git clean' will refuse to run unless given -f or -n.
>> +     to false, 'git clean' will refuse to run unless given -f, -n or
>> +     -i.
>> +
>> +-i::
>> +--interactive::
>> +  Show what would be done and a confirmation dialog before actually
>> +  cleaning. In the confirmation dialog, the user can input a space
>> +  separated prefix list, and each clean candidate that matches with
>> +  one of prefix, will be excluded from cleaning. When the user feels
>> +  it's OK, press ENTER to start cleaning. If the user wants to cancel
>> +  the whole cleaning, simply input ctrl-c in the confirmation dialog.
>
> Broken indentation. It seems you've set your tab-width to 2, in which
> case you can't see it, but you've indented with 2 spaces where the rest
> of the file is indented with tabs.

Oops, I code lots of ruby recently, and vim is not smart to handle txt file.
I will correct them.

>>               if (S_ISDIR(st.st_mode)) {
>> -                     strbuf_addstr(&directory, ent->name);
>>                       if (remove_directories || (matches == MATCHED_EXACTLY)) {
>> -                             if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
>> -                                     errors++;
>> -                             if (gone && !quiet) {
>> -                                     qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
>> -                                     printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
>> -                             }
>> +                             string_list_append(&dels, ent->name);
>
> The patch would be much easier to read if split into a first refactoring
> patch that would introduce this "dels" list, and a second patch that
> would introduce -i. Reading this, I wondered why the code was removed,
> while it was actually just moved.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 
Jiang Xin
