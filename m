From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with pack
Date: Fri, 25 Aug 2006 03:58:33 -0700
Message-ID: <7vbqq95bfq.fsf@assigned-by-dhcp.cox.net>
References: <44EECBE2.7090801@arces.unibo.it> <44EECEDC.7090608@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Fri Aug 25 12:58:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGZOQ-0004tL-L9
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 12:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWHYK6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 06:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHYK6Z
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 06:58:25 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27595 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751451AbWHYK6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 06:58:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060825105823.ZLLF18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 Aug 2006 06:58:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id EAyP1V00H4Noztg0000000
	Fri, 25 Aug 2006 06:58:23 -0400
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44EECEDC.7090608@op5.se> (Andreas Ericsson's message of "Fri, 25
	Aug 2006 12:20:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25997>

Andreas Ericsson <ae@op5.se> writes:

>> Btw, even without that, if I understand correctly, git packs are
>> collections of compressed objects, each of which has its own header
>> stating how long is the compressed object itself. In my case, the
>> error is in inflating one object (git unpack-objects says inflate
>> returns -3)... so shouldn't there be a way to try to skip to the
>> next object even in this case?
>
> It should be possible, assuming the pack index is still intact. The
> pack index is where the headers are stored, afaik.

The problem Sergio seems to be having is because somehow he does
not have a base object that another object that is in the pack
depends on, because the latter object is stored in deltified
form.

This should never happen unless .pack itself is corrupted
(git-pack-objects, unless explicitly told to do so with --thin
flag to git-rev-list upstream, would not make a delta against
objects not in the same pack).

When a delta is written to the pack file, unless its base object
has already written out, git-pack-objects writes out the base
object immediately after that deltified object.  So one
possibility is that the pack was truncated soon after the delta
that is having trouble with finding its base object.  In such a
case, the proposed recovery measure of skipping the corruption
and keep going would not buy you that much.  On the other hand,
if the corruption is in the middle (e.g. a single disk block was
wiped out), having .idx file might help you resync.

Does the pack pass git-verify-pack test, I wonder?
