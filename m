From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Tue, 26 May 2015 15:10:03 -0400
Message-ID: <CAPig+cTaiZ_PVaGk6n_bsEqqTJEYEMSCWcnC0=MiN2Bf7L4sWw@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 21:10:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxKEs-0002Lj-GD
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 21:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbbEZTKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 15:10:06 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35572 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbEZTKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 15:10:04 -0400
Received: by iesa3 with SMTP id a3so99845147ies.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8W9eQYpMD7LKwUzoW4lLOaHhqMVL8sE6iP2LfpR/PNU=;
        b=BOq9eTKEdubIVSLSYMFDq7FNTxeIWwi5Otw7DkK+h0Eah0KVk0QBdTVaisOxcLkxHs
         DHSguoXZqZXWohU7yh2HHBJWsGOv50DN+ieAuX3SyXuvqy9RqLospv4xkOjOvQEhUNMx
         F3Pn0GHnhlyndlT7/Dq3CcZORTKC4FXQD2V6ENFcgHD2LxnGl3TTxlFKwRyQVbFQoMrM
         p1cMsK4jVL2BKHIYpPCcWlOgrfE8gbTBeHGFG2Q8qLchfMatoyy5SwCdijsum9aNFvks
         W+5B35wg7BzBtgwom7zsH3q/JSNp+RkW04Q9hkyyzGTSNvgoMUv813cbaUlYpHr8UOWq
         W64g==
X-Received: by 10.42.67.80 with SMTP id s16mr30921172ici.25.1432667403603;
 Tue, 26 May 2015 12:10:03 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 12:10:03 -0700 (PDT)
In-Reply-To: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
X-Google-Sender-Auth: lACi61D-TpEjQRt2B6kDVU3TAts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269965>

On Saturday, May 23, 2015, Allen Hubbe <allenbh@gmail.com> wrote:
> Note that this only adds support for a limited subset of the sendmail
> format.  The format is is as follows.
>
>         <alias>: <address|alias>[, <address|alias>...]
>
> Aliases are specified one per line, and must start on the first column of the
> line.  Blank lines are ignored.  If the first non whitespace character
> on a line is a '#' symbol, then the whole line is considered a comment,
> and is ignored.
> [...]
> Signed-off-by: Allen Hubbe <allenbh@gmail.com>
> ---
>
> Notes:
>     This v5 renames the parser 'sendmail' again, from 'simple'.
>     Therefore, the subject line is changed again, too.
>
>     Previous subject line: send-email: Add simple email aliases format
>
>     The format is restricted to a subset of sendmail.  When the subset
>     diverges from sendmail, the parser warns about the line that diverges,
>     and ignores the line.  The supported format is described in the
>     documentation, as well as the behavior when an unsupported format
>     construct is detected.
>
>     A badly constructed sentence was corrected in the documentation.
>
>     The test case was changed to use a here document, and the unsupported
>     comment after an alias was removed from the test case alias file input.

Thanks. This round looks much nicer. A few minor comments below...

> diff --git a/git-send-email.perl b/git-send-email.perl
> index e1e9b1460ced..ffea50094a48 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -487,6 +487,8 @@ sub split_addrs {
>  }
>
>  my %aliases;
> +
> +

Unnecessary whitespace change sneaked in.

>  my %parse_alias = (
>         # multiline formats can be supported in the future
>         mutt => sub { my $fh = shift; while (<$fh>) {
> @@ -516,6 +518,33 @@ my %parse_alias = (
>                           }
>                       } },
>
> +       sendmail => sub { my $fh = shift; while (<$fh>) {
> +               # ignore comment lines
> +               if (/^\s*(?:#.*)?$/) { }

This confused me at first because the comment talks only about
"comment lines", for which a simpler /^\s*#/ would suffice. The regex,
however, actually matches blank lines and comment lines (both of which
get skipped). Either the comment should be fixed or the regex could be
split into two much simpler ones. The splitting into simpler regex's
has the benefit of being easier to comprehend at a glance. For
instance:

    next if /^\s*$/;
    next if /^\s*#/;

Speaking of 'next', its use here is inconsistent. Due to use of the
if/elsif/else chain, 'next' is not needed at all, yet it is used for
some cases but not others. To be consistent, either use it everywhere
or nowhere.

> +               # warn on lines that contain quotes
> +               elsif (/"/) {
> +                       print STDERR "sendmail alias with quotes is not supported: $_\n";
> +                       next;
> +               }
> +
> +               # warn on lines that continue
> +               elsif (/^\s|\\$/) {
> +                       print STDERR "sendmail continuation line is not supported: $_\n";
> +                       next;
> +               }
> +
> +               # recognize lines that look like an alias
> +               elsif (/^(\S+)\s*:\s*(.+?)$/) {

Observation: Given "foo:bar:baz", this regex will take "foo:bar" as
the key, and "baz" as the value, which is probably not what was
intended, however, it likely doesn't matter much in this case since
colon isn't legal in an email address[1].

[1]: However, I could have sworn that colon was legal in some type of
email address years ago, but I can no longer remember which type it
was. UUCP used '!' in email addresses, so that wasn't it.

> +                       my ($alias, $addr) = ($1, $2);
> +                       $aliases{$alias} = [ split_addrs($addr) ];
> +               }
> +
> +               # warn on lines that are not recognized
> +               else {
> +                       print STDERR "sendmail line is not recognized: $_\n";
> +               }}},
> +
>         gnus => sub { my $fh = shift; while (<$fh>) {
>                 if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
>                         $aliases{$1} = [ $2 ];
