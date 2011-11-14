From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] pack-objects: don't traverse objects unnecessarily
Date: Sun, 13 Nov 2011 21:40:37 -0800
Message-ID: <7vaa7zl0ru.fsf@alter.siamese.dyndns.org>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
 <1318915284-6361-3-git-send-email-dpmcgee@gmail.com>
 <7vk47qxe9x.fsf@alter.siamese.dyndns.org>
 <CAEik5nNmAnPni+rnLm7n5tO7f=LV_1TuTbVqxgjVaoqqaF_Ukw@mail.gmail.com>
 <7v1utdrfsf.fsf@alter.siamese.dyndns.org>
 <CAEik5nPJ3r6gp9Lttzh5aQmiPRFxpZvhTBXZoreY98QV6Cocdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 06:40:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPpHh-0004SQ-Go
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 06:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab1KNFkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 00:40:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab1KNFkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 00:40:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B46230A2;
	Mon, 14 Nov 2011 00:40:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9LSdWvUf5XGZa/zCPoN0JeElRC4=; b=fRWCnI
	6OTX5epDHP8g8ePgJIGvR5EfbzVZqDSXtad+n/yOwDGfv7K1uIdl59jpFh1tUveJ
	4dsOLaZYsgdwTpPcFao+IS4U5Uc1hVOXWc1bMBowB6qz6t5LkBiXiORzhUwar/jt
	xINAFv+eVHhxkmykkYPhahoItjHAxfh6vWUR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IRLBiU09/BVi3EIyOcQVk+DpCGvzMnKZ
	Bs9QfXoDiZt2U7485Y8U/T6qxROtj1jWqwA440GD5Ek9CS/JWz2xT0V0qMtS9fP0
	8jDvGrP3a6EV5c2drWAr93XijNf7bRocDhXrCr65ruRhGtKY+C4jDIoNtAbGB3Pg
	sUz6PmC8Qgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EF9A30A1;
	Mon, 14 Nov 2011 00:40:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 863A530A0; Mon, 14 Nov 2011
 00:40:38 -0500 (EST)
In-Reply-To: <CAEik5nPJ3r6gp9Lttzh5aQmiPRFxpZvhTBXZoreY98QV6Cocdg@mail.gmail.com> (Dan
 McGee's message of "Sun, 13 Nov 2011 16:34:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EBEFAEE-0E83-11E1-9D48-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185364>

Dan McGee <dpmcgee@gmail.com> writes:

>>> unable to figure out how you generated those numbers so I wasn't able
>>> to do so (and had planned to get back to you to find out how you made
>>> those tables). Were you able to verify the ordering did not regress?
>>
>> No; I was hoping you would redo the benchmark using 5f44324 (core: log
>> offset pack data accesses happened, 2011-07-06).
>
> I'm still not sure what you used to parse these results,...

Ah, in the kernel repository, after running "repack -a -d -f" with
versions of git and copying the resulting packfiles in PACK-OLD/ and
PACK-NEW/, I used these scripts to examine the access pattern.

-- >8 -- DOIT.sh -- >8 --
#!/bin/sh

tmp=/var/tmp/ll$
trap 'rm -f "$tmp.*"' 0

ln -f PACK-OLD/* .git/objects/pack/. || exit
log="$tmp.old"
eval '/usr/bin/time rungit test -c core.logpackaccess="$log" '"$*"

ln -f PACK-NEW/* .git/objects/pack/. || exit
log="$tmp.new"
eval '/usr/bin/time rungit test -c core.logpackaccess="$log" '"$*"

perl OFS.perl "$tmp.old" "$tmp.new"
-- 8< -- DOIT.sh -- 8< --

-- >8 -- OFS.perl -- >8 --
#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;

my $verbose;

exit(1) if (!GetOptions("verbose" => \$verbose));

sub take_one {
	my ($filename) = @_;
	my (%lofs, $num);
	my @diff;
	open my $in, '<', $filename;

	$num = 0;
	while (<$in>) {
		my ($file, $ofs) = split(' ');
		if (!exists $lofs{$file}) {
			$lofs{$file} = [$num++, 0];
		}
		my $diff = $ofs - $lofs{$file}[1];
		$lofs{$file}[1] = $ofs;
		push @diff, abs($diff);
		print "$lofs{$file}[0] $diff $ofs\n" if $verbose;
	}
	return \@diff;
}

sub bsearch {
	my ($list, $target) = @_;
	my ($hi, $lo) = ((scalar @$list), 0);

	while ($lo < $hi) {
		my $mi = int(($lo + $hi) / 2);
		if ($list->[$mi] == $target) {
			return $mi;
		} elsif ($list->[$mi] < $target) {
			$lo = $mi + 1;
		} else {
			$hi = $mi;
		}
	}
	return $hi;
}

my @percentile = ();
for (my $i = 0; $i < 100; $i += 10) {
	push @percentile, $i;
}
push @percentile, 95, 99, 99.9, 99.99;

sub thcomma {
	my ($intval) = @_;
	my $result = "";
	while ($intval > 1000) {
		my $rem = $intval % 1000;
		if ($result ne "") {
			$result = sprintf "%03d,%s", $rem, $result;
		} else {
			$result = sprintf "%03d", $rem;
		}
		$intval -= $rem;
		$intval /= 1000;
	}
	if ($intval) {
		if ($result ne "") {
			$result = sprintf "%d,%s", $intval, $result;
		} else {
			$result = sprintf "%d", $intval;
		}
	}
	$result =~ s/^[0,]*//;
	$result = "0" if ($result eq "");
	return $result;
}

sub show_stat {
	my ($diff1, $diff2) = @_;
	my ($i, $ix);
	if ($diff2) {
		@$diff2 = sort { $a <=> $b } @$diff2;
	}
	@$diff1 = sort { $a <=> $b } @$diff1;
	printf "\nTotal number of access : %12s", thcomma(scalar(@$diff1));
	printf "%12s", thcomma(scalar(@$diff2)) if ($diff2);
	for $i (@percentile) {
		$ix = scalar(@$diff1) * $i / 100;
		printf "\n     %5.2f%% percentile : %12s", $i, thcomma($diff1->[$ix]);
		if ($diff2) {
			$ix = scalar(@$diff2) * $i / 100;
			printf "%12s", thcomma($diff2->[$ix]);
		}
	}

	$ix = bsearch($diff1, 2 * 1024 * 1024);
	printf "\n   Less than 2MiB seek :       %5.2f%%", ($ix * 100.0 / @$diff1);
	if ($diff2) {
		$ix = bsearch($diff2, 2 * 1024 * 1024);
		printf "      %5.2f%%", ($ix * 100.0 / @$diff2);
	}

	print "\n";
}

my ($diff1, $diff2);
$diff1 = take_one($ARGV[0]);
$diff2 = take_one($ARGV[1]) if ($ARGV[1]);

show_stat($diff1, $diff2);
-- 8< -- OFS.perl -- 8< --


	
