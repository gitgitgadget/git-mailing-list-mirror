From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/4] contrib: add git-contacts helper
Date: Mon, 01 Jul 2013 11:39:25 -0700
Message-ID: <7vbo6mgm5e.fsf@alter.siamese.dyndns.org>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<1372590512-21341-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 20:39:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utj0f-0007sa-Iv
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 20:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab3GASj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 14:39:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65189 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754752Ab3GASj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 14:39:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA7482D2FE;
	Mon,  1 Jul 2013 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90BuVgnVGvy3DFNq3xaOyOlXLsc=; b=BNikez
	bj4bxdxq3O4/lI8iDvPUAdSOR7RZOcUA33BDTaN1b7+In2gIdcrWbY6/CJuy24CG
	uiTAZ0qQyNp/sCTOPTXFMR4z8BOKZMJCjhsESVlWmFQgqyIUoPtBJmkuHnr+IbBp
	o+YxWV4Rj36AIZJBYYb8EfvZGbvspycFxZrcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gbD0BQrQWwcALT15qf0Fxw1b6hpf42o3
	mcg02jf5HeiigIlAl2GgVDH+Ch6uekpVJOmLaEA3esNfGN4u8PI2+99KKzMphxRn
	DRZKEHxTLERkesKDW8U6u7JlN+/MEEgcJHgfWUAbCz2J4k4e9w7yJETU/bSJKIOH
	ttRa5tAUJKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0A522D2FD;
	Mon,  1 Jul 2013 18:39:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD01B2D2FC;
	Mon,  1 Jul 2013 18:39:26 +0000 (UTC)
In-Reply-To: <1372590512-21341-2-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 30 Jun 2013 07:08:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8EB96108-E27D-11E2-9A3A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229317>

Eric Sunshine <sunshine@sunshineco.com> writes:

> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
> new file mode 100755
> index 0000000..9007bae
> --- /dev/null
> +++ b/contrib/contacts/git-contacts
> @@ -0,0 +1,121 @@
> +#!/usr/bin/perl
> +
> +# List people who might be interested in a patch.  Useful as the argument to
> +# git-send-email --cc-cmd option, and in other situations.
> +#
> +# Usage: git contacts <file>
> +
> +use strict;
> +use warnings;
> +use IPC::Open2;
> +
> +my $since = '5-years-ago';
> +my $min_percent = 10;
> +my $labels_rx = qr/(?:Signed-off|Reviewed|Acked)-by/;

Although I personally do not see particuarly a good reason to do so,
I have seen people add "Cc:" on the footers, and I suspect they may
expect them to be also picked up as "relevant parties" to the
change.  Also S-o-b is often misspelled as "Signed-Off-By", so you
may want to do qr//i this one.

> +my $id_rx = qr/[0-9a-f]{40}/i;

On the other hand, we always mark the "this is a format-patch
output" marker lines with lowercase hex, so you would want to lose
'i' from here.

And you probably want to tighten it even more, perhaps
like so:

	qr/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/

Of course, you wuold need to have a separate regular expression to
parse "git blame --incremental/--porcelain" output that may read
perhaps like so:

	qr/^([0-9a-f]{40})[ *](\d) (\d) (\d)$/

to pick up only the group header.  The last \d is the number of
lines that came from this guilty party, and it might become useful
if we want to give weight to people based on line-count, not just
number of commits.

