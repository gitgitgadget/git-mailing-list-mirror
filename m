From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of for-each-ref
Date: Fri, 12 Feb 2016 12:00:43 -0800
Message-ID: <xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
References: <56B32953.2010908@gmail.com>
	<20160204111307.GA30495@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, tr@thomasrast.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 21:00:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUJta-0007FY-Ai
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 21:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbcBLUAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 15:00:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750852AbcBLUAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 15:00:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2B8F4048C;
	Fri, 12 Feb 2016 15:00:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DzHzfJr3hWQFYDJjvvexJHeMgOg=; b=ZwFRaE
	jzS2Dz/EKs0IQUMzc+8/g9yK/rDpOuiRag+POPaTCJCffDPGxSpighiAC4JOJIAn
	KqLOWWEmqEj2DnCehMuILUm3b7jiuoYa51OPssaiY2YzzwM3BKd2eUHsctJVwymo
	dNtuOO8ykON7UJs4oPA1dub5p+Xxxfry2yD2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQqT1+fnTroG79fYKcVIOiLP8bvuD/O3
	9iD134ANKw6nmpepcoh0nMEVXgDlTvUcILA9O1m/94NTPuOj8CyhRs6cg6X7iN9r
	LJLt93hkvkROMo8C8Oamm2DSHfRivowFgCti0/lP7nJNkuucdDYOi7dxnUR+KCC/
	VJtf9NaxWMA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA2104048B;
	Fri, 12 Feb 2016 15:00:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 473C84048A;
	Fri, 12 Feb 2016 15:00:44 -0500 (EST)
In-Reply-To: <20160204111307.GA30495@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 4 Feb 2016 06:13:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CDD2728-D1C3-11E5-ABFD-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286074>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 04, 2016 at 11:34:59AM +0100, Sebastian Schuberth wrote:
>
>> This avoids output like
>> 
>>     warning: ignoring broken ref refs/remotes/origin/HEAD
>> 
>> while completing branch names.
>
> Hmm. I feel like this case (HEAD points to a branch, then `fetch
> --prune` deletes it) came up recently and we discussed quieting that
> warning. But now I cannot seem to find it.
>
> Anyway, I this is a reasonable workaround. Errors from bash completion
> scripts are almost always going to be useless and get in the way of
> reading your own prompt.

I think that is absolutely the right stance to take, but then I
wonder if it is a sensible execution to sprinkle 2>/dev/null
everywhere.

For example, couldn't we do something like this instead?

This is just for illustration and does not remove all 2>/dev/null
and replace them with a single redirection that covers the entire
shell function body, but something along this line smells a lot more
pleasant.  I dunno.

 contrib/completion/git-completion.bash | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba4137d..637c42d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -47,14 +47,14 @@ __gitdir ()
 		elif [ -d .git ]; then
 			echo .git
 		else
-			git rev-parse --git-dir 2>/dev/null
+			git rev-parse --git-dir
 		fi
 	elif [ -d "$1/.git" ]; then
 		echo "$1/.git"
 	else
 		echo "$1"
 	fi
-}
+} 2>/dev/null
 
 # The following function is based on code from:
 #
@@ -320,7 +320,7 @@ __git_heads ()
 			refs/heads
 		return
 	fi
-}
+} 2>/dev/null
 
 __git_tags ()
 {
@@ -330,7 +330,7 @@ __git_tags ()
 			refs/tags
 		return
 	fi
-}
+} 2>/dev/null
 
 # __git_refs accepts 0, 1 (to pass to __gitdir), or 2 arguments
 # presence of 2nd argument means use the guess heuristic employed
@@ -389,7 +389,7 @@ __git_refs ()
 			"refs/remotes/$dir/" 2>/dev/null | sed -e "s#^$dir/##"
 		;;
 	esac
-}
+} 2>/dev/null
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
 __git_refs2 ()
