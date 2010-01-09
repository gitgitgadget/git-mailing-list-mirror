From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Fri, 08 Jan 2010 16:06:09 -0800
Message-ID: <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
 <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
 <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 01:06:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTOqf-0006nx-0n
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 01:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab0AIAG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 19:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754172Ab0AIAG2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 19:06:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab0AIAG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 19:06:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 485C18F633;
	Fri,  8 Jan 2010 19:06:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T1QeVai9LuQlJ6ceaTnkgScOhTo=; b=MKA2Vc
	16Nz5HzsN5l7+LPoMKekZ/vnj9y3Xm1zN8vYTsBvsVNnq/ZgLuD9OW70MqXsOuyB
	FkvUMwAPfFM3o9+QrD/EEXUtPSUnMyLYeUG6UXNg9pVb7wx2OJciiDmTIDFQ+uc0
	IgcaadMCKJwVMT62n0uIHAHRDS/m7dIT/UaMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aYyghUaVVpDmn4FzvZ9XTKjKKEujUuJ5
	BpyFmyDAKYcX1KWopViO6uRz/tEG7w0VmqnalsuIexM4SRNA5tPEFN8u7Aiuq3RO
	H28FPfcuvO7cVBUi12wLXVQ8lOJw44vWxtNERE/yWryMCKdAYPG0Om5djcIkcU6/
	1Ja8c2j/E9U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D22178F62D;
	Fri,  8 Jan 2010 19:06:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76B988F62B; Fri,  8 Jan
 2010 19:06:11 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
 (Linus Torvalds's message of "Fri\, 8 Jan 2010 15\:24\:13 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D064165C-FCB2-11DE-814D-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136498>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 8 Jan 2010, Junio C Hamano wrote:
>>
>> Given pathspecs that share a common prefix, ls-files optimized its call
>> into recursive directory reader by starting at the common prefix
>> directory.
>> 
>> If you have a directory "t" with an untracked file "t/junk" in it, but the
>> top-level .gitignore file told us to ignore "t/", this resulted in an
>> unexpected behaviour:
>
> Ok, I'm not sure how "unexpected" this is, since arguably you are 
> overriding the ignore file by _being_ in that directory (the same way 
> index contents override ignore files), but I could go either way on that.
>
> Your patch looks fine, although I think you did this in a very odd way.

Actually, there is some funny interaction with "git add" I ran out of time
to figure out what the right fix should be:

    $ git init new
    $ cd new
    $ mkdir t
    $ >kuzu
    $ >t/gomi
    $ echo t >.gitignore
    $ echo kuzu >>.gitignore
    $ git add kuzu
    The following paths are ignored...
    kuzu
    Use -f if you really want to add them.
    $ git add t/gomi

Since "git add" uses the exact same codepath to find the untracked files
that match the pathspecs, I expected the "fix" will make it complain about
"t/gomi" being ignored.  Not so.

Actually, it does start ignoring t/gomi (the index does not have t/gomi
after the above sequence with the patch), but lack of the error message
makes it a rather unfortunate regression---it works as specified in the
sense that ignored paths are not added to the index unless --forced, but
it does so without telling the user about it.
