From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --temp and --stage=all options to checkout-index.
Date: Sat, 04 Mar 2006 21:29:55 -0800
Message-ID: <7vlkvpihm4.fsf@assigned-by-dhcp.cox.net>
References: <20060303012032.GC6321@spearce.org>
	<7vmzg83xro.fsf@assigned-by-dhcp.cox.net>
	<20060303151331.GA16369@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 06:30:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFlok-0001dU-7X
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 06:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWCEF35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 00:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWCEF35
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 00:29:57 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:27881 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751696AbWCEF35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 00:29:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305052840.KPSA3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 00:28:40 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060303151331.GA16369@spearce.org> (Shawn Pearce's message of
	"Fri, 3 Mar 2006 10:13:31 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17204>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>> 
>> >  Unfortunately this change lead me down a path which changed the core
>> >  checkout code also used by apply and read-tree.
>> 

I would have preferred not to add to_tempfile member to the
checkout struct.  Instead, if checkout_entry has non NULL
topath, check out to a temporary location and return the path;
otherwise behave the way it did before.

That way everybody else would not need to declare useless
topath[] array on the stack and pass it to checkout_entry
(instead they would just pass NULL because they are not
interested in checking out to temporary files).

I am unsure about what the tempfile option should do when asked
to checkout a symbolic link.  Creating a temporary regular file
that has the readlink result does not sound very useful to me.

BTW, in any case, I think there is one breakage that needs to be
fixed with something like this...

---
diff --git a/apply.c b/apply.c
index 5a2cf54..727d63d 100644
--- a/apply.c
+++ b/apply.c
@@ -1311,6 +1311,7 @@ static int check_patch(struct patch *pat
 				costate.force = 0;
 				costate.quiet = 0;
 				costate.not_new = 0;
+				costate.to_tempfile = 0;
 				costate.refresh_cache = 1;
 				if (checkout_entry(active_cache[pos],
 						   &costate, topath) ||
