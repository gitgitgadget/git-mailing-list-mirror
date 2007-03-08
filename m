From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Thu, 08 Mar 2007 01:06:54 -0800
Message-ID: <7vy7m8aytt.fsf@assigned-by-dhcp.cox.net>
References: <20070308041618.GA29744@spearce.org>
	<81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com>
	<20070308083317.GB30289@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 10:07:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPEaU-0006uT-Jx
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbXCHJG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbXCHJG6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:06:58 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35646 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030363AbXCHJG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:06:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308090655.NHC26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 04:06:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Y96u1W00L1kojtg0000000; Thu, 08 Mar 2007 04:06:55 -0500
In-Reply-To: <20070308083317.GB30289@spearce.org> (Shawn O. Pearce's message
	of "Thu, 8 Mar 2007 03:33:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41721>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Alex Riesen <raa.lkml@gmail.com> wrote:
>> On 3/8/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>> >+# Called by git-receive-pack with arguments:
>> >+#    (refname sha1-old sha1-new)+
>> > #
>> 
>> What do you do if this breaks because of too many refs passed?
>
> Die a horrible horrible death?
>
> That's certainly a problem in receive-pack.  It should (somehow)
> break long invocations up, much like what xargs winds up doing.
> Problem is that limit is OS dependent... so uh, yea...

I suspect that it is deeper than that.  Think about why having
"everything at once" is better than "one at a time".

Potentially you could have a rule that says "these should be
updated together" (or the other way around).  If you split the
set of refs at arbitrary limit, like xargs does, you would lose
that advantage.  We could take stdin to solve that and shell
scripts should be able to handle that as refnames do not contain
shell metacharacters.

But this is only true if you want to make it really nice.  I
personally feel that nobody would scream if pushing 1300 refs at
once (4K pages and MAX_ARG_PAGES at 32 would give 128K for
**argv and its strings, and one ref's worth of data is two
40-digit hex plus refname, roughly 100-byte per ref) is not
supported and always failed.
