From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix bunch of fd leaks in http-fetch
Date: Fri, 11 Nov 2005 21:45:30 -0800
Message-ID: <7vk6feiflx.fsf@assigned-by-dhcp.cox.net>
References: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com>
	<20051111235516.GY30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 06:46:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaoCy-0007EZ-8N
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 06:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVKLFpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 00:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVKLFpc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 00:45:32 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31111 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932136AbVKLFpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 00:45:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051112054437.CPYU776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Nov 2005 00:44:37 -0500
To: Petr Baudis <pasky@suse.cz>, Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051111235516.GY30496@pasky.or.cz> (Petr Baudis's message of
	"Sat, 12 Nov 2005 00:55:16 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11658>

Petr Baudis <pasky@suse.cz> writes:

> The current http-fetch is rather careless about fd leakage, causing
> problems while fetching large repositories. This patch does not reserve
> exhaustiveness, but I covered everything I spotted...

Thanks.  While I am sure a quick fix is better for the end user
than not doing anything at all, I am a bit reluctant.

It strikes me somewhat odd that these close() are not tied to
the lifetime rule of the transfer_request structure.  When the
program falls back from an individual object to alternates, the
same request structure is reused, but in that case ->local stays
the same.  Otherwise, the original request structure is released
so I wonder if would make things cleaner to close ->local inside
request_release()...

Nick?
