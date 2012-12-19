From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH v2] git-clean: Display more accurate delete messages
Date: Wed, 19 Dec 2012 11:59:59 +1100
Message-ID: <CAKJhZwRPzrsnbnW_HgRTo86T6jqmm_osznDqpYo7pKO=cUaVDA@mail.gmail.com>
References: <1355743765-17549-1-git-send-email-zoltan.klinger@gmail.com>
	<7vsj74jr2k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 02:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl81D-0005iv-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 02:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab2LSBAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 20:00:01 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:42048 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342Ab2LSBAA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 20:00:00 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so1858853iea.26
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 16:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Lh0ewcnUJN5nOQVS+dppby2NaJGfA6jC9dKLSPwes6w=;
        b=vl4wxR/OaK+dgtahBv7uI8JoBIlqt8JVlIcpL1nSfrPaEojBy7wNhwrTMBwv04ThPW
         /715cVGxljoBpw4A4pK5YVi9TJK9en8t8cT+y7525CD5Cwvm0Ov2/zXYVuO4drBdAEM8
         IgKogwAN8syMa+xRKv/ZvpqC/925QjhF/Ts6/ZQ5R77XQjiMtFAZKv2YH/lNT53sFH3L
         +IjNkrC3RT1/Qbv/VuBSDqFhASKqg2IGum6LD540CmiovGtJLFVCs5BBIRTNcfG7f1Vt
         33MiU7TsFF1pIeMInVj0CSIXEXJbhVvHUI/ZgqBGQw26SOf5pf72NqTt1B4s5TfYaK1Y
         hh7A==
Received: by 10.50.159.165 with SMTP id xd5mr424415igb.82.1355878799688; Tue,
 18 Dec 2012 16:59:59 -0800 (PST)
Received: by 10.50.13.104 with HTTP; Tue, 18 Dec 2012 16:59:59 -0800 (PST)
In-Reply-To: <7vsj74jr2k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211797>

Thanks for the feedback.

> My reading of the above is that "lst" after sorting is expected to
> have something like:
>
>         a/
>         a/b/
>         a/b/to-be-removed
>         a/to-be-removed
>
> and we first show "a/", remember that prefix in "dir", not show
> "a/b/" because it matches prefix, but still update the prefix to
> "a/b/", not show "a/b/to-be-removed", and because "a/to-be-removed"
> does not match the latest prefix, it is now shown.  Am I confused???

No, it's a bug. The correct output should be just "a/". Thanks for
pointing it out, I'm going to fix that.

>
>> @@ -150,43 +170,45 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>               if (S_ISDIR(st.st_mode)) {
>>                       strbuf_addstr(&directory, ent->name);
>>                       qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
>> -                     if (show_only && (remove_directories ||
>> -                         (matches == MATCHED_EXACTLY))) {
>> -                             printf(_("Would remove %s\n"), qname);
>> -                     } else if (remove_directories ||
>> -                                (matches == MATCHED_EXACTLY)) {
>> -                             if (!quiet)
>> -                                     printf(_("Removing %s\n"), qname);
>> -                             if (remove_dir_recursively(&directory,
>> -                                                        rm_flags) != 0) {
>> -                                     warning(_("failed to remove %s"), qname);
>> -                                     errors++;
>> -                             }
>> -                     } else if (show_only) {
>> -                             printf(_("Would not remove %s\n"), qname);
>> -                     } else {
>> -                             printf(_("Not removing %s\n"), qname);
>> +                     if (remove_directories || (matches == MATCHED_EXACTLY)) {
>> +                             remove_dir_recursively_with_dryrun(&directory, rm_flags, dry_run,
>> +                                             &dels, &skips, &errs, prefix);
>>                       }
>
> Moving the above logic to a single helper function makes sense, but
> can we name it a bit more concisely?  Also this helper feels very
> specific to "clean"---does it need to go to dir.[ch], I have to
> wonder.

Would you have a better name in mind for the
remove_dir_recursively_with_dryrun() function? I'm kinda stuck.

My thinking was that since the private function remove_dir_recurse()
in dir.c already handles the recursive removing of files and
directories and checks for nested git directories, it would be better
to modify that function rather than implement something similar but
with dels, skips and errs lists in clean.c.

> I am not very much pleased by the change to dir.[ch] in this patch,
> though.
>
>> +static void append_dir_name(struct string_list *dels, struct string_list *skips,
>> +             struct string_list *errs, char *name, const char * prefix, int failed, int isdir)
>> +{
>> +     struct strbuf quoted = STRBUF_INIT;
>> +
>> +     quote_path_relative(name, strlen(name), &quoted, prefix);
>> +     if (isdir && quoted.buf[strlen(quoted.buf) -1] != '/')
>> +             strbuf_addch(&quoted, '/');
>> +
>> +     if (skips)
>> +             string_list_append(skips, quoted.buf);
>> +     else if (!failed && dels)
>> +             string_list_append(dels, quoted.buf);
>> +     else if (errs)
>> +             string_list_append(errs, quoted.buf);
>> +}
>
> The three lists dels/skips/errs are mostly mutually exclusive (the
> caller knows which one to throw the element in) except that failed
> controls which one between dels or errs is used.
>
> That's an ugly interface, I have to say.  I think the quote-path
> part should become a separate helper function to be used by the
> callers of this function, and the callers should stuff the path to
> the list they want to put the element in.  That will eliminate the
> need for this ugliness.

Will get rid of append_dir_name() and reimplement things the way you
suggested above.

Cheers,
Zoltan
