From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Better chopping in commit search results
Date: Sat, 23 Feb 2008 14:04:05 -0800
Message-ID: <7vd4qn1ga2.fsf@gitster.siamese.dyndns.org>
References: <7vbq6kprql.fsf@gitster.siamese.dyndns.org>
 <7voda8ap6r.fsf@gitster.siamese.dyndns.org>
 <200802221849.44054.jnareb@gmail.com> <200802222014.13205.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jean-Baptiste Quenot <jbq@caraldi.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT2Ug-0006Ua-4O
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbYBWWEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbYBWWEU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:04:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYBWWET (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:04:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 302FE129E;
	Sat, 23 Feb 2008 17:04:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C0561129C; Sat, 23 Feb 2008 17:04:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74861>

Jakub Narebski <jnareb@gmail.com> writes:

> 	# regexps: ending and beginning with word part up to $add_len
> 	my $endre = qr/.{0,$len}[^ \/\-_:\.@]{0,$add_len}/;
> 	my $begre = qr/[^ \/\-_:\.@]{0,$add_len}.{0,$len}/;

I have no idea what these line noise characters inside [] are.
Did you mean something like "\w"?

I have a suspicion that it may be easier to read and could be
even more efficient to split an overlong line at word boundaries
and to remove elements from the end you are removing from until
it fits.

sub chop_whence {
	my ($line, $max, $slop, $where) = @_;

	my $len = length($line);
	if ($len < $max + $slop) {
		return $line;
	}

	# Cut at word boundaries
	my @split = split(/\b/, $line);
	my $filler = "...";

	while ((2 < @split)) {
		my $removed;
		my $splice_at;
		if ($where eq 'left') {
			$removed = shift @split;
		} elsif ($where eq 'right') {
			$removed = pop @split;
		} else {
			my $splice_at = int($#split / 2);
			$removed = splice(@split, $splice_at, 1);
		}
		$len -= length($removed) + length($filler);
		if ($len < $max + $slop) {
			if ($where eq 'left') {
				unshift @split, $filler;
			} elsif ($where eq 'right') {
				push @split, $filler;
			} else {
				my $splice_at = int($#split / 2);
				splice(@split, $splice_at, 0, $filler);
			}
			return join('', @split);
		}
	}
	# give up
	return $line;
}
