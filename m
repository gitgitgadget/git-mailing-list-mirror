From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 1/2] git-credential-store: support XDG config dir
Date: Thu, 5 Mar 2015 14:26:39 +0800
Message-ID: <CACRoPnTBmqtB+mvx9wFG3EUDRjfrsM==GQsso6V3q9NHH1k-YA@mail.gmail.com>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
	<1425414299-24000-2-git-send-email-pyokagan@gmail.com>
	<20150304094505.GA15593@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 07:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTPF8-0005GX-Jt
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 07:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbbCEG0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 01:26:42 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:39007 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbbCEG0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 01:26:41 -0500
Received: by labgd6 with SMTP id gd6so2332823lab.6
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 22:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YbeSYvkTkknq/Yi1Q/V0QArOpafPzhpgJ4SknRy4nyg=;
        b=hPfWFmyFxZslpxAB7hiHQKjbfPQPMUpiJsBsvHuNiO126W1tFbLx6DLb5NSMW9oNKb
         FQUhfP4u84KcrEjQT3UNKRABTgptReKOQQazhR8fycPin3qx6s9LFUNQbJVtxyhjEmsI
         9P1R2qu5Td9VVhJ0mz2F0GXmyG9YgiiKaJuE01RgGIL2Tv0qjqPohVpTdX2rKawrbtxq
         c3tvvJfaiTti/8FgxuHBMoTdrW/E8Fqb/p7ZtUQMAfuXqCjMoq11CsXcOAtDZLKwSvPn
         nN22Fpeoxca/r1U3Raiacag5CGTfHSOd2kSHX0hJ/m8DD2HQaxKbcLus/H8YgD3HHFl8
         USuw==
X-Received: by 10.112.130.39 with SMTP id ob7mr6773820lbb.32.1425536799236;
 Wed, 04 Mar 2015 22:26:39 -0800 (PST)
Received: by 10.112.130.228 with HTTP; Wed, 4 Mar 2015 22:26:39 -0800 (PST)
In-Reply-To: <20150304094505.GA15593@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264819>

Hi all,

Thanks for the review. I apologize for rushing the patch out as I
wanted to get feedback on the new behavior before committing to any
more code changes. I also wanted to quickly clear any doubts that
people may have about my coding ability. (Or maybe it created more ;)
)


On Wed, Mar 4, 2015 at 6:00 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>> * get: call lookup_credential() on the XDG file first if it exists. If
>>   the credential can't be found, call lookup_credential() on the HOME
>>   file.
>> * erase: Call remove_credential() on both the XDG file if it exists and
>>   the HOME file if it exists.
>> * store: If the XDG file exists, call store_credential() on the XDG file
>>   and remove_credential() on the HOME file to prevent duplicates.
>> * If "--file" is provided, use the file for all operations instead.
>
> When writting a commit message, always insist on _why_ you did what you
> did, not _what_ you did (the patch already says it). For example, your
> proposal for erase makes sense because if you're using "erase", you
> probably don't want to leave cleartext passwords in another file. But
> you didn't give the argument.
>
> In other words: I hate GNU-style changelogs ;-).
>
> Also, we usually put blank lines between items (read the output of "git
> log --no-merges" in git.git to get an idea of the conventions).

Generally, I would like git to have full support for the XDG base dir
spec because it would allow it to become a good citizen in an
ecosystem of software which already support the XDG base dir spec by
default. Personally, I am annoyed when a piece of software does not
store its configuration into its own separate directory because I
version control the configuration of every piece of software (with git
;) ) in its own directory, and store them as submodules in my home
directory git repo.

Keeping consistent with the behavior of git-config, the presence of
the credentials file in the XDG git directory signals that the user
wants credentials to be stored in the XDG directory rather than the
HOME directory. However, we keep reading from the home credentials in
case the user is using old versions of git on the same home directory.

In fact, thinking about it again, I think the behavior implemented in
the patch may not be suitable. Comments below.

>> Likewise,
>> lookup_credential() returns 1 if it could find the credential, and 0 if
>> it could not.
>
> Err, you're changing the calling convention, and you're not the only
> caller (git grep lookup_credential).
>
> If you need to change this existing function, best is to start your
> series with a preparatory patch that does the calling convention change,
> adapts the other caller, and then write your change on top, as [PATCH 2].

