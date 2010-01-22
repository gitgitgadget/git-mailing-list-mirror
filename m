From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Thu, 21 Jan 2010 17:40:41 -0800
Message-ID: <7vpr52gbmu.fsf@alter.siamese.dyndns.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 22 02:40:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY8W9-0000Gw-B8
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 02:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab0AVBky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 20:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619Ab0AVBkx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 20:40:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab0AVBkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 20:40:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD06893CCE;
	Thu, 21 Jan 2010 20:40:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Yqy8LppU6GiXe9xwIG8GM2AkzM=; b=KY6GLT
	b9kiy062caEWd1n21Syzw0boXEAe/JiSnvyENBZgU0l4nfPIVALHaRfpaZvwWlr4
	QXqCkShRCkg00y1K0HUn6QNyeF4SpzACapDvQpAtz2/D+9f+y3wEkfBCxqpbFeFI
	2qivfOmsust1n1+zh3PCm5I/Q12lt7gjCxy5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bf3giTd56TAP6jhHq2e4vu7hoEnm1Emo
	qZ1NcdOr/sr1afQH6tB3acthBQ9GYS5FeuH3Zej4UccXnUhRNeK5JJrPMQmzn1ZA
	AdBuCxxe6dS7hrW2N3OvAwsPrpYp4y0bnr1c8o6Tzx6kNHr93FFfl8QT2uMIWEoV
	5q/ZdUSQ2Pw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AEF093CCB;
	Thu, 21 Jan 2010 20:40:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE8EE93CCA; Thu, 21 Jan
 2010 20:40:42 -0500 (EST)
In-Reply-To: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 22 Jan 2010 01\:07\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 296C575C-06F7-11DF-AB11-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137714>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/path.c b/path.c
> index 2ec950b..a195bab 100644
> --- a/path.c
> +++ b/path.c
> @@ -400,10 +400,10 @@ int set_shared_perm(const char *path, int mode)
>  	baselen = strlen(base);
>  	if (prefixcmp(abs, base))
>  		return abs;
> -	if (abs[baselen] == '/')
> -		baselen++;
> -	else if (base[baselen - 1] != '/')
> +	if (abs[baselen] != '/' && base[baselen - 1] != '/')
>  		return abs;
> +	while (abs[baselen] == '/')
> +		baselen++;
>  	strcpy(buf, abs + baselen);
>  	return buf;
>  }

Curious; why does your hunk header says set_shared_perm() while this is a
patch to make_relative_path()?  Do you run a broken git with funny
funcname regexp pattern?

The function takes two paths, an early part of abs is supposed to
match base; otherwise abs is not a path under base and the function
returns the full path of abs.

Now what is the goal of this patch?  To allow people to have duplicated
slashes at random places in either abs or base, or is it only interested
in a particular input that is malformed?  If the latter, what is the
permitted non-canonical input?

If abs were "/a//b/c" and base were "/a/b", then the combination is
rejected by prefixcmp() and full "/a//b/c" is returned.  Is it the
intended behaviour of the patch?

I would actually have expected to see something like this, but I haven't
even compile tested it, so... 

 path.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index 2ec950b..1c3570c 100644
--- a/path.c
+++ b/path.c
@@ -394,17 +394,28 @@ int set_shared_perm(const char *path, int mode)
 const char *make_relative_path(const char *abs, const char *base)
 {
 	static char buf[PATH_MAX + 1];
-	int baselen;
+	int i = 0, j = 0;
+
 	if (!base)
 		return abs;
-	baselen = strlen(base);
-	if (prefixcmp(abs, base))
-		return abs;
-	if (abs[baselen] == '/')
-		baselen++;
-	else if (base[baselen - 1] != '/')
-		return abs;
-	strcpy(buf, abs + baselen);
+	while (base[i]) {
+		if (base[i] == '/') {
+			if (abs[j] != '/')
+				return abs;
+			while (base[i] == '/')
+				i++;
+			while (abs[j] == '/')
+				j++;
+			continue;
+		} else if (abs[j] != base[i]) {
+			return abs;
+		}
+		i++;
+		j++;
+	}
+	while (abs[j] == '/')
+		j++;
+	strcpy(buf, abs + j);
 	return buf;
 }
 
