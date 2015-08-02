From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sun, 2 Aug 2015 05:41:29 -0400
Message-ID: <CAPig+cQwgYYYYsszaRdJDwFLLB0PmiDQ_WTa+Nzzoq0U1zuMiA@mail.gmail.com>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
	<20150801201950.5d8c1951@jvn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 11:41:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLplv-0007M2-KA
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 11:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbbHBJlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 05:41:31 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36301 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbbHBJla (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 05:41:30 -0400
Received: by ykeb10 with SMTP id b10so9932286yke.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uPspAaif66J7a+tQW0ZFCjcR7czyxsmXPavKtXB3E7c=;
        b=WBJS7dFZJmNFRKeCruE/pET5JBwZnwBqXuvd3eKp//Nlk6CWesEHfQCNGNTwBXK1s5
         3ZaeidMX7iLYhisbQihtTN4XAk02jTMxBjg13BuBqD2jlwChfpJ4b2cUvVX9zyyGW9Ls
         Eo5Gve2Gjqg07VvFLnSk6aUWbZYbUCkGNbAeaiH+O+AXYpFF46WfJT5Q6FUJvuBZ+Jii
         aTfgOlMyl3bARjqaK2OkNa97ZFxx6KgKVeN+wjhsTW7APHc/EC5qkmXjAsXj5iyRFSFj
         lYg1exL+7AbV/8TSdyeM2fnwRZSLHnmEj+ruy87MFwGMmTx1P1Ivq2whMx602Jc0DIHt
         Rjeg==
X-Received: by 10.129.91.87 with SMTP id p84mr14211067ywb.95.1438508489462;
 Sun, 02 Aug 2015 02:41:29 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 2 Aug 2015 02:41:29 -0700 (PDT)
In-Reply-To: <20150801201950.5d8c1951@jvn>
X-Google-Sender-Auth: qJ7mtx1DsQBzsUVqxZMxqVaxWBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275132>

On Sat, Aug 1, 2015 at 2:19 PM, Jan Viktorin <viktorin@rehivetech.com> wrote:
> On Sat, 1 Aug 2015 05:33:28 -0400 Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, Jul 31, 2015 at 7:33 PM, Jan Viktorin
>> <viktorin@rehivetech.com> wrote:
>> At the very least, you will also want to update the documentation
>> (Documentation/git-send-email.txt) and, if possible, add new tests
>> (t/t9001-send-email.sh).
>
> I will update the documentation when it is clear, how the smtp-auth
> works.
>
> I have no idea, how to test the feature. I can see something like
> fake.sendmail in the file. How does it work? I can image a test whether
> user inserts valid values. What more?

That's what I was thinking. You could test if the die() is triggered
or if it emits warnings for bad values (assuming you implement that
feature). As for testing the actual authentication, I'm not sure you
can (and don't see any such testing in the script).

>> > diff --git a/git-send-email.perl b/git-send-email.perl
>> > index ae9f869..b00ed9d 100755
>> > --- a/git-send-email.perl
>> > +++ b/git-send-email.perl
>> > @@ -1129,6 +1134,16 @@ sub smtp_auth_maybe {
>> >                 return 1;
>> >         }
>> >
>> > +       # Do not allow arbitrary strings.
>>
>> Can you explain why this restriction is needed. What are the
>> consequences of not limiting the input to this "approved" list?
>
> This is more a check of an arbitrary user input then a check
> of an "approved list". It should be also used to inform user
> about invalid methods (however, I didn't implemented it yet).

What I was really asking was whether this sort of checking really
belongs in git-send-email or if it is better left to Net::SMTP (and
Authen::SASL) to do so since they are in better positions to know what
is valid and what is not. If the Perl module(s) generate suitable
diagnostics for bad input, then it makes sense to leave the checking
to them. If not, then I can understand your motivation for
git-send-email doing the checking instead in order to emit
user-friendly diagnostics.

So, that's what I meant when I asked 'What are the consequences of not
limiting the input to this "approved" list?'.

The other reason I asked was that it increases maintenance costs for
us to maintain a list of "approved" mechanisms, since the list needs
to be updated when new ones are implemented (and, as brian pointed
out, some may already exist which are not in your list).

>> > +                       $filtered_auth .= $_ . " ";
>>
>> Style question: Would this be more naturally expressed with
>> 'filtered_auth' as an array onto which items are pushed, rather than
>> as a string? At the point of use, the string can be recreated via
>> join().
>>
>> Not a big deal; just wondering.
>
> I am not a Perl programmer. Yesterday, I've discovered for the first
> time that Perl uses a dot for concatenation... I have no idea what
> happens when passing an array to Authen::SASL->new(). Moreover, the
> Perl arrays syntax rules scare me a bit ;).

You wouldn't pass the array to Authen::SASL, instead you would use
join() to transform the array back into a space-separated string. It's
probably moot (since you probably shouldn't be doing the filtering
manually), but the code would look something like this:

    my @filtered_auth;
    ...
    foreach (...) {
        if (...) {
            push @filtered_auth, $_;
        }
    }
    ...
    if (@filtered_auth) {
        my $sasl = Authen::SASL->new(
            mechanism => join(' ', @filtered_auth),
            ...

>> Style: add "\n" at end in order to suppress printing of the
>>     perl line number and input line number which aren't
>>     very meaningful for a user error
>
> Another hidden Perl suprise, I guess...

Yes.

>> Also, don't you want to warn the user about tokens that don't match
>> one of the accepted (PLAIN, LOGIN, CRAM-MD5, DIGEST-MD5), rather than
>> dropping them silently?
>
> Yes, this would be great (as I've already mentioned). It's a question
> whether to include the check for the mechanisms or whether to leave
> the $smtp_auth variable as it is... Maybe just validate by a regex?
>
> The naming rules are defiend here:
>  https://tools.ietf.org/html/rfc4422#page-8
> So, this looks to me as a better way.

Maybe. This leads back to my original question of whether it's really
git-send-email's responsibility to do validation or if that can be
left to Net::SMTP/Authen::SASL. If the Perl module(s) emit suitable
diagnostics for bad input, then validation can be omitted from
git-send-email.
