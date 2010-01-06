From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filename quoting / parsing problem
Date: Tue, 05 Jan 2010 17:08:06 -0800
Message-ID: <7viqbgniq1.fsf@alter.siamese.dyndns.org>
References: <201001011844.23571.agruen@suse.de>
 <201001021236.26947.agruen@suse.de> <7v8wcge4kr.fsf@alter.siamese.dyndns.org>
 <201001022148.47841.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:08:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKNm-0007E0-Pq
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab0AFBIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755201Ab0AFBIP
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:08:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab0AFBIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:08:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D98B5AD4CE;
	Tue,  5 Jan 2010 20:08:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=aCuNYRP6F8w/BxzYUZfHHf/P98U=; b=Q6yucK
	iTrjj8Jtp0njvYp/flb6l4GoFgtsHoF5HfmZlL6Y/GVsiEYaVRnMmmRnCDhl3zPB
	b2zM8w8bD2iQcg3Za9wocWN6deClgTPMJxJ28Kbg10Z17Be+WlKmgGwvigTKaMIH
	tCqK+nk9XR2CZw7nzA6DTNRIw3AnRqVh95SAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=doNNlm+YW0fMxixjtuAdJXgQQ0oBgH7M
	F2KC4GzvZkJvpNGE1PFtzlUlPvN8g0xaNqgdJXDZI7bdFQwELM53N1NLn5L7Slod
	hMTRJZBb4CP41HxwrxioFHBKwVQqEU8eBz8GljcNUOk2glWWQlNKqnkqOIBMLnKC
	4jFXx7DKOtE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B5EFBAD4CD;
	Tue,  5 Jan 2010 20:08:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 92EEEAD4CA; Tue,  5 Jan 2010
 20:08:08 -0500 (EST)
In-Reply-To: <201001022148.47841.agruen@suse.de> (Andreas Gruenbacher's
 message of "Sat\, 2 Jan 2010 21\:48\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F5987878-FA5F-11DE-9D80-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136232>

Andreas Gruenbacher <agruen@suse.de> writes:

> Right now, git generates lines like "diff --git a/f a/f b/f b/f" in some 
> corner cases, and from such lines alone, it is not possible to tell what the 
> two file names are (either "a/f a/f" and "b/f b/f", or "a/f a/f b/f" and 
> "b/f").  I can only find that out by looking at the other header lines.

I would understand "a/f a/f b/f a/f", which would be a diff of "f a/f"
between two versions.

"a/f a/f b/f b/f" could be rename from "f /a/f" to "f b/f" (or "f a/f b/f"
to "f").  But you will always get "rename from" and "rename to" in that
case.

So you can (and I think git-apply does) follow this simple rule:

    If you see +++/---/rename from/rename to/new file/deleted file, use
    the names you find there.  Otherwise, because there is no rename,
    "diff --git" lines has two identical names that follow a/ and b/, so
    use that name.

The parsing code in builtin-apply.c is not so dense; you should be able to
lift it from there, I think.

Although an output of "a/f a/f b/f b/f" without "rename from/to" is
possible with --no-index of two unrelated files, --no-index output is not
even something that is meant to be appliable, so I wouldn't worry too much
about it.
