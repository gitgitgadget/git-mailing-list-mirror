From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv6] Add contrib/credentials/netrc with GPG support
Date: Fri, 8 Feb 2013 01:18:55 -0500
Message-ID: <20130208061855.GA11892@sigill.intra.peff.net>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com>
 <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com>
 <7vhalqsfkf.fsf@alter.siamese.dyndns.org>
 <8738xaqy40.fsf_-_@lifelogs.com>
 <7vip66qu0u.fsf@alter.siamese.dyndns.org>
 <7vtxpqnwiv.fsf@alter.siamese.dyndns.org>
 <876226p97h.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3hIw-0006JK-0p
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab3BHGS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 01:18:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39147 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3BHGS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:18:57 -0500
Received: (qmail 26551 invoked by uid 107); 8 Feb 2013 06:20:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 01:20:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 01:18:55 -0500
Content-Disposition: inline
In-Reply-To: <876226p97h.fsf_-_@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215759>

On Tue, Feb 05, 2013 at 07:38:58PM -0500, Ted Zlatanov wrote:

> Add Git credential helper that can parse netrc/authinfo files.
> 
> This credential helper supports multiple files, returning the first one
> that matches.  It checks file permissions and owner.  For *.gpg files,
> it will run GPG to decrypt the file.
> 
> Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>


> +	# the following check is copied from Net::Netrc, for non-GPG files
> +	# OS/2 and Win32 do not handle stat in a way compatable with this check :-(

s/compatable/compatible/

You mention os/2 and Win32 here, but the check has more:

> +	unless ($gpgmode || $options{insecure} ||
> +		$^O eq 'os2'
> +		|| $^O eq 'MSWin32'
> +		|| $^O eq 'MacOS'
> +		|| $^O =~ /^cygwin/) {

Does MacOS really not handle stat? Or is this old MacOS, not OS X?

> +sub load_netrc {
> [...]
> +	foreach my $nentry (@netrc_entries) {
> +		my %entry;
> +		my $num_port;
> +
> +		if (!defined $nentry->{machine}) {
> +			next;
> +		}
> +		if (defined $nentry->{port} && $nentry->{port} =~ m/^\d+$/) {
> +			$num_port = $nentry->{port};
> +			delete $nentry->{port};
> +		}
> +
> +		# create the new entry for the credential helper protocol
> +		$entry{$options{tmap}->{$_}} = $nentry->{$_} foreach keys %$nentry;
> +
> +		# for "host X port Y" where Y is an integer (captured by
> +		# $num_port above), set the host to "X:Y"
> +		if (defined $entry{host} && defined $num_port) {
> +			$entry{host} = join(':', $entry{host}, $num_port);
> +		}

So this will convert:

  machine foo port smtp

in the netrc into (protocol => "smtp", host => "foo"), but:

  machine foo port 25

into (protocol => undef, host => "foo:25"), right? That makes sense to
me.

> +sub net_netrc_loader {
> [...]

I won't comment here, as I know very little about netrc (I always
thought it was line-oriented, too!) and Junio has covered it.

> +# takes the search tokens and then a list of entries
> +# each entry is a hash reference
> +sub find_netrc_entry {
> +	my $query = shift @_;
> +
> +    ENTRY:
> +	foreach my $entry (@_)
> +	{
> +		my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
> +		foreach my $check (sort keys %$query) {
> +			if (defined $query->{$check}) {
> +				log_debug("compare %s [%s] to [%s] (entry: %s)",
> +					  $check,
> +					  $entry->{$check},
> +					  $query->{$check},
> +					  $entry_text);
> +				unless ($query->{$check} eq $entry->{$check}) {
> +					next ENTRY;
> +				}
> +			} else {
> +				log_debug("OK: any value satisfies check $check");
> +			}

This looks right to me.

> +sub print_credential_data {

I don't know if you want to take the hit of relying on Git.pm (it is
nice for the helper to be totally standalone and copy-able), but one
obvious possible refactor would be to use the credential read/write
functions recently added there. I'm OK with not doing that, though.

> +	my $entry = shift @_;
> +	my $query = shift @_;
> +
> +	log_debug("entry has passed all the search checks");
> + TOKEN:
> +	foreach my $git_token (sort keys %$entry) {
> +		log_debug("looking for useful token $git_token");
> +		# don't print unknown (to the credential helper protocol) tokens
> +		next TOKEN unless exists $query->{$git_token};
> +
> +		# don't print things asked in the query (the entry matches them)
> +		next TOKEN if defined $query->{$git_token};
> +
> +		log_debug("FOUND: $git_token=$entry->{$git_token}");
> +		printf "%s=%s\n", $git_token, $entry->{$git_token};
> +	}

Printf? Bleh, isn't this supposed to be perl? :P

I don't see anything wrong from the credential-handling side of things.
As I said, I didn't look closely at the netrc parsing bits. From my
reading of "perldoc macos", the answer to my question above is "yes,
stat doesn't work on MacOS Classic". So I think the script itself is
fine.

In your tests:

> +++ b/contrib/credential/netrc/Makefile
> @@ -0,0 +1,12 @@
> +test_netrc:
> +       @(echo "bad data" | ./git-credential-netrc -f A -d -v) || echo "Bad invocation test, ignoring
> failure"
> +       @echo "=> Silent invocation... nothing should show up here with a missing file"
> +       @echo "bad data" | ./git-credential-netrc -f A get
> +       @echo "=> Back to noisy: -v and -d used below, missing file"
> +       echo "bad data" | ./git-credential-netrc -f A -d -v get
> +       @echo "=> Look for any entry in the default file set"
> +       echo "" | ./git-credential-netrc -d -v get
> +       @echo "=> Look for github.com in the default file set"
> +       echo "host=google.com" | ./git-credential-netrc -d -v get
> +       @echo "=> Look for a nonexistent machine in the default file set"
> +       echo "host=korovamilkbar" | ./git-credential-netrc -d -v get

You are depending on whatever the user has in their ~/.netrc, no?
Wouldn't it make more sense to ship a sample netrc and run all of the
tests with "-f netrc.example"?

It may also be worth building on top of the regular git test harness.
It's more work, but the resulting code (and the output) will be much
more readable.

-Peff
