From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Libification project (SoC)
Date: Sat, 17 Mar 2007 19:58:32 +0000
Organization: Mandriva
Message-ID: <20070317195832.2af87c06@home.brethil>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
	<7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	<20070316104715.483df0d5@localhost>
	<20070316140855.GE4489@pasky.or.cz>
	<20070316153822.5c842e69@localhost>
	<20070316231646.GB4508@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 21:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSfHM-0000hq-Ko
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 21:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbXCQUN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 16:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbXCQUN1
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 16:13:27 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:56372 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbXCQUN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 16:13:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 43F682AEDE;
	Sat, 17 Mar 2007 17:13:24 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Rbmq0KWWhCDb; Sat, 17 Mar 2007 17:10:48 -0300 (BRT)
Received: from home.brethil (unknown [189.4.51.23])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9CC842AFBF;
	Sat, 17 Mar 2007 16:55:45 -0300 (BRT)
In-Reply-To: <20070316231646.GB4508@spearce.org>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42452>

On Fri, 16 Mar 2007 19:16:46 -0400
"Shawn O. Pearce" <spearce@spearce.org> wrote:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
| >  I think the right solution is to get rid of die() from functions that
| > are supposed to be an interface, set errno if needed and return -1
| > or NULL.
| 
| And then make their callers (if they are above the public API layer)
| die instead.  In some cases this might imply an undesirable change
| in the error message produced, as necessary details that are included
| today would be unavailable in the caller.

 Exactly!

 One simple example of an important error message that would be
lost can be found in read-cache.c:read_cache_from():

 o index file smaller than expected

 I've found a possible solution, though.

 Take a look at Rusty's solution for the same problem in
module-init-tools:

"""
/* We use error numbers in a loose translation... */
static const char *insert_moderror(int err)
{
	switch (err) {
	case ENOEXEC:
		return "Invalid module format";
	case ENOENT:
		return "Unknown symbol in module, or unknown parameter (see dmesg)";
	case ENOSYS:
		return "Kernel does not have module support";
	default:
		return strerror(err);
	}
}
"""

 Instead of calling strerror() directly for error generated
when inserting a module, the insmod() function calls insert_moderror()
which provides the desirable mapping.

 I think we could have something like that for each git's
module, eg, git_cache_strerror(), git_commit_strerror() and so on.

 Does this look reasonable?

-- 
Luiz Fernando N. Capitulino
