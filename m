X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Better symbolic link support in "tree" view
Date: Tue, 05 Dec 2006 14:34:58 -0800
Message-ID: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
References: <1165256780505-git-send-email-jnareb@gmail.com>
	<7vr6vfkv3i.fsf@assigned-by-dhcp.cox.net>
	<200612052227.56770.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 22:35:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612052227.56770.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 5 Dec 2006 22:27:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33380>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrisT-00086P-Q2 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936794AbWLEWfA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936791AbWLEWfA
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:35:00 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54765 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S936794AbWLEWe7 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 17:34:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205223458.QCHH27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 17:34:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vAb81V00W1kojtg0000000; Tue, 05 Dec 2006
 17:35:09 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> ...
>> I think " -> link_target" is fine, but I do not know if it is
>> useful (while I do not think it is wrong) to make the value that
>> would have been returned from readlink() into an href, even when
>> it points at something inside the same revision.
>
> I have added this bit (making symbolic link target symlink) because 
> otherwise there is no way, besides hand-munging the URL, to go to the 
> link target.

I can read what you wrote it does.

For one thing, the user is tracking the symbolic link itself,
not the contents of the file or directory the link points at.
For that "tracked symlink", where it points at is the important
content, not what the file that is pointed at happens to contain
in the same revision.

If you have to open an extra object while drawing the list, I do
not think it is worth doing it.

In order to show " -> link_target", you have to read the
contents of the blob.  I think that overhead to read one extra
blob is probably an acceptable tradeoff for convenience.

But if you want to make it a link into the same tree, you would
need to check if link_target path exists and if it is a blob or
tree to produce an appropriate tree_view/blob_view link (I
haven't read your code but that is the natural thing to do).

That would involve in reading a few more tree objects (depending
on how deep the target is in the tree), and I do not think it is
worth doing it while drawing a list.  After you prepared dozens
of such links, the user would click at most one of them and 
leaves the page; your cycles to draw those unclicked links were
wasted.

If you wanted to do this, a better way would be to have a new
view that takes a commit/tree object and a path from the top of
the repository, and shows either "no such path in that tree" or
"here is the view for that object, by the way it was a blob."
page.  Then your list drawing would still need to open each
symlink blob to show " -> link_target", and need to check if it
goes outside the repository (I would assume you are handling
relative links as well), but you do not need to do expensive
ls-tree step one per symlink on the page.  The href attr of the
A element " -> link_target" would point at that "universal
object view" with the link_target pathname (that is, the blob
contents) and the commit/tree object name (h or hb I do not know
which) and you will spend cycles to run ls-tree only when the
user actually asks to follow that link.

In other words, I think trying to be lazy is extremely important
while drawing a big list.
