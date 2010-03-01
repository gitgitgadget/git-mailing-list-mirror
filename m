From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Mar 2010 09:23:23 -0800
Message-ID: <7v1vg4ufas.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <4b8bf32f.0706c00a.26cb.691d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 18:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm9LI-00060t-8l
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 18:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab0CARXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 12:23:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab0CARXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 12:23:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D8DE9E5C7;
	Mon,  1 Mar 2010 12:23:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bGj9PcOMQnM8lCb307V7i2GaR64=; b=u2DsoN
	zCJNdSDa8/1IsTlLr3/cNcEklBwMorGHm9YRfXtIYlV1001wy55tsLtA0nW2PzTB
	TjnuO5T2Bh1f862LThvXFN3xutX+kzF58vmphP3bXeSdIh0pTwWi4rw/60Flrpma
	5cBUo7g/XZEh4etsgTCemnH1e5GKusHIC4FG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1m8AHuPb4U6U8TTLWQxuqQWZlUBZqXX
	KKFxUomYtkGm6CLe0bQzRcDlgtMYVEtLajDqyohlESXU1b6WuuzoM4C4T7vAW2Nj
	EGYwGD7Wh1VG0N7VD5zL/T7m+YrDaiC0PfsWtRBqZ+LCWsgRBW2TM0aYj13bRu6V
	tr9sTFsEqZ0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C6A89E5C6;
	Mon,  1 Mar 2010 12:23:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87DAF9E5C2; Mon,  1 Mar
 2010 12:23:25 -0500 (EST)
In-Reply-To: <4b8bf32f.0706c00a.26cb.691d@mx.google.com> (Michael Witten's
 message of "Mon\, 01 Mar 2010 09\:02\:39 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 27106740-2557-11DF-A109-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141335>

>Michael Witten <mfwitten@gmail.com> writes:

> ..., I think you essentially want to implement
> "git checkout" with something like the following (this hack is **not**
> meant as a solution; it is only meant to illustrate what I think is
> Markus Elfring's desire):

Your "checkout" needs a bit better error checking.  For example, you don't
want to "reset --hard" when stash failed for whatever reason.

For performance and cleanliness reasons, it should first try a branch
switch, and only after seeing it fail due to local changes, perform your
stash-unstash magic.  You would probably want to use the usual "stash
save", as you will be consuming the stashed change yourself as its first
user, and "pop" will clear it if things resolve cleanly, or the stash will
be left as the first element to make it easy to re-attempt the conflict
resolution.  No need for stash-id nor special casing of detached HEAD
situation.

And it should do all that only under "-m" option, i.e. when the user
indicated that s/he is willilng to face conflict resolution while
switching.  That would be a genuine improvement compared to the current
system (and I suspect it would be easier to implement).  "checkout -m" so
far has been as bad as "CVS/SVN update" in that it can get you into an
unresolvable mess without a chance to go back and retry.  autostash will
remedy that.
