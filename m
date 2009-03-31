From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bsd group semantics
Date: Tue, 31 Mar 2009 14:33:26 -0700
Message-ID: <7vr60d4btl.fsf@gitster.siamese.dyndns.org>
References: <20090331112637.GA1910@coredump.intra.peff.net>
 <7vvdpp6623.fsf@gitster.siamese.dyndns.org>
 <20090331160842.GA9019@coredump.intra.peff.net>
 <7veiwd61k1.fsf@gitster.siamese.dyndns.org>
 <20090331184604.GA10701@coredump.intra.peff.net>
 <7vy6ul4exy.fsf@gitster.siamese.dyndns.org>
 <20090331203600.GA24340@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:35:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lolby-0008LJ-Vp
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 23:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109AbZCaVdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 17:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756437AbZCaVdg
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 17:33:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbZCaVdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 17:33:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B5B44B843;
	Tue, 31 Mar 2009 17:33:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CE1F2B83F; Tue,
 31 Mar 2009 17:33:27 -0400 (EDT)
In-Reply-To: <20090331203600.GA24340@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 31 Mar 2009 16:36:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94E08DA0-1E3B-11DE-B73D-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115319>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 31, 2009 at 01:26:01PM -0700, Junio C Hamano wrote:
>
>> For now, I'd suggest teaching the test not to care about g+s bit.
>> After all, they are about giving correct mode bits to files and
>> directories.  Correct mode bits for group do not mean anything if you make
>> them owned by a wrong group, but that is not something we have tested so
>> far, and can be a separate test anyway.
>
> Makes sense. How about this?
>
> -- >8 --
> Subject: [PATCH] t1301: loosen test for forced modes
>
> One of the aspects of the test checked explicitly for the
> g+s bit to be set on created directories. However, this is
> only the means to an end (the "end" being having the correct
> group set). And in fact, on systems where
> DIR_HAS_BSD_GROUP_SEMANTICS is set, we do not even need to
> use this "means" at all, causing the test to fail.
>
> This patch removes that part of the test. In an ideal world
> it would be replaced by a test to check that the group was
> properly assigned, but that is difficult to automate because
> it requires the user running the test suite be a member of
> multiple groups.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1301-shared-repo.sh |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 11ef302..9b18507 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -147,9 +147,6 @@ test_expect_success 'forced modes' '
>  	# Everything must be unaccessible to others
>  	test -z "$(sed -n -e "/^.......---/d" actual)" &&
>  
> -	# All directories must have 2770
> -	test -z "$(sed -n -e "/^drwxrws---/d" -e "/^d/p" actual)" &&

Did you mean 

-	# All directories must have 2770
-	test -z "$(sed -n -e "/^drwxrws---/d" -e "/^d/p" actual)" &&
+	# All directories must have either 2770 or 770
+	test -z "$(sed -n -e "/^drwxrw[sx]---/d" -e "/^d/p" actual)" &&


> -
>  	# post-update hook must be 0770
>  	test -z "$(sed -n -e "/post-update/{
>  		/^-rwxrwx---/d
> -- 
> 1.6.2.1.591.geb450
