From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 05 Apr 2009 22:15:19 -0700
Message-ID: <7vab6ue520.fsf@gitster.siamese.dyndns.org>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
 <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
 <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 07:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqhCr-0002RB-2V
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 07:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbZDFFPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 01:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbZDFFPh
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 01:15:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbZDFFPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 01:15:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E79DA83F0;
	Mon,  6 Apr 2009 01:15:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CE2FEA83EB; Mon,
  6 Apr 2009 01:15:21 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0904052326090.6741@xanadu.home> (Nicolas
 Pitre's message of "Sun, 05 Apr 2009 23:34:32 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F4662C30-2269-11DE-BC64-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115763>

Nicolas Pitre <nico@cam.org> writes:

> What git-pack-objects does in this case is not a full repack.  It 
> instead _reuse_ as much of the existing packs as possible, and only does 
> the heavy packing processing for loose objects and/or inter pack 
> boundaryes when gluing everything together for streaming over the net.  
> If for example you have a single pack because your repo is already fully 
> packed, then the "packing operation" involved during a clone should 
> merely copy the existing pack over with no further attempt at delta 
> compression.

One possibile scenario that you still need to spend memory and cycle is if
the cloned repository was packed to an excessive depth to cause many of
its objects to be in deltified form on insanely deep chains, while cloning
send-pack uses a depth that is more reasonable.  Then pack-objects invoked
by send-pack is not allowed to reuse most of the objects and would end up
redoing the delta on them.
