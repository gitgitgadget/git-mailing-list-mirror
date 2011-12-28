From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Tue, 27 Dec 2011 18:34:27 -0800
Message-ID: <7vboqt2zm4.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Dec 28 03:34:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfjLu-0007W1-Cj
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 03:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab1L1Ceb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 21:34:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895Ab1L1Cea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 21:34:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3297D7785;
	Tue, 27 Dec 2011 21:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=xZ8a3d9gOFU4deddegHExBMMXIY=; b=xF6tVHN2xu5uCgrkRtZo
	MS5lf5LFaFQnZlSMaQUkmhGGa4KnGZXbFWD61T4ApJJW4jIyhTqcYfeNd+gKVUQP
	tEg83XW57+akMlCdGMBgLQUOFs1nqFNIa/NHJL7GhBpbr77W3w6/gC9YJCodoO7x
	vGFkgfi/Q8NrY9pLq80VAEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ka9ozcPTtFaoyoVlyjlRprkj14Eo8lfhE2bw2sjL+RB0bI
	LKF+9R1DDa6qo47KTzdMJ32DU+1PWEYVg5CHIy1/nvJg8/FkL1wod2FCCU+OsBdk
	cKm/AMlCyh+U9UcdpQ1bROeuTfiTN6Gfte0m+RZd9fetPlSdtvDgfN9APdNpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2978F7784;
	Tue, 27 Dec 2011 21:34:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86D527783; Tue, 27 Dec 2011
 21:34:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7715DFB0-30FC-11E1-B987-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187742>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> git-svn reads passwords from an interactive terminal or by using
> GIT_ASKPASS helper tool. But if GIT_ASKPASS environment variable is not
> set, git-svn does not try to use SSH_ASKPASS as git-core does. This
> cause GUIs (w/o STDIN connected) to hang waiting forever for git-svn to
> complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).
>
> Commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795 tried to solve this
> issue, but was incomplete as described above.
>
> Instead of using hand-rolled prompt-response code that only works with
> the interactive terminal, a reusable prompt() method is introduced in
> this commit. This change also adds a fallback to SSH_ASKPASS.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

Thanks. Vastly more readable ;-)

I only have a few minor nits, and request for extra set of eyeballs from
Perl-y people.

>  sub _read_password {
>  	my ($prompt, $realm) = @_;
> -	my $password = '';
> -	if (exists $ENV{GIT_ASKPASS}) {
> -		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
> -		$password = <PH>;
> -		$password =~ s/[\012\015]//; # \n\r
> - ...
> -		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
> -			last if $key =~ /[\012\015]/; # \n\r
> -			$password .= $key;
> -		}
> - ...
> +	my $password = Git->prompt($prompt);
>  	$password;
>  }
> ...
> +Check if GIT_ASKPASS or SSH_ASKPASS is set, use first matching for querying
> +user and return answer. If no *_ASKPASS variable is set, the variable is
> +empty or an error occoured, the terminal is tried as a fallback.

Looks like a description that is correct, but I feel a slight hiccup when
trying to read the first sentence aloud.  Perhaps other reviewers on the
list can offer an easier to read alternative?

> +sub prompt {
> +	my ($self, $prompt) = _maybe_self(@_);
> +	my $ret;
> +	if (exists $ENV{'GIT_ASKPASS'}) {
> +		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
> +	}
> +	if (!defined $ret && exists $ENV{'SSH_ASKPASS'}) {
> +		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
> +	}
> +	if (!defined $ret) {
> +		print STDERR $prompt;
> +		STDERR->flush;
> +		require Term::ReadKey;
> +		Term::ReadKey::ReadMode('noecho');
> +		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
> +			last if $key =~ /[\012\015]/; # \n\r
> +			$ret .= $key;

Unlike the original in _read_password, $ret ($password over there) is left
"undef" here; I am wondering if "$ret .= $key" might trigger a warning and
if that is the case, probably we should have an explicit "$ret = '';"
before going into the while loop.

> +sub _prompt {
> +	my ($askpass, $prompt) = @_;
> +	unless ($askpass) {
> +		return undef;
> +	}

Perl gurus on the list might prefer to rewrite this with statement
modifier as "return undef unless (...);" but I am not one of them.

> +	my $ret;
> +	open my $fh, "-|", $askpass, $prompt || return undef;

I am so used see this spelled with the lower-precedence "or" like this

	open my $fh, "-|", $askpass, $prompt
        	or return undef;

that I am no longer sure if the use of "||" is Ok here. Help from Perl
gurus on the list?

> +	$ret = <$fh>;
> +	$ret =~ s/[\012\015]//g; # strip \n\r, chomp does not work on all systems (i.e. windows) as expected

The original reads one line from the helper process, removes the first \n
or \r (expecting there is only one), and returns the result. The new code
reads one line, removes all \n and \r everywhere, and returns the result.

I do not think it makes any difference in practice, but shouldn't this
logically be more like "s/\r?\n$//", that is "remove the CRLF or LF at the
end"?

> +	close ($fh);

It seems that we aquired a SP after "close" compared to the
original. What's the prevailing coding style in our Perl code?

This close() of pipe to the subprocess is where a lot of error checking
happens, no? Can this return an error?

I can see the original ignored an error condition, but do we care, or not
care?
