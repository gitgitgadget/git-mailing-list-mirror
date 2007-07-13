From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lockfile.c: schedule remove_lock_file only once.
Date: Fri, 13 Jul 2007 11:23:07 -0700
Message-ID: <7vabu0noxg.fsf@assigned-by-dhcp.cox.net>
References: <20070713141450.GA8392MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 20:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Pnc-0000Gq-JQ
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 20:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934287AbXGMSXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 14:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759667AbXGMSXO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 14:23:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47671 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760588AbXGMSXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 14:23:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713182308.OBHP1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Jul 2007 14:23:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P6P71X00H1kojtg0000000; Fri, 13 Jul 2007 14:23:08 -0400
In-Reply-To: <20070713141450.GA8392MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Fri, 13 Jul 2007 16:14:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52410>

Sven Verdoolaege <skimo@kotnet.org> writes:

> Removing a lockfile once should be enough.

Yeah.  I wonder what we were smoking.  415e96c8 which introduces
the atexit to index.c does:

    int hold_index_file_for_update(struct cache_file *cf, const char *path)
    {
           sprintf(cf->lockfile, "%s.lock", path);
           cf->next = cache_file_list;
           cache_file_list = cf;
           if (!cf->next) {
                   signal(SIGINT, remove_lock_file_on_signal);
                   atexit(remove_lock_file);
           }
           return open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0600);
    }

whose intent is exactly "do this once, only for the first one".

The reason we do not use lk->next but instead check lk->on_list,
and the reason why we do not remove the lock from the list, are
described in 1084b845.

But your "fire atexit() once" fix is needed.  Thanks.
