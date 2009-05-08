From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix segfault in merge-recursive
Date: Fri, 08 May 2009 16:36:16 -0700
Message-ID: <7vocu3p3pr.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net>
	<alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de>
	<alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net>
	<alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave O <cxreg@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 09 01:36:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2ZcH-0004qH-PK
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 01:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762159AbZEHXgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 19:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763357AbZEHXgS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 19:36:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34524 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122AbZEHXgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 19:36:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508233616.FRPY17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 May 2009 19:36:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id pBcH1b0024aMwMQ04BcHrW; Fri, 08 May 2009 19:36:17 -0400
X-Authority-Analysis: v=1.0 c=1 a=8jqgv1hcQK4A:10 a=cdyOxa89AhGyP6sK-qwA:9
 a=RfgG9tlTFuKWredGt3jAmhITICAA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302> (Johannes Schindelin's message of "Fri\, 8 May 2009 22\:30\:32 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118639>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When there is no "common" tree (for whatever reason), we must not
> throw a segmentation fault.

You described why the old code was wrong (i.e. "init_tree_desc_from_tree
is called with common == NULL"), but there is no mention why the new code
is correct.  For the purpose of satisfying the above statement, you could
have just exit(0) as well ;-)

> +	else {
> +		opts.merge = 0;
> +		opts.head_idx = 1;
> +		init_tree_desc_from_tree(t+0, head);
> +		init_tree_desc_from_tree(t+1, merge);
> +		rc = unpack_trees(2, t, &opts);
> +	}

This looks more like a half of branch-switch from HEAD to MERGE, not a
merge between HEAD and MERGE as two equal histories.  Shouldn't it be
doing a three-way tree merge using an empty tree object as the common
ancestor instead, just like merge_recursive.c::merge_recursive() itself
does?
