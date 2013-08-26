From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 10:03:50 -0700
Message-ID: <xmqqioysidu1.fsf@gitster.dls.corp.google.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
	<CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
	<xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
	<20130825042314.GE2882@elie.Belkin>
	<xmqqk3jal4t7.fsf@gitster.dls.corp.google.com>
	<xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
	<CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
	<xmqqr4dgifp5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:04:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0Cv-0004Qe-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab3HZRD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:03:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab3HZRD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:03:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD8E13A546;
	Mon, 26 Aug 2013 17:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S9WJtArplSWqmZMo/q94/um+xpQ=; b=oBR/Xb
	47wekJt1GU91OAdnw86ta7eM/kOxI6IpjZcVLoDoy2ULB3+MJCXtajlIa+kW+XiW
	US3NT2w55tQ6VTNsBgbz9F6zV5CqNbhQz1BtBqkF8/Ul7BFIsm9D0p23Fb9x3DEu
	wdTS3/ZMFraiaqqtuEbfXaA7zoOFH+xmAfLtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UM+ahFkY+o84348iGOebCtb/81ubXsh5
	iag7nCzeK+kgiyYrib0Eb+H6+e/ROsmZlMFuX/x89nwTXroG9Byh4V3l5EfpqoQy
	rfNQanEfEPKgHYRJjCPpuNXuwp4UMbRqwNb5x7MoOUGgxXy32dqxClZ/idcC4JrC
	cQv25dS9kv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A18013A545;
	Mon, 26 Aug 2013 17:03:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44FAE3A53D;
	Mon, 26 Aug 2013 17:03:53 +0000 (UTC)
In-Reply-To: <xmqqr4dgifp5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 26 Aug 2013 09:23:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C70B1CA-0E71-11E3-A538-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233004>

Junio C Hamano <gitster@pobox.com> writes:

> If your justification were "above says 'there may be a readon why
> the user wanted to ask it in that way', i.e. 'find in this tree
> object HEAD:some/path and report where hits appear', but the reason
> can only be from laziness and/or broken script and the user always
> wants the answer from within the top-level tree-ish", then that
> argument may make some sense. You need to justify why it is OK to
> lose information in the answer by rewriting the colon that separates
> the question ("in this tree object") and the answer ("at this path
> relative to the tree object given").
>
> Whether you rewrite the input or the output is not important; you
> are trying to give an answer to a different question, which is what
> I find questionable.

For example, one of the cases the proposed change will break that I
am worried about is a script that wants to take N trees and a
pattern, and report where in the given trees hits appear, something
like:

git grep -c -e $pattern "$@" |
perl -e '
	my @trees = @ARGV;
	my %found = ();
	while (<>) {
	        my $line = $_;
	        for (@trees) {
			my $tree_prefix = $_ . ":";
			my $len = len($tree_prefix);
			if (substr($line, 0, $len) eq $tree_prefix) {
				my ($path_count) = substr($line, $len);
				my ($path, $count) = $path_count =~ /^(.*):(\d+)$/
				$found{$tree} = [$path, $count];
			}
		}
	}
	# Do stats on %found
' "$@"
