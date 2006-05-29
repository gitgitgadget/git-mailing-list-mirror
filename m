From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-diff-tree indicate when it flushes
Date: Mon, 29 May 2006 15:18:01 -0700
Message-ID: <7vr72c79wm.fsf@assigned-by-dhcp.cox.net>
References: <17530.59395.5611.931858@cargo.ozlabs.ibm.com>
	<7vejyc8ymw.fsf@assigned-by-dhcp.cox.net>
	<17531.28529.215905.856397@cargo.ozlabs.ibm.com>
	<7vzmh07a9k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 00:18:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkq43-0007FV-Uh
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWE2WSF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWE2WSF
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:18:05 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36572 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751436AbWE2WSC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 18:18:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529221802.TKJM27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 18:18:02 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <7vzmh07a9k.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 29 May 2006 15:10:15 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20987>

Junio C Hamano <junkio@cox.net> writes:

> Paul Mackerras <paulus@samba.org> writes:
>
>> With --always, how do I tell that 65aadb affects apply.c and cc189c
>> doesn't?
>
> I am not quite sure exactly what you are trying to achieve, but
> one trivial way is not giving -s perhaps?

Having said that, I suspect this might be a better way.
Whatever you throw at it from stdin that are not a validly
looking object name, you will get them back, so you can use your
favorite markers.

diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index cc53b81..7208c48 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -138,11 +138,15 @@ int cmd_diff_tree(int argc, const char *
 	if (opt->diffopt.detect_rename)
 		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
 				       DIFF_SETUP_USE_CACHE);
-	while (fgets(line, sizeof(line), stdin))
-		if (line[0] == '\n')
+	while (fgets(line, sizeof(line), stdin)) {
+		unsigned char sha1[20];
+
+		if (get_sha1_hex(line, sha1)) {
+			fputs(line);
 			fflush(stdout);
+		}
 		else
 			diff_tree_stdin(line);
-
+	}
 	return 0;
 }
