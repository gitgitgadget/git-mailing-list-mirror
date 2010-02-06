From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Fri, 05 Feb 2010 18:57:14 -0800
Message-ID: <7vtytvf4vp.fsf@alter.siamese.dyndns.org>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
 <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
 <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 04:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndaxw-0006TZ-O8
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 04:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab0BFC51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 21:57:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0BFC50 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 21:57:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01FF497444;
	Fri,  5 Feb 2010 21:57:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aVAhldbWnr7mW4B0yTUkMhw8VAw=; b=lqNh6e
	YS5hyXHA6FZQIOkNOSdX2672BCAZL6StjUOuozsYI15Xkv2z7EyqzVcFxJRENG/k
	dGhlBDQEreDSpN0iBDE/xYG3LPKqGyTjhQvZwmbyu0hcEVAX/ZKjpCcm4d7TIaQi
	vN7eIRNb/FWpem3UewDeoQ2lilCflJg/WkV64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uOf5zRcrrmJTvsvmqtk3XyEswq8+cDql
	CTicHJIVU7gNkMKnCsIu6Pt1o2vatnEMFY5sVwdmeSc30lua+4bjmrfEhN6b3P+P
	OWQQ0NO3MgRduQWy5f6jBdMKlN3s61LSwBrnp3L3tDRxf0zpM4F9ClJgKKa9BZlQ
	JmHXBfEyXVk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C13349743F;
	Fri,  5 Feb 2010 21:57:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFFA29743A; Fri,  5 Feb
 2010 21:57:15 -0500 (EST)
In-Reply-To: <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com> (Jay
 Soffian's message of "Fri\, 5 Feb 2010 20\:58\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 575AD92E-12CB-11DF-9D8B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139139>

Jay Soffian <jaysoffian@gmail.com> writes:

>> We might instead want to add a hook that is called from cherry-pick (and
>> rebase will get a similar one) immediately after the command creates a new
>> commit out of another commit, so that people can record the correspondence
>> in notes namespace if they choose to.
>
> Hmfph. So I know some folks don't like polluting log messages (e.g.,
> the git-svn-id footer, or apparently, the cherry-pick -x message),...

That reminds me of a slightly related topic.  I've been running git-svn to
follow (but never build) a project without metadata, exactly because I do
not want the log message contamination. I am having a hard time mapping
the commit object name back to the upstream subversion serial number.

I ended up using this hacky script for that.  It finds the svn uuid from
the metadata file, and then finds ".rev_map.$uuid" files from all over the
place to see if any of them contains a record that points at the git
commit I am interested in.

I really wish "git svn" has a built-in way to do something like that;
perhaps I didn't look hard enough.

-- >8 --

#!/usr/bin/perl -w

use strict;
use Carp qw/croak/;
use Fcntl qw/:DEFAULT :seek/;
use constant rev_map_fmt => 'NH40';
use File::Find;

my $uuid = `git config -f .git/svn/.metadata svn-remote.svn.uuid`;
chomp($uuid);

# remotes/trunk

sub find_version {
	my ($name, $sha1) = @_;
	my ($fh, $size);
	if (!sysopen($fh, "$name/.rev_map.$uuid", O_RDONLY)) {
		return undef;
	}
	if (!binmode $fh) {
		close($fh);
		return undef;
	}
	$size = (stat($fh))[7];
	if (($size % 24) != 0) {
		close($fh);
		return undef;
	}

	while (sysread($fh, my $buf, 24) == 24) {
		my ($rev, $commit) = unpack(rev_map_fmt, $buf);
		if ($sha1 eq $commit) {
			close($fh);
			return $rev;
		}
	}
	close($fh);
	return undef;
}

my $top = ".git/svn/refs";
my $commit = $ARGV[0] || "HEAD";
my $sha1 = `git rev-parse $commit`;
chomp($sha1);
my $found;

sub match_svn_revision {
	if (-f "$_/.rev_map.$uuid") {
		my $it = "$File::Find::dir/$_";
		$it =~ s|^\Q$top\E/||;
		my $v = find_version($_, $sha1);
		if ($v) {
			$found = [$it, $v];
		}
		$File::Find::prune = 1;
	}
	if ($found) {
		$File::Find::prune = 1;
	}
}

File::Find::find(\&match_svn_revision, $top);

if ($found) {
	my ($origin, $rev) = @$found;
	$origin =~ s|^remotes/||;
	$origin =~ s|/|-|g;
	if ($origin eq 'trunk') {
		$origin = '';
	} else {
		$origin = "-$origin";
	}
	print "$rev$origin\n";
}
