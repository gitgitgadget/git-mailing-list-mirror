From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Wed, 23 May 2007 15:08:25 -0700
Message-ID: <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
References: <46528A48.9050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 00:08:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqz0S-0000Gc-5N
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981AbXEWWI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756168AbXEWWI0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:08:26 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35007 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981AbXEWWI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:08:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523220825.TVZW15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 18:08:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2m8Q1X00B1kojtg0000000; Wed, 23 May 2007 18:08:24 -0400
In-Reply-To: <46528A48.9050903@gmail.com> (Dana How's message of "Mon, 21 May
	2007 23:14:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48183>

Dana How <danahow@gmail.com> writes:

> This patch implements the following:
> 1. git pack-objects takes a new --max-blob-size=N flag,
>    with the effect that only blobs less than N KB are written
>    to the packfiles(s).  If a blob was in a pack but violates
>    this limit (perhaps the packs were created by fast-import
>    or max-blob-size was reduced),  then a new loose object
>    is written out if needed so the data is not lost.

Why?

I really do not like that "write a new loose object" part
without proper justification.  From your description, I thought
the most natural way to do this is to pretend you did not hear
about large objects at all, by rejecting them early, perhaps
inside add_object_entry() or inside get_object_details() --
either case you would do sha1_object_info() early instead of
doing it in check_object().

By the way, is there fundamental reason that this needs to be
"blob size" limit?  Wouldn't "max-object-size" be more clean in
theory, and work the same way in practice?

> 2. git repack inspects repack.maxblobsize .  If set,  its
>    value is passed to git pack-objects on the command line.
>    The user should change repack.maxblobsize ,  NOT specify
>    --max-blob-size=N .

Why not?

> This patch is on top of the earlier max-pack-size patch,
> because I thought I needed some behavior it supplied,
> but could be rebased on master if desired.

Your earlier "split according to max-pack-size" will hopefully be
on master shortly.
