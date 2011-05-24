From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 07/10] pack-objects: Allow --max-pack-size to be used
 together with --stdout
Date: Mon, 23 May 2011 17:09:28 -0700
Message-ID: <7vlixxrmbr.fsf@alter.siamese.dyndns.org>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-8-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 24 02:09:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOfBw-0000Nn-5s
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 02:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab1EXAJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 20:09:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab1EXAJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 20:09:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 771AB528F;
	Mon, 23 May 2011 20:11:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oMqo7HlpvHwqzZT2ncGZ/OhurKc=; b=ofmYHk
	Mzm1bNPayl9VztzhPsZ5bS4E4u0v7F0Ti28ctZ5tDHvXZhFJ6JkZTNIInSS9NoGT
	sfxsSE9XDE5SatShpsYimEm3X9VYB4k9aIyUMdnNkTfMGw6WdkTNgj+suhuWOA9b
	FdWIo8GrkG/zjCXBlkKGT28fUOhaeGbUuo4+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0IS0NTnLxWQsfpHsjUR+U8RDz3Zls67
	EFlSwe6dXNE3kjhKsMta/HDcaWJA+JVmbtUwULU4H7w/sEn3s+nfIW7QvHLSNLw0
	PDnt43piQqvSbKzymCQN+4s2PxjnBrqHKn5oLRebdRV5LhSNqseTavH9HHW4ghLS
	JUhtlhPhD1k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38366528D;
	Mon, 23 May 2011 20:11:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ECF7F5285; Mon, 23 May 2011
 20:11:37 -0400 (EDT)
In-Reply-To: <1306111923-16859-8-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon, 23 May 2011 02:52:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 670D1E02-859A-11E0-976A-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174297>

Johan Herland <johan@herland.net> writes:

> Currently we refuse combining --max-pack-size with --stdout since there's
> no way to make multiple packs when the pack is written to stdout. However,
> we want to be able to limit the maximum size of the pack created by
> --stdout (and abort pack-objects if we are unable to meet that limit).
>
> Therefore, when used together with --stdout, we reinterpret --max-pack-size
> to indicate the maximum pack size which - if exceeded - will cause
> pack-objects to abort with an error message.

I have to say that I am not very fond of this approach.

Imagine that in the future we may want to allow 32-bit receivers to say "I
want you to transfer data but I cannot handle very large packs locally, so
please send the packs in less-than-1GB chunks to make it easier for me to
store them in separate packfiles" (obviously this involves a new protocol
extension). The underlying machinery the sending side would use would
naturally want to say

	git pack-objects --max-pack-size=1GB --stdout

and you would see the data for the first pack, followed by the data for
the second pack, etc. on the standard output.  Such a receiver might also
want to say "You are not allowed to send more than 3GB at once to me" to
the sending side. What should the "pack-objects" command line look like?

I think you should keep the two concepts separate. max-pack-size should
stay the limit of each packfile "git pack-objects" is allowed to produce,
and there should be another option to specify the total pack data to be
produced, perhaps named --max-total-pack-size or something.

That would make your earlier "count" thing --max-total-commit-count; it is
perfectly fine that we do not plan to have the --max-commit-count option
that is per packfile.

Some people may kvetch about "inconsistency", but I think this is a
justifiable inconsistency, as "You should refrain from putting more than
this number of commits in a single pack" is a limit that does not have any
practical use, while "You should refrain from sending more than this
number of commits in total" does.
