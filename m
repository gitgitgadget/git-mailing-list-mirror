From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebase, please help
Date: Wed, 11 Apr 2007 02:46:48 -0700
Message-ID: <7vr6qrnszb.fsf@assigned-by-dhcp.cox.net>
References: <200704110852.00540.litvinov2004@gmail.com>
	<81b0412b0704110048j30193650r6a7e7417a9afeaf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbZPi-0001Pf-CD
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 11:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbXDKJqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 05:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbXDKJqv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 05:46:51 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50214 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbXDKJqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 05:46:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411094648.VPYM1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 05:46:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id llmp1W0071kojtg0000000; Wed, 11 Apr 2007 05:46:49 -0400
In-Reply-To: <81b0412b0704110048j30193650r6a7e7417a9afeaf8@mail.gmail.com>
	(Alex Riesen's message of "Wed, 11 Apr 2007 09:48:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44227>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 4/11/07, Alexander Litvinov <litvinov2004@gmail.com> wrote:
>>
>> What is --merge for ? Will the result be the same ?
>
> Maybe, maybe not. It uses merge strategies instead of git-am
> and has advantages over blindly applying the patches (it can
> know how a change got in, and it uses resolved conflict cache).

I think "blindly applying the patches" is a gross overstatement,
as merge-recursive will get confused the same way as git-apply,
when a difference that comes from the two commits can be applied
to two places.  When the forward-ported change gets conflict,
3-way merge logic in "git-am -3" kicks in and does a fall back
to merge-recursive on a reconstructed tree that has only the
paths relevant to the case.

With "format-patch piped to am-3", we could give the -M option
to "format-patch" to deal with renames that happen in the series
you are rebasing, but renames between the bases (the original
base commit for the series and the new "onto" commit) is not
something it can handle sensibly.

That is the true advantage --merge has over "format-patch piped
to am-3", as it always drives merge-recursive and it can notice
renames between the two bases.

But always driving merge-recursive is also its weakness.  When
the series being rebased is simple and long, especially on a big
tree, applying many patches without conflicts tends to
outperform running the same number of merges, as the patch
application is tuned to take advantage of cache-tree while
read-tree based merge essentially trashes cache-tree, and has to
pay the full cost of write-tree for every commit it makes.

Also there is that small D/F conflict problem merge-recursive
has that I told you about, which does not exist in git-apply ;-)
Did you have a chance to take a look at it yet?
