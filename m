From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Wed, 18 May 2005 13:30:15 -0700
Message-ID: <7vll6cnup4.fsf@assigned-by-dhcp.cox.net>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org>
	<7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
	<Pine.LNX.4.58.0505181134470.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 18 22:31:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYVAv-0001Po-JW
	for gcvg-git@gmane.org; Wed, 18 May 2005 22:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVERUa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 16:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVERUa3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 16:30:29 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37786 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262352AbVERUaT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 16:30:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050518203016.VOFV1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 16:30:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505181134470.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 18 May 2005 11:38:46 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I took the liberty of doing just that. The only subtle issue was that 
LT> the strbuf functions would consider an empty line to be EOF, which looked 
LT> wrong and unintentional. Fixing that made the actual diff-helper changes 
LT> totally trivial, and I can now do
LT> 	git-rev-list HEAD | git-diff-tree -r -v --stdin | ./git-diff-helper -r | less -S
LT> and it does the right thing for me.

Thanks for fixing up strbuf.

@@ -136,8 +268,12 @@ int main(int ac, const char **av) {
 		if (sb.eof)
 			break;
 		status = parse_diff_raw_output(sb.buf, av+1, ac-1, reverse);
-		if (status)
-			fprintf(stderr, "cannot parse %s\n", sb.buf);
+		if (status) {
+			flush_renames(av+1, ac-1, reverse);
+			printf("%s%c", sb.buf, line_termination);
+		}
 	}
+
+	flush_renames(av+1, ac-1, reverse);
 	return 0;
 }

I suspect doing something like this might be saner instead,
assuming non raw-diffs come at the end.  

		if (status)
			break;
	}
	flush_renames(av+1, ac-1, reverse);
	if (!sb.eof) {
        	spit out what we have in sb.eof, sendfile ;-) the
                rest of the input to the output.
	}
	return 0;

