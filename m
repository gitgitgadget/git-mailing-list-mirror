From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-rev-list: --topo-order --boundary and --max-count
Date: Mon, 05 Mar 2007 02:39:53 -0800
Message-ID: <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 11:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOAcw-0004Mh-PE
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 11:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbXCEKkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 05:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933057AbXCEKke
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 05:40:34 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:65420 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933059AbXCEKjz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 05:39:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305103955.KUTG2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 05:39:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wyfu1W0041kojtg0000000; Mon, 05 Mar 2007 05:39:54 -0500
In-Reply-To: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	(Santi =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 5 Mar 2007 11:02:27
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41435>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

>  the --topo-order does not play well with --boundary and --max-count.
>
> $ git-rev-list --boundary --max-count=3D50 5ced0 | wc -l
> 56
> $ git-rev-list --topo-order --boundary --max-count=3D50 5ced0 | wc -l
> 8846
>
> (5ced0 is git.git's master). I think it should be 56 for both. It
> presents this behaviour since c4025103fa, when was added --boundary
> support for git-rev-list --max-count and --max-age.

I think the code that does --boundary when the list is limited
with --max-count is not quite right, even without topo-order.
Only when the traversal is not limited, the code happens to work
correctly because in that case alone we pick up positive commits
one by one up to the specified count, and do not place anything
other than their immediate parents in the list.

It needs to find out commits (be they marked as UNINTERESTING or
not) still in the revs->commits that are _not_ reachable by any
other commits in the list, or something like that.

I suspect that would unfortunately be very expensive.  Dscho,
have better ideas?
