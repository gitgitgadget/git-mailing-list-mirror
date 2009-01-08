From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] replace_object: add mechanism to replace objects
 found in "refs/replace/"
Date: Thu, 08 Jan 2009 15:55:32 -0800
Message-ID: <7v8wpl4akr.fsf@gitster.siamese.dyndns.org>
References: <20090107084341.1554d8cd.chriscool@tuxfamily.org>
 <7vmye3a4pt.fsf@gitster.siamese.dyndns.org>
 <200901081831.22616.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 09 00:57:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL4kJ-0007lI-RX
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 00:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbZAHXzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 18:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbZAHXzk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 18:55:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZAHXzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 18:55:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B2E11C168;
	Thu,  8 Jan 2009 18:55:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B9531C167; Thu, 
 8 Jan 2009 18:55:33 -0500 (EST)
In-Reply-To: <200901081831.22616.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu, 8 Jan 2009 18:31:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D962FDB0-DDDF-11DD-A34E-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104969>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yeah, but read_sha1_file is called to read all object files, not just 
> commits. So putting the hook there will:
>
> 	1) add a lookup overhead when reading any object,
> 	2) make it possible to replace any object,

I actually see (2) as an improvement, and (1) as an associated cost.

> And there is also the following problem:
>
> 	3) this function is often called like this:
>
> 	buffer = read_sha1_file(sha1, &type, &size);
> 	if (!buffer)
> 		die("Cannot read %s", sha1_to_hex(sha1));
>
> 	so in case of error, it will give an error message with a bad sha1
> 	in it because the sha1 of the file that we cannot read is the sha1
> 	in the replace ref not the one passed to read_sha1_file.

You have refs/replace/$A that records $B, to tell git that the real object
$A in the history is replaced by another object $B.  The caller feeds $A
in the above snippet to read_sha1_file(), and your read_sha1_file()
notices that it needs to read $B instead, returns the buffer from the
object $B, and reports its type and size.  If there is no $B available, it
may return NULL and the caller says "I asked for $A but in this repository
I cannot get to it".  That sounds consistent to me, but I agree it would
be more helpful to report "and the reason why I cannot get to it is
because you have replacement defined as $B which you do not have."

> To avoid the above problems, maybe we can try to also improve what 
> read_sha1_file does:
>
> 1) allow callers to pass a type in the "type" argument and only lookup in 
> the replace refs if we say we want a commit, but this makes calling this 
> function more error prone

This is debatable, but can go either way.

> 2) when we say we want an object with a given type, check if the object we 
> read has this type (and die if not)

That we already do anyway, don't we?  parse_commit() gets data from
read_sha1_file() and would complain if it gets a blob, etc.

> 3) die in read_sha1_file when there is an error and we are replacing so that 
> callers don't need to die themself and so that we can always report an 
> accurate sha1 in the error message

I expect the use of graft and object replacement (or if you insist,
"commit replacement") rather rare, and I think it is probably Ok to
declare it a grave repository misconfiguration if somebody claims that $A
is replaced by $B without actually having $B:

	void *read_sha1_file(sha1, type, size)
        {
		void *data;
        	unsigned char *replacement = lookup_replace_object(sha1);
                if (replacement) {
                	data = read_sha1_file(replacement, type, size);
                        if (!data)
                        	die("replacement %s not found for %s",
                                    get_sha1_hex(replacement),
                                    get_sha1_hex(sha1));
		} else {
			data = read_object(sha1, type, size);
		}
                ... existing code ...
                return data;                
        }


To disable replacement for connectivity walkers, lookup_replace_object()
can look at a some global defined in environment.c, perhaps.
