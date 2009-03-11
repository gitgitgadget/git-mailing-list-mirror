From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 14:47:57 -0700
Message-ID: <7veix33f5e.fsf@gitster.siamese.dyndns.org>
References: <49B74373.3090609@gmail.com>
 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
 <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
 <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
 <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
 <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Mar 11 22:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhWJ1-0000ax-Av
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 22:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbZCKVsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 17:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbZCKVsJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 17:48:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZCKVsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 17:48:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E2FCEA1394;
	Wed, 11 Mar 2009 17:48:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 297A8A1390; Wed,
 11 Mar 2009 17:47:58 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
 (david@lang.hm's message of "Wed, 11 Mar 2009 14:05:56 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D10F362-0E86-11DE-A40F-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112980>

david@lang.hm writes:

>>> there are two types of helpers that can be written
>>>
>>> 1. a low-level part that does the simple merges automaticaly and leaves
>>>    behind appropriate conflict markers when it can't
>>>
>>> 2. after a conflict has taken place, a helper to work with the user to
>>>    resolve the conflict
> ...
> secondly, I somewhat disagree with you. #1 is needed for any new
> formats that are goning to be handled, but #2 may not be.
>
> take the case of OO documents, you may not need to write a conflict
> resolver helper. the 'appropriate conflict markers' may be something
> that shows up in your normal OO document editor similar to how the
> ====> shows up in a text editor for text conflicts

You can cut it both ways.  For an OO document, you do not necessarily need
any file-level merger at the driver level, but just let the "binary"
driver declare conflicts and punt.  A merge helper can do all the work
starting from the "original, ours and theirs" that are not smudged with
conflict markers.

Between these two extremes, the discussion from other people in the thread
seemed to all focus too heavily on the "driver punts" approach, forgetting
that mergetool is useful only because most of the time we do not have to
even use it, thanks to the fact that "xdl" driver works reasonably well
for most trivial cases where branches being merged stayed away from each
other, which is the majority case.  It is a huge win from the productivity
point of view, and many people might be unaware of it because it is so
invisible.

Handling trivial cases safely and automatically at the driver level, if
you can figure out how, lets the user focus on hard cases that needs
manual intervention, and "merge helper" is about helping that manual
intervention step.

Being aware of these two distinct layers allows you to realize that there
is a third possibility.  The driver could notice the cases it can resolve
cleanly and return a cleanly merged result.  When it cannot autoresolve,
but there is no way to "mark" a tentative result with conflict markers, it
can do the same thing as the "binary" driver and let the mergetool backend
handle the "driver punted" case.
