From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH1/2]  Libify blame
Date: Tue, 17 Mar 2009 22:41:12 -0700
Message-ID: <7vocvzmlqf.fsf@gitster.siamese.dyndns.org>
References: <49BE5343.60900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: pi song <pi.songs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 06:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjoYL-0001Rj-9p
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 06:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbZCRFlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 01:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbZCRFlZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 01:41:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbZCRFlY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 01:41:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9065DA2E4E;
	Wed, 18 Mar 2009 01:41:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 993EDA2E4D; Wed,
 18 Mar 2009 01:41:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69DEDE84-137F-11DE-A7A5-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113578>

pi song <pi.songs@gmail.com> writes:

> diff --git a/blame.h b/blame.h
> new file mode 100644
> index 0000000..72d1e2a
> --- /dev/null
> +++ b/blame.h
> @@ -0,0 +1,166 @@
> +/*
> + * for storing stats. it can be used
> + * across multiple blame operations
> + */
> +struct blame_stat {
> +	int num_read_blob;
> +	int num_get_patch;
> +	int num_commits;
> +};

As I said in my previous message, I do not understand why this is not part
of the super-scoreboard (now blame_info).

> +#define PICKAXE_BLAME_MOVE		01
> +#define PICKAXE_BLAME_COPY		02
> +#define PICKAXE_BLAME_COPY_HARDER	04
> +#define PICKAXE_BLAME_COPY_HARDEST	010
> +
> +#define BLAME_DEFAULT_MOVE_SCORE	20
> +#define BLAME_DEFAULT_COPY_SCORE	40
> +
> +/* bits #0..7 in revision.h, #8..11 used for merge_bases() in commit.c */
> +#define METAINFO_SHOWN		(1u<<12)
> +#define MORE_THAN_ONE_PATH	(1u<<13)

Do we need to expose all of these constants outside blame.c?  I think the
library caller needs access to the first four above, but I tend to think
the latter four are purely internal implementation detail that should be
kept in blame.c.

> +/* output formatting constants */
> +#define OUTPUT_ANNOTATE_COMPAT  001
> +#define OUTPUT_LONG_OBJECT_NAME 002
> +#define OUTPUT_RAW_TIMESTAMP    004
> +#define OUTPUT_PORCELAIN        010
> +#define OUTPUT_SHOW_NAME        020
> +#define OUTPUT_SHOW_NUMBER      040
> +#define OUTPUT_SHOW_SCORE      0100
> +#define OUTPUT_NO_AUTHOR       0200

I think these can be public.

> +/*
> + * One blob in a commit that is being suspected
> + */
> +struct origin {
> +	int refcnt;
> +	struct origin *previous;
> +	struct commit *commit;
> +	mmfile_t file;
> +	unsigned char blob_sha1[20];
> +	char path[FLEX_ARRAY];
> +};

I somehow doubt we would want to expose this level of implementation
detail to the callers of the library.  If we need to, the structure needs
to be renamed---"origin" is way too generic a name.

> +extern void assign_blame(struct blame_scoreboard *sb, int opt) ;

Lose the extra SP before ";".  I had to fix them in your previous patch
and there were many.
