From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Header files not mentioned in the makefile
Date: Mon, 03 Mar 2008 11:22:55 -0800
Message-ID: <7vr6erhasw.fsf@gitster.siamese.dyndns.org>
References: <20080303072424.GA25623@auto.tuwien.ac.at>
 <alpine.LSU.1.00.0803031146310.22527@racer.site>
 <20080303185524.GA26790@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Mon Mar 03 20:23:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGGI-0001OT-Ax
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbYCCTXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754353AbYCCTXH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:23:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYCCTXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 14:23:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 686E120D3;
	Mon,  3 Mar 2008 14:23:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8B65D20CE; Mon,  3 Mar 2008 14:22:57 -0500 (EST)
In-Reply-To: <20080303185524.GA26790@auto.tuwien.ac.at> (Martin Koegler's
 message of "Mon, 3 Mar 2008 19:55:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75974>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> On Mon, Mar 03, 2008 at 11:47:01AM +0000, Johannes Schindelin wrote:
>> On Mon, 3 Mar 2008, Martin Koegler wrote:
>> 
>> > When I modified fetch-pack.h I was surprised by the fact, that it does 
>> > not result in rebuilding all object files. In fact, no file was rebuilt. 
>> > It turned out, that fetch-pack.h was not mentioned in the Makefile.
>> > 
>> > A quick search (on next) showed, that other header files are also not
>> > taking part in dependency checking:
>> > 
>> > $for a in `ls *.h`; do grep "$a" Makefile >/dev/null || (echo "missing: $a"; grep "$a" *.c|grep include) ; done
>> > missing: branch.h
>> 
>> Somehow I miss "wt-status.h" in your list.
>
> There is a dependency for wt-status.h, so it does not show up in
> my grep:
>  builtin-revert.o wt-status.o: wt-status.h
>
> But this is complete:
> $ grep wt-status.h *.c
> builtin-commit.c:#include "wt-status.h"
> builtin-revert.c:#include "wt-status.h"
> wt-status.c:#include "wt-status.h"

I've been meaning to do a Makefile clean-up.

 * Various lists (SCRIPT_SH, SCRIPT_PERL, PROGRAMS, LIB_H, ...).  Make
   them into a sorted one-item-per-line of the form "LIB_H += foo.h".

 * Dependencies.  We probably should auto-maintain them ("gcc -M",
   makedepend etc).

 * Removing libgit.a; it used to be that what we had was a collection of
   independent programs that link various but not all object files, and it
   was a very easy and low maintenance way to tell the linker "grab
   whatever you need from libgit.a".  These days, however, we roll almost
   everything into "git" as built-ins, and the private library outlived
   its usefulness.  We can instead just link in *.o files to build "git"
   directly.

I'd probably do the first item from the above list, immediately after all
the 1.5.5 topics graduat to 'master' and v1.5.5-rc1 is tagged; at that
point, by definition, we will not have new topics on 'master' until the
final.  This conversion should not be difficult nor disruptive from
technical point of view, but it needs to be done at the right moment when
everything is quiescent.


