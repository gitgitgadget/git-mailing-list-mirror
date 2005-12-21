From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing git patches to a subversion project
Date: Tue, 20 Dec 2005 23:25:19 -0800
Message-ID: <7vpsnqdi8w.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512202137w772a3fe9p8e9e68345e39654a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Kalle Valo <Kalle.Valo@iki.fi>
X-From: git-owner@vger.kernel.org Wed Dec 21 08:26:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoyLp-0007Wv-Vv
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 08:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVLUHZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 02:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVLUHZ1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 02:25:27 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54484 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932305AbVLUHZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 02:25:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221072437.PIMP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 02:24:37 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512202137w772a3fe9p8e9e68345e39654a@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 21 Dec 2005 18:37:26 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13871>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I am starting to work an svn-based upstream. In order to make life
> easy for me and for them I am trying to figure out a way for them to
> be able to merge my (emailed) patches atomically and preserving my
> comments.
>
> Something like git-am for svn.

Many building blocks git-am uses should be usable for this.

 * git-mailsplit you already know about due to earlier "non UNIX
   mbox" discussion.

 * git-mailinfo can be used to parse out commit message, title
   and authorship information, and actual patch.

 * git-apply without --index option can be used to apply patch
   to the working tree, but normal "patch -p1" would do the same
   unless it is a git renaming patch.  git-apply would also be
   useful for its --summary option to find out mode changes
   (if it is a git patch) and file creation and deletion.

So probably you could script something like this:

	$ git mailinfo .msg .patch <e-mail-file >.info
        $ (sed -ne 's/^Subject: //p' .info ; echo ; cat .msg) >.final-msg
	$ git apply --summary <.patch |
        while read cd mo de file
        do
        	case "$cd" in
                create)
                	svn add "$file" ;;
		delete)
                	svn rm "$file" ;;
		esac
	done
	$ svn commit -F .final-msg
