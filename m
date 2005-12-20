From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Racy GIT
Date: Tue, 20 Dec 2005 11:28:17 -0800
Message-ID: <7vr787h8ku.fsf@assigned-by-dhcp.cox.net>
References: <7vwti0go2w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Dec 20 20:29:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eon9q-0005ep-24
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 20:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVLTT2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 14:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVLTT2T
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 14:28:19 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32202 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750850AbVLTT2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 14:28:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051220192651.GLMI17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Dec 2005 14:26:51 -0500
To: git@vger.kernel.org
In-Reply-To: <7vwti0go2w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 20 Dec 2005 00:38:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13852>

Junio C Hamano <junkio@cox.net> writes:

> This fixes the longstanding "Racy GIT" problem,...

Sorry, it does not really.

> If you run the following sequence of commands:
>
>         echo frotz >infocom
>         git update-index --add infocom
>         echo xyzzy >infocom

The patch deals with the above sequence correctly, but it breaks
down with:

	echo frotz >infocom
        git update-index --add infocom
        echo xyzzy >infocom
        sleep 3 ;# a little while later
        echo nitfol >activision
        git update-index --add activision
        git diff-files infocom

We need to detect the false clean entries just before we write
out index in the second update-index and mark them out of date.
