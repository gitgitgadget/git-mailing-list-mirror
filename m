From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix extraneous lstat's in 'git checkout -f'
Date: Tue, 14 Jul 2009 01:59:13 -0700
Message-ID: <7vzlb7hc7y.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0907132040530.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 10:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQdrG-0008PI-UQ
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 10:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbZGNI7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 04:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbZGNI7W
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 04:59:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZGNI7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 04:59:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6F5343F4;
	Tue, 14 Jul 2009 04:59:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 74DD843F2; Tue, 14 Jul 2009
 04:59:18 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907132040530.13838@localhost.localdomain>
 (Linus Torvalds's message of "Mon\, 13 Jul 2009 21\:01\:59 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F236D1C-7054-11DE-8018-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123231>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Quite frankly, I'd like for us to at least think about removing CE_VALID. 

This is heavy.  I personally do not use this flag, nor know anybody who
does, but deviating from the original purpose of CE_VALID, which was to
avoid lstat() on slow filesystems, people have advised/advocated its use
for "narrow checkout".  These people may not even have a file checked out
to the CE_VALID path in the work tree, and they depend on us not running
lstat() on them and instead always answering that the work tree has the
necessary blob.

> I wonder if we have other places where we have optimized away the lstat() 
> just because we decided that it was already up-to-date - without 
> realizing that something could have been marked up-to-date just because 
> it was marked CE_VALID.

That is a very valid concern, but I think fixing them may break the
"narrow checkout" people.

We may need to add ce_uptodate(ce) check instead of doing lstat() in
some places (like the one you modified in this patch), not because we want
to avoid lstat(), but because we do not want to lstat() paths that are
marked as CE_VALID.

There are some mechanisms, such as REFRESH_REALLY flag, to give an escape
hatch to break out of the CE_VALID illusion, but I have to admit that when
we did CE_VALID we did not quite clarified its ramifications with respect
to merging and branch switching.
