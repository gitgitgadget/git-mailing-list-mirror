From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 12:46:53 -0700
Message-ID: <7vej83gxjm.fsf@gitster.siamese.dyndns.org>
References: <482C85C8.90804@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwjQp-00026Q-FI
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 21:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbYEOTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 15:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbYEOTrL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 15:47:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbYEOTrK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 15:47:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACB203612;
	Thu, 15 May 2008 15:47:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AB4973609; Thu, 15 May 2008 15:47:02 -0400 (EDT)
In-Reply-To: <482C85C8.90804@facebook.com> (David Reiss's message of "Thu, 15
 May 2008 11:49:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3818294-22B7-11DD-89D2-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82224>

David Reiss <dreiss@facebook.com> writes:

> + * ....  Paths must
> + * be in a canonical form: empty components, or "." or ".." components
> + * are not allowed.  prefix_list may be null, which is like "".

The caller starts from cwd[] and chomps, so you can safely assume that it
would not feed anything problematic.  But prefix_list comes from user's
environment, and it is easy to make mistakes like doubled slashes (which
you seem to take care) and also is tempting to use ".." when specifying
the ceiling (e.g. "CEIL=$HOME/..").  Perhaps canonicalizing the ceiling
would make this easier to use for end users?


> +#if 0
> +static void test_longest_ancestor_length()
> +{
> ...
> +	assert(longest_ancestor_length("/foo/bar", "/:/bar/"      ) ==  0);

No test for nonsense/invalid input, like "::/foo" for prefix_list?

> diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
> new file mode 100755
> index 0000000..091baad
> --- /dev/null
> +++ b/t/t1504-ceiling-dirs.sh
> @@ -0,0 +1,156 @@
> +#!/bin/sh
> +
> +test_description='test GIT_CEILING_DIRS'
> +. ./test-lib.sh
> +
> +test_prefix() {
> +	test_expect_success "$1" \
> +	"test '$2' = \"\$(git rev-parse --show-prefix)\""
> +}
> +
> +test_fail() {
> +	test_expect_code 128 "$1: prefix" \
> +	"git rev-parse --show-prefix"
> +}
> +
> +TRASH_ROOT="$(pwd)"
> +ROOT_PARENT=$(dirname "$TRASH_ROOT")
> +
> +
> +unset GIT_CEILING_DIRS
> +test_prefix no_ceil ""
> +
> +export GIT_CEILING_DIRS=""

Portability.  Instead write this as two separate statements, please.

        VAR=val
        export VAR

> +test_prefix ceil_empty ""
> +
> +export GIT_CEILING_DIRS="$ROOT_PARENT"
> +test_prefix ceil_at_parent ""
> +
> +export GIT_CEILING_DIRS="$ROOT_PARENT/"
> +test_prefix ceil_at_parent_slash ""
> +
> +export GIT_CEILING_DIRS="$TRASH_ROOT"
> +test_prefix ceil_at_trash ""
> +
> ...
> +
> +export GIT_CEILING_DIRS="$TRASH_ROOT/subdi"
> +test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
> +
> +
> +export GIT_CEILING_DIRS="foo:$TRASH_ROOT/sub"
> +test_fail second_of_two
> +
> +export GIT_CEILING_DIRS="$TRASH_ROOT/sub:bar"
> +test_fail first_of_two

You may also check stuff like "sub//dir" and "::sub/dir/".

How well would this colon separated list work with msys folks?
