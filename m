From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: Add sendmail aliases support
Date: Thu, 21 May 2015 16:48:15 -0400
Message-ID: <CAJ80satMSCGydLRb5k=xpSqxXSBL=_T7nsHEz3jsuFV9MdmmtA@mail.gmail.com>
References: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
	<xmqqioblisyk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 22:48:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvXOG-0005ch-SR
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbbEUUsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:48:19 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37141 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399AbbEUUsR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 16:48:17 -0400
Received: by wibt6 with SMTP id t6so27014365wib.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mMXh+Mnd8JaNzwhnGJ4hyhPxLebsqJz/MnS/6qGMpG4=;
        b=C3iVW9VTE55WqEahsMC6C8u9SAw3AGVjuF2gsZknLJ0gOPQO2lpd60zbNo+Xzl9Euu
         XKkxBUykUx2NSe/sY0pioDE20CIDHGfZDGbdFKVM7jFxc6bN4bRf9D/2rXpyPUtu7jT0
         p+zDAKOUH/XDYpDNfCLOIGY7OmqQP6pl11M/LVBBQKYOavHrhySjAql3SPPkzr6/iLW1
         6wwHNNWe9Ki1zIBGPGkuioxoQsh4aoZVeoypF/6dDA9/qWWk3pJUjSSFKotV8F6Fk0LN
         0oCKEIiCox3sjfCwcGuxfDiVGpiTDJD2+oHGKxy2dxPtltjq5Lr+XGZ8MFkJyDSHyh7/
         3ZYQ==
X-Received: by 10.180.74.144 with SMTP id t16mr992970wiv.33.1432241295881;
 Thu, 21 May 2015 13:48:15 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Thu, 21 May 2015 13:48:15 -0700 (PDT)
In-Reply-To: <xmqqioblisyk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269659>

On Thu, May 21, 2015 at 4:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Allen Hubbe <allenbh@gmail.com> writes:
>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index e1e9b14..5f2ec0d 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -515,7 +515,12 @@ my %parse_alias = (
>>                              $aliases{$alias} = [ split_addrs($addr) ];
>>                         }
>>                     } },
>> -
>> +     sendmail => sub { my $fh = shift; while (<$fh>) {
>> +             next if /^$|^#|^\s/;
>> +             if (/^(\S+)\s*:\s*(.*?)\\?$/) {
>> +                     my ($alias, $addr) = ($1, $2);
>> +                     $aliases{$alias} = [ split_addrs($addr) ];
>> +             }}},
>
> Let me unfold the line only to make commenting it easier.
>
>         sendmail => sub {
>                 my $fh = shift;
>                 while (<$fh>) {
>                         next if /^$|^#|^\s/;
>                         if (/^(\S+)\s*:\s*(.*?)\\?$/) {
>                                 my ($alias, $addr) = ($1, $2);
>                                 $aliases{$alias} = [ split_addrs($addr) ];
>                         }
>                 }
>         },
>
> It is probably OK to omit support for folded lines, but wouldn't it
> be easy enough to be a bit more helpful to give a warning when you
> find such lines in the input?  Otherwise you will leave the users
> wondering why some of their aliases work while others don't.

The diff doesn't show enough context to include this comment:

my %parse_alias = (
        # multiline formats can be supported in the future
...

I can't be sure the author's intent, but my interpretation is such.
The parsers do not support multiline, even though the format might
allow it by definition.  Another interpretation could be, no multiline
formats allowed, or, the first person to add a multiline format should
remove this comment.

I think the first interpretation is correct, because according to this
script, the mutt format also has continuation lines.  I didn't find a
more authoritative document in my quick search.

http://www.wizzu.com/mutt/checkalias.pl

I suppose at this point it is also worth mentioning that /etc/aliases
doesn't claim to support aliases of aliases, but does support
non-email-addresses like mail directories and pipes.  I don't think
most git users would try to send email directly to a pipe.

My motivation for this patch was not really to support the sendmail
aliases file directly.  The commit message may therefore be
misleading.  So, I could also rewrite the commit message to say
something like, "loosely based on" the sendmail aliases format, if the
exceptions to the format in the current message are not enough.
Really, I just prefer the simpler <alias>: <email|alias> syntax
instead of the ones for mutt, elm, etc, and that is why I wrote this
patch.

>
> Perhaps like this (this is not even an output from "diff" but typed
> in my MUA, so there may be typos---take it just as illustrating
> ideas)?
>
> That way, users can fold the input themselves and try again if they
> wanted to.  The warning _may_ have to be squelched after a few hits
> to keep the result usable, though.
>
>         sendmail => sub {
>                 my $fh = shift;
>                 while (<$fh>) {
> -                       next if /^$|^#|^\s/;
> -                       if (/^(\S+)\s*:\s*(.*?)\\?$/) {
> +                       next if /^$|^#/;
> +                       if (/^\s/ || /\\$/) {
> +                               print STDERR "$.: $_";
> +                               print STDERR "continuation lines in alias not supported\n";
> +                               next;
> +                       }
> +                       if (/^(\S+)\s*:\s*(.*)$/) {
>                                 my ($alias, $addr) = ($1, $2);
>                                 $aliases{$alias} = [ split_addrs($addr) ];
>                         }
>                 }
>         },

That's interesting.  I'd like to hear a second opinion before I add
that.  It's a good idea, but none of the other parsing routines print
out messages.

>
> Thanks.
