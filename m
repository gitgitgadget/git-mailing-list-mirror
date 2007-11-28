From: jhud7196@artax.karlin.mff.cuni.cz
Subject: Re: QGit: Shrink used memory with custom git log format
Date: Wed, 28 Nov 2007 16:53:25 +0100 (CET)
Message-ID: <57101.194.138.12.144.1196265205.squirrel@artax.karlin.mff.cuni.cz>
References: <e5bfff550711240014n78f24b46qf012957d92b1a8e1@mail.gmail.com>
    <20071127015248.GK14735@spearce.org>
    <Pine.LNX.4.64.0711271045430.27959@racer.site>
    <20071127191915.GB9174@efreet.light.src>
    <Pine.LNX.4.64.0711281200070.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:53:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPET-0004ym-9F
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758714AbXK1Px1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbXK1Px1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:53:27 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:50159 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbXK1Px0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:53:26 -0500
Received: from artax.karlin.mff.cuni.cz (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id 88A08980E8;
	Wed, 28 Nov 2007 16:53:25 +0100 (CET)
Received: from 194.138.12.144
        (SquirrelMail authenticated user jhud7196)
        by artax.karlin.mff.cuni.cz with HTTP;
        Wed, 28 Nov 2007 16:53:25 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0711281200070.27959@racer.site>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66361>

> Hi,
>
> On Tue, 27 Nov 2007, Jan Hudec wrote:
>
>> On Tue, Nov 27, 2007 at 10:48:00 +0000, Johannes Schindelin wrote:
>> > On Mon, 26 Nov 2007, Shawn O. Pearce wrote:
>> > > [...]
>> > > Otherwise I think what you really want here is a libgit that you can
>> > > link into your process and that can efficiently inflate an object
>> > > on demand for you.  Like the work Luiz was working on this past
>> > > summer for GSOC.  Lots of downsides to that current tree though...
>> > > like die() kills the GUI...
>> >
>> > But then, die() calls die_routine, which you can override.  And C++
>> has
>> > this funny exception mechanism which just begs to be used here.  The
>> only
>> > thing you need to add is a way to flush all singletons like the object
>> > array.
>>
>> Unfortunately, exceptions won't really work. Why? Because to use
>> exceptions, you need to have an exception-safe code. That is the code
>> needs to free any allocated resources when it's aborted by exception.
>> And git code is not exceptions safe. Given the lack of destructors in C,
>> it means registering all resource allocation in some kind of pool, so
>> they can be freed en masse in case of failure. Than you can also use
>> longjmp for die (for C they really behave the same).
>
> Sorry, I just assumed that you can read my mind (or alternatively remember
> what I suggested a few months ago, namely to "override" xmalloc(),
> xcalloc(), xrealloc() and xfree() (probably you need to create the
> latter)).

That sounds like the easiest (but not necessarily easy) direction towards
the goal. Thread-local or global (I don't think git is currently reentrant
anyway) would do. Also filehanles would have to be taken care of and
everything checked for using malloc, calloc, strdup and other libc
functions directly.

Than die could longjmp out to a specified buffer and could be safely
overriden to throw exception for C++ apps.

--
                                         - Jan Hudec <bulb@ucw.cz>
