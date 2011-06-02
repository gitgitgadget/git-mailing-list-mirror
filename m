From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Added a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 02 Jun 2011 11:01:19 -0700
Message-ID: <7vy61kcdu8.fsf@alter.siamese.dyndns.org>
References: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?SsOpcsOpbWll?= Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:01:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSCDJ-00061T-5s
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 20:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab1FBSBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 14:01:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1FBSBj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 14:01:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9AE9041A1;
	Thu,  2 Jun 2011 14:03:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=37Ab8YNybr7g2QZ5jIGzNCfWqY0=; b=Mdy946
	AGOb7vYRL5K9Pv+50u+VVaKVQmbt3u3/ZaeqxRH6nME2J9HkcAeB8fWUEnNFfBkU
	6WjlTMsCyXeHNqToV4Ymb2p3OrL3YJvbryxW/5jqhvGsPEeZ7CufaSFEK1vKcwIt
	y20A+YOjq2ehJI0NdUdaUV0hRejLyQtnj2epg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J9jco9fWBQUFvNlepfLthnTjgmtl5Uod
	V+8s+3LYctYZUoA8siaMad6U32Z6gMXLfNAXR92GceHr3mrXOIpaIU40breb+ZW2
	sfDj+KwAqpJ3PkecFINNHyq2tO10hX+bEPYb4Lj2Eg/DDrcUXAKTsOUfNbvwbYAP
	4bJDmy2thdw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2984941A0;
	Thu,  2 Jun 2011 14:03:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B36D94191; Thu,  2 Jun 2011
 14:03:29 -0400 (EDT)
