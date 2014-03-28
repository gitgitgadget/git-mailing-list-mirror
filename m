From: Victor Kartashov <victor.kartashov@gmail.com>
Subject: Re: [PATCH] gitweb: gpg signature status indication for commits
Date: Fri, 28 Mar 2014 23:14:51 +0400
Message-ID: <CAGfpA8RUaJKxEcqjpmBFeinefK=qu8sYuQHxRTg9ndFG_GJGEA@mail.gmail.com>
References: <1396000130-10322-1-git-send-email-v.kartashov@npo-echelon.ru>
 <xmqqfvm2b4h1.fsf@gitster.dls.corp.google.com> <CAGfpA8RWnX9DZtDiZ3Zf=8s+ga+DEmTbGDN0b7B0JM5_U4tAPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:15:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTcFf-00047a-6g
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaC1TPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 15:15:34 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:60094 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaC1TPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:15:34 -0400
Received: by mail-wi0-f176.google.com with SMTP id r20so1089685wiv.15
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sae6o1hy/iEPVWQEyGEjTTR6JvdVR3LeO+G452/pn14=;
        b=JUNJpc/P0HEM+vREqbkPlO2szRsrxLUK0qfpFQ3zSM2Z1sEG9jKAM/iAdtqobPV2sg
         KXVkTKG+IZu1acEKCi2NWp1OSJ2jwXIcrtGv2yeHW0TVGgxHAPnmBb5406sEmcVQX4nO
         deFlvlctTsZ2q+JNiecu9PHrY1eCJeTa7p/JjSQ+EFB5S1HdI9yYuuMNrwvy24a60GA2
         mgJUbO63/ly2406y42mN+7aAvcBTaMeVnT9oD1ZH7Ym1dDWyBKbryTuz/giUnXTQF5Bd
         EjkNwAp+cbv5yeR7N50AGmjOHBKzm9lYfsSnA1AQF0uvvnZ/Hd5l/JjHGIT3xsWeIkPO
         q6Ng==
X-Received: by 10.194.78.77 with SMTP id z13mr369107wjw.64.1396034132232; Fri,
 28 Mar 2014 12:15:32 -0700 (PDT)
Received: by 10.217.47.3 with HTTP; Fri, 28 Mar 2014 12:14:51 -0700 (PDT)
In-Reply-To: <CAGfpA8RWnX9DZtDiZ3Zf=8s+ga+DEmTbGDN0b7B0JM5_U4tAPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245419>

 On 28 March 2014 21:47, Junio C Hamano <gitster@pobox.com> wrote:
>
>
>    Teach gitweb to show GPG signature verification status when
>    showing a commit that is signed.  Highlight in green or red to
>    differentiate valid and invalid signatures.
>
> or something?


 Yes, kind of :)

> Is it a good idea to do this unconditionally in all repositories?


 Actually, I don't know. It's a question to discuss. This patch
doesn't affect commits without signature. And if there is a signature,
you robably would like to validate it.
 There is an option "remove_signoff" that, as I thought, would have an
effect on this. But I couldn't find where it's defined.

>
>
> This comment, which only says what it intends to do without saying
> why it wants to do so, does not explain why this is a good change.
>
> Does the code even know if $commit_lines[-1] is a non-empty string?
> Is it safe to assume if $commit_lines[-1] has a NUL anywhere, it is
> always the last line that ends the record, which is not part of the
> commit log message?
>
> I am assuming that this $commit_text is read from "log -z" (or
> "rev-list -z") output and split at NUL boundary, but if that is the
> case, it might be cleaner to remove the trailing NUL from $commit_text
> before even attempting to split it into an array at LFs, but that is
> an unrelated tangent.
>
> A bigger question is why does the incoming data sometimes ends with
> NUL that must be stripped out, and sometimes does not?  I see that
> you are updating the data producer in the later part of the patch;
> wouldn't it be saner if you have the data producer produce the input
> to this function in a way that is consistent with the current code,
> i.e. always terminate the output with a NUL?


 It seems to be a good idea. I'll try to do that.

> > @@ -3469,6 +3470,9 @@ sub parse_commit_text {
> >                               $co{'committer_name'} = $co{'committer'};
> >                       }
> >               }
> > +             elsif ($line =~ /^gpg: /) {
>
> I think Eric already pointed out the style issue on this line.
>
> > @@ -3508,6 +3512,10 @@ sub parse_commit_text {
> >       foreach my $line (@commit_lines) {
> >               $line =~ s/^    //;
> >       }
> > +     push(@commit_lines, "") if scalar @signature;
> > +     foreach my $sig (@signature) {
> > +             push(@commit_lines, $sig);
> > +     }
>
> Hmm, is it different from doing:
>
>         push @commit_lines, @signature;
>
> in some way?
>
> > @@ -4571,7 +4579,21 @@ sub git_print_log {
> >       # print log
> >       my $skip_blank_line = 0;
> >       foreach my $line (@$log) {
> > -             if ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
> > +             if ($line =~ m/^gpg:(.)+Good(.)+/) {
> > +                     if (! $opts{'-remove_signoff'}) {
>
> Sorry, but I fail to see what the "remove-signoff" option has to do
> with this new feature.  The interaction needs to be explained in the
> log message.


 I explained it above. From my point of view, one may want to remove
gpg signature and "sign-off" inscription together.
 Maybe, we should discuss this question, and after that I'll prepare new patch.

>
>
> > +                             print "<span class=\"good_sign\">" . esc_html($line) . "</span><br/>\n";
> > +                             $skip_blank_line = 1;
> > +                     }
> > +                     next;
> > +             }
> > +             elsif ($line =~ m/^gpg:(.)+BAD(.)+/) {
> > +                     if (! $opts{'-remove_signoff'}) {
> > +                             print "<span class=\"bad_sign\">" . esc_html($line) . "</span><br/>\n";
> > +                             $skip_blank_line = 1;
> > +                     }
> > +                     next;
> > +             }
> > +             elsif ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
> >                       if (! $opts{'-remove_signoff'}) {
> >                               print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
> >                               $skip_blank_line = 1;
> > diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> > index 3212601..e99e223 100644
> > --- a/gitweb/static/gitweb.css
> > +++ b/gitweb/static/gitweb.css
> > @@ -136,6 +136,17 @@ span.signoff {
> >       color: #888888;
> >  }
> >
> > +span.good_sign {
> > +     font-weight: bold;
> > +     background-color: #aaffaa;
> > +}
> > +
> > +span.bad_sign {
> > +     font-weight: bold;
> > +     background-color: #880000;
> > +     color: #ffffff
> > +}
> > +
> >  div.log_link {
> >       padding: 0px 8px;
> >       font-size: 70%;
