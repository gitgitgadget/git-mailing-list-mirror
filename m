From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-clone --reference problem?
Date: Sun, 23 Apr 2006 11:34:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604231122490.3701@g5.osdl.org>
References: <1145810080.16166.223.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 23 20:34:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXjPu-00023n-Be
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 20:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWDWSed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 14:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWDWSec
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 14:34:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751436AbWDWSec (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Apr 2006 14:34:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3NIYPtH015552
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 23 Apr 2006 11:34:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3NIYOB8028196;
	Sun, 23 Apr 2006 11:34:25 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1145810080.16166.223.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19072>



On Sun, 23 Apr 2006, David Woodhouse wrote:
>
> Should I expect cloning with alternates using '--reference' to be
> transitive?

Well, certainly not now.

> Using '--reference clone1 --reference linux-2.6' for the second clone
> works OK, but surely it ought to work with just '--reference clone1'? 

Actually, I don't think using "--reference clone1 --reference linux-2.6" 
works OK at all - in the sense that it doesn't do what you _think_ it 
does.

It doesn't use two reference repos at all: it uses just one, which is the 
last one (ie linux-2.6).

Maybe something like this could work.

Untested, of course. It probably isn't even syntactically correct shell. 
Whatever. You get the idea.

(That while-loop could probably be simplified to just a 

  cat ""$reference/objects/info/alternates" >> "$GIT_DIR/objects/info/alternates"

because all alternates _should_ already be absolute paths, but hey, 
whatever. I also forget whether we decided that non-absolute paths were 
relative to the $reference directory, or to the $reference/objects/ 
directory. The while-loop should be fixed to match whatever that decision 
was (or just not accept anything but absolute paths: make it use a

	grep '^/' ..

instead of "cat"?)

		Linus

---
diff --git a/git-clone.sh b/git-clone.sh
index 0805168..df4c135 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -221,6 +221,13 @@ then
 		fi
 		reference=$(cd "$reference" && pwd)
 		echo "$reference/objects" >"$GIT_DIR/objects/info/alternates"
+		if test -s "$reference/objects/info/alternates"
+		then
+			while read alt
+			do
+				echo $(cd "$reference" && cd "$alt" && pwd) >> "$GIT_DIR/objects/info/alternates"
+			done < "$reference/objects/info/alternates"
+		fi
 		(cd "$reference" && tar cf - refs) |
 		(cd "$GIT_DIR/refs" &&
 		 mkdir reference-tmp &&
