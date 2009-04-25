From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add an option not to use link(src, dest) &&
 unlink(src) when that is unreliable
Date: Sat, 25 Apr 2009 10:05:29 -0700
Message-ID: <7vws98y886.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
 <200904232116.10769.j6t@kdbg.org>
 <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 19:13:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxlRk-0006z5-QN
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 19:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbZDYRFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbZDYRFj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 13:05:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbZDYRFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 13:05:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C25DADE9B;
	Sat, 25 Apr 2009 13:05:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D13FADE9A; Sat,
 25 Apr 2009 13:05:31 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 25 Apr 2009 11:57:14 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4BF7DC0E-31BB-11DE-8570-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117562>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It seems that accessing NTFS partitions with ufsd (at least on my EeePC)
> has an unnerving bug: if you link() a file and unlink() it right away,
> the target of the link() will have the correct size, but consist of NULs.
>
> It seems as if the calls are simply not serialized correctly, as single-stepping
> through the function move_temp_to_file() works flawlessly.

A few questions.

When this problem triggers for you,

 (1) do we have an open file descriptor to the tmpfile?

 (2) if so have we fsync'ed (or better yet, closed) it?

 (3) if the answers to the above are "yes, no", does it help the situation
     if we fsync the filedescriptor before calling move_temp_to_file()?

    ... gitster digs after asking questions to find answers himself ...

I realize that the answers seem to be "no, and the fd that created the
tempfile has been closed".  Hmm.  Very curious.

So if you do:

	cat >corrupt-move.c <<\EOF
	#include <unistd.h>
	int main(int ac, char **av)
        {
                return (link(av[1], av[2]) || unlink(av[1]));
	}
	EOF
        cc -o corrupt-move corrupt-move.c
        ./corrupt-move corrupt-move.c corrupt-move.c.new

you end up with a corrupt-move.c.new file that is full of NUL?

Very curious...
