From: Junio C Hamano <gitster@pobox.com>
Subject: Re: not all tests pass when on an NFS partition
Date: Thu, 12 Feb 2009 13:20:34 -0800
Message-ID: <7vk57vjqsd.fsf@gitster.siamese.dyndns.org>
References: <3a69fa7c0902121220n4ea2f19di6fe984dd2002772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:22:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXj0Z-0006U2-5O
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbZBLVUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbZBLVUk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:20:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbZBLVUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:20:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E17632AFFB;
	Thu, 12 Feb 2009 16:20:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1C7142AFFA; Thu,
 12 Feb 2009 16:20:35 -0500 (EST)
In-Reply-To: <3a69fa7c0902121220n4ea2f19di6fe984dd2002772@mail.gmail.com> (E.
 R.'s message of "Thu, 12 Feb 2009 14:20:19 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FED22BEE-F94A-11DD-988F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109660>

E R <pc88mxer@gmail.com> writes:

> When I run 'make test' for git-1.6.1.3 it will fail on this test when
> running on an NFS partition.

... when the filesystem clock and the machine clock are out of sync.

> Is this a known problem? Is this a real problem?

It's a problem whose cause can be easily guessed ;-)

The tests check if the default expiration period (14 days) are honored by
creating unreferenced objects that are slightly older and slightly newer
than the cut-off timestamp and running the gc.  I suspect that the issue
with network filesystems whose clock are not grossly skewed can easily be
worked around by tweaking these -30 and +1 constants to larger (but not
too large to make the tests meaningless) values.

> My uname -a: Linux XXX 2.6.18-92.1.17.el5 #1 SMP Tue Nov 4 13:45:01
> EST 2008 i686 athlon i386 GNU/Linux
>
>
> *** t5304-prune.sh ***
> *   ok 1: setup
> *   ok 2: prune stale packs
> *   ok 3: prune --expire
> * FAIL 4: gc: implicit prune --expire
>
>
>                 before=$(git count-objects | sed "s/ .*//") &&
>                 BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
>                 BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
>                 test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
>                 test -f $BLOB_FILE &&
>                 test-chmtime =-$((86400*14-30)) $BLOB_FILE &&
>                 git gc &&
>                 test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
>                 test -f $BLOB_FILE &&
>                 test-chmtime =-$((86400*14+1)) $BLOB_FILE &&
>                 git gc &&
>                 test $before = $(git count-objects | sed "s/ .*//") &&
>                 ! test -f $BLOB_FILE
