From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 10:41:15 +0200
Message-ID: <86tzrhhuxg.fsf@lola.quinscape.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<85ps25y1ac.fsf@lola.goethe.zz>
	<7vk5sdscfr.fsf@assigned-by-dhcp.cox.net>
	<85wswdwjll.fsf@lola.goethe.zz>
	<7vabt9sasl.fsf@assigned-by-dhcp.cox.net>
	<85lkctw3sl.fsf@lola.goethe.zz>
	<7v3az1oyjn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 10:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGsj2-0002XL-Cg
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 10:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbXHCIlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 04:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbXHCIlb
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 04:41:31 -0400
Received: from main.gmane.org ([80.91.229.2]:60300 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754363AbXHCIla (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 04:41:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGsiq-0003cf-4n
	for git@vger.kernel.org; Fri, 03 Aug 2007 10:41:24 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 10:41:24 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 10:41:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:+m7b1ieoKA/BVecKc9vrYRQRwq4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54693>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Ok, seems like the sort of cleanups I proposed would not clash with
>> current git policies.  I'll readily agree that the timing of their
>> adoption might not really fit with a rc4, but posting them for the
>> queue does not seem outrageous.
>
> Yeah, except that Kristian's C-rewrite of git-commit.sh may well
> jump the queue before such a patch would touch the file it
> intends to replace...

Well, since the work has already been done, I guess I might as well
post it.

With regard to C rewrites: I would hazard a guess that git's
performance might actually be improved by splitting some primitives
into even smaller C building blocks and tying them all together with
pipes (which makes shell scripts a natural container).  As long as one
designs the C chunks carefully enough that no bulk processing is done
in the scripts themselves, this could actually lead to better
schedulable pieces of software.  I think that most index processing
can be done in a list-merge style on sorted lists.  That implies pipes
and files on input and output, and a small memory footprint.  With a
good scheduler (the current Linux scheduler sucks at exploiting the
asynchronicity of pipes; this should be better with CFS), this should
make things work rather efficiently, be flexible for extension, and
make good use of multi-core systems.

We have seen a recent example on this list: hand-chaining git-ls-files
and a few other tools into a pipeline beat the pants off
builtin-add.c.

Given that portability goes down the drain if we want to use similarly
or more efficient constellations in C (multithreading and asynchronous
I/O come to mind), I would not replace shell scripts (and the
associated flexibility in extending functionality) lightly right now.
As long as the main data flow is only managed rather than processed by
the scripts, I think we would have more to gain by restructuring into
pipelineable pieces.  It will still be possible to ultimately tie
those together in a single process image (with multiple threads
presumably).  But that immediately takes away a lot of flexibility.

-- 
David Kastrup
