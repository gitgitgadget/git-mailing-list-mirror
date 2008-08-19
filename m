From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3 v2] add new Perl API: Git::Repo, Git::Commit,
 Git::Tag, and Git::RepoRoot
Date: Mon, 18 Aug 2008 18:32:07 -0700
Message-ID: <7v8wutkcx4.fsf@gitster.siamese.dyndns.org>
References: <1219088389-14828-1-git-send-email-LeWiemann@gmail.com>
 <1219088389-14828-2-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 03:33:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVG63-0005iS-2o
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 03:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbYHSBcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 21:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbYHSBcO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 21:32:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbYHSBcN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 21:32:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B6EE54743;
	Mon, 18 Aug 2008 21:32:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BA41E5473E; Mon, 18 Aug 2008 21:32:09 -0400 (EDT)
In-Reply-To: <1219088389-14828-2-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Mon, 18 Aug 2008 21:39:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5CF053C-6D8E-11DD-98FD-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92805>

Lea Wiemann <lewiemann@gmail.com> writes:

> +=head1 DESCRIPTION
> +...
> +The author, committer and message methods return Unicoded strings,

Unicoded?

> +decoded according to the "encoding" header, with UTF-8 and then
> +Latin-1 as fallbacks.  (These Unicode strings can contain code points
> +...
> +decoding for you, so you should not normally need this method.

Anyway, nicely written description.

> +=back
> +
> +=cut
> +
> +
> +sub tree {
> +	my $self = shift;
> +	$self->_load;
> +	return $self->{tree};
> +}
> +
> +sub parents {
> +	my $self = shift;
> +	$self->_load;
> +	return map { ref($self)->new($self->repo, $_) } @{$self->{parents}};
> +}
> +
> +sub author {
> +	my $self = shift;
> +	$self->_load;
> +	return $self->_decode($self->{author});
> +}
> +
> +sub committer {
> +	my $self = shift;
> +	$self->_load;
> +	return $self->_decode($self->{committer});
> +}
> +
> +sub message {
> +	my $self = shift;
> +	$self->_load;
> +	return $self->_decode($self->{message});
> +}
> +
> +sub encoding {
> +	my $self = shift;
> +	$self->_load;
> +	return $self->{encoding};
> +}
> +
> +# Auxiliary method to load (and parse) the commit object from the
> +# repository if it hasn't already been loaded.  Optional parameter:
> +# The raw contents of the commit object; the commit object will be
> +# retrieved from the repository if that parameter is not given.
> +sub _load {
> +	my ($self, $raw_text) = shift;
> +	return if exists $self->{message};  # already loaded
> +
> +	my $sha1 = $self->sha1;
> +	if (!defined $raw_text) {
> +		# Retrieve from the repository.
> +		(my $type, $raw_text) = $self->repo->get_object($sha1);
> +		die "$sha1 is a $type object (expected a commit object)"
> +		    unless $type eq 'commit';
> +	}
> +
> +	(my $header, $self->{message}) = split "\n\n", $raw_text, 2;
> +	# Parse header.
> +	for my $line (split "\n", $header) {
> +		local $/ = "\n"; # for chomp
> +		chomp($line);
> +		my ($key, $value) = split ' ', $line, 2;
> +		if ($key eq 'tree') {
> +			$self->{tree} = $value;
> +		} elsif ($key eq 'parent') {
> +			push @{$self->{parents}}, $value;
> +		} elsif ($key eq 'author') {
> +			$self->{author} = $value;
> +		} elsif ($key eq 'committer') {
> +			$self->{committer} = $value;
> +		} elsif ($key eq 'encoding') {
> +			$self->{encoding} = $value;
> +		} else {
> +			# Ignore unrecognized header lines.
> +		}
> +	}
> +	undef;
> +}

Aside from seeming repetitive and quite similar to Git::Tag::_load(), I
have to wonder how parent rewriting and grafts come into the picture.
Git::Repo::get_object is just a cat-file which means you are ignoring any
grafts.  As a design decision it is fine, but it needs to be documented.

Also if you run "per path history" using "rev-list $head -- $path" to
collect commits that touch the named $path, you might want to get
rewritten parents for each commit and use it in the presentation, but it
is something you cannot cache easily (i.e. you should not be reusing the
parent list rewritten with respect to other paths).

The tests looked fine, too.
