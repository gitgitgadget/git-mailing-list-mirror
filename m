From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC Redux] strbuf: Add method to convert byte-size to human
 readable form
Date: Fri, 19 Sep 2008 14:55:03 -0700
Message-ID: <7v1vzfrebs.fsf@gitster.siamese.dyndns.org>
References: <1221279997-9336-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Sep 19 23:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgnyZ-0003Hz-Se
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 23:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbYISVzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 17:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYISVzL
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 17:55:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbYISVzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 17:55:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E60356269E;
	Fri, 19 Sep 2008 17:55:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C6A26269D; Fri, 19 Sep 2008 17:55:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9FBE44F8-8695-11DD-81D5-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96318>

Marcus Griep <marcus@griep.us> writes:

>  This is a redux of a prior patch as part of a series on count-objects
>  but is now split off and submitted on its own as an RFC for a library
>  function to be added to strbuf.

Ok, so I looked at the patch again.

> diff --git a/.gitignore b/.gitignore
> index bbaf9de..251537b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -147,6 +147,7 @@ test-date
>  test-delta
>  test-dump-cache-tree
>  test-genrandom
> +test-human-read
>  test-match-trees
>  test-parse-options
>  test-path-utils

Is it just me or should the test called "test-human-readable"?

> diff --git a/strbuf.c b/strbuf.c
> index 720737d..d9888fb 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -308,3 +308,95 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
> ...
> +{
> +	const int maxscale = 7;

This is unused as far as I can tell.

> +	strbuf_addf(sb, "%f", sign * val);
> +
> +	if (maxlen) {
> +		int signlen = sign == -1 ? 1 : 0;
> +		maxlen -= (sb->buf[maxlen-1+signlen] == '.' ? 1 : 0);
> +		if (maxlen <= 0) {
> +			strbuf_setlen(sb, 0);
> +			retval = maxlen - 1;
> +		} else {
> +			strbuf_setlen(sb, maxlen + signlen);
> +		}
> +	}

This means you print to the buffer and then _truncate_ down to precision,
doesn't it?  Shouldn't you be rounding (possibly up if it is above the
midway point)?

For example, if I hand 1638 to you, you would give 1.599Ki back to me, but
if I give you only 4 digits to work with, you do not want to say 1.59Ki;
instead you would rather say 1.60Ki, right?

You would need to compute the number of digits you would want to see
upfront and format the value using "%.*f" with appropriate precision.

> diff --git a/test-human-read.c b/test-human-read.c
> new file mode 100644
> index 0000000..7890922
> --- /dev/null
> +++ b/test-human-read.c
> @@ -0,0 +1,23 @@
> +#include "builtin.h"
> +#include "strbuf.h"
> +
> +int main(int argc, char **argv) {
> +	if (argc != 6) {
> +		exit(-1);
> +	}
> +
> +	struct strbuf sb;

Decl after statement.

> +	strbuf_init(&sb, 0);
> +
> +	int retval = strbuf_append_human_readable(&sb,
> +		atof(argv[1]), atoi(argv[2]), atoi(argv[3]), atoi(argv[4]));
> +
> +	int failed = strcmp(sb.buf, argv[5]);
> +
> +	fprintf( stderr, failed ? "Failure" : "Success" );
> +	fprintf( stderr, ": Act '%s'; Exp '%s'\n", sb.buf, argv[5] );
> +	fprintf( stderr, "Return Value: %d\n", retval );

Style.

> +
> +	if(failed) return -1;

Style.

> +	return retval;
> +}
> -- 
> 1.6.0.1.451.gc8d31
