From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filenames and prefixes in extended diffs
Date: Wed, 13 Jan 2010 16:16:21 -0800
Message-ID: <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 01:16:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVDO8-0005Yg-JD
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 01:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab0ANAQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 19:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755769Ab0ANAQa
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 19:16:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab0ANAQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 19:16:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5AD49085C;
	Wed, 13 Jan 2010 19:16:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Q6TzmHN0ehq4CXGBja8E8XZRZM=; b=oDBgh9
	nYv3AAWxtX7ZKN3YKP4LaZnoorgSssGZg2SWPH4r9rJZVdbQc/UTQSd9UVT0xcw3
	C/RCLxJ/A+YRGMmfcr2UrkYvHWNE7eAsSp1OFla6bJUS1c1QDq5vTj81b3RwNuLW
	e7nZRODQFkPHW7S2spVtMcvfY0M3R/rTVnsIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWtPSG9cBCAwPgvXo7hPtnXnUV9pkf7g
	VOEIH4dRfY1snUZWc9a8izsRbyWvHfUEYxdRxRGYpzTzdggIVTKgn5prwyjschvJ
	ObcMfma0xyGOetGA1GX+ZG7vdjmHBaeKTaVuh7T5od5yw1pea+eFYYxBgBBQE5d8
	NaZ7t+33VSs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90FD29085B;
	Wed, 13 Jan 2010 19:16:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B05C890856; Wed, 13 Jan
 2010 19:16:23 -0500 (EST)
In-Reply-To: <201001131713.05505.agruen@suse.de> (Andreas Gruenbacher's
 message of "Wed\, 13 Jan 2010 17\:13\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E193110-00A2-11DF-BDC3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136901>

Andreas Gruenbacher <agruen@suse.de> writes:

> Can git be changed to ...

Just to save your time coming up with more ways to *change* git diff...

Even though I wouldn't say _any_ change is too late to bring in, change in
the output format from "git diff" family _must_ be usable by "git apply"
people have been using for the last 4 years or so.

Suppose your updated version of "git diff" with a certain set of options
produces output A, which is different from the output B you would get out
of today's "git diff" that is run with the same set of options.

If "git apply" people have been using understands B (i.e. current output)
and does something, the format change between A and B must be designed in
such a way that the same "git apply" accepts A (i.e. your output) and do
the same thing.

Two examples:

 - "git diff -M" (or "git show -M") is _defined_ to show the filenames
   without prefix on "rename from" line, and deployed "git apply" relies
   on this definition to apply the patch to the file the patch was meant
   to apply.  If your modified "git diff -M" changes it to add the prefix,
   and existing "git apply" changes behaviour (either by rejecting your
   output, or applying the patch to a wrong file), then such a change has
   *no chance* of getting in.  It is merely a breakage.

 - If you say "git diff --src-prefix=a/b/c --dst-prefix=x/y", it _might_
   produce something "git apply" won't grok (I haven't checked this,
   though).  You can suggest to change the output from such a case to work
   better.  We didn't work as expected so a change _could_ be a fix.

The output from "git diff --no-index" is an exception to the above rule.
It is primarily for people who have unmanaged contents and want to use
features of the git diff engine that are not found in other people's diff
implementations (e.g. wordwise colored diff), and the header part of its
output does not currently follow "git diff" convention to be grokkable by
"git apply".

Fixing _that_ is a welcome change, but I suspect that there are corner
cases, e.g. "git diff --no-index frotz-1.2.36/ /tmp/frotz/" (i.e. you have
a pristine version in frotz-1.2.36 directory, but your modified version is
in /tmp/frtoz/) that might make fixing it fundamentally impossible (I
haven't looked into it for a long time, so it could be easy, but my gut
feeling is it isn't).
