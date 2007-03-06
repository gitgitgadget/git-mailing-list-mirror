From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 06 Mar 2007 02:45:30 -0800
Message-ID: <7vzm6qps51.fsf@assigned-by-dhcp.cox.net>
References: <20070306093917.GA1761@coredump.intra.peff.net>
	<989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
To: "Li Yang-r58472" <LeoLi@freescale.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:45:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOXAj-0000zb-QG
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 11:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbXCFKpc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 05:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbXCFKpc
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 05:45:32 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41702 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964780AbXCFKpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 05:45:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306104531.RDYU2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 05:45:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XNlW1W0071kojtg0000000; Tue, 06 Mar 2007 05:45:30 -0500
In-Reply-To: <989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net>
	(Li Yang-r's message of "Tue, 6 Mar 2007 18:31:23 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41569>

"Li Yang-r58472" <LeoLi@freescale.com> writes:

>> -----Original Message-----
>> From: Jeff King [mailto:peff@peff.net]
>> ...
>> I think this should do the same, and is perhaps less magic (or maybe
>> more, depending on your perspective).
>
> Yes, it also fixed the problem.  I'm not very familiar with perl.  Will
> CGI::autoEscape(1) change CGI action for other users of CGI module on
> the system?  If so, maybe it will break other CGIs.

By "other CGIs" if you mean other independent CGI scripts that
do not have anything to do with gitweb, then I do think there is
no need to worry.

What I'd be worried about more, however, is if all the callers
of esc_html and esc_path are really expecting the full quoting
done by CGI::autoEscape(1).  I think we had some discussion on
the path quoting when we introduced quot_cec and quot_upr, but
do not recall the details.  For example, many places esc_html()
is used as the body of <a ...>$here</a> but some places it is
used as

    $cgi->a({ ... -title =>esc_html($fullname) }, esc_path($dir))

which would be the same as:

    print '<a title="' . esc_html($fullname) . '">' . esc_path($dir) . '</a>';

which may or may not be right (I do not know offhand).

Speaking of -title, I see "sub git_project_list_body" does this:

    $cgi->a({ ... -title => $pr->{'descr_long'}}, esc_html($pr->{'descr'}));
	
which seems inconsistent with the earlier quoted $fullname
handling (unless $pr->{'descr_long'} is already quoted and $pr->{'descr'}
is not, which I find highly unlikely).
