From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Tue, 26 May 2015 15:41:35 -0400
Message-ID: <CAJ80sasp6kNgbJJw-2TzZnPPDVgYdAwwsdh=hNH4xxu1TBtiyA@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<CAPig+cTaiZ_PVaGk6n_bsEqqTJEYEMSCWcnC0=MiN2Bf7L4sWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 26 21:41:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxKjO-0008Db-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 21:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbbEZTlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 15:41:37 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33764 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbbEZTlh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 15:41:37 -0400
Received: by wicmx19 with SMTP id mx19so74475867wic.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OHFQzH2D1/CI271zH1TYZ5TNKEwqub9tXmMPCFBio20=;
        b=P1LV9gKXP0XxvBmIliagZUPtRbFshJJ/hk4hHlLIR4mnbBEB/Es3yAf/6s3Y/8b4g/
         D4CzhtThu0v27IWI4IaILwoPmM3+Q5JXaRq/x/3UCjtB/fwuBxid11QRlhWpnljZozil
         YL1DaHu5pWdtOn/Tl79j26+vObXY89PpKC9pDyPj3yJEY5XAN1kCxFm+CgMJEXCNpu5q
         +qEhpXjRdYVlbYl6n5UZKFhVA5z/OwRyJbSvDGOkyCkCkmc/uMBWbM4NuIl2pLPOunal
         jKyc/YA2LKGU0fJtkRXTN1QCanxcePcnzK4X32d4tm7xaRq+zy4G7FDQeHGlK29wtQ5k
         JBxA==
X-Received: by 10.195.11.168 with SMTP id ej8mr35626646wjd.150.1432669295851;
 Tue, 26 May 2015 12:41:35 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Tue, 26 May 2015 12:41:35 -0700 (PDT)
In-Reply-To: <CAPig+cTaiZ_PVaGk6n_bsEqqTJEYEMSCWcnC0=MiN2Bf7L4sWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269967>

On Tue, May 26, 2015 at 3:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Saturday, May 23, 2015, Allen Hubbe <allenbh@gmail.com> wrote:
>> Note that this only adds support for a limited subset of the sendmail
>> format.  The format is is as follows.
>>
>>         <alias>: <address|alias>[, <address|alias>...]
>>
>> Aliases are specified one per line, and must start on the first column of the
>> line.  Blank lines are ignored.  If the first non whitespace character
>> on a line is a '#' symbol, then the whole line is considered a comment,
>> and is ignored.
>> [...]
>> Signed-off-by: Allen Hubbe <allenbh@gmail.com>
>> ---
>>
>> Notes:
>>     This v5 renames the parser 'sendmail' again, from 'simple'.
>>     Therefore, the subject line is changed again, too.
>>
>>     Previous subject line: send-email: Add simple email aliases format
>>
>>     The format is restricted to a subset of sendmail.  When the subset
>>     diverges from sendmail, the parser warns about the line that diverges,
>>     and ignores the line.  The supported format is described in the
>>     documentation, as well as the behavior when an unsupported format
>>     construct is detected.
>>
>>     A badly constructed sentence was corrected in the documentation.
>>
>>     The test case was changed to use a here document, and the unsupported
>>     comment after an alias was removed from the test case alias file input.
>
> Thanks. This round looks much nicer. A few minor comments below...
>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index e1e9b1460ced..ffea50094a48 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -487,6 +487,8 @@ sub split_addrs {
>>  }
>>
>>  my %aliases;
>> +
>> +
>
> Unnecessary whitespace change sneaked in.
>
>>  my %parse_alias = (
>>         # multiline formats can be supported in the future
>>         mutt => sub { my $fh = shift; while (<$fh>) {
>> @@ -516,6 +518,33 @@ my %parse_alias = (
>>                           }
>>                       } },
>>
>> +       sendmail => sub { my $fh = shift; while (<$fh>) {
>> +               # ignore comment lines
>> +               if (/^\s*(?:#.*)?$/) { }
>
> This confused me at first because the comment talks only about
> "comment lines", for which a simpler /^\s*#/ would suffice. The regex,
> however, actually matches blank lines and comment lines (both of which
> get skipped). Either the comment should be fixed or the regex could be
> split into two much simpler ones. The splitting into simpler regex's
> has the benefit of being easier to comprehend at a glance. For
> instance:
>
>     next if /^\s*$/;
>     next if /^\s*#/;

I noticed this too after sending the patch, and I have already changed
the comment to mention blank lines or comment lines.

Splitting the regex would be more simple, but the regex is already
quite simple as it is.

>
> Speaking of 'next', its use here is inconsistent. Due to use of the
> if/elsif/else chain, 'next' is not needed at all, yet it is used for
> some cases but not others. To be consistent, either use it everywhere
> or nowhere.

These used to be `if (foo) { somthing; next; }` while this version was
work in progress, which I changed to elsif with the intention of
removing the next.  Thanks for catching the inconsistency.  I will
remove the next.

>
>> +               # warn on lines that contain quotes
>> +               elsif (/"/) {
>> +                       print STDERR "sendmail alias with quotes is not supported: $_\n";
>> +                       next;
>> +               }
>> +
>> +               # warn on lines that continue
>> +               elsif (/^\s|\\$/) {
>> +                       print STDERR "sendmail continuation line is not supported: $_\n";
>> +                       next;
>> +               }
>> +
>> +               # recognize lines that look like an alias
>> +               elsif (/^(\S+)\s*:\s*(.+?)$/) {
>
> Observation: Given "foo:bar:baz", this regex will take "foo:bar" as
> the key, and "baz" as the value, which is probably not what was
> intended, however, it likely doesn't matter much in this case since
> colon isn't legal in an email address[1].

That's a keen observation.  I think it would work simply to use a
non-greedy +? in the first capture group.

>
> [1]: However, I could have sworn that colon was legal in some type of
> email address years ago, but I can no longer remember which type it
> was. UUCP used '!' in email addresses, so that wasn't it.
>
>> +                       my ($alias, $addr) = ($1, $2);
>> +                       $aliases{$alias} = [ split_addrs($addr) ];
>> +               }
>> +
>> +               # warn on lines that are not recognized
>> +               else {
>> +                       print STDERR "sendmail line is not recognized: $_\n";
>> +               }}},
>> +
>>         gnus => sub { my $fh = shift; while (<$fh>) {
>>                 if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
>>                         $aliases{$1} = [ $2 ];
