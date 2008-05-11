From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] repack: modify behavior of -A option to leave
 unreferenced objects unpacked
Date: Sat, 10 May 2008 18:23:05 -0700
Message-ID: <7v63tlab2e.fsf@gitster.siamese.dyndns.org>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
 <3927888.1210392047922.JavaMail.teamon@b303.teamon.com>
 <20080510060345.GC11556@sigill.intra.peff.net>
 <alpine.LFD.1.10.0805101157090.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, drafnel@gmail.com, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun May 11 03:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv0Ig-0004sS-BC
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 03:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYEKBXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 21:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbYEKBXQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 21:23:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYEKBXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 21:23:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 640825C46;
	Sat, 10 May 2008 21:23:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 858CD5C44; Sat, 10 May 2008 21:23:08 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805101157090.23581@xanadu.home> (Nicolas
 Pitre's message of "Sat, 10 May 2008 21:10:53 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D3229AE2-1EF8-11DD-990D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81723>

Nicolas Pitre <nico@cam.org> writes:

> I'm now starting to wonder if there is a reason for keeping unreachable 
> objects that used to be packed.  Putting --keep-unreachable aside for 
> now, the only way an unreachable object could have entered a pack is if 
> it used to be reachable before through the commit history or reflog.  
> So if they're not reachable anymore, that's most probably because their 
> reflog expired.  So what's the point for keeping them even longer?  
> What's the reasoning that led to the creation of --keep-unreachable in 
> the first place?

I think the logic went like this.

(1) You may have rewound your head since you last repacked; blobs and
    trees in the rewound commit are already packed now.

(2) Now you may be fetching (or somebody else may be pushing) a commit
    that contains such blobs and/or trees, and the fetch or push is small
    enough that it unpacks, but the packed and unreachable ones are not
    unpacked.

(3) But before that fetch or push finishes to update the ref, you can race
    with a "repack -a -d".
