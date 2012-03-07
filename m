From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Tue, 06 Mar 2012 18:57:42 -0800
Message-ID: <7vlindp17d.fsf@alter.siamese.dyndns.org>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
 <20120306114914.GB6733@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Privoznik <mprivozn@redhat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 03:58:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S574j-0006wt-VP
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 03:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758854Ab2CGC5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 21:57:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756658Ab2CGC5p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 21:57:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E83BA6874;
	Tue,  6 Mar 2012 21:57:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RgjC2AGJmerKD8Gmh84T8JlA4pc=; b=yfFq9n
	50Uyf43Ii8lBI6SNEcrr4P7BNgzGv66UeBiH2j+dzbFmCJqUpE5R5pjnLXbk1C70
	z0HAXSQJ//vJCUmuSg3FSVgw2donmPfpUD0M+VlWeFUcEEyHYw2nF0+yBZoQB7oM
	dtKVV7a6m0W0GY4NO3VgZh+V+UAC/N0fLJHjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gx2cDCJ+n4SAY892WS1No2b3HcHD/2pm
	zNdqm7jgAEWue7K6BsQpczLjRb1OUNLyqPAHDwUWIvQdF2BpodU9wH4yaZ4wvEUn
	S+o9n1JP3OMohOsXf/72wKzfe3a7LFXHjdmRBQGG3X2LOmfzdofFmRFthBhILOZB
	7Aq5BY4wLJU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD9886872;
	Tue,  6 Mar 2012 21:57:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C2206871; Tue,  6 Mar 2012
 21:57:44 -0500 (EST)
In-Reply-To: <20120306114914.GB6733@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 6 Mar 2012 06:49:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FFA3B88-6801-11E1-B29D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192424>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 06, 2012 at 11:59:42AM +0100, Michal Privoznik wrote:
>
>> Some users like the patience diff more than the bare diff. However,
>> specifying the '--patience' argument every time diff is to be used
>> is impractical. Moreover, creating an alias doesn't play with other
>> tools nice, e.g. git-show; Therefore we need a configuration variable
>> to turn this on/off across whole git tools.
>
> The idea of turning on patience diff via config makes sense to me, and
> it is not a problem for plumbing tools to have patience diff on, since
> patience diffs are syntactically identical to non-patience diffs.

Even though I do not strongly object to the general conclusion, I
have to point out that the last line above is a dangerous thought.

If you change the default diff algorithm, you will invalidate long
term caches that computed their keys based on the shape of patches
produced in the past.  The prime example being the rerere database,
but I wouldn't be surprised if somebody has a notes tree to record
patch ids for existing commits to speed up "git cherry" (hence "git
rebase").  Also kup tool kernel.org folks use to optimize the
uploading of inter-release diff relies on having a stable output
from "git diff A..B", so that the uploader can run the command to
produce a diff locally, GPG sign it, and upload only the signature
and have the k.org side produce the same diff between two tags,
without having to upload the huge patchfile over the wire.

IOW, "syntactically identical so it is OK" is not the right thought
process.  "It may change the shape of the patch, which is a potential
problem for various tools, but as long as users understand that, it
should be allowed." is OK.

Cached patch-id database for "git cherry" would be a local and does
not affect the correctness, so I would consider breaking it is fine.

About kup use case, the potential problem can be worked around as
long as the receiving end keeps the setting vanilla (and I do not
see any reason it wouldn't) and the uploader remembers to choose the
matching variant when he locally generates the patch, so I think it
would be also OK.

Unnecessarily invalidating rerere database may be more frustrating,
but that again is local and personal, so the end user may suffer
worse than cached patch-id use case, but that hopefully is just one
time pain.

My preference however is to limit this to Porcelains only, though.
