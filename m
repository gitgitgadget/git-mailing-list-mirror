From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git cat-file does not terminate
Date: Fri, 04 Mar 2011 09:16:30 -0800
Message-ID: <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
References: <4D70E340.3050309@tweerlei.de>
 <20110304154014.GE24660@m62s10.vlinux.de>
 <20110304160047.GA9662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>,
	Robert Wruck <wruck@tweerlei.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 18:17:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvYcf-0001MN-Hd
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 18:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760044Ab1CDRQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 12:16:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759998Ab1CDRQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 12:16:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B077E3F8A;
	Fri,  4 Mar 2011 12:18:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OcPmFWUPegMj34IvoqAU6TwMmj4=; b=TaqnpQ
	v7qmGtsaEeiShl/M1/7rxxHnp5OIGGiWVBdxnmKtpJoO0Ovmbi+d9Kt6OhfEO1g0
	W98nskW8JOMeaCO0hPsSo3Kl/s1DZiKH5ZRmt9IEFf3KN/1fFxktbr+40fewCDRy
	PQHH0/IPOb0jXUZE8ei8orCI6qfZEQK/1nyjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rZIOVVnGh8/WypgLYpV3KBjwbSAslQO2
	aitdARwIy3mv4eZglkwL9x2/G9ZIha6PYNP/bV8hWaH0oQZzILGL/vbxWSa+WOK0
	c2MQ/y57bidcyn7WBQSMR0e5vJW/1lNsmmkf+mbjqufManEYE/X1iCFb1vn/z1Oe
	f5blnNw8HQs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C66383F85;
	Fri,  4 Mar 2011 12:18:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2184B3F77; Fri,  4 Mar 2011
 12:17:54 -0500 (EST)
In-Reply-To: <20110304160047.GA9662@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 4 Mar 2011 11\:00\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B4D4E3A-4683-11E0-B007-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168448>

Jeff King <peff@peff.net> writes:

> It would probably look like the patch below, though it really feels like
> the right solution is to fix the cygwin bug.

Thanks for a quick analysis and fix, folks.

We would need to assume certain things that the platform would give its
users are reliable, and system calls are fundamental part; otherwise we
would end up tying our hands behind our back saying "we cannot use this
and that as these are unreliable in certain places" and litter our
codebase with full of ifdefs and workarounds.

If this were merely of a breakage in a test release or a nightly build, I
would be happier to see us ignore this, but the problematic one is widely
in the wild, a workaround would be necessary, and more importantly, if it
is harder for a casual end-user to tell if the platform is affected (I am
assuming that most releases of Cygwin is without this bug, and most users
who build git themselves wouldn't bother reading README or Makefile even
if we said a MAX_WRITE_SIZE definition is necessary only for this and that
version), I would rather see a change that covers the problem a bit more
widely than necessary.

How prevalent is the problematic cygwin1.dll 1.7.8?  Also for how long did
this bug exist, in other words, if we were to make a table of problematic
versions, would we have only just a handful entries in it?  Also can we at
runtime find out what version we are running?

The reason I am asking these questions is because I think, assuming that
this would affect many unsuspecting Cygwin users, the best fix would be to
add a hook in the compat/ layer that decides if MAX_WRITE_SIZE workaround
is necessary at runtime, and do something like this:

	ssize_t xwrite(int fd, const void *buf, size_t len)
        {
        	ssize_t nr;
                static size_t max_write_size = platform_max_write_size();

                if (max_write_size && max_write_size < len)
                	len = max_write_size;
		...
	}

And then we would have in git-compat-util.h something like:

	#define platform_max_write_size() 0

on sane platforms, so that the fix will be optimized away by the compiler.

By the way, does the same version of Cygwin have similar issue on the read
side?
