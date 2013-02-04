From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Mon, 04 Feb 2013 14:56:06 -0800
Message-ID: <7vd2wf1yex.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Uxm-0006yV-9z
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 23:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab3BDW4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 17:56:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41870 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943Ab3BDW4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 17:56:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D62F2DC0C;
	Mon,  4 Feb 2013 17:56:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jY5zhxMSzp1Wz3HGM+172r5/50w=; b=O66CJc
	Hh4jJndIoL1D5oLSn50WDpQzhtrC6CfIQErpmTITnHVt1eb6KWFmqHCQsLfNGTqV
	8FEh9p3Tp++V+9Rp/tXoed/tT1dHZP9iUk9k/ozONLEM7JTT9VjP89GIVLWyGFrt
	KOmQcqmlr8PL3ZzdlaE7WU8H1MxG3sJAbh468=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/jZ0BYlybwz5xKviWHdhUJZvu71D0Cm
	SSnQiQTja/KjU25KzCe/Vv0slRv0MYgBSezASe8XO2UBw1vXayBayVTrbZ6qT9Bv
	QHMBgE1YnLZ/OE0hOqjdOkw9fbej653BFSooMxj9qWJesCsKSch+0vxA7h/bbVZQ
	bGXdX83tl+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC4ADC0B;
	Mon,  4 Feb 2013 17:56:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFB9EDC04; Mon,  4 Feb 2013
 17:56:08 -0500 (EST)
In-Reply-To: <87mwvjsqjc.fsf_-_@lifelogs.com> (Ted Zlatanov's message of
 "Mon, 04 Feb 2013 16:44:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1064462E-6F1E-11E2-83D1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215426>

Ted Zlatanov <tzz@lifelogs.com> writes:

> Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>

The space above your S-o-b: could be utilized a bit better ;-)

> @@ -0,0 +1,236 @@
> +#!/usr/bin/perl
> +
> +use strict;
> +use warnings;
> +
> +use Getopt::Long;
> +use File::Basename;
> +
> +my $VERSION = "0.1";
> +
> +my %options = (
> +               help => 0,
> +               debug => 0,
> +
> +               # identical token maps, e.g. host -> host, will be inserted later
> +               tmap => {
> +                        port => 'protocol',
> +                        machine => 'host',
> +                        path => 'path',
> +                        login => 'username',
> +                        user => 'username',
> +                        password => 'password',
> +                       }
> +              );
> +
> +# map each credential protocol token to itself on the netrc side
> +$options{tmap}->{$_} = $_ foreach values %{$options{tmap}};
> +
> +foreach my $suffix ('.gpg', '') {
> +	foreach my $base (qw/authinfo netrc/) {
> +		my $file = glob("~/.$base$suffix");
> +		next unless (defined $file && -f $file);
> +		$options{file} = $file ;
> +	}
> +}

This checks .gpg first and then unencrypted, and checks authinfo
first and netrc second, both of which makes sense.  It is good to
encourage use of encrypted files, and it is good to use newer
authinfo files over netrc files.

However, it is strange that you let the ones that are discovered
later in the loop to override the ones that are discovered earlier.
Perhaps you meant

	next unless (... exists there ...);
        $options{"file"} = $file;
        last;

instead?

> +Getopt::Long::Configure("bundling");

Hmm, OK.

