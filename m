From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep for
 fixed-strings
Date: Fri, 06 Nov 2009 02:00:11 -0800
Message-ID: <7vbpjg0y8k.fsf@alter.siamese.dyndns.org>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
 <20091106084855.GA20964@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Collins <bricollins@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 11:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6LcP-00025R-2S
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 11:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbZKFKAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 05:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZKFKAS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 05:00:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbZKFKAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 05:00:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 263A494B4D;
	Fri,  6 Nov 2009 05:00:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pyUK2CEL4GARilBRY1IISGuIeWc=; b=H9Mp2o
	z3rMSRnUgAq5YqCPCvSpZQ15axA99vWWX72YmABD5/efDo30Rfe2o5jr97e1sK5F
	UGHhkW7llA7EfBNBbb3aID8M4FidxTGlWk7clKXEUTocMMv8AWaOIJC3Bn8xB51m
	HgrsrqksABUkFkvLihukyft4Yt5SzNxWWyujM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QDpPeFGmrRhxOWUMqWXxIApkHnjUZB0t
	HEDHCx5iZVQl1pvumbXVWcjnIENdtbDIwisaijkfBoLgZLX+6TvhuEYGqITCcxDB
	/uiJF/b+OIiL/rMZmCDBLQyNVqZCYciJX6tjIi2yee72y1wPyjSsrUaY3tqJ25sS
	FFNKq/QEawU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECB2D94B4C;
	Fri,  6 Nov 2009 05:00:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C2DF94B4B; Fri,  6 Nov 2009
 05:00:13 -0500 (EST)
In-Reply-To: <20091106084855.GA20964@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 6 Nov 2009 03\:48\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2FEA2FDC-CABB-11DE-8304-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132294>

Jeff King <peff@peff.net> writes:

>> git-grep currently throws an error when you combine the -F and -i
>> flags. This isn't in line with how GNU grep handles it. This patch
>> allows the simultaneous use of those flags.
>
> I don't see a reason not to allow this combination if our grep
> implementation supports it. My only reservation would be that we
> sometimes call out to an external grep, and non-GNU grep might barf on
> this. But I think that is OK, as the user should get a sane error from
> the external grep.

I think that is OK but not for the reason you stated.  The user should
never get such an error message.

The reason why I think this is OK is because the builder can choose to use
NO_EXTERNAL_GREP if the external grep does not allow this combination.

We need to update comments on the Makefile if we are going to take this
patch.  Currently the description suggests three possible reasons you
might want to choose NO_EXTERNAL_GREP.  "lacks grep" is obvious, "slower"
is not about correctness, but "is broken" is way underspecified, and this
patch adds one more reason to label your "grep" as broken.

Currently, SunOS and IRIX/IRIX64 are the only ones that specify
NO_EXTERNAL_GREP, and I suspect both are defined due to "is broken", but
we do not tell the builder in what way they are considered broken, iow,
what features we expect from the platform "grep", so somebody coming up
with a new port would be at loss.

I suspect 01ae841 (SunOS grep does not understand -C<n> nor -e, 2009-07-23)
would be a good starting point.  Something like this...

    # Define NO_EXTERNAL_GREP if you don't want "git grep" to ever call
    # your external grep (e.g., if your system lacks grep, if its grep
    # does not support necessary features, or spawning external process is
    # slower than built-in grep git has).  To be usable, your grep must
    # support -C<n> (show n lines of context), -e <pattern> (primarily
    # used to quote a pattern that begins with a dash), and use of -F and
    # -i at the same time.  Otherwise define this.

But I didn't try hard to find out what _else_ we are depending on.

> Tests? They help prove to us that your feature works, and also prevent
> us from accidentally breaking your feature in the future.

Yeah, thanks.  The latter is the primary purpose of test.
