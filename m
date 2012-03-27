From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Tue, 27 Mar 2012 08:11:27 -0700
Message-ID: <7vbonikrj4.fsf@alter.siamese.dyndns.org>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
 <20120327031953.GA17338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 17:11:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCY3c-0004yu-4q
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 17:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab2C0PLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 11:11:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab2C0PLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 11:11:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A55F95956;
	Tue, 27 Mar 2012 11:11:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZpwdvxkI2/a8svZeiq4aQ8xEKwk=; b=tPHpnq
	v0PhaqrKNpm/1Ij5ay1Jr7Wp262O2K4tptHCb/j2g1S3PcGyl3hbSAHqm4vj01e6
	CVbCkbVunK1d7WuvEd0eN7rqTyTLZiB+FY7LktVi00KyEcehecfSsN87mh1HSeUs
	2ads8By3RYdDlF47XScgReY6jFqTSVHK3y9dI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofTG2bdGpLiETtFHgvGliZm/4/ZbG+ha
	eiY+3H66qVBYeEuqcrZchgMBYFGME5s+nsQfKvlpJ/bPiju8wGy+y5W5kUUchdyR
	0os8J4ADbHz2EIr2lMiItpqL1xJMH8qVQXGtjBVYjjXdrurtWH7KcaIbCSNBJbuA
	JQfGwTiLL9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BAD25955;
	Tue, 27 Mar 2012 11:11:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 051355953; Tue, 27 Mar 2012
 11:11:28 -0400 (EDT)
In-Reply-To: <20120327031953.GA17338@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 26 Mar 2012 23:19:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20F96650-781F-11E1-8606-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194048>

Jeff King <peff@peff.net> writes:

> This seems to come up about once a year....
> ...
> So basically our options are:
>
>   1. Start treating EACCESS silently as ENOENT. The downside is that we
>      fail to report the proper error when the file really does have
>      permissions problems (we would say "command not found", but that is
>      misleading).
>
>   2. Implement our own execvp, differentiating between "path not
>      available for looking in" and "we found the command, but there was
>      a permissions problem". I think somebody was working on this a few
>      months ago (search for "add exeecvp failure diagnostics") but it
>      seems to have fizzled.
>
>   3. If we get an EACCESS, remember it, try to do the alias lookup, and
>      then if that fails, report the "Permission denied" error (not
>      "command not found"). That is following the spirit of what execvp
>      does (it will find later entries in the PATH if they are there, but
>      otherwise will remember the EACCESS error).
>
> From what I can tell, dash uses stock execvp, and ends up closest to
> (3). Bash seems to have implemented their own path lookup, as it will
> distinguish between the two cases as in (2):
> ...
> I think the general feeling last time this came up was "why not just
> remove the cruft from your PATH?" But I would personally be OK with
> option (3) above, and it is probably not that hard to implement.

http://thread.gmane.org/gmane.comp.version-control.git/171755/focus=171838
shows that it was almost exactly a year ago; we tried (2) and nobody liked
it.

I got an impression from the discussion in it that #3 may give confusing
messages to the end users, but I didn't think the issues through.