Eh? I thought lookup_credential has static linkage. The only other use
of lookup_credential is in credential-cache--daemon.c, and that has
its own function definition with static linkage.

>> -     if (!strcmp(op, "get"))
>> -             lookup_credential(file, &c);
>> -     else if (!strcmp(op, "erase"))
>> -             remove_credential(file, &c);
>> -     else if (!strcmp(op, "store"))
>> -             store_credential(file, &c);
>> -     else
>> +     if (!strcmp(op, "get")) {
>> +             if (file) {
>> +                     lookup_credential(file, &c);
>> +             } else {
>> +                     if (xdg_file && access_or_warn(xdg_file, R_OK, 0) == 0)
>> +                             ret = lookup_credential(xdg_file, &c);
>> +                     if (!ret && home_file && access_or_warn(home_file, R_OK, 0) == 0)
>> +                             lookup_credential(home_file, &c);
>> +             }
>> +     } else if (!strcmp(op, "erase")) {
>> +             if (file) {
>> +                     remove_credential(file, &c);
>> +             } else {
>> +                     if (xdg_file && access(xdg_file, F_OK) == 0)
>> +                             remove_credential(xdg_file, &c);
>> +                     if (home_file && access(home_file, F_OK) == 0)
>> +                             remove_credential(home_file, &c);
>
> Why is it somethimes access_or_warn and sometimes just access? (genuine
> question)

For "get" even though the xdg file cannot be read I believe it should
not be a fatal error because the credential may be found in the home
file. We should still warn the user though because it may not be what
the user wants. However, I see now that I mistakenly broke
compatibility with the old behavior, which errors out if the home
credential file could not be read.

Thinking about it again, the behavior could go both ways. The user may
actually not want the xdg or home credential file to be unreadable,
and so we should error out if the files are unreadable. This is
something that the community should decide, I think, so opinions
please :) Personally, I think we should go with this behavior. If that
is so, access(file, F_OK) would be used instead of access_or_warn.

For "erase", as stated above, having the xdg credentials file existing
signals that the user wants the xdg location to be used. If the xdg
credentials file does not exist then git should just skip over it.
Hence, the use of access instead of access_or_warn.

(As a side note, I discovered the lockfile code does not respect write
permissions on the target file, and will just rename the lockfile
over. Perhaps git should do that?)

>> +             }
>> +     } else if (!strcmp(op, "store")) {
>> +             if (file) {
>> +                     store_credential(file, &c);
>> +             } else if (xdg_file && access(xdg_file, F_OK) == 0) {
>> +                     store_credential(xdg_file, &c);
>> +                     if (home_file && access(home_file, F_OK) == 0 &&
>> +                         c.protocol && (c.host || c.path) && c.username
>> +                         && c.password)
>
> It would make sense to introduce a helper like sensible_credential(c),
> or sanity_check(c). It could be used in store_credential too.

Yes, I agree that the entire code needs to be refactored. The code
needs to be moved into store_credential(), remove_credential() and
lookup_credential() instead of cluttering up main()

> I'm not convinced you need to remove the credential from home_file if
> the xdg_file takes precedence. Not saying you shouldn't, but you should
> argue more at least.

Indeed, I committed a reasoning error there. I was thinking about what
happens if the user runs "store" on the new version of git, then
switches to an old one. Actually, "store" should write to both, so
that users will get the updated credentials regardless of whether they
use the old or new git.

In fact, the priority needs to be changed. To summarize, for
compatibility with older versions, git should read from the home
credentials file first, then the XDG one (since store will handle
updating of both). For writing, git should write to both files. For
erasing, git should erase from both files.

On Wed, Mar 4, 2015 at 7:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> Teach git-credential-store to read/write credentials from
>> $XDG_CONFIG_HOME/git/credentials and ~/.git-credentials where
>> appropriate:
>>
>> * get: call lookup_credential() on the XDG file first if it exists. If
>>   the credential can't be found, call lookup_credential() on the HOME
>>   file.
>> * erase: Call remove_credential() on both the XDG file if it exists and
>>   the HOME file if it exists.
>> * store: If the XDG file exists, call store_credential() on the XDG file
>>   and remove_credential() on the HOME file to prevent duplicates.
>> * If "--file" is provided, use the file for all operations instead.
>>
>> In order to support the above, parse_credential_file() now returns 1 if
>> it finds a matching credential, and 0 if it does not. Likewise,
>> lookup_credential() returns 1 if it could find the credential, and 0 if
>> it could not.
>>
>> Signed-off-by: Paul Tan <pyokagan@gmail.com>
>> ---
>
> I agree with everything Matthieu said ;-)

;-)

