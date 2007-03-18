From: Junio C Hamano <junkio@cox.net>
Subject: Re: Libification project (SoC)
Date: Sat, 17 Mar 2007 22:52:52 -0700
Message-ID: <7vzm6bp07f.fsf@assigned-by-dhcp.cox.net>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
	<7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	<20070316104715.483df0d5@localhost>
	<20070316140855.GE4489@pasky.or.cz>
	<20070316153822.5c842e69@localhost>
	<20070316231646.GB4508@spearce.org>
	<20070317195832.2af87c06@home.brethil>
	<20070318052332.GC15885@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 06:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSoK8-0006mY-6P
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 06:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbXCRFwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 01:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbXCRFwy
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 01:52:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54802 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbXCRFwx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 01:52:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318055254.KVWX1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 18 Mar 2007 01:52:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c5ss1W00B1kojtg0000000; Sun, 18 Mar 2007 01:52:53 -0400
In-Reply-To: <20070318052332.GC15885@spearce.org> (Shawn O. Pearce's message
	of "Sun, 18 Mar 2007 01:23:32 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42476>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Take a look at sha1_file.c, open_packed_git_1:
>
> ...
>     if (!pack_version_ok(hdr.hdr_version))
>         return error("packfile %s is version %u and not supported"
>             " (try upgrading GIT to a newer version)",
>             p->pack_name, ntohl(hdr.hdr_version));
> ...
>
> Here we are supplying a lot more than just a simple error code
> that can be mapped to a static string.
>
> Of course that code is currently feeding it to the error function,
> which today calls the error_routine (see usage.c).  We could buffer
> the strings sent to error()/warn() and let the caller obtain all
> strings that occurred during the last API call.

Actually, since we are talking about the error path,

 (1) we do not care performance of what happens there that much, but
 (2) we *do* care about not doing extra allocation.

So it might make sense to have a preallocated "error string"
buffer, sprintf the error message in there and return error
codes.
