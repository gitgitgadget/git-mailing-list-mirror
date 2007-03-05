From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-rev-list: --topo-order --boundary and --max-count
Date: Mon, 05 Mar 2007 04:15:24 -0800
Message-ID: <7vhcszzy1v.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 13:16:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOC6n-0005br-4D
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 13:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933293AbXCEMP1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 07:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933326AbXCEMP1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 07:15:27 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41779 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933293AbXCEMP0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 07:15:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305121527.LKAC2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 07:15:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id X0FR1W00D1kojtg0000000; Mon, 05 Mar 2007 07:15:25 -0500
In-Reply-To: <7vlkicynwm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 05 Mar 2007 02:39:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41439>

Junio C Hamano <junkio@cox.net> writes:

> "Santi B=C3=A9jar" <sbejar@gmail.com> writes:
>
>>  the --topo-order does not play well with --boundary and --max-count=
=2E
>>
>> $ git-rev-list --boundary --max-count=3D50 5ced0 | wc -l
>> 56
>> $ git-rev-list --topo-order --boundary --max-count=3D50 5ced0 | wc -=
l
>> 8846
>>
>> (5ced0 is git.git's master). I think it should be 56 for both. It
>> presents this behaviour since c4025103fa, when was added --boundary
>> support for git-rev-list --max-count and --max-age.
>
> I think the code that does --boundary when the list is limited
> with --max-count is not quite right, even without topo-order.
> Only when the traversal is not limited, the code happens to work
> correctly because in that case alone we pick up positive commits
> one by one up to the specified count, and do not place anything
> other than their immediate parents in the list.

This is not even correct.  Let's see an extreme example.
Suppose you have something like this:

 ---o---o---o---x---A
=20
   ---o---o---o---y---B

and think about what "rev-list --boundary --max-count=3D1 A B"
should return.  It does not matter how branches A and B are
related in the past because we are showing only one.

Without --boundary, it is clear we will show B (time flows from
left to right).  With --boundary, the current code would show B,
and show -y and -A as boundaries, and I think that is wrong.

Originally --boundary was invented for the specific purpose of
supporting thin packs.  It worked on the set of commits
resulting from a limited traversal (that is, you have at least
one negative, iow UNINTERESTING, commit and one or more positive
commits), and it showed the negative commit that is a parent of
a positive commit.

There are two primary users of --boundary right now.  gitk wants
to show where the partial traversal ends (although it can figure
it out itself without help from --boundary), and thin pack
generation wants to have it upfront so that it can see which
trees and blobs can be used as the bases of delta.  In both
cases, the semantics desired is to show commits that are _not_
included in the usual (i.e. non --boundary) results that are
immediate parents of the commits that are included in the
result.

So with that definition, the above example should show B and
then -y as boundary, and should not even talk about A nor -x.
This may affect the git-bundle's computation of references
included in the bundle (I think the current code assumes that if
you do "git bundle --max-count=3D1 A B" the resulting bundle says
its set of tips consists of A and B) but if that is broken it
also needs to be fixed.
