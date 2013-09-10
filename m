From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsserver strips exec bit
Date: Tue, 10 Sep 2013 13:11:42 -0700
Message-ID: <xmqqfvtcxwqp.fsf@gitster.dls.corp.google.com>
References: <522F397E.6080709@cchtml.com>
	<xmqqa9jkzk2l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: Michael Cronenworth <mike@cchtml.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 22:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJUI0-0007NA-FU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 22:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab3IJULr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 16:11:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab3IJULq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 16:11:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1515140DA7;
	Tue, 10 Sep 2013 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y2EIw/5j6ewvj1nrSlOOWp/qtYw=; b=qT2qDi
	dxcoEvblsD35Rr7EAkMPRvyzpq7LwQapykNuC6iG+IYpJvjqQpjLeYWPMenQrLjj
	we59kWrh2/PPrlRZYiv6mwiiZEagy8kjcY1G7o6PZCvsYAQsDsYw7dcezCEK+xAO
	u4euX/RkurkdJRncU5RRdueIa8j8fhGI3Znq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OdVnTtFLSmFg/sq6angcXx2vxNYxGo+Z
	w4VHhW0np+uDqnKhyRc5jFJnmzALa+a0+TePJSyao/RuCygtFiDZD8Zq5n74uyv2
	lX+PqJjrv0bLye8lqR9VxR+4572x/rh4dOxs0FxcV+phtDc+uTpu9bp7XFr9BsJM
	mimLr0lU9EI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0947D40DA6;
	Tue, 10 Sep 2013 20:11:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B918D40DA5;
	Tue, 10 Sep 2013 20:11:44 +0000 (UTC)
In-Reply-To: <xmqqa9jkzk2l.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 10 Sep 2013 10:02:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36F31094-1A55-11E3-9F61-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234476>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Cronenworth <mike@cchtml.com> writes:
>
>> On git 1.8.1.x (Fedora 18) I was able to use the git-cvsserver to checkout code
>> to package into a tarball. Script files that were in git with 755 masks were
>> checked-out with the same mask. After upgrading the git repository machine to
>> Fedora 19 (1.8.3.1) the behaviour has changed. When I checkout the same script
>> files their mask is now 644. The mask has not changed in git.
>
> Matthew, I do not know if you are still using the git-cvsserver, but
> it seems that the only substantial change to that subsystem between
> the 1.8.1.x and 1.8.3.x is your update.
>
> Especially 2c3af7e7 (cvsserver: factor out git-log parsing logic,
> 2012-10-13) looks interesting.  It has a hunk like this:
>
> -                my $git_perms = "";
> -                $git_perms .= "r" if ( $mode & 4 );
> -                $git_perms .= "w" if ( $mode & 2 );
> -                $git_perms .= "x" if ( $mode & 1 );
> -                $git_perms = "rw" if ( $git_perms eq "" );
> +                my $dbMode = convertToDbMode($mode);
>
> with the definition of convertToDbMode being:
>
> +sub convertToDbMode
> +{
> +    my $mode = shift;
> +    ...
> +    $mode=~/^\d\d(\d)\d{3}$/;
> +    my $userBits=$1;
> +
> +    my $dbMode = "";
> +    $dbMode .= "r" if ( $userBits & 4 );
> +    $dbMode .= "w" if ( $userBits & 2 );
> +    $dbMode .= "x" if ( $userBits & 1 );
> +    $dbMode = "rw" if ( $dbMode eq "" );
> +
> +    return $dbMode;
>
> The $mode in the caller comes from diff-tree output (the post-change
> side of the mode string, like "100755").
>
> Picking the third digit from the left (i.e. "10'0'755"), instead of
> the tail digit (i.e. "10075'5'"), looks strange.
>
> Side note: now I look at it, the original does not make much sense
> for that matter.  "100755" & 4 is different from oct("100755") & 4.

I stopped interacting with CVS quite a long time ago, so I do not
have any way of verifying, but the fix may be just the matter of
something like this.

I am not sure if we want to use the owner bit (i.e. 4th place)
instead of the other bit (i.e. the last place) like this patch does,
though.  The old code in 1.8.1.x would have produced either "r" (for
100644) or "wx" (for 100755); I think that the result of applying
this patch would give us "r" (for 100644) or "rx" (for 100755).

-- >8 --
Subject: cvsserver: pick up the right mode bits

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

Let's use the last digit of the octal mode string to make sure we
get the executable and read bits right.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 git-cvsserver.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a0d796e..b1d7a4c 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -4167,7 +4167,7 @@ sub convertToDbMode
     #  this half-converted form, but it isn't currently worth the
     #  backwards compatibility headaches.
 
-    $mode=~/^\d\d(\d)\d{3}$/;
+    $mode=~/^\d{5}(\d)$/;
     my $userBits=$1;
 
     my $dbMode = "";