>> diff --git a/credential-store.c b/credential-store.c
>> index 925d3f4..18b8897 100644
>> --- a/credential-store.c
>> +++ b/credential-store.c
>> @@ -6,7 +6,7 @@
>>
>>  static struct lock_file credential_lock;
>>
>> -static void parse_credential_file(const char *fn,
>> +static int parse_credential_file(const char *fn,
>>                                 struct credential *c,
>>                                 void (*match_cb)(struct credential *),
>>                                 void (*other_cb)(struct strbuf *))
>> @@ -14,18 +14,20 @@ static void parse_credential_file(const char *fn,
>>       FILE *fh;
>>       struct strbuf line = STRBUF_INIT;
>>       struct credential entry = CREDENTIAL_INIT;
>> +     int found_credential = 0;
>>
>>       fh = fopen(fn, "r");
>>       if (!fh) {
>>               if (errno != ENOENT)
>>                       die_errno("unable to open %s", fn);
>> -             return;
>> +             return 0;
>
> Returning found_credential here would be easier to read, no?  After
> all, that is why you explicitly initialized it to 0 up there to say
> "no we haven't found any yet".

Actually I think die_errno is a function that does not return at all.
The return is just to shut the compiler up. Perhaps I shall comment
that.

>> +     if (!strcmp(op, "get")) {
>> +             if (file) {
>> +                     lookup_credential(file, &c);
>> +             } else {
>> +                     if (xdg_file && access_or_warn(xdg_file, R_OK, 0) == 0)
>> +                             ret = lookup_credential(xdg_file, &c);
>> +                     if (!ret && home_file && access_or_warn(home_file, R_OK, 0) == 0)
>> +                             lookup_credential(home_file, &c);
>> +             }
>> +     } else if (!strcmp(op, "erase")) {
>> +             if (file) {
>> +                     remove_credential(file, &c);
>> +             } else {
>> +                     if (xdg_file && access(xdg_file, F_OK) == 0)
>> +                             remove_credential(xdg_file, &c);
>> +                     if (home_file && access(home_file, F_OK) == 0)
>> +                             remove_credential(home_file, &c);
>> +             }
>> +     } else if (!strcmp(op, "store")) {
>> +             if (file) {
>> +                     store_credential(file, &c);
>> +             } else if (xdg_file && access(xdg_file, F_OK) == 0) {
>> +                     store_credential(xdg_file, &c);
>> +                     if (home_file && access(home_file, F_OK) == 0 &&
>> +                         c.protocol && (c.host || c.path) && c.username
>> +                         && c.password)
>
> If you have to chomp, do it like this instead:
>
>> +                     if (home_file && access(home_file, F_OK) == 0 &&
>> +                         c.protocol && (c.host || c.path) &&
>> +                         c.username && c.password)

> It would make it more clear that the second line is about the URL
> being accessed while the last line is about the user.

Agreed, but I think I will re-factor out the credential check into its
separate function.

>
>> +                             remove_credential(home_file, &c);
>> +             } else
>> +                     store_credential(home_file, &c);
>
> The repetitiousness of the above three blocks looked somewhat
> disturbing, but I guess you cannot avoid it because of the subtle
> differences among these codepaths.  When "getting", you want to get
> from only one place, and while not having an earlier candidate is
> not an error, an existing but unreadable file deserves a warning.
> When "erasing", you want to erase from everywhere.
>
> I am not sure if I understand what you are doing in the store
> codepath.  If your "get" will read from xdg (if available) without
> looking at home anyway, why do you need to remove it from home?
> Wouldn't the leftover be ignored anyway?

Actually, I think git should write to both files. See above.


On Wed, Mar 4, 2015 at 5:45 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 04, 2015 at 04:24:58AM +0800, Paul Tan wrote:
>
>> @@ -111,8 +114,7 @@ static void remove_credential(const char *fn, struct credential *c)
>>
>>  static int lookup_credential(const char *fn, struct credential *c)
>>  {
>> -     parse_credential_file(fn, c, print_entry, NULL);
>> -     return c->username && c->password;
>> +     return parse_credential_file(fn, c, print_entry, NULL);
>>  }
>
> I wondered if we were losing something here, as the return value from
> parse_credential_file is not the same as "did we find both a username
> and a password". But then I realized that the existing "return" line is
> nonsensical. The "c" variable here is our template of what to look for,
> not the return.
>
> I think this is leftover from an earlier iteration, where our callback
> filled in the values, rather than directly printing them. Nobody noticed
> because we didn't actually look at the return value of lookup_credential
> at all.
>
> So I think regardless of the end goal, it is nice to see this oddity
> cleaned up.

Haha, you just reminded me of that issue when I was coding. At first,
when I was rapidly prototyping the changes, I thought that
lookup_credential would return some kind of true/false value, but then
I realized it kept on returning the same value all the time ;) Thus, I
implemented the function signature change in parse_credential_file().
Totally forgot about it when posting the patch though.

>> +     if (!strcmp(op, "get")) {
>> +             if (file) {
>> +                     lookup_credential(file, &c);
>> +             } else {
>> +                     if (xdg_file && access_or_warn(xdg_file, R_OK, 0) == 0)
>> +                             ret = lookup_credential(xdg_file, &c);
>> +                     if (!ret && home_file && access_or_warn(home_file, R_OK, 0) == 0)
>> +                             lookup_credential(home_file, &c);
>> +             }
>> +     } else if (!strcmp(op, "erase")) {
>> +             if (file) {
>> +                     remove_credential(file, &c);
>> +             } else {
>> +                     if (xdg_file && access(xdg_file, F_OK) == 0)
>> +                             remove_credential(xdg_file, &c);
>> +                     if (home_file && access(home_file, F_OK) == 0)
>> +                             remove_credential(home_file, &c);
>> +             }
>
> The lookup rules here all look sane. Thanks for paying such attention
> to the details. Like Matthieu, I was unclear on the inconsistent use of
> access_or_warn.

I don't think the lookup rules are sane now ;) See above.

> If we can use the same access variant everywhere, I wonder if it would
> be more readable to hoist it into a function like:
>
>   int has_config_file(const char *file)
>   {
>         return file && access_or_warn(file, F_OK) == 0;
>   }
>
> It's a tiny function, but then your repetitious "if" statements drop
> some of the noise:
>
>   if (has_config_file(xdg_file))
>         ret = lookup_credential(xdg_file, &c);
>   if (!ret && has_config_file(home_file))
>         lookup_credential(home_file, &c);

Yes, refactoring is required.

>> +     } else if (!strcmp(op, "store")) {
>> +             if (file) {
>> +                     store_credential(file, &c);
>> +             } else if (xdg_file && access(xdg_file, F_OK) == 0) {
>> +                     store_credential(xdg_file, &c);
>> +                     if (home_file && access(home_file, F_OK) == 0 &&
>> +                         c.protocol && (c.host || c.path) && c.username
>> +                         && c.password)
>> +                             remove_credential(home_file, &c);
>
> I like that you take care not to lose information during the migration,
> but I really don't like that we have to replicate the "is this a
> fully-formed credential" logic. I think I'd rather just store the
> credential in the xdg_file, and leave it be in home_file. The lookup
> will prefer the xdg version, and if we ever issue an "erase" (e.g.,
> because the credential changes), it should remove both of them.

At first, I simply followed the existing behavior of
store_credential/parse_credential_file/credential_check as it will
remove duplicate credentials (matching on protocol, host, path,
username as keys). Now, however, I think that we should just write to
both the xdg and home files. See above.

Again, thanks everyone for taking time to review my code.

Regards,
Paul
