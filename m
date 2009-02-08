From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] use lock token in non-URI form in start_put
Date: Sun, 8 Feb 2009 11:28:27 +0800
Message-ID: <be6fef0d0902071928w1d9c5a0ej851c6ef7d61c8c5@mail.gmail.com>
References: <498DE0B9.6080603@gmail.com>
	 <alpine.DEB.1.00.0902072114360.10279@pacific.mpi-cbg.de>
	 <7v1vuavv4l.fsf@gitster.siamese.dyndns.org>
	 <be6fef0d0902071745r355309c2o76622b3af8df53bc@mail.gmail.com>
	 <7vzlgx3bnt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 04:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW0P3-0001Nw-DV
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 04:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbZBHD2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 22:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbZBHD23
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 22:28:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:14333 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZBHD22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 22:28:28 -0500
Received: by wa-out-1112.google.com with SMTP id v33so674285wah.21
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 19:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cGCgrzxc+/6dBVNBjgg/sCVzPuaNkDsdzok04u/8RCU=;
        b=DHL8AZslzb7axE0qwQbv3K5AxQqRN+f30xVlXU5Sbal9xINhKy1pu5fb8eth2LuPl5
         FjV1CSZR9g5pGZZ3jV0JUB9pX2X74eIu/PkSDeXQQxVvSHETqsYpbRLhiWXM1RNlweju
         hgPhDujrHUJExnlk+SKV9WhAIWo2ERyqsK7jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XD0KviuPaOZMocGwPKorYrKjHP1fKYaQiuValgIS2J33nb+qcqCCWEy68NKz4tXME2
         h+daVB8ZBeoxHWaH31siha5pKF04z8Y7NzmtO1dtTflvhcxth4aXReBcPXFzMkuUsMcs
         r6VrAPRlAVXjOj58LMZy4f+Cg6FnTFyNhjqU8=
Received: by 10.115.58.18 with SMTP id l18mr482989wak.31.1234063707840; Sat, 
	07 Feb 2009 19:28:27 -0800 (PST)
In-Reply-To: <7vzlgx3bnt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108915>

Hi,

On Sun, Feb 8, 2009 at 10:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I somehow thought that the natural reading of the guarantee is *not* that
> the tokens are unique over the lifetime of the server installation (iow, a
> lock token you obtained today will never be used in the future, and it is
> a token that the server never has used before), but it merely guarantees
> that there are no any two outstanding locks that share the same URI, lest
> one client's unlock request breaks the wrong lock.  But I may be wrong here.
>
> ...
>
> What breaks and how, if we do not even use a random string but a fixed
> suffix ".temp" here?  I am not suggesting we actually do that, but I'd
> like to see how important the uniqueness is here to better understand the
> issue.

Having a temporary file dually ensures 1) no repository corruption 2)
no pushing simultaneously to a object file. I think an example of a
racy situation would help illustrate why a unique temporary file is
needed (pun not intended).

Imagine if two git clients, A and B, are trying to push to the
repository at the same time. Let's assume that A is our "official"
implementation of http-push, while B is a rogue, forked implementation
of A. B is rogue because, unlike A, it doesn't care about locks on
info/refs, refs/head/<branch>, etc. -- stuff that A checks for before
beginning pushing objects. But apart from that, A and B are similar in
all other aspects.

It so happens that they're pushing the same object, say, X, to the
same repository. A starts first, and during the period of the transfer
of object X, B starts too.

If we had used the ".temp" as you had suggested, we would have some
problems due to unexpected behaviour as a result of A's and B's
simultaneous writing to the file X.temp.

If we had used the token instead for the temporary file name, the
chances of this occurring is lowered, but still possible. That's
because we're using a token from a lock somewhat arbitrarily. For
example, if A was pushing to the branch "branch_A", it would lock
refs/heads/branch_A and use that lock token, and if B was pushing to
"branch_B", it would use the lock token obtained from locking
refs/heads/branch_B.

Going back to your first point on the uniqueness of the lock token,
one only needs a token that's unique for the locks currently in
effect. If the server had given us a token that had been used before,
but isn't used by anyone else *now*, then it's ok, since we wouldn't
be overwriting anybody else's file.

Thus, a token that's unique *now* is sufficient.

-- 
Cheers,
Ray Chuan
