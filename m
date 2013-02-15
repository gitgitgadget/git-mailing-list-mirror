From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v4.1 09/12] sequencer.c: teach append_signoff to avoid
 adding a duplicate newline
Date: Fri, 15 Feb 2013 10:58:38 -0800
Message-ID: <CA+sFfMecyfD7x_8Jk-hUDceL_nS5kuKq5nF0vRBqLROWFgdypA@mail.gmail.com>
References: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
	<1360665222-3166-1-git-send-email-drafnel@gmail.com>
	<20130214175849.GA27958@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	jrnieder@gmail.com, Brandon Casey <bcasey@nvidia.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Feb 15 19:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6QUy-0005aH-PG
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 19:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039Ab3BOS6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 13:58:41 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:60205 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab3BOS6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 13:58:40 -0500
Received: by mail-wi0-f180.google.com with SMTP id hi8so1557315wib.1
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 10:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=yrs9S3f1PhiXTAgVgRoTJXTtp1c3Nz2A3JaoUOnrcEU=;
        b=hQwaBJ0Ju3q78747NSUhP6eznomexN5SGArA3BvY6TktFV4TTsv6peLGkHciFM89Zp
         lpoCrKe2h9AL1hDVhvKncMIc0K1ZcO9ZJmC4yl38+6jzIqsl2XtDNSWBfxfjzCt0e37K
         A62amtoevNPPsasY8udb7sXDcmeKguvC4TZl7fXuQ/DbRXA+ehrPU3fWKGjPyXR1UYgn
         MaOa5cdeaUql1UPBBUCoeT/18f/ZEcCjZIPEeEvPOR3agxFbb2wbc5DIqbH7ugDIp7Zd
         zbU/gmJz6DnrxN4Omd1pdsEUDVGcMrKq/3s7vpp2dXxPtg/vhbVenswebvv61hcscEtn
         evag==
X-Received: by 10.180.109.82 with SMTP id hq18mr6290738wib.0.1360954718955;
 Fri, 15 Feb 2013 10:58:38 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Fri, 15 Feb 2013 10:58:38 -0800 (PST)
In-Reply-To: <20130214175849.GA27958@farnsworth.metanate.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216351>

On Thu, Feb 14, 2013 at 9:58 AM, John Keeping <john@keeping.me.uk> wrote:
> On Tue, Feb 12, 2013 at 02:33:42AM -0800, Brandon Casey wrote:
>> Teach append_signoff to detect whether a blank line exists at the position
>> that the signed-off-by line will be added, and refrain from adding an
>> additional one if one already exists.  Or, add an additional line if one
>> is needed to make sure the new footer is separated from the message body
>> by a blank line.
>>
>> Signed-off-by: Brandon Casey <bcasey@nvidia.com>
>> ---
>
> As Jonathan Nieder wondered before [1], this changes the behaviour when
> the commit message is empty.  Before this commit, there is an empty line
> followed by the S-O-B line; now the S-O-B is on the first line of the
> commit.
>
> The previous behaviour seems better to me since the empty line is
> hinting that the user should fill something in.  It looks particularly
> strange if your editor has syntax highlighting for commit messages such
> that the first line is in a different colour.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/214796
>
>> diff --git a/sequencer.c b/sequencer.c
>> index 3364faa..084573b 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1127,8 +1127,19 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>>       else
>>               has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
>>
>> -     if (!has_footer)
>> -             strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
>> +     if (!has_footer) {
>> +             const char *append_newlines = NULL;
>> +             size_t len = msgbuf->len - ignore_footer;
>> +
>> +             if (len && msgbuf->buf[len - 1] != '\n')
>> +                     append_newlines = "\n\n";
>> +             else if (len > 1 && msgbuf->buf[len - 2] != '\n')
>> +                     append_newlines = "\n";
>
> To restore the old behaviour this needs something like this:
>
>                 else if (!len)
>                         append_newlines = "\n";
>
>> +             if (append_newlines)
>> +                     strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
>> +                             append_newlines, strlen(append_newlines));
>> +     }
>>
>>       if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
>>               strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,

Are you talking about the output produced by format-patch?  Or are you
talking about what happens when you do 'commit --amend -s' for a
commit with an empty commit message. (The email that you referenced
was about the behavior of format-patch).

I'm thinking you must be talking about the 'commit --amend -s'
behavior since you mentioned your editor.  Is there another case that
is affected by this?  Normally, any extra blank lines that precede or
follow a commit message are removed before the commit object is
created.  So, I guess it wouldn't hurt to insert a newline (or maybe
it should be two?) before the signoff in this case.  Would this
provide an improvement or change for any other commands than 'commit
--amend -s'?

If we want to do this, then I'd probably do it like this:

-               if (len && msgbuf->buf[len - 1] != '\n')
+               if (!len || msgbuf->buf[len - 1] != '\n')
                        append_newlines = "\n\n";
-               else if (len > 1 && msgbuf->buf[len - 2] != '\n')
+               else if (len == 1 || msgbuf->buf[len - 2] != '\n')
                        append_newlines = "\n";

This would ensure there were two newlines preceding the sob.  The
editor would place its cursor on the top line where the user should
begin typing in a commit message.  If an editor was not opened up
(e.g. if 'git cherry-pick -s --allow-empty-message ...' was used) then
the normal mechanism that removes extra blank lines would trigger to
remove the extra blank lines.

I think that's reasonable.

It seems 'git cherry-pick -s --edit' follows a different code path,
and the commit message is stripped of newlines by 'git commit' before
it is passed to the editor.  'cherry-pick -s --edit' and 'commit
--amend -s' should probably have the same behavior and present the
same buffer to the user for editing when they encounter a commit with
an empty message.

Maybe something like this is enough(?):

diff --git a/builtin/commit.c b/builtin/commit.c
index 7b9e2ac..0796412 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -124,8 +124,10 @@ static int opt_parse_m(const struct option *opt, const char
        if (unset)
                strbuf_setlen(buf, 0);
        else {
+               if (buf->len)
+                       strbuf_addch(buf, '\n');
                strbuf_addstr(buf, arg);
-               strbuf_addstr(buf, "\n\n");
+               strbuf_complete_line(buf);
        }
        return 0;
 }
@@ -673,9 +675,6 @@ static int prepare_to_commit(const char *index_file, const c
        if (s->fp == NULL)
                die_errno(_("could not open '%s'"), git_path(commit_editmsg));

-       if (clean_message_contents)
-               stripspace(&sb, 0);
-
        if (signoff) {
                /*
                 * See if we have a Conflicts: block at the end. If yes, count
@@ -703,6 +702,9 @@ static int prepare_to_commit(const char *index_file, const c
                append_signoff(&sb, ignore_footer, 0);
        }

+       if (clean_message_contents)
+               stripspace(&sb, 0);
+
        if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
                die_errno(_("could not write commit template"));

I suspect we have a broken test at t7502.15 though that happened to
work because opt_parse_m() was appending two newlines that the test
expected to be there.

-Brandon
