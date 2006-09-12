From: Junio C Hamano <junkio@cox.net>
Subject: Re: problem with http clone/pull
Date: Tue, 12 Sep 2006 16:43:42 -0700
Message-ID: <7vodtkejm9.fsf@assigned-by-dhcp.cox.net>
References: <17671.16741.995661.664789@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 01:42:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNHts-0001c5-IW
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 01:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWILXmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 19:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWILXmm
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 19:42:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:3982 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030372AbWILXml (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 19:42:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060912234240.CKDJ2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Sep 2006 19:42:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MbiW1V0061kojtg0000000
	Tue, 12 Sep 2006 19:42:30 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17671.16741.995661.664789@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Wed, 13 Sep 2006 09:23:17 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26894>

Paul Mackerras <paulus@samba.org> writes:

> Getting alternates list for http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
> Also look at http://git.kernel.or
> error: Couldn't resolve host 'git.kernel.orobjects' (curl_result = 6, http_code = 0, sha1 = c336923b668fdcf0312efbec3b44895d713f4d81)
> Getting pack list for http://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
> Getting pack list for http://git.kernel.or

I've seen this "last character of hostname dropped" symptom
mentioned on the #git channel long time ago, but I do not
remember if somebody figured out what the problem was.  I know
that nobody did a patch to specifically fix it.

Among the changes since v1.3.0 that touches http-fetch.c the
only thing I can see that touches anything related to alternates
handling is this one, but I do not see anything obviously wrong
with it X-<.

commit bfbd0bb6ecbbbf75a5caaff6afaf5a6af8fa518e
Date:   Sun Jun 11 14:03:28 2006 +0200

    Implement safe_strncpy() as strlcpy() and use it more.
    
diff --git a/http-fetch.c b/http-fetch.c
index d3602b7..da1a7f5 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -584,10 +584,8 @@ static void process_alternates_response(
 			// skip 'objects' at end
 			if (okay) {
 				target = xmalloc(serverlen + posn - i - 6);
-				strncpy(target, base, serverlen);
-				strncpy(target + serverlen, data + i,
-					posn - i - 7);
-				target[serverlen + posn - i - 7] = '\0';
+				safe_strncpy(target, base, serverlen);
+				safe_strncpy(target + serverlen, data + i, posn - i - 6);
 				if (get_verbosely)
 					fprintf(stderr,
 						"Also look at %s\n", target);
