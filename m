From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] bisect: implement "read_bisect_paths" to read
 paths in "$GIT_DIR/BISECT_NAMES"
Date: Wed, 25 Mar 2009 23:49:26 -0700
Message-ID: <7vwsacrd6x.fsf@gitster.siamese.dyndns.org>
References: <20090326055559.743cb502.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 07:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjQm-0000dz-Ft
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 07:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbZCZGth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 02:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbZCZGtg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 02:49:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZCZGtf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 02:49:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 222DBA5F69;
	Thu, 26 Mar 2009 02:49:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6B8CBA5F68; Thu,
 26 Mar 2009 02:49:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43ED797A-19D2-11DE-9ECE-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114742>

Christian Couder <chriscool@tuxfamily.org> writes:

> This is needed because  "git bisect--helper" must read bisect paths
> in "$GIT_DIR/BISECT_NAMES", so that a bisection can be performed only
> on commits that touches paths in this file.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Again, very nice.

>  bisect.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 47 insertions(+), 9 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index ce62696..a6fd826 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -4,6 +4,7 @@
>  #include "revision.h"
>  #include "refs.h"
>  #include "list-objects.h"
> +#include "quote.h"
>  #include "bisect.h"
>  
>  
> @@ -424,6 +425,33 @@ static int read_bisect_refs(void)
>  	return for_each_bisect_ref(register_ref, NULL);
>  }
>  
> +void read_bisect_paths()
> +{
> +	struct strbuf str = STRBUF_INIT;
> +	const char *filename = git_path("BISECT_NAMES");
> +	FILE *fp = fp = fopen(filename, "r");

s/= fp //;