> +# TODO: maybe allow the token map $options{tmap} to be configurable.
> +GetOptions(\%options,
> +           "help|h",
> +           "debug|d",
> +           "file|f=s",
> +          );
> +
> +if ($options{help}) {
> +	my $shortname = basename($0);
> +	$shortname =~ s/git-credential-//;
> +
> +	print <<EOHIPPUS;
> +
> +$0 [-f AUTHFILE] [-d] get
> +
> +Version $VERSION by tzz\@lifelogs.com.  License: BSD.
> +
> +Options:
> +  -f AUTHFILE: specify a netrc-style file
> +  -d: turn on debugging
> +
> +To enable (note that Git will prepend "git-credential-" to the helper
> +name and look for it in the path):
> +
> +  git config credential.helper '$shortname -f AUTHFILE'
> +
> +And if you want lots of debugging info:
> +
> +  git config credential.helper '$shortname -f AUTHFILE -d'
> +
> +Only "get" mode is supported by this credential helper.  It opens
> +AUTHFILE and looks for entries that match the requested search
> +criteria:
> +
> + 'port|protocol':
> +   The protocol that will be used (e.g., https). (protocol=X)
> +
> + 'machine|host':
> +   The remote hostname for a network credential. (host=X)
> +
> + 'path':
> +   The path with which the credential will be used. (path=X)
> +
> + 'login|user|username':
> +   The credential’s username, if we already have one. (username=X)
> +
> +Thus, when we get this query on STDIN:
> +
> +protocol=https
> +username=tzz
> +
> +this credential helper will look for lines in AUTHFILE that match
> +
> +port https login tzz
> +
> +OR
> +
> +protocol https login tzz
> +
> +OR... etc. acceptable tokens as listed above.  Any unknown tokens are
> +simply ignored.

I recall that netrc/authinfo files are _not_ line oriented.  Earlier
you said "looks for entries that match" which is a lot more correct,
but then we see "look for lines in authfile".

> +Then, the helper will print out whatever tokens it got from the line,
> +including "password" tokens, mapping e.g. "port" back to "protocol".

Again "line" is mentioned twice, above and below.

> +The first matching line is used.  Tokens can be quoted as 'STRING' or
> +"STRING".
> +
> +No caching is performed by this credential helper.
> +
> +EOHIPPUS
> +
> +	exit;
> +}

> +my $mode = shift @ARGV;
> +
> +# credentials may get 'get', 'store', or 'erase' as parameters but
> +# only acknowledge 'get'
> +die "Syntax: $0 [-f AUTHFILE] [-d] get" unless defined $mode;
> +
> +# only support 'get' mode
> +exit unless $mode eq 'get';

The above looks strange.  Why does the invoker get the error message
only when it runs this without arguments?  Did you mean to say more
like this?

	unless (defined $mode && $mode eq 'get') {
		die "...";
	}

By the way, I think statement modifiers tend to get overused and
make the resulting program harder to read.  die "..." at the
beginning of line makes the reader go "Whoa, it already is done and
existing on error", and then forces the eyes to scan the error
message to find "unless" and the condition.

It may be a cute syntax and some may find it even cool, but cuteness
or coolness is less valuable compared with the readability.

> +my $debug = $options{debug};
> +my $file = $options{file};
> +
> +unless (defined $file) {
> +	print STDERR "Please specify an existing netrc file (with or without a .gpg extension) with -f AUTHFILE\n" if $debug;
> +	exit 0;
> +}
> +
> +unless (-f $file) {
> +	print STDERR "Sorry, the specified netrc $file is not accessible\n" if $debug;
> +	exit 0;
> +}

Perhaps "-r $file", if you say "is not accessible"?

Is it sensible to squelch the error message by default and force
user to specify --debug?  You could argue that the option is to
debug the user's configuration, but the name of the option sounds
more like it is for debugging this script itself.

I saw Peff already pointed out error conditions, but I am not sure
why all of these exit with 0.  If the user has configured

	git config credential.helper 'netrc -f $HOME/.netcr'

shouldn't it be diagnosed as an error?  It is understandable to let
this go silently

	git config credential.helper 'netrc'

and let other credential helpers take over when no $HOME/.{netrc,authinfo}{,.gpg}
file exist, but in that case the user may still want to remove the
config item that is not doing anything useful and erroring out with
a message may be a way to help the user know about the situation.

> +my @data;
> +if ($file =~ m/\.gpg$/) {
> +	@data = load('-|', qw(gpg --decrypt), $file)
> +}
> +else {
> +	@data = load('<', $file);
> +}
> +
> +chomp @data;
> +
> +unless (scalar @data) {

Shouldn't this error check come logically before chomping?

> +	print STDERR "Sorry, we could not load data from [$file]\n" if $debug;
> +	exit;
> +}

Is this really an error?  The file perhaps was empty.  Shouldn't
that case treated the same way as the case where no entry that
matches the criteria invoker gave you was found?
