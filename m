From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 2/2] gitweb: append short hash ids to snapshot
 files
Date: Sat, 12 Sep 2009 20:35:10 -0700
Message-ID: <7v7hw34ivl.fsf@alter.siamese.dyndns.org>
References: <4AAC2917.6000306@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun Sep 13 05:35:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmfs9-0006e5-K0
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 05:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944AbZIMDfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 23:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbZIMDfU
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 23:35:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbZIMDfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 23:35:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DA144E7F8;
	Sat, 12 Sep 2009 23:35:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZwbLSTPFo8wecodYWd6XyKJE8yo=; b=aLuuXknEoytRtNG6uQ5CrYZ
	/HetSvHdNlvT+uBQXZaAtCXFPhxKI3wd3NMF7dCwMd3ghNWTgxt6cyrlrsJM4m8B
	rFl4fsPL+VzVTAorI1Okd/rEGLdgw0GxJyeZ6WMQj27u7QzJUHYDzWu+sYvOBGgQ
	aHMt7AabAPwM8/zvumzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hr0vBChgvDmS7i14r7GJT4159yabSv1nT2OEzYXLXsFt1Qf+x
	GM1KczQ4urmDjI90NQo69dxzf1Qx/+CW8+JDJ6iY3SVw6Xo8cVlxKlu0gtA/fXmg
	9wqWrwzghpzkmyQsjiwd9reYXmsGOOkSVSHnf/+/KqrxElRaiV/LNBNpII=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5D4B4E7F7;
	Sat, 12 Sep 2009 23:35:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E33524E7F2; Sat, 12 Sep 2009
 23:35:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76118746-A016-11DE-B952-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128329>

Mark Rada <marada@uwaterloo.ca> writes:

> Teach gitweb how to produce nicer snapshot names by only using the
> short hash id. If clients make requests using a tree-ish that is not a
> partial or full SHA-1 hash, then the short hash will also be appended
> to whatever they asked for.
> ...
> +sub git_get_short_hash {
> +	my $project = shift;
> +	my $hash = shift;
> +	my $o_git_dir = $git_dir;
> +	my $retval = undef;
> +	$git_dir = "$projectroot/$project";
> +	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--short', $hash) {
> +		$hash = <$fd>;
> +		close $fd;
> +		if (defined $hash && $hash =~ /^([0-9a-fA-F]{7,})$/) {

If you want to make sure it is 7 or longer, ask rev-parse to give you 7 or
longer explicitly, so that you won't be hit by default changing under you
in the future.

> @@ -5207,6 +5227,12 @@ sub git_snapshot {
> ...
> +
> +	if ($full_hash !~ /$hash/) {
> +		$hash .= '-' . git_get_short_hash($project, $hash);
> +	} else {
> +		$hash = git_get_short_hash($project, $hash);
> +	}

I do not get this test.  What is this unanchored pattern match about?

I do not think you wanted to allow matching a partial 1234567 $hash to
substitute a full 01234567..... $full_hash, so I am guessing that you
meant to say "$full_hash !~ /^$hash/" at least, or perhaps you meant even
"$full_hash ne $hash".

But that still does not make much sense to me.  Perhaps you meant to catch
a case where $hash is a tagname (or refname), i.e. $hash = 'v1.6.3' or
$hash = 'next'?

If that is indeed the case, then perhaps you should check for that more
explicitly, perhaps using "git show-ref $hash" or something.  I do not
know if the complexity (not just the "detect handcrafted $hash string that
is not an SHA-1", but this whole "give shorten one" topic) is worth it,
though.  And if you drop the hunk that changes user supplied $hash to
$full_hash in the output file name in your [PATCH 1/2], I do not think you
need this anyway.  If somebody asked for 'next', he will get 'next'.

If somebody asked for 01234... (full 40 hexdigits) because that was the
link on the gitweb output page, it might make sense to give him a
shortened name, but then the above conditional needs to be only:

	if ($full_hash eq $hash) {
        	$hash = git_get_short_hash($project, $hash);
	}

no?        

> +test_commit \
> +	'SnapshotFileTests' \
> +	'i can has snapshot?'
> +test_expect_success \
> +	'snapshots: give full hash' \
> +	'ID=`git rev-parse --verify HEAD` &&
> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
> +	ID=`git rev-parse --short HEAD` &&
> +	grep ".git-$ID.tar.gz" gitweb.output'

I'd rather see these indented like:

        test_expect_success 'snapshots: give full hash' '
		ID=$(git rev-parse --verify HEAD) &&
		gitweb_run ...
        '

Also, if I am not mistaken, "test_commit" is not about doing any test, but
is a short-hand for doing an operation, right?  It would be better to have
it inside test_expect_success just in case your "git commit" or some other
commands are broken.  I.e. like

	test_expect_success 'create a test commit' '
		test_commit SnapshotFileTests "Can I have shapshot?"
        '
