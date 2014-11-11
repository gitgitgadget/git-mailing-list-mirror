From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 5/9] builtin/notes: Simplify early exit code in add()
Date: Tue, 11 Nov 2014 01:49:58 +0100
Message-ID: <CALKQrgdBhm91tipHRQ3sF_DacSh5nRJmS7eP4S5Z4vB8R8O4_w@mail.gmail.com>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
	<1415536255-19961-6-git-send-email-johan@herland.net>
	<xmqqmw7y94jm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 01:50:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnzfd-0001Fz-7p
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 01:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbaKKAux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 19:50:53 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:54198 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaKKAuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 19:50:52 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1XnzfV-0002S6-7m
	for git@vger.kernel.org; Tue, 11 Nov 2014 01:50:49 +0100
Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Xnzdp-000478-Sz
	for git@vger.kernel.org; Tue, 11 Nov 2014 01:49:47 +0100
Received: by mail-pd0-f175.google.com with SMTP id y13so8969846pdi.34
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 16:49:58 -0800 (PST)
X-Received: by 10.68.65.68 with SMTP id v4mr35615378pbs.52.1415666998206; Mon,
 10 Nov 2014 16:49:58 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Mon, 10 Nov 2014 16:49:58 -0800 (PST)
In-Reply-To: <xmqqmw7y94jm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 9:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> Signed-off-by: Johan Herland <johan@herland.net>
>> ---
>>  builtin/notes.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index 1017472..f1480cf 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> @@ -399,7 +399,7 @@ static int append_edit(int argc, const char **argv, const char *prefix);
>>
>>  static int add(int argc, const char **argv, const char *prefix)
>>  {
>> -     int retval = 0, force = 0;
>> +     int force = 0;
>>       const char *object_ref;
>>       struct notes_tree *t;
>>       unsigned char object[20], new_note[20];
>> @@ -441,6 +441,8 @@ static int add(int argc, const char **argv, const char *prefix)
>>
>>       if (note) {
>>               if (!force) {
>> +                     free_note_data(&d);
>> +                     free_notes(t);
>>                       if (!d.given) {
>
> It looks a bit strange to refer to d.given after calling a function
> that sounds as if it is meant to clear what is recorded in and to
> invalidate &d; yes, I can read the implementation to see that
> d.given keeps its stale value, but that is something other people
> may want to "clean up" later and this reference to d.given will get
> in the way when that happens.

Yes, that was obviously an oversight on my part.

> At this point of the code, it makes sense to free t in preparation
> to either switching to append codepath or erroring out, but does &d
> have anything in it already to necessitate its freeing?

Actually, no, although verifying that required double-checking that
each of the -m/-F/-c/-C parsers which store data into &d, do in fact
set d.given.

I suggest to either move the free_note_data(&d) call below the "if
(!d.given)" block, or reorganize into this (which at the moment reads
better to me):

    if (note) {
        if (!force) {
            free_notes(t);
            if (d.given) {
                free_note_data(&d);
                return error(_("Cannot add notes. "
                    "Found existing notes for object %s. "
                    "Use '-f' to overwrite existing notes"),
                    sha1_to_hex(object));
            }
            /*
             * Redirect to "edit" subcommand.
             *
             * We only end up here if none of -m/-F/-c/-C or -f are
             * given. The original args are therefore still in
             * argv[0-1].
             */
            argv[0] = "edit";
            return append_edit(argc, argv, prefix);
        }
        fprintf(stderr, _("Overwriting existing notes for object %s\n"),
            sha1_to_hex(object));
    }

This keeps the two free_* calls close together, only separated by if
(d.given), which nicely indicates whether we need to call
free_notes_data(&d) at all.

If that looks good to you, do you want a re-roll, or is it easier to
fix up yourself?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
