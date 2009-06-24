From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fread does not return negative on error
Date: Wed, 24 Jun 2009 09:15:20 -0700
Message-ID: <7vws71wquf.fsf@alter.siamese.dyndns.org>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu>
	<25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com>
	<4A3FB479.2090902@lsrfire.ath.cx>
	<7vhby64i8f.fsf@alter.siamese.dyndns.org>
	<20090624081819.GA10436@elte.hu>
	<alpine.DEB.1.00.0906241201040.4773@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	roel kluin <roel.kluin@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 24 18:15:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJV8F-0001bC-4N
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 18:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbZFXQPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 12:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbZFXQPU
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 12:15:20 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62603 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbZFXQPT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 12:15:19 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090624161521.OQNU17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Wed, 24 Jun 2009 12:15:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 7sFM1c0034aMwMQ04sFM9Q; Wed, 24 Jun 2009 12:15:21 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=F_o4wktclTQA:10 a=gA5Y4G7fYRxiLLm0FjAA:9
 a=9tMDMil1Dg2kv_TpEFYsQ9AIYZwA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0906241201040.4773@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Wed\, 24 Jun 2009 12\:03\:29 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122141>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This here script:
>
> -- snip --
> for file in abspath.c alias.c cache.h color.c color.h config.c ctype.c \
> 	environment.c exec_cmd.c exec_cmd.h help.c help.h levenshtein.c \
> 	levenshtein.h pager.c parse-options.c parse-options.h path.c \
> 	quote.c quote.h run-command.c run-command.h sigchain.c sigchain.h \
> 	strbuf.c strbuf.h string.c string.h symbol.c symbol.h usage.c \
> 	util.h wrapper.c
> do
> 	echo $file
> 	git shortlog -n -s $file | head -n 2
> done

I have thought about suggesting this myself, and your output for many of
the files matched my intuition, but some were grossly off, so I checked.

The above procedure counts commits, and a one liner "s/char \*/const &/"
weighs as heavily as the patch that implemented the whole thing, for a
file that was done in one commit almost perfectly except that it needed a
small constness fix.  Summarizing output from "blame" for each file may
give you a more meaningful results:

    # timestamp
    ts='[12][0-9][0-9][0-9]-[0-9][0-9]-[0-3][0-9] ..:..:.. [-+]....'
    # linenum
    lno='[1-9][0-9]*'
    git blame "$file" |
    sed -e 's/^[^ ]*  *(\([^)]*[^ ]\)  *'"$ts  *$lno"').*/\1/' |
    sort |
    uniq -c |
    sort -r -n

For example, I do not think it is fair to credit me for abspath.c more
than Dmitry like this:

> outputs this (note that a few files you mentioned are not in git.git):
>
> abspath.c
>      2	Junio C Hamano
>      1	Dmitry Potapov

Initially Dmitry introduced this file with 5b8e6f8 (shrink git-shell by
avoiding redundant dependencies, 2008-06-28) at 68 lines.  J6t added 36
lines for add_path() with 10c4c88 (Allow add_path() to add non-existent
directories to the path, 2008-07-21), I added 12 lines to add a new
function with 90b4a71 (is_directory(): a generic helper function,
2008-09-09) and then added a two-liner out-of-bounds-then-die check in
737e31a (make_absolute_path(): check bounds when seeing an overlong
symlink, 2008-12-17).
