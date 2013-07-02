From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 1/4] contrib: add git-contacts helper
Date: Tue, 2 Jul 2013 04:17:14 -0400
Message-ID: <CAPig+cRbBGqrXj-Anib1ESdBBbdUGM-9um4XoPcwG2QxJBubuA@mail.gmail.com>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<1372590512-21341-2-git-send-email-sunshine@sunshineco.com>
	<7vbo6mgm5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 10:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utvm7-0005of-HW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 10:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab3GBIRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 04:17:18 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:56132 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab3GBIRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 04:17:14 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so10799639iet.23
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=6MTjBAkUFW+8+ZlxezTp7u7J+6Pg4ClKe1ashQI/xx8=;
        b=YwBkiWVwQGcjU/6+KO4noWAKrw2F0zcItJHdb1SY80YPf+qJvnQrlGeoDcp64GAG8H
         MjCAop8D7xyDr1pb8IuSmml/MPYFF4fK1reDikPJJkNM7xBrc45OtMmculJvne2ovBN1
         Cd6Z0hhSwFnQgSspvHN3fhehPiyrmSJTklvjkiOga2MvqEMmvWOb3h5CTugiVJ4IpAfE
         sKk/PT8DZv8lchA2qTWIJChljA4Yor+P+EgNSd3NTB8LRvW6YKl161nvLR7Z0U3u0y+h
         FAG5L3GAnCVyz6LzH2cuhNUnNMzUZHLhj7MDhbc93EPMWRVkXOLWZddg3b1KH/BVYhkV
         uKRg==
X-Received: by 10.50.47.46 with SMTP id a14mr5496391ign.46.1372753034255; Tue,
 02 Jul 2013 01:17:14 -0700 (PDT)
Received: by 10.64.86.164 with HTTP; Tue, 2 Jul 2013 01:17:14 -0700 (PDT)
In-Reply-To: <7vbo6mgm5e.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: WCmuKQhTShY-nhaavQNT8MKFxJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229375>

On Mon, Jul 1, 2013 at 2:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
>> new file mode 100755
>> index 0000000..9007bae
>> --- /dev/null
>> +++ b/contrib/contacts/git-contacts
>> @@ -0,0 +1,121 @@
>> +#!/usr/bin/perl
>> +
>> +# List people who might be interested in a patch.  Useful as the argument to
>> +# git-send-email --cc-cmd option, and in other situations.
>> +#
>> +# Usage: git contacts <file>
>> +
>> +use strict;
>> +use warnings;
>> +use IPC::Open2;
>> +
>> +my $since = '5-years-ago';
>> +my $min_percent = 10;
>> +my $labels_rx = qr/(?:Signed-off|Reviewed|Acked)-by/;
>
> Although I personally do not see particuarly a good reason to do so,
> I have seen people add "Cc:" on the footers, and I suspect they may
> expect them to be also picked up as "relevant parties" to the
> change.  Also S-o-b is often misspelled as "Signed-Off-By", so you
> may want to do qr//i this one.

I originally used /i but bogusly discarded it due to too narrow
thinking. Will re-add.

Agreed about adding Cc:.

>> +my $id_rx = qr/[0-9a-f]{40}/i;
>
> On the other hand, we always mark the "this is a format-patch
> output" marker lines with lowercase hex, so you would want to lose
> 'i' from here.

Indeed, all the SHA-1's matched by $id_rx in the script are
git-generated and thus lowercase hex. Will change.

> And you probably want to tighten it even more, perhaps
> like so:
>
>         qr/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/
>
> Of course, you wuold need to have a separate regular expression to
> parse "git blame --incremental/--porcelain" output that may read
> perhaps like so:
>
>         qr/^([0-9a-f]{40})[ *](\d) (\d) (\d)$/
>
> to pick up only the group header.  The last \d is the number of
> lines that came from this guilty party, and it might become useful
> if we want to give weight to people based on line-count, not just
> number of commits.

Can do.

