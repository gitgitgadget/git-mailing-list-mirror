From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] lib-rebase.sh: introduce test_commit() and
 test_merge() helpers
Date: Tue, 27 Jan 2009 13:09:28 -0800
Message-ID: <7vvds01mnr.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901271012550.14855@racer>
 <20090127085418.e113ad5a.stephen@exigencecorp.com>
 <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901271847070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 22:11:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRvD5-0003pW-Dp
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 22:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbZA0VJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 16:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZA0VJh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 16:09:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbZA0VJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 16:09:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 959C41D688;
	Tue, 27 Jan 2009 16:09:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 66B321CB25; Tue,
 27 Jan 2009 16:09:30 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901271847070.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 27 Jan 2009 18:47:16 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CCD986AA-ECB6-11DD-A383-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107390>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	This may want to live in test-lib.sh instead.

Yeah, I tend to agree.

> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index cda7778..37430f3 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -46,3 +46,29 @@ EOF
>  	test_set_editor "$(pwd)/fake-editor.sh"
>  	chmod a+x fake-editor.sh
>  }
> +
> +# Call test_commit with the arguments "<message> [<file> [<contents>]]"
> +#
> +# This will commit a file with the given contents and the given commit
> +# message.  It will also add a tag with <message> as name.
> +#
> +# Both <file> and <contents> default to <message>.
> +
> +test_commit () {
> +	file=$2
> +	test -z "$2" && file=$(echo "$1" | tr 'A-Z' 'a-z')

	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z')}

might be more consistent with this:

> +	echo ${3-$1} > $file &&

and may be easier to read.

I'd suggest dquoting argument to echo above, i.e. "${3-$1}", and all the
references to positional arguments in the remainder of the patch, though.

> +	git add $file &&

as well as "$file" here.

> +	test_tick &&
> +	git commit -m $1 &&
> +	git tag $1
> +}
> +
> +# Call test_merge with the arguments "<message> <commit>", where <commit>
> +# can be a tag pointing to the commit-to-merge.
> +
> +test_merge () {
> +	test_tick &&
> +	git merge -m $1 $2 &&
> +	git tag $1
> +}
> -- 
> 1.6.1.482.g7d54be
