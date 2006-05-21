From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 01:31:22 -0700
Message-ID: <7vlksvzsmd.fsf@assigned-by-dhcp.cox.net>
References: <20060521054827.GA18530@coredump.intra.peff.net>
	<7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net>
	<20060521081435.GA4526@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 21 10:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhjLS-0007la-JB
	for gcvg-git@gmane.org; Sun, 21 May 2006 10:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWEUIbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWEUIbY
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 04:31:24 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29886 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751502AbWEUIbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 04:31:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521083123.LKSF24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 04:31:23 -0400
To: git@vger.kernel.org
In-Reply-To: <20060521081435.GA4526@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 May 2006 04:14:35 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20440>

Jeff King <peff@peff.net> writes:

> On Sat, May 20, 2006 at 11:17:42PM -0700, Junio C Hamano wrote:
>
>> base delta for that object to skip computation".  What you want
>> here is "if the object we are going to send is not a delta in
>> the source, and there are sufficient number of other objects the
>> object could have been deltified against, then it is very likely
>> that it was not worth deltifying when it was packed; so it is
>> probably not worth deltifying it now".
>
> I think we can make a stronger statement in many cases: "if the object
> we are going to send is not a delta in the source, and there are no
> other objects it could be deltified against, then it is not worth
> deltifying." That is, in the case that we just packed we KNOW that it's
> not worth it, since we're not sending anything that isn't already
> packed.

Careful.

We do not delta an otherwise perfectly deltifiable object if its
delta base happens to be at the depth edge in the original pack.
So no, we do _NOT_ know if it is not worth it merely from the
fact that it is not deltified in the existing pack.  And the
latter part of your test "there are no other objects it could be
deltified against" is either expensive (you have to try first to
see if that is the case to really see it) or stupid (you just
assume there is no suitable delta base without looking at other
objects like we currently do).
