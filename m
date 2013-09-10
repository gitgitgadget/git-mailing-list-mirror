From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsserver strips exec bit
Date: Tue, 10 Sep 2013 15:33:06 -0700
Message-ID: <xmqqtxhsux25.fsf@gitster.dls.corp.google.com>
References: <522F397E.6080709@cchtml.com>
	<xmqqa9jkzk2l.fsf@gitster.dls.corp.google.com>
	<xmqqfvtcxwqp.fsf@gitster.dls.corp.google.com>
	<522F9B1D.3070100@cchtml.com> <522F9BBE.404@cchtml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: Michael Cronenworth <mike@cchtml.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWUl-0000aF-4R
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab3IJWdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:33:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab3IJWdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:33:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D3E740C1D;
	Tue, 10 Sep 2013 22:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y1IdbJ9BhcSC2prdPt5l0nLA5Dg=; b=wWDdqv
	jiDau5q7AX1Tklo75aVC3c2/9zTWa64h3LyRUXwV0QkYZxlZ0UY9WPxlGEiL7Npt
	vDER4ykpNstTfOKIXdmDoRye/YvZBUh+3T//4HxXHbvlnbNoi01VTDjIH/tjbj72
	OkApRhInxURAcvmAwxU3NILSDFikGhlirzEHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S+ze6zAGj6JhWDfHdIYjj4ibw7A57UID
	6tFYZzl7KKM4bWG6dGqnYASMIKJx1f9hkrDQaHSyedj+pFFfoElJJZx0g8Qm8FFj
	X2IvEr71ygDzrkvQmuBrxB2YKy8A60amT1dua9oPhZzrlF/Kv58GAV/keklIZgOP
	ABXPSgmkBjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8321A40C1B;
	Tue, 10 Sep 2013 22:33:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E501440C13;
	Tue, 10 Sep 2013 22:33:07 +0000 (UTC)
In-Reply-To: <522F9BBE.404@cchtml.com> (Michael Cronenworth's message of "Tue,
	10 Sep 2013 17:22:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7514488-1A68-11E3-8AA2-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234497>

Michael Cronenworth <mike@cchtml.com> writes:

> Michael Cronenworth wrote:
>> This fix is close. Now all files are checked out with a mask of 555.
>
> Let me clarify.
>
> Git mask 755 => CVS mask 555
> Git mask 644 => CVS mask 444
>
> Thanks,
> Michael

Then what I wrote was actually relevant ;-)

    I am not sure if we want to use the owner bit (i.e. 4th place)
    instead of the other bit (i.e. the last place) like this patch does,
    though.  The old code in 1.8.1.x would have produced either "r" (for
    100644) or "wx" (for 100755); I think that the result of applying
    this patch would give us "r" (for 100644) or "rx" (for 100755).

This should then work, I would think.

-- >8 --
Subject: [PATCH v2] cvsserver: pick up the right mode bits

When determining the file mode from either ls-tree or diff-tree
output, we used to grab these octal mode string (typically 100644 or
100755) and then did

	$git_perms .= "r" if ( $mode & 4 );
	$git_perms .= "w" if ( $mode & 2 );
	$git_perms .= "x" if ( $mode & 1 );

which was already wrong, as (100644 & 4) is very different from
oct("100644") & 4.  An earlier refactoring 2c3af7e7 (cvsserver:
factor out git-log parsing logic, 2012-10-13) further changed it to
pick the third octal digit (10*0*644 or 10*0*755) from the left and
then do the above conversion, which does not make sense, either.

Let's use the third digit from the last of the octal mode string to
make sure we get the executable and read bits right.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 git-cvsserver.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a0d796e..67b1e7b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -4167,7 +4167,7 @@ sub convertToDbMode
     #  this half-converted form, but it isn't currently worth the
     #  backwards compatibility headaches.
 
-    $mode=~/^\d\d(\d)\d{3}$/;
+    $mode=~/^\d{3}(\d)\d\d$/;
     my $userBits=$1;
 
     my $dbMode = "";