>> +sub format_contact {
>> +     my ($name, $email) = @_;
>> +     return "$name <$email>";
>> +}
>> +
>> +sub parse_commit {
>> +     my ($commit, $data) = @_;
>> +     my $contacts = $commit->{contacts};
>> +     my $inbody = 0;
>> +     for (split(/^/m, $data)) {
>> +             if (not $inbody) {
>> +                     if (/^author ([^<>]+) <(\S+)> .+$/) {
>> +                             $contacts->{format_contact($1, $2)} = 1;
>
> The author name and email can be grabbed from the "blame" output
> without doing this (and the result may be more robust), but you
> would need to read from the log message anyway, so I think this is
> OK.
>
> Note that the names and emails in blame output are sanitized via the
> mailmap mechanism, but "cat-file commit" will certainly not be.

Thanks for pointing this out. Grabbing the author name and email from
git-blame output does seem like a better approach.

> You may have to do the mapping yourself by reading the mailmap for
> the names and addresses you read from S-o-b: and friends.

Felipe did introduce mailmap support in v4 but dropped it at about v6.
It seems worthwhile, but I first wanted to duplicate the basic
functionality of his v9, and figured that mailmap support could be
added in a follow-up patch.

v4: http://article.gmane.org/gmane.comp.version-control.git/222439/
v6: http://thread.gmane.org/gmane.comp.version-control.git/224896/

>> +sub import_commits {
>> +     my ($commits) = @_;
>> +     return unless %$commits;
>> +     my $pid = open2 my $reader, my $writer, qw(git cat-file --batch);
>
> Hmph.
>
> I vaguely recall that people wanted not to use open2/IPC::Open2 in
> other parts of the system.
>
> I think "cat-file --batch" is designed to behave on a regular bidi
> pipe, as long as the caller strictly does a ping-pong of issuing one
> request, flush (with an empty line) and always read the response, so
> if open2 becomes problematic, we could switch to regular pipes.

Checking the log, I see several cases where deprecated Python popen2
was removed but find nothing mentioning Perl. Git.pm,
git-archimport.perl and git-cvsimport.perl appear to use open2.
Switching to pipes is certainly an option.

>> +sub get_blame {
>> +     my ($commits, $source, $start, $len, $from) = @_;
>> +     $len = 1 unless defined($len);
>> +     return if $len == 0;
>> +     open my $f, '-|',
>> +             qw(git blame --incremental -C -C), '-L', "$start,+$len",
>> +             '--since', $since, "$from^", '--', $source or die;
>
> "--incremental" is meant for consumers that wants better latency,
> not necessarily better throughput, but I think this consumer does
> not present incremental result to the end user, so perhaps you would
> want to use "--porcelain" instead.

This use of --incremental was copied literally from Felipe's v9, but
after reading git-blame documentation, I agree that --porcelain makes
sense.

>> +sub scan_hunks {
>> +     my ($commits, $id, $f) = @_;
>> +     my $source;
>> +     while (<$f>) {
>> +             if (/^---\s+(\S+)/) {
>
> I wonder what happens to a patch that touches a file with SP in its
> path with this regular expression.  As it is fairly clear that you
> are reading from format-patch output (the caller does not call this
> function if it did not see $id), perhaps you can tighten the prefix
> a bit more?  I.e. something like:
>
>         if (/^--- (.*)$/)

Good idea.

>> +             } elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {
>
> (mental note) For each hunk of a patch that is not a creation patch,
> find the origin of the preimage.
>
>> +                     get_blame($commits, $source, $1, $2, $id);
>> +             }
>
> An major issue (*) and a few minor issues (-) from the above
> observations:
>
>  * A single patch may touch two or more paths.  If the first one is
>    to modify an existing file, its path is assigned to $source.
>    Now, imagine that the second one is a creation patch.  $source is
>    not set to undef but is kept, and the code ends up trying to run
>    blame on the first path with the range for the second path.
>
>    Oops?
>
>    This is one of the reasons why we shouldn't use statement
>    modifiers lightly.  I think the above should be more like:
>
>         if (/^--- (.*)$) {
>                 $source = ($1 eq '/dev/null') ? undef : substr($1, 2);
>         } elsif ...

This error is entirely mine. Felipe's script did it correctly.

>  - If the patch were prepared with a non-standard src/dst-prefix,
>    unconditional substr($1, 2) would call blame on a wrong (and
>    likely to be nonexistent) path without a useful diagnosis (the
>    invocation of "git blame" will likely die with "no such path
>    'tailofpathname' in $id").
>
>    One way to make it more robust may be to do something like this:
>
>         if (/^--- /) {
>                 if (m{^--- (?:a/(.*)|/dev/null)$}) {
>                         $source = ($1 eq '/dev/null') ? undef : $1;
>                 } else {
>                         die "Cannot parse the patch file:$_";
>                 }
>         } elsif ...

The substr($1, 2) also bothered me, but I didn't immediately see a
good solution. Aborting, as you suggest, seems reasonable.

>  - Often a single patch touches more than one ranges in the same
>    path.  Depending on the size of the patch, it might be more
>    efficient to run a single blame for a range that covers all the
>    lines the patch touches while discarding irrelevant parts.  A
>    longer term improvement may be to extend "git blame" so that it
>    can take more than one "-L n,m" ranges, but I think that is
>    outside of the scope of this patch.

Sounds like a potentially good optimization for a future patch, though
it's not clear what heuristic to use to decide when to combine the
ranges for a single git-blame run. Extending git-blame to recognize
multiple -L sounds even better, though definitely outside the scope of
this series.
