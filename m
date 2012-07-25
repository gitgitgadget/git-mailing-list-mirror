From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] help.c::exclude_cmds: realloc() before copy, plug
 a leak
Date: Wed, 25 Jul 2012 10:39:37 -0700
Message-ID: <7v394fd9k6.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 19:39:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su5Yn-0004oD-TV
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 19:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab2GYRjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 13:39:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab2GYRjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 13:39:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 811858C8C;
	Wed, 25 Jul 2012 13:39:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AqQr0OsTjuM2CZxZ4q4BbK7g3JA=; b=CsnzOA
	xQiyONcwFbN/ztY4+MvOkUlc6I6IOPpGEMVsimq4TcP6k+i245YO/rE/9nhwT7Ld
	r/UrTZYEVnj2tfu3pBGzUHN13i/xtJ1aQRlusr4/+DtMcl95IXhEqAQ/MNpEC5jI
	uPLNlWjadNa889rSVoGf4EAAtTxU77Ka67m00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iss82fNBQgyvjTke5zDFrU43frUhCC4C
	BP4DL1qTZ6Qc10r26zIjalFu0rFRRSYWi3CU3K5xmMFilyR0lmxcWvWjYKPZpHYS
	tEooFyjbfhXr/ZTtZEenEjvWyNuJiHr9C5MzJVHHoRGhXqqxdSFDo49jqqBuyBhz
	JM4ajbYxMyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FBED8C8A;
	Wed, 25 Jul 2012 13:39:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A78518C89; Wed, 25 Jul 2012
 13:39:38 -0400 (EDT)
In-Reply-To: <1343232982-10540-3-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu, 26 Jul 2012 00:16:20 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5319E78-D67F-11E1-B5C8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202179>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Copying with structural assignment may not take into account that the
> LHS struct has sufficient memory, especially since the cmdname->name
> member is nonfixed in size. Be unambiguous about it by realloc()'ing it
> to be of sufficient size.

If the original code were

	*(cmd->names[cj++]) = *(cmd->names[ci++]);

there may be a structural assignment involved, but

	cmds->names[dst] = cmd->names[src]

just copies the pointer that points at a struct cmdname that records
the src command name to another slot of cmds->names[] array, whose
elements are pointers, no?  What's there to realloc?

> @@ -58,20 +69,25 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
>  {
>  	int ci, cj, ei;
>  	int cmp;
> +	int last_cj;
>  
>  	ci = cj = ei = 0;
>  	while (ci < cmds->cnt && ei < excludes->cnt) {
>  		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
>  		if (cmp < 0)
> -			cmds->names[cj++] = cmds->names[ci++];
> +			copy_cmdname(&cmds->names[cj++], cmds->names[ci++]);
>  		else if (cmp == 0)
>  			ci++, ei++;
>  		else if (cmp > 0)
>  			ei++;
>  	}
> +	last_cj = cj;
>  
>  	while (ci < cmds->cnt)
> -		cmds->names[cj++] = cmds->names[ci++];
> +		copy_cmdname(&cmds->names[cj++], cmds->names[ci++]);
> +
> +	while (last_cj < cmds->cnt)
> +		free(cmds->names[last_cj++]);
>  
>  	cmds->cnt = cj;
>  }

We shifted cmds->names[] array to skip entries that appear in
excludes.  If original cmds->names[] had "0", "1", "2", "3", ...
and excludes had "0" and "1", cmds->names[] would contain "2", "3",
"2", "3"; the first two are copied over "0" and "1" that are
excluded, and the latter two are leftover beyond last_cj.  The
corresponding names share the same structure (cmds->names[] is an
array of pointers).  Doesn't freeing cmds->names[2] free the
structure that is used by both cmds->names[0] and cmds->names[2]?

Confused.

The function drops cmds->names[ci] when it appears in excludes, so
you may want to free it when it happens, though.

 help.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 6991492..cae389b 100644
--- a/help.c
+++ b/help.c
@@ -64,9 +64,10 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
 		if (cmp < 0)
 			cmds->names[cj++] = cmds->names[ci++];
-		else if (cmp == 0)
-			ci++, ei++;
-		else if (cmp > 0)
+		else if (cmp == 0) {
+			ei++;
+			free(cmd->names[ci++]);
+		} else if (cmp > 0)
 			ei++;
 	}
 
