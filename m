From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't send copies to the From: address
Date: Fri, 10 Feb 2006 19:55:13 -0800
Message-ID: <7vk6c2sg66.fsf@assigned-by-dhcp.cox.net>
References: <11396260373307-git-send-email-cbiesinger@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	Greg Kroah-Hartman <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 04:55:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7lqy-0005Mk-AA
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 04:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWBKDzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 22:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWBKDzR
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 22:55:17 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15334 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932212AbWBKDzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 22:55:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211035347.DWLX6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 22:53:47 -0500
To: Christian Biesinger <cbiesinger@web.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15921>

Christian Biesinger <cbiesinger@web.de> writes:

> Sending copies to the from address is pointless.

Ryan, care to defend this part of the code?  This behaviour
might have been inherited from Greg's original version.

I cannot speak for Ryan or Greg, but I think the script
deliberately does this to support this workflow:

 (1) The original author sends in a patch to a subsystem
     maintainer;

 (2) The subsystem maintainer applies the patch to her tree,
     perhaps with her own sign-off and sign-offs by other people
     collected from the list.  She examines it and says this
     patch is good;

 (3) The commit is formatted and sent to higher level of the
     foodchain.  The message is CC'ed to interested parties in
     order to notify that the patch progressed in the
     foodchain.

Me, personally I do not like CC: to people on the signed-off-by
list, but dropping a note to From: person makes perfect sense to
me, if it is to notify the progress of the patch.

What you are after _might_ be not CC'ing it if it was your own
patch.  Maybe something like this would help, but even if that
is the case I suspect many people want to CC herself so it needs
to be an optional feature.

-- >8 --
[PATCH] Do not CC me

---
git diff
diff --git a/git-send-email.perl b/git-send-email.perl
index 3f1b3ca..a02e2f8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -343,7 +343,7 @@ foreach my $t (@files) {
 	}
 	close F;
 
-	$cc = join(", ", unique_email_list(@cc));
+	$cc = join(", ", unique_email_list(grep { $_ ne $from } @cc));
 
 	send_message();
 
