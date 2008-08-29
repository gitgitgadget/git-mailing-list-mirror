From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Expand ~ and ~user in core.excludesfile,
 commit.template
Date: Fri, 29 Aug 2008 09:08:35 -0700
Message-ID: <7vsksn4xdo.fsf@gitster.siamese.dyndns.org>
References: <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
 <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
 <20080827002506.GB7347@coredump.intra.peff.net>
 <quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>
 <7vy72jrr00.fsf@gitster.siamese.dyndns.org>
 <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
 <20080829032630.GA7024@coredump.intra.peff.net>
 <7vod3ca2ey.fsf@gitster.siamese.dyndns.org>
 <quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ6Xn-0000or-NF
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 18:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbYH2QIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 12:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYH2QIq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 12:08:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbYH2QIp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 12:08:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F83E6C14B;
	Fri, 29 Aug 2008 12:08:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 30E956C149; Fri, 29 Aug 2008 12:08:37 -0400 (EDT)
In-Reply-To: <quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu> (Karl
 Chen's message of "Fri, 29 Aug 2008 02:29:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C0A10DB6-75E4-11DD-85C7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94306>

Karl Chen <quarl@cs.berkeley.edu> writes:

> These config variables are parsed to substitute ~ and ~user with getpw
> entries.
>
> user_path() refactored into new function expand_user_path(), to allow
> dynamically allocating the return buffer.
>
> Signed-off-by: Karl Chen <quarl@quarl.org>

Thanks.

> ... Anyway, I accept the color you picked for this
> bikeshed.

I do not think Documentation/CodingStyle is bikesheding but just behaving
like Romans do while in Rome, so that the end result will blend in better.

>     Hannes> You really should use the strbuf API here. Look for
>     Hannes> strbuf_detach() in the existing code.
>
> Unfortunately expand_user_path() needs to support both a fixed
> buffer and mallocing return.  I don't think the strbuf API can do
> that easily?

I do not see any strong reason why the single caller of user_path() has to
keep using the static allocation.  Would it help to reduce the complexity
of your expand_user_path() implementation, if we fixed the caller along
the lines of this patch (untested, but just to illustrate the point)?

 path.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git i/path.c w/path.c
index 76e8872..c5b253c 100644
--- i/path.c
+++ w/path.c
@@ -221,19 +221,22 @@ char *enter_repo(char *path, int strict)
 		if (PATH_MAX <= len)
 			return NULL;
 		if (path[0] == '~') {
-			if (!user_path(used_path, path, PATH_MAX))
+			char *newpath = expand_user_path(path);
+			if (!newpath || (PATH_MAX <= strlen(newpath))) {
+				if (path != newpath)
+					free(newpath);
 				return NULL;
+			}
 			strcpy(validated_path, path);
-			path = used_path;
-		}
-		else if (PATH_MAX - 10 < len)
-			return NULL;
-		else {
+			path = newpath;
+		} else {
 			path = strcpy(used_path, path);
 			strcpy(validated_path, path);
 		}
 		len = strlen(path);
 		for (i = 0; suffix[i]; i++) {
+			if (PATH_MAX <= strlen(suffix[i] + len))
+				continue;
 			strcpy(path + len, suffix[i]);
 			if (!access(path, F_OK)) {
 				strcat(validated_path, suffix[i]);
