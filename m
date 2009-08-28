From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] import-tars: Allow per-tar author and commit message.
Date: Thu, 27 Aug 2009 18:38:54 -0700
Message-ID: <7vskfcd8ep.fsf@alter.siamese.dyndns.org>
References: <20090826193015.962A7189B12@perkele>
 <7viqg96ehf.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908270741170.6459@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Aug 28 03:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgqQp-0001Iv-3Y
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 03:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbZH1BjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 21:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbZH1BjA
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 21:39:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbZH1BjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 21:39:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCDAA39ED9;
	Thu, 27 Aug 2009 21:39:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CKj3D0WzrDECAQePG53R6jo9fGA=; b=REAtvx
	DlNCV1Y0ydhhb7vilXUrWtJcoR8ZnnDMAskVoKtT6ei+y8qHiF+sQnTpN0OyMCbz
	HKWD7h4EApJijf2jZOXZo0PBjtxFDtjXjm3rpYrDTgmuG/pEw9m/Qx6du9z9VnjX
	WPnOhmGkTFFvEhkNG83eNpFjNQlkwdOOQdU1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IAEQYNStYtuonFFH3Fs4cNqG6HVXta1Y
	uZjyTY8VH9MjjuDgPdpRYGN8kjmgd+ELvljazeguBliLD60Gcx9L2FPh1PIOkr8a
	Z9DAmlOBKO9Yx59TdLYYY3yOZ2Cu+E4QPfsA6zWdkr3nywKyUnCOflDS/tftKwne
	kbelaSDSSIs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A28BE39ED7;
	Thu, 27 Aug 2009 21:38:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E82A39ED5; Thu, 27 Aug 2009
 21:38:56 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.0908270741170.6459@perkele.intern.softwolves.pp.se> (Peter
 Krefting's message of "Thu\, 27 Aug 2009 07\:42\:57 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8EEC587C-9373-11DE-97CE-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127240>

Peter Krefting <peter@softwolves.pp.se> writes:

> Junio C Hamano:
>
>> Do you really want to slurp Committer:/Author: lines from _anywhere_
>> in the file?  Wouldn't it make more sense to vaguely emulate e-mail
>> message format with headers, empty-line and then body that is free
>> form?
>
> I just tried not to overdo it, and keep the parsing code as simple as
> possible. I wasn't trying to implement an RFC 5322 compliant parser...

It is not about overdoing, but about not glossly underdoing.

Don't you at least want to avoid misparsing a msg file that looks like
this?

	Author: Peter Krefting <peter@softwolves.pp.se>

	import-tars: Allow per-tar author and commit message

        This version updates the import-tars program so that another
	file next to the archive can be read for the log message and
        other meta information.  A line that begins with Committer: or
        Author: is used as long as it consists of name and <email>
	to override the corresponding metainformation.  Remaining lines
	are used as the commit log message.

And I do not think you need a complex parser.  Stop paying attention to a
line that begins with Author:/Committer:, once you see a line that does
not match the pattern; and you would be Ok.

IOW, something like...

	my $reading_metainfo = 1;
        my $squashing_empty = 0;
	while (<>) {
        	if ($reading_metainfo) {
			if (/^Committer:.../) {
                        	...
				next;
			} elsif (/^Author:.../) {
                        	...
				next;
			} else {
                        	$reading_metainfo = 0;
			}
                }
                if (/^$/) {
			$squashing_empty = 1;
                        next;
		}
                if ($squashing_empty && $commit_msg ne '') {
                	$commit_msg .= "\n";
		}
                $commit_msg .= $_;
                $squashing_empty = 0;
	}
