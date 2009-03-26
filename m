From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] bisect--helper: implement "git bisect--helper"
Date: Wed, 25 Mar 2009 23:49:19 -0700
Message-ID: <7v3ad0srrk.fsf@gitster.siamese.dyndns.org>
References: <20090326055554.e91bf6ba.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 07:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjQl-0000dz-Ob
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 07:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbZCZGt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 02:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbZCZGt2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 02:49:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbZCZGt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 02:49:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EC27A5F67;
	Thu, 26 Mar 2009 02:49:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E627CA5F66; Thu,
 26 Mar 2009 02:49:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F62AEB6-19D2-11DE-A1C4-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114741>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch implements a new "git bisect--helper" builtin plumbing
> command that will be used to migrate "git-bisect.sh" to C.
>
> We start by implementing only the "--next-vars" option that will
> read bisect refs from "refs/bisect/", and then compute the next
> bisect step, and output shell variables ready to be eval'ed by
> the shell.
>
> At this step, "git bisect--helper" ignores the paths that may
> have been put in "$GIT_DIR/BISECT_NAMES". This will be fixed in a
> later patch.

Very nicely done.

> +static int read_bisect_refs(void)
> +{
> +	return for_each_bisect_ref(register_ref, NULL);
> +}

This is only a minor point, but I do not foresee anybody other than
bisect--helper (and later bisect) running for_each_bisect_ref().  It might
make sense to redo [01/10] to introduce

	for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb)

and change this call site to:

	return for_each_ref_in("refs/bisect/", register_ref, NULL);

Needless to say, for_each_{ref,tag_ref,branch_ref,remote_ref}() can be
redefined in terms of for_each_ref_in() so that we can lose these
hardcoded length of prefix strings from the code.
