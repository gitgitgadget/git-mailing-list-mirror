From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Really slow 'git gc'
Date: Thu, 19 Feb 2009 13:14:48 -0800
Message-ID: <7vr61uku2f.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0902191200010.21686@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 22:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaGFr-0006Bv-Ok
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbZBSVOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbZBSVOz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:14:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbZBSVOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 16:14:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A88319B889;
	Thu, 19 Feb 2009 16:14:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BE6A29B888; Thu,
 19 Feb 2009 16:14:50 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0902191200010.21686@localhost.localdomain>
 (Linus Torvalds's message of "Thu, 19 Feb 2009 12:24:43 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59EEFB68-FECA-11DD-80C6-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110753>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The real reason _seems_ to be the "--unpacked=pack-....pack" arguments. I 
> literally had 232 pack-files, and it looks like a lot of the time was 
> spent in that silly loop oer 'ignore_packed' in find_pack_entry(), when 
> revision.c does that "has_sha1_pack()" thing. You get a O(n**2) effect in 
> number of pack-files: for each commit we look over every pack-file, and 
> for every pack-file we look at, we look over each ignore_pack entry.

I think we can add a single bit to "struct packed_git" and in the middle
of setup_revisions() perform the O(N**2) once, so that find_pack_entry()
can check the bit without looping.
