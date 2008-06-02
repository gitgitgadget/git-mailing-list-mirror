From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make verify-pack a bit more useful with bad packs
Date: Sun, 01 Jun 2008 23:27:40 -0700
Message-ID: <7vskvw8i77.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0805291716470.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 08:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K33X9-0008DQ-4V
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 08:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbYFBG1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 02:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbYFBG1u
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 02:27:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYFBG1t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 02:27:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D8EA3543;
	Mon,  2 Jun 2008 02:27:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 912DA3540; Mon,  2 Jun 2008 02:27:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805291716470.23581@xanadu.home> (Nicolas
 Pitre's message of "Thu, 29 May 2008 17:34:50 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04525A96-306D-11DD-8DBF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83496>

Nicolas Pitre <nico@cam.org> writes:

> When a pack gets corrupted, its SHA1 checksum will fail.  However, this
> is more useful to let the test go on in order to find the actual 
> problem location than only complain about the SHA1 mismatch and
> bail out.
> ...
>  	/* Verify SHA1 sum of the index file */
>  	SHA1_Init(&ctx);
>  	SHA1_Update(&ctx, index_base, (unsigned int)(index_size - 20));
>  	SHA1_Final(sha1, &ctx);
>  	if (hashcmp(sha1, index_base + index_size - 20))
> -		ret = error("Packfile index for %s SHA1 mismatch",
> +		err = error("Packfile index for %s SHA1 mismatch",
>  			    p->pack_name);
>  
> -	if (!ret) {
> -		/* Verify pack file */
> -		struct pack_window *w_curs = NULL;
> -		ret = verify_packfile(p, &w_curs);
> -		unuse_pack(&w_curs);
> -	}
> +	/* Verify pack file */
> +	err = verify_packfile(p, &w_curs);

This overwrites the index SHA-1 mismatch you detected earlier.  An obvious
fix-up would be to:

	err |= verify_packfile(p, &w_curs);

Will be in 1.5.6-rc1.
