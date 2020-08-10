Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEECC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 03:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB04206C3
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 03:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgHJDMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:12:44 -0400
Received: from aibo.runbox.com ([91.220.196.211]:51960 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgHJDMo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 23:12:44 -0400
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1k4yEr-0007Rw-CC; Mon, 10 Aug 2020 05:12:41 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k4yEc-0003CG-7U; Mon, 10 Aug 2020 05:12:28 +0200
Date:   Mon, 10 Aug 2020 03:12:00 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
Message-ID: <20200810031123.GA3565@pluvano.com>
References: <20200808213457.13116-1-me@pluvano.com>
 <20200809230436.2152-1-me@pluvano.com>
 <CAPig+cT3aMUQapU7i0C3jZaLd2XJwP9SbxFEm_tG_1wj8w1PKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cT3aMUQapU7i0C3jZaLd2XJwP9SbxFEm_tG_1wj8w1PKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-09 20:49:59-0400, Eric Sunshine wrote:
> On Sun, Aug 9, 2020 at 7:06 PM Emma Brooks <me@pluvano.com> wrote:
> > Add an option to map names and emails to their canonical forms via a
> > .mailmap file. This is enabled by default, consistent with the behavior
> > of Git itself.
> >
> > Signed-off-by: Emma Brooks <me@pluvano.com>
> > ---
> > diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> > @@ -751,6 +751,11 @@ default font sizes or lineheights are changed (e.g. via adding extra
> > +mailmap::
> > +       Use mailmap to find the canonical name/email for
> > +       committers/authors (see linkgit:git-shortlog[1]). Enabled by
> > +       default.
> 
> Is this setting global or per-repository? (I ask because documentation
> for other options in this section document whether they can be set
> per-repository.)

Global. I'll add a note that it cannot be set per-project, or I could
add support for setting it per-project if that's wanted.

> Should there be any sort of support for functionality similar to the
> "mailmap.file" and "mailmap.blob" configuration options in Git itself?
> (Genuine question, not a demand for you to implement such support.)

Yes, that would be useful and should probably be supported.

> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > +# Contents of mailmap stored as a referance to a hash with keys in the format
> 
> s/referance/reference/

OK.

> > +# of "name <email>" or "<email>", and values that are hashes containing a
> > +# replacement "name" and/or "email". If set (even if empty) the mailmap has
> > +# already been read.
> > +my $mailmap;
> > +
> > +sub read_mailmap {
> > +       my %mailmap = ();
> > +       open my $fd, '-|', quote_command(
> > +               git_cmd(), 'cat-file', 'blob', 'HEAD:.mailmap') . ' 2> /dev/null'
> > +               or die_error(500, 'Failed to read mailmap');
> 
> Am I reading this correctly that this will die if the project does not
> have a .mailmap file? If so, that seems like harsh behavior since
> there are many projects in the wild lacking a .mailmap file.

No, this error message is misleading. The die_error is called if there
is a problem executing git cat-file, but not if cat-file returns an
error. I'll revise this message to be more accurate.

> > +       return \%mailmap if eof $fd;
> > +       foreach (split '\n', <$fd>) {
> 
> If the .mailmap has no content, then the 'foreach' loop won't be
> entered, which means the early 'return' above it is unneeded, correct?
> (Not necessarily asking for the early 'return' to be removed, but more
> a case of checking that I'm understanding the logic.)

The early return is intended to catch when there is no mailmap, so $fd
does not get initialized. Without it, you would get an error when you
try to split $fd's content:

    Use of uninitialized value $fd in split at [the foreach]

> > +               next if (/^#/);
> > +               if (/(.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) (?:\s+\#)/x ||
> > +                   /(.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>)/x) {
> > +                       # New Name <new@email> <old@email>
> > +                       # New Name <new@email> Old Name <old@email>
> 
> The first regex is intended to handle a trailing "# comment", whereas
> the second regex is for lines lacking a comment, correct? However,
> because neither of these expressions are anchored, the second regex
> will match both types of lines, thus the first regex is redundant. I'm
> guessing, therefore, that your intent was actually to anchor the
> expressions, perhaps like this:
> 
>     if (/^\s* (.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) (?:\s+\#)/x ||
>         /^\s* (.*)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) \s*$/x) {
> 
> Also, if you're matching lines of the form:
> 
>     name1 <email1> [optional-name] <email2>
> 
> in which you expect to see "name1", then is the loose "(.*)\s+"
> desirable? Shouldn't it be tighter "(.+)\s+"? For instance:
> 
>     if (/^\s* (.+)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) (?:\s+\#)/x ||
>         /^\s* (.+)\s+ <([^<>]+)>\s+ ((?:.*\s+)? <[^<>]+>) \s*$/x) {

Yes and yes. I'll update those.

> > +                       $mailmap{$3} = ();
> 
> I wonder if you should be doing some sort of whitespace normalization
> on $3 before using it as a hash key. For instance, if someone has a
> .mailmap that looks like this (where I've used "." to represent
> space):
> 
>     name1.<email1>.name2...<email2>
> 
> then $3 will have three spaces between 'name2' and '<email2>' when
> used as a key, and that won't match later when you construct a "name
> <email>" key later in map_author() with a single space.

Yes, I hadn't considered that case.

Thanks.
