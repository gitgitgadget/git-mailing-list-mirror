From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Refactor git_header_html
Date: Tue, 21 Jun 2011 16:48:50 -0700
Message-ID: <7v4o3i7nkt.fsf@alter.siamese.dyndns.org>
References: <20110621183550.9315.21922.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 01:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZAgm-0004Yj-Db
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 01:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757534Ab1FUXsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 19:48:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757497Ab1FUXsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 19:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EA156A7E;
	Tue, 21 Jun 2011 19:51:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qRFuRopTHtBXPwvu4ys6CPMVrKQ=; b=g1wouS
	wvkANen8L7k6z8c55vSocsJP/VgbTvbYGYvEDOtTOjy0x/nWIcmG7qkJD52KZjsq
	npKYk03lrT+rJWg0GEjfW7d4If/FrudW0EVWmkg5OifibWwkLXQz9J+TcW0W+6FJ
	9iolRmSuesxVu4N3WWQh2Ut1q17cbWoCwUUbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mZmkNjGHAwBhyz7q7XredHUsSoRoh4IJ
	vaDlOXqvo26mBMVgAYbY8P86L+8FKvi39EdQukXIgbcDM9EyS47/ZMgJTxPLv9xt
	ws8rOfCtQAuxsaexzJeVwedQvQvkvtukxI7X1YLOuzhtFCBEWyygro3u+VZ3sQyN
	pmP9uI4TrDs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76AA96A7D;
	Tue, 21 Jun 2011 19:51:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BADE36A7C; Tue, 21 Jun 2011
 19:51:03 -0400 (EDT)
In-Reply-To: <20110621183550.9315.21922.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Tue, 21 Jun 2011 20:38:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52E6DFDE-9C61-11E0-8F0F-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176202>

Jakub Narebski <jnareb@gmail.com> writes:

> P.S. I wonder if print_search_form() should also get passed %opts as
> one of its parameters...

I do not particularly care for this:

	sub foo {
        	my %opts = @_;

		if ($opts{-option} eq 'bar') {
                	... do this ...

style, which lets a caller pass any random typo to the callee, like so:

	foo(-optoin => 'value');

But maybe it is just me.

> +sub print_header_links {
> +	my %opts = @_;
> +
> +	# print out each stylesheet that exist, providing backwards capability
> +	# for those people who defined $stylesheet in a config file
> +	if (defined $stylesheet) {
> +		print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
> +	} else {
> +		foreach my $stylesheet (@stylesheets) {
> +			next unless $stylesheet;
> +			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
> +		}
> +	}
> +	if ($opts{'-feed'}) {
> +		print_feed_meta();
> +	}

Here, we refrain from showing the <link> elements that are related to the
RSS/Atom feeds (if we know what $project we are talking about), or <link>
elements that are related to the project list (html top page and opml) if
we are not showing a normal return, as $opts{'-feed'} is true only when we
are returning '200 OK'.

The original implementation, even though it used statement modifiers after
this print_feed_meta(), was much easier to follow, at least for me. The
association between "feed-meta" and "200 OK" was close together and more
direct.

> ...
> -		}
> -	}
> -	print_feed_meta()
> -		if ($status eq '200 OK');

Other than that, this looks a correct no-op patch that makes the resulting
smaller functions easier to grok.