> +sub format_contact {
> +	my ($name, $email) = @_;
> +	return "$name <$email>";
> +}
> +
> +sub parse_commit {
> +	my ($commit, $data) = @_;
> +	my $contacts = $commit->{contacts};
> +	my $inbody = 0;
> +	for (split(/^/m, $data)) {
> +		if (not $inbody) {
> +			if (/^author ([^<>]+) <(\S+)> .+$/) {
> +				$contacts->{format_contact($1, $2)} = 1;

The author name and email can be grabbed from the "blame" output
without doing this (and the result may be more robust), but you
would need to read from the log message anyway, so I think this is
OK.

Note that the names and emails in blame output are sanitized via the
mailmap mechanism, but "cat-file commit" will certainly not be.

You may have to do the mapping yourself by reading the mailmap for
the names and addresses you read from S-o-b: and friends.

> +			} elsif (/^$/) {
> +				$inbody = 1;
> +			}
> +		} elsif (/^$labels_rx:\s+([^<>]+)\s+<(\S+?)>$/o) {
> +			$contacts->{format_contact($1, $2)} = 1;
> +		}
> +	}
> +}
> +
> +sub import_commits {
> +	my ($commits) = @_;
> +	return unless %$commits;
> +	my $pid = open2 my $reader, my $writer, qw(git cat-file --batch);

Hmph.

I vaguely recall that people wanted not to use open2/IPC::Open2 in
other parts of the system.

I think "cat-file --batch" is designed to behave on a regular bidi
pipe, as long as the caller strictly does a ping-pong of issuing one
request, flush (with an empty line) and always read the response, so
if open2 becomes problematic, we could switch to regular pipes.

> +	for my $id (keys(%$commits)) {
> +		print $writer "$id\n";
> +		my $line = <$reader>;
> +		if ($line =~ /^($id_rx) commit (\d+)/o) {
> +			my ($cid, $len) = ($1, $2);
> +			die "expected $id but got $cid" unless $id eq $cid;
> +			my $data;
> +			# cat-file emits newline after data, so read len+1
> +			read $reader, $data, $len + 1;
> +			parse_commit($commits->{$id}, $data);
> +		}
> +	}
> +	close $reader;
> +	close $writer;
> +	waitpid($pid, 0);
> +	die "git-cat-file error: $?" if $?;
> +}
> +
> +sub get_blame {
> +	my ($commits, $source, $start, $len, $from) = @_;
> +	$len = 1 unless defined($len);
> +	return if $len == 0;
> +	open my $f, '-|',
> +		qw(git blame --incremental -C -C), '-L', "$start,+$len",
> +		'--since', $since, "$from^", '--', $source or die;

"--incremental" is meant for consumers that wants better latency,
not necessarily better throughput, but I think this consumer does
not present incremental result to the end user, so perhaps you would
want to use "--porcelain" instead.

> +	while (<$f>) {
> +		if (/^$id_rx/o) {
> +			my $id = $&;
> +			$commits->{$id} = { id => $id, contacts => {} };
> +		}
> +	}
> +	close $f;
> +}
> +
> +sub scan_hunks {
> +	my ($commits, $id, $f) = @_;
> +	my $source;
> +	while (<$f>) {
> +		if (/^---\s+(\S+)/) {

I wonder what happens to a patch that touches a file with SP in its
path with this regular expression.  As it is fairly clear that you
are reading from format-patch output (the caller does not call this
function if it did not see $id), perhaps you can tighten the prefix
a bit more?  I.e. something like:

	if (/^--- (.*)$/)

> +			$source = substr($1, 2) unless $1 eq '/dev/null';

(mental note) A creation patch is special-cased, but this does not
allow anything that does not begin with a single-byte --src-prefix
(e.g. "a/path/to/patched/file").

> +		} elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {

(mental note) For each hunk of a patch that is not a creation patch,
find the origin of the preimage.

> +			get_blame($commits, $source, $1, $2, $id);
> +		}

An major issue (*) and a few minor issues (-) from the above
observations:

 * A single patch may touch two or more paths.  If the first one is
   to modify an existing file, its path is assigned to $source.
   Now, imagine that the second one is a creation patch.  $source is
   not set to undef but is kept, and the code ends up trying to run
   blame on the first path with the range for the second path.

   Oops?

   This is one of the reasons why we shouldn't use statement
   modifiers lightly.  I think the above should be more like:

	if (/^--- (.*)$) {
		$source = ($1 eq '/dev/null') ? undef : substr($1, 2);
	} elsif ...

 - If the patch were prepared with a non-standard src/dst-prefix,
   unconditional substr($1, 2) would call blame on a wrong (and
   likely to be nonexistent) path without a useful diagnosis (the
   invocation of "git blame" will likely die with "no such path
   'tailofpathname' in $id").

   One way to make it more robust may be to do something like this:

	if (/^--- /) {
		if (m{^--- (?:a/(.*)|/dev/null)$}) {
			$source = ($1 eq '/dev/null') ? undef : $1;
		} else {
			die "Cannot parse the patch file:$_";
		}
	} elsif ...

 - Often a single patch touches more than one ranges in the same
   path.  Depending on the size of the patch, it might be more
   efficient to run a single blame for a range that covers all the
   lines the patch touches while discarding irrelevant parts.  A
   longer term improvement may be to extend "git blame" so that it
   can take more than one "-L n,m" ranges, but I think that is
   outside of the scope of this patch.

> +	}
> +}
> +
> +sub commits_from_patch {
> +	my ($commits, $file) = @_;
> +	open my $f, '<', $file or die "read failure: $file: $!";
> +	my $id;
> +	while (<$f>) {
> +		if (/^From ($id_rx) /o) {
> +			$id = $1;
> +			last;
> +		}
> +	}
> +	scan_hunks($commits, $id, $f) if $id;
> +	close $f;
> +}
> +
> +exit 1 unless @ARGV == 1;
> +
> +my %commits;
> +commits_from_patch(\%commits, $ARGV[0]);
> +import_commits(\%commits);
> +
> +my %count_per_person;
> +for my $commit (values %commits) {
> +	for my $contact (keys %{$commit->{contacts}}) {
> +		$count_per_person{$contact}++;
> +	}
> +}
> +
> +my $ncommits = scalar(keys %commits);
> +for my $contact (keys %count_per_person) {
> +	my $percent = $count_per_person{$contact} * 100 / $ncommits;
> +	next if $percent < $min_percent;
> +	print "$contact\n";
> +}