In-Reply-To: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr> (Arnaud
 Lacurie's message of "Thu, 2 Jun 2011 11:28:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4A4B626-8D42-11E0-AFFC-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174965>

Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr> writes:

>  contrib/mw-to-git/git-remote-mediawiki     |  252 ++++++++++++++++++++++++++++
>  contrib/mw-to-git/git-remote-mediawiki.txt |    7 +
>  2 files changed, 259 insertions(+), 0 deletions(-)

It is pleasing to see that a half of a custom backend can be done in just
250 lines of code.  I understand that this is a work-in-progress with many
unnecessary lines spitting debugging output to STDERR, whose removal will
further shrink the code?

> +# commands parser
> +my $loop = 1;
> +my $entry;
> +my @cmd;
> +while ($loop) {

This is somewhat unusual-looking loop control.

Wouldn't "while (1) { ...; last if (...); if (...) { last; } }" do?

> +	$| = 1; #flush STDOUT
> +	$entry = <STDIN>;
> +	print STDERR $entry;
> +	chomp($entry);
> +	@cmd = undef;
> +	@cmd = split(/ /,$entry);
> +	switch ($cmd[0]) {
> +		case "capabilities" {
> +			if ($cmd[1] eq "") {
> +				mw_capabilities();
> +			} else {
> +			       $loop = 0;

I presume that this is "We were expecting to read capabilities command but
found something unexpected; let's abort". Don't you want to say something
to the user here, perhaps on STDERR?

> +			}
> +		}
> ...
> +		case "option" {
> +			mw_option($cmd[1],$cmd[2]);
> +		}

No error checking only for this one?

> +		case "push" {
> +			#check the pattern +<src>:<dist>

The latter one is usually spelled <dst> standing for "destination".

> +			my @pushargs = split(/:/,$cmd[1]);
> +			if ($pushargs[1] ne "" && $pushargs[2] eq ""
> +			&& (substr($pushargs[0],0,1) eq "+")) {
> +				mw_push(substr($pushargs[0],1),$pushargs[1]);
> +			} else {
> +			       $loop = 0;
> +			}

Is "push" always forcing?

> +sub mw_import {
> +	my @wiki_name = split(/:\/\//,$url);
> +	my $wiki_name = $wiki_name[1];
> +
> +	my $mediawiki = MediaWiki::API->new;
> +	$mediawiki->{config}->{api_url} = "$url/api.php";
> +
> +	my $pages = $mediawiki->list({
> +		action => 'query',
> +		list => 'allpages',
> +		aplimit => 500,
> +	});
> +	if ($pages == undef) {
> +		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
> +		print STDERR "fatal: make sure '$url/api.php' is a valid page\n";
> +		exit;
> +	}
> +
> +	my @revisions;
> +	print STDERR "Searching revisions...\n";
> +	my $fetch_from = get_last_local_revision() + 1;
> +	my $n = 1;
> +	foreach my $page (@$pages) {
> +		my $id = $page->{pageid};
> +
> +		print STDERR "$n/", scalar(@$pages), ": $page->{title}\n";
> +		$n++;
> +
> +		my $query = {
> +			action => 'query',
> +			prop => 'revisions',
> +			rvprop => 'ids',
> +			rvdir => 'newer',
> +			rvstartid => $fetch_from,
> +			rvlimit => 500,
> +			pageids => $page->{pageid},
> +		};
> +
> +		my $revnum = 0;
> +		# Get 500 revisions at a time due to the mediawiki api limit

It's nice that you can dig deeper with rvlimit increments. I wonder if
'allpages' also let's you retrieve more than 500 pages in total by somehow
iterating over the set of pages.

> +	# Creation of the fast-import stream
> +	print STDERR "Fetching & writing export data...\n";
> +	binmode STDOUT, ':binary';
> +	$n = 0;
> +
> +	foreach my $pagerevids (sort {$a->{revid} <=> $b->{revid}} @revisions) {
> +		#fetch the content of the pages
> +		my $query = {
> +			action => 'query',
> +			prop => 'revisions',
> +			rvprop => 'content|timestamp|comment|user|ids',
> +			revids => $pagerevids->{revid},
> +		};
> +
> +		my $result = $mediawiki->api($query);
> +
> +		my $rev = pop(@{$result->{query}->{pages}->{$pagerevids->{pageid}}->{revisions}});

Is the list of per-page revisions guaranteed to be sorted (not a
rhetorical question; just asking)?

> +		print "commit refs/mediawiki/$remotename/master\n";
> +		print "mark :$n\n";
> +		print "committer $user <$user\@$wiki_name> ", $dt->epoch, " +0000\n";
> +		print "data ", bytes::length(encode_utf8($comment)), "\n", encode_utf8($comment);

Calling encode_utf8() twice on the same data?  How big is this $comment
typically?  Or does encode_utf8() somehow memoize?

> +		# If it's not a clone, needs to know where to start from
> +		if ($fetch_from != 1 && $n == 1) {
> +			print "from refs/mediawiki/$remotename/master^0\n";
> +		}
> +		print "M 644 inline $title.wiki\n";
> +		print "data ", bytes::length(encode_utf8($content)), "\n", encode_utf8($content);

Same for $content, which presumably is larger than $comment...

Perhaps a small helper

	sub literal_data {
        	my ($content) = @_;
                print "data ", bytes::length($content), "\n", $content;
	}

would help here, above, and below where you create a "note" on this
commit?

> +		# mediawiki revision number in the git note
> +		my $note_comment = encode_utf8("note added by git-mediawiki");
> +		my $note_comment_length = bytes::length($note_comment);
> +		my $note_content = encode_utf8("mediawiki_revision: " . $pagerevids->{revid} . "\n");
> +		my $note_content_length = bytes::length($note_content);
> +
> +		if ($fetch_from == 1 && $n == 1) {
> +			print "reset refs/notes/commits\n";
> +		}
> +		print "commit refs/notes/commits\n";
> +		print "committer $user <user\@example.com> ", $dt->epoch, " +0000\n";
> +		print "data ", $note_comment_length, "\n", $note_comment;

With that, this will become

	literal_data(encode_utf8("note added by git-mediawiki"));

and you don't need two extra variables.  Same for $note_content*.
