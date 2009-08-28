From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] import-tars: Allow per-tar author and commit message.
Date: Fri, 28 Aug 2009 13:50:30 -0700
Message-ID: <7vskfbhdd5.fsf@alter.siamese.dyndns.org>
References: <20090828185652.448AD189B7B@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Aug 28 22:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh8PH-0005Y6-Sc
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 22:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbZH1Uui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbZH1Uui
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 16:50:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbZH1Uuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 16:50:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BDD273BB98;
	Fri, 28 Aug 2009 16:50:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k4Xrxp32mWTm8bBdFd3o72D4YhQ=; b=Vs/5fV
	hbs6ClsW1hZ6/U1MylZcuqZ8zCC1C2bbeXgbpeoGXbXP2J+sDnNlItdRUyFkp/en
	Vv575OZgDbkN6RtWcGKFvbADqk69B1bAMzIH4B/Q0fb6N+zdOHaTyAmzV4PPMNKi
	c57OXWE9+IOqj6tGCpvMBnei3Xk1Nk3d0lHGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SLpg5w6ANkqR0disRBNIjzjLhUQs2cr5
	PedswcfvExgvQ7NWG4IOCCjwZJydzSGFai8Z2U1RcLFzSaR+6OO6PBmF4TAsx2Tt
	SGs1aZvHg7RIMYN8m5viL33yY1uqy51XX8a909vm2VSXhL8W05NN2zJP7rP8d5h/
	vjFQdSjmI1s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D8053BB97;
	Fri, 28 Aug 2009 16:50:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A0123BB96; Fri, 28 Aug 2009
 16:50:31 -0400 (EDT)
In-Reply-To: <20090828185652.448AD189B7B@perkele> (Peter Krefting's message
 of "Wed\, 26 Aug 2009 20\:26\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F5808E8-9414-11DE-B607-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127348>

Peter Krefting <peter@softwolves.pp.se> writes:

> +	my $commit_msg = "Imported from $tar_file.";
> +	my $this_committer_name = $committer_name;
> +	my $this_committer_email = $committer_email;
> +	my $this_author_name = $author_name;
> +	my $this_author_email = $author_email;
> +	if ($metaext ne '')
> +	{
> +		# Optionally read a commit message from <filename.tar>.msg
> +		# Add a line on the form "Committer: name <e-mail>" to override
> +		# the committer and "Author: name <e-mail>" to override the
> +		# author for this tar ball.
> +		if (open MSG, '<', "${tar_file}.${metaext}")
> +		{
> +			my $header_done = 0;
> +			$commit_msg = '';
> +			while (<MSG>)
> +			{
> +				if (!$header_done && /^Committer:\s+([^<>]*)\s+<(.*)>\s*$/i)
> +				{
> +					$this_committer_name = $1;
> +					$this_committer_email = $2;
> +				}
> +				elsif (!$header_done && /^Author:\s+([^<>]*)\s+<(.*)>\s*$/i)
> +				{
> +					$this_author_name = $1;
> +					$this_author_email = $2;
> +				}
> +				else
> +				{
> +					$commit_msg .= $_;
> +					$header_done = 1;
> +				}
> +			}
> +			close MSG;
> +		}
> +	}
> +

I think people would expect that if they put a blank line after the header
part, it would be stripped away, because a format that has a list of
colon-separated key-value pairs, followed by a blank line, and then
followed by the body of the message is so familiar.

While you are at it, can you also fix the style?  Existing code in
import-tars.perl looks like this:

		if ($typeflag == 2) { # symbolic link
			print FI "data ", length($linkname), "\n", $linkname;
			$mode = 0120000;
		} else {
			print FI "data $size\n";
			while ($size > 0 && read(I, $_, 512) == 512) {
				print FI substr($_, 0, $size);
				$size -= 512;
			}
		}

i.e. opening brace comes at the end of the line of "if" and "else";
closing brace comes on the same line immediately before "else".
