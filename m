From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 06:28:18 -0400
Message-ID: <CAPig+cSNvXQTvhdU-9YTRa3M_BDPBB0jH87y-C16E+_Qqo_Lxg@mail.gmail.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
	<1373483041-27901-2-git-send-email-sunshine@sunshineco.com>
	<CALWbr2zJTBSptGsOr6tqrr4KcVd2GOWCkgy4GgdZ2+0Vz7DU4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 12:28:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxE6z-0002h3-M8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 12:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab3GKK2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 06:28:25 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:48474 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629Ab3GKK2X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 06:28:23 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so6637154lab.13
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=v/GuWvYfYA00s/Bb+p8xCs4ECgCwgrdrQNmRWbiQGsI=;
        b=RPeMfeKBLpFBrPVhtrjzJJMMuS5EmXjRgbsBT1E33hzkyGOtA34k3DDvCnPYi+7sOh
         kW6v871QVw+O7QmSODg8QZ3Y6VJSGlsb9GBb8zldDfqCMDAs+dd/ZRmrk/au6/tVzak9
         vIJJI1+4MOagzvJjPaIr2LN4sWQMXwy2x/O+vHXfS1+TPoP4sEJZ/mInQDZx1AWc13e8
         3+chsG7TDJp9Mvwih8d+4XAnEGJrxXIdr5dlKDEBbiMrZnh25oPkB2uV50gkCy+TRmf7
         WziLKM5ELm5Jw56UVvRZa+IJUFwvECqcTBgkckrx6jzGE3Sgjm/wD6J/hbIVS/eJ/L44
         nkpw==
X-Received: by 10.112.144.35 with SMTP id sj3mr17025984lbb.4.1373538498877;
 Thu, 11 Jul 2013 03:28:18 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 11 Jul 2013 03:28:18 -0700 (PDT)
In-Reply-To: <CALWbr2zJTBSptGsOr6tqrr4KcVd2GOWCkgy4GgdZ2+0Vz7DU4w@mail.gmail.com>
X-Google-Sender-Auth: siosZhV3e3sSfTnOF7GU1lZB7kE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230080>

On Thu, Jul 11, 2013 at 2:45 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Wed, Jul 10, 2013 at 9:03 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +static void check_mailmap(struct string_list *mailmap, const char *contact)
>> +{
>> +       const char *name, *mail;
>> +       size_t namelen, maillen;
>> +       struct ident_split ident;
>> +       char term = null_out ? '\0' : '\n';
>> +
>> +       if (split_ident_line(&ident, contact, strlen(contact)))
>> +               die(_("unable to parse contact: %s"), contact);
>> +
>> +       name = ident.name_begin;
>> +       namelen = ident.name_end - ident.name_begin;
>> +       mail = ident.mail_begin;
>> +       maillen = ident.mail_end - ident.mail_begin;
>> +
>> +       map_user(mailmap, &mail, &maillen, &name, &namelen);
>
> Would it be useful to check the return value of this function, to
> display a message when the name can't mapped ?

I thought about it but decided against the added complexity (at least
initially) for a few reasons.

There are only two callers in the existing code which even look at the
return value:

  % git grep 'map_user('
  builtin/blame.c: map_user(&mailmap, &mailbuf, &maillen,
  builtin/shortlog.c: map_user(&log->mailmap, &mailbuf, &maillen,
&namebuf, &namelen);
  pretty.c: map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
  pretty.c: return mail_map->nr && map_user(mail_map, email,
email_len, name, name_len);
  revision.c: if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {

Of those, mailmap_name() in pretty.c merely passes the return value
along to its callers, but its callers don't care about it:

  % git grep 'mailmap_name('
  pretty.c: mailmap_name(&mail, &maillen, &name, &namelen);

commit_rewrite_person() in revision.c uses the return value apparently
only as an optimization to decide if it should go through the effort
of replacing the "old" person with the re-mapped person, and then
passes the return value along to its callers, none of which care:

  % git grep 'commit_rewrite_person('
  revision.c: commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
  revision.c: commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);

The sort of optimization taken by commit_rewrite_person() is
effectively lost to script and porcelain clients of check-mailmap
since the cost of executing the command probably swamps any savings
the client might otherwise achieve by knowing whether the person was
remapped. Also, modulo possible whitespace changes, a client can
compare what it passed in to what is received back to determine if
remapping occurred.

As plumbing, the expectation is that most clients will pass a value in
and use the output without further interpretation. If check-mailmap
unconditionally adds some "mapped" or "not mapped" indicator to each
returned value, then that places extra burden on all clients by
forcing them to parse the result. Alternately, if the indicator is
controlled by a command-line option, then (at the least) that
increases documentation costs.

For people using check-mailmap as a .mailmap debugging aid, such an
indicator might indeed be useful, however, it seems prudent to keep
things simple initially by omitting the bells and whistles until
practical experience shows that more features (and complexity) are
warranted.

>> +       if (namelen)
>> +               printf("%.*s <%.*s>%c",
>> +                       (int)namelen, name, (int)maillen, mail, term);
>> +       else
>> +               printf("<%.*s>%c", (int)maillen, mail, term);
>> +}
