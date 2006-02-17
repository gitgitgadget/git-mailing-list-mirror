From: Junio C Hamano <junkio@cox.net>
Subject: Re: Use case: GIT to manage transactions in a CMS?
Date: Fri, 17 Feb 2006 03:44:29 -0800
Message-ID: <7v7j7u43c2.fsf@assigned-by-dhcp.cox.net>
References: <43F30602.500@itaapy.com> <43F31454.8060704@op5.se>
	<43F5AF3C.5050507@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 12:44:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA42M-00022G-Gf
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 12:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWBQLob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Feb 2006 06:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWBQLob
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 06:44:31 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32180 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751378AbWBQLob convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 06:44:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060217114202.MNNJ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Feb 2006 06:42:02 -0500
To: =?iso-8859-1?Q?J=2E_David_Ib=E1=F1ez?= <jdavid@itaapy.com>
In-Reply-To: <43F5AF3C.5050507@itaapy.com> (J. David =?iso-8859-1?Q?Ib=E1?=
 =?iso-8859-1?Q?=F1ez's?= message of "Fri,
	17 Feb 2006 12:10:52 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16339>

"J. David Ib=E1=F1ez" <jdavid@itaapy.com> writes:

> Maybe I could hack something, are there some docs explaining the
> internal format of git objects? or, where to look in the source to
> find this info?

The index file is mostly dealt with by read-cache.c (despite its
name, it has both read and write routines).  The easiest way to
understand the tree object format is by reading write-tree.c.

But the format is the easiest part.  You have to realize that
this is a nontrivial task.

The merge algorithm assumes that it can detect a presense of
directory by finding a blob under that.  You need to teach
'read-tree -m' that sometimes there is an empty directory
recorded in the index file.  This is very important to avoid
directory-file conflicts during the merge.

Tree object side is probably easier because we _can_ write an
empty tree object, and presumably three tree-walker
implementations (one used in read-tree and object layer, one in
diff-tree and another in merge-tree) should all handle empty
trees gracefully, but still its callers need to be verified.

> Another point, the application is written in Python, right now
> I have to open a shell to run the git commands.

I always have a shell open so it does not sound a big deal to me
;-).

> It would be nice if the core functionality was implemented in a C
> library, then with a Python wrapper I could use git without going
> through the shell.
>
> Is this something to be expected? There will be a "libgit" sometime
> in the future?

Yes, read the list archive.

But not yet.  The core level has been fluctuating quite a bit.  The
latest round being the object layer bookkeeping changes.
