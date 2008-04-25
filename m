From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Add tests for git cat-file
Date: Fri, 25 Apr 2008 11:03:43 -0700
Message-ID: <7vve25q0ao.fsf@gitster.siamese.dyndns.org>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 20:06:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpSIG-0003pC-Pk
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 20:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765633AbYDYSDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 14:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765629AbYDYSDy
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 14:03:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765387AbYDYSDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 14:03:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E32024FFB;
	Fri, 25 Apr 2008 14:03:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0A0F44FF9; Fri, 25 Apr 2008 14:03:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80342>

Adam Roben <aroben@apple.com> writes:

> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
>  t/t1006-cat-file.sh |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 101 insertions(+), 0 deletions(-)
>  create mode 100755 t/t1006-cat-file.sh
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> new file mode 100755
> index 0000000..15741d9
> --- /dev/null
> +++ b/t/t1006-cat-file.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +
> +test_description='git cat-file'
> +
> +. ./test-lib.sh
> +
> +function echo_without_newline()
> +{
> +    echo "$@\c"
> +}

"function " noiseword is unnecessary and unportable.

echo "\c" is unportable.  Traditional trick to do this is to pipe it to tr
to strip "\010".

When you see "<anything>$@<anything>" in shell scripts, you usually do not
mean it, but instead mean "<anything>$*<anything>".  It does not make
difference if you always feed a single parameter, but it is a good habit
to get into.

> +function maybe_remove_timestamp()
> +{
> +    if test -z "$2"; then
> +        echo_without_newline "$1"
> +    else
> +        echo_without_newline "$1" | sed -e 's/ [0-9]\{10\} [+-][0-9]\{4\}$//'

We tend to avoid \{num\| for portability.  Do you really need them here?

> +function run_tests()
> +{
> +    type=$1
> +    sha1=$2
> +    size=$3
> +    content=$4
> +    pretty_content=$5
> +    no_timestamp=$6
> +
> +    test_expect_success \
> +        "$type exists" \
> +        "git cat-file -e $sha1"
> +    test_expect_success \
> +        "Type of $type is correct" \
> +        "test $type = \"\$(git cat-file -t $sha1)\""

It is quite hard to read with backslashes inside dq.  Please use single
quote pairs without excess backslashes when possible.
