From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [RFC PATCH] commit: Warn about encodings unsupported by iconv.
Date: Tue, 21 Oct 2008 14:43:25 +0400
Message-ID: <bb6f213e0810210343l3fd36056m3d087fef4b134f14@mail.gmail.com>
References: <1224537918-14024-1-git-send-email-angavrilov@gmail.com>
	 <7vmygy233r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Paul Mackerras" <paulus@samba.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 12:44:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsEjE-0005QO-5e
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 12:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbYJUKnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 06:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbYJUKna
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 06:43:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:6013 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbYJUKn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 06:43:28 -0400
Received: by ey-out-2122.google.com with SMTP id 6so741386eyi.37
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1JEctPWz3oioGJSkODx8M/AmPOk059vcAgqXEFuBzeU=;
        b=OdLOyX2wlB0RELSR/bb7DEbhvQUOFw03X3K7mUd2/pTym0/6Q5uJVPQD2NJOQS/meU
         2Q4lSepcukbNYTnB51b5ZXdZT7x3XPOKdqIDkrdmjMfNMNBeuptJlg7lWPHO7EIsKzn3
         eVXC9/WSwe0lV9V4ITciEBlwUmjbfPL87wOSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SepRfST58sJXKUEjwpTKgIT/Tg+KH3/IZU/dNUA3zEecUYgVm9Uj1U2+vkrmmbuqEP
         mLuGwAK2tIp5QM+1jsxUnOaVU4b1lc/jbjqgvwWdWM42zdEQ+fQl49dkfovtIdwz2UgQ
         2A33P+w+nY21ujmzIfrU/mn6+RDTSzS9dMdwA=
Received: by 10.103.238.4 with SMTP id p4mr789252mur.114.1224585805801;
        Tue, 21 Oct 2008 03:43:25 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Tue, 21 Oct 2008 03:43:25 -0700 (PDT)
In-Reply-To: <7vmygy233r.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98772>

On Tue, Oct 21, 2008 at 4:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Alexander Gavrilov <angavrilov@gmail.com> writes:
>
>> diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
>> index 0453425..7f325a3 100644
>> --- a/builtin-commit-tree.c
>> +++ b/builtin-commit-tree.c
>> @@ -45,6 +45,28 @@ static const char commit_utf8_warn[] =
>>  "You may want to amend it after fixing the message, or set the config\n"
>>  "variable i18n.commitencoding to the encoding your project uses.\n";
>>
>> +static const char commit_bad_encoding_warn[] =
>> +"Warning: commit encoding '%s' is not supported.\n"
>> +"You may want to change the value of the i18n.commitencoding config\n"
>> +"variable, and redo the commit. Use 'iconv --list' to see the list of\n"
>> +"available encoding names.\n";
>> +
>> +static void verify_commit_encoding(const char *text, const char *encoding)
>> +{
>> +     if (is_encoding_utf8(encoding)) {
>> +             if (!is_utf8(text))
>> +                     fprintf(stderr, commit_utf8_warn);
>> +     }
>> +#ifndef NO_ICONV
>> +     else {
>> +             char *conv = reencode_string("", "utf-8", encoding);
>> +             if (!conv)
>> +                     fprintf(stderr, commit_bad_encoding_warn, encoding);
>> +             free(conv);
>> +     }
>> +#endif
>> +}
>> +

> It just marks it with the encoding header.  Wouldn't that mean that it
> should be possible for you to create a commit with its message encoded in
> KOI-8, and mark the resulting commit as encoded as such, on a host that is
> incapable of actually transcoding from KOI-8 to utf-8?  IOW, your being
> able to encode from i18n.commitencoding to utf-8 does not have much to do
> with the validity of the configuration variable.

It may be possible to check for reencode_string("", encoding,
encoding). IConv should be able to do the identity conversion for any
valid encoding. I checked with the iconv command-line executable on my
system, and it correctly errors out on invalid names, and agrees to do
the conversion for valid ones.

> It would clarify the issues to think about what this new code would do on
> a host without iconv, if you do not have the above #ifndef/#endif pair.
> The replacement reencode_string() implementation always returns NULL, so
> the code will always warn.
>
> I am guessing that the reason you added #ifndef/#endif is because what the
> warning message says is incorrect.
>
>  * "is not supported" is not correct.  "is not supported HERE" may be.
>
>  * "is not supported" (nor "is not supported HERE") does not matter.  It
>   is log-reading side that does the re-encoding, not the commit
>   generating side.

The trouble is, by the time it gets to the "log-reading" side, it may
be too late to do anything, because the commits have already been
created, hashed and pushed out somewhere. And the originating side
won't notice because they would actually expect to get the messages
without conversion from their git-log. It may be amended somewhat if
gitk insists on receiving all data from git-log in utf-8 unless
explicitly told otherwise; on the other hand it may make people think
that the problem is in gitk...

>  * what you would really want to say is "might be incorrectly spelled",
>   but your problem is that you do not have a direct way to check that.
>
> Another reason of your "#ifndef/#endif" would be that there is no way to
> squelch the warning message after seeing it on a NO_ICONV platform.
>
> But that suggests that the "#ifndef/#endif" is not a good way to squelch
> the message.  What would you do, after seeing the warning message and
> examining the situation, you know KOI-8 is a valid encoding name, your
> editor is recording what you type in the commit log message in KOI-8, you
> know you set i18n.commitencoding to KOI-8, and you know somehow your
> system is incapable of reencode_string("", "utf-8" "KOI-8")?  There is no
> way to squelch the message.

A bit of a problem is that unless git implements its own encoding
alias table, the only authority on valid encoding names is iconv. So
checking would still involve running reencode_string, or looking at
iconv --list, possibly on another machine.

> So perhaps you would need some "state" variable that says "I know this
> i18n.commitencoding configuration is valid" if you go this route?  But the
> reason for "I know" would be either (1) because we earlier tried
> reencode_string() and it resulted in an Ok return, or (2) because the user
> verified that the configuration is valid, even though on this particular
> system it cannot be encoded to utf-8.  IOW, the latter one would be
> "because the user tells us so" --- which would be the same as trusting
> i18n.commitencoding from the beginning.  I dunno.

Maybe if the option is called something like i18n.brokenIconv, people
would understand that it should not be enabled in normal
circumstances? It can also be used to tell GUI tools that git-log
cannot be trusted to do the conversion properly -- perhaps being
enabled system-wide by make install if NO_ICONV is set.

> I actually have an alternative approach to suggest.
>
> How about adding a new i18n.commit-reencode-logmessage option (boolean),
> and when it is set, we actually re-encode from i18n.commitencoding to
> "utf-8" before creating the commit object (and obviously we do not store
> "encoding" header in the resulting commit)?  When the conversion fails, we
> know it failed, so the warning you added does make sense in that context.

This option changes the way data is actually processed before storing,
so it probably cannot be turned on by default -- while the check is
nearly useless _unless_ it is turned on by default.

Alexander
