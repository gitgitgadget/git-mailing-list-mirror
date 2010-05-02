From: Junio C Hamano <gitster@pobox.com>
Subject: Re: new platform & S_IFGITLINK problem
Date: Sat, 01 May 2010 19:33:26 -0700
Message-ID: <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
X-From: git-owner@vger.kernel.org Sun May 02 04:56:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8PLo-0002MW-AC
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 04:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618Ab0EBCdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 22:33:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab0EBCde (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 22:33:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F89BAFCEE;
	Sat,  1 May 2010 22:33:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DxKQiAyjm6UfSlAkyLpMRh7r/Bw=; b=WEpwo3
	bid7WvnEM8wiESoaih1wPHk9Ag2u3I61dcNzXBGTU0mG8oIVtvP1Dlfp/j2qzQKI
	R4cXfZXF95QX4lh8JPJsUd8hZzSQ53g9u5LNOTCmrrobaPrpt58lqLrCL2CkLEvK
	Hdvft7UqsCjvKev4ZuOHwhsDzMRdGEcSrQ16o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yOY6jx5wj650lYP4Wh+9f7qVpEwyfywB
	SlAPoDXyc2nvOr242RiZq0/UwuAdNDVU8f2lZENOO1TusfzlA6Bo0SfmdGA9P6Aj
	/gfCtolMA3yI+tMIkILUrhHc0vclzELrpixmXiXVyt/6xdrWN0rCR2/+ZHrn9uX8
	q9dvwZn5DIE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BF52AFCEC;
	Sat,  1 May 2010 22:33:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7D3DAFCEB; Sat,  1 May
 2010 22:33:27 -0400 (EDT)
In-Reply-To: <1272756555.13488.1314.camel@jetpack.demon.co.uk> (Alan
 Hourihane's message of "Sun\, 02 May 2010 00\:29\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 186DF524-5593-11DF-B8F9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146125>

Alan Hourihane <alanh@fairlite.co.uk> writes:

> Just joined as I'm compiling git on a new platform and wondered if
> someone can help solve a problem with the definition of S_IFGITLINK.

Yikes.  The current codebase pretty much assumes that IFREG is 0100000,
IFDIR 0040000, and IFLNK 0120000, and the bits read from "struct stat" and
the mode bits we store in the index and tree objects are interchangeable.

Yes, that assumption is a gross POSIX violation but we so far haven't seen
any platform that matters in real life that assigns the IFMT bits
differently.

We would need to:

 (1) rename S_IFGITLINK to GIT_S_IFMODULE;

 (2) define GIT_S_IF{REG,DIR,LNK} as 0100000, 0040000, and 0120000;

 (3) write MODE_SYSTEM_TO_GIT() macro to convert from S_IF{REG,DIR,LNK} we
     read from struct stat to the "canonical" GIT_S_IF{REG,DIR,LNK}
     values; and

 (4) change all the code that read mode from struct stat and use it to
     first use MODE_SYSTEM_TO_GIT().

Currently 'git grep -e "S_IF[A-Z]" -e "struct stat"' reports around 250
hits, so it is not infeasible amount of work, but it is not a trivial and
mechanical replacement, either.  I or somebody need to set aside a block
of time to do this clean-up and audit the result.

Thanks for a report.
