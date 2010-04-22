From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git log --follow find copies among unmodified
 files.
Date: Wed, 21 Apr 2010 23:26:57 -0700
Message-ID: <7v1ve86lzi.fsf@alter.siamese.dyndns.org>
References: <1271908244-18910-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 08:27:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4psc-0002jN-VO
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 08:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab0DVG1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 02:27:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0DVG1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 02:27:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E32E3ACD9E;
	Thu, 22 Apr 2010 02:27:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ul3C86CR4+/io8txuOztkZI5hFs=; b=A/9Vu4
	3VHFwzuS4B5MrC/L7bXY2eE+4wErosbahmKQjHo7fcSFI4hCBc8mbQDKS7dRJh3T
	/zWj3n/sONMclyzs3duJkhyWKFq7Tss5BluGxnBClQliDa2q9vB8M6sF2K+26t+P
	U8hqVEhx2VZ04ZZ8gagihujo3UPGuZcfD2f7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wITS9VR5eNodvgfl6lbPVvQtd+WmMhFP
	Zvs9s/862Vkxr9zLSTMpmsvuDyTdgJFAzb2PHp/gURpdG8AF7s/BG02C7YI7A0pL
	8RGUeabo97uC+MqEt+4RPf3yQGP8T3Scj/8kmiEk7/woASVKfsJdGHP7qolCtKwG
	KZijD2yzKW8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9BEAACD9D;
	Thu, 22 Apr 2010 02:27:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAC7CACD99; Thu, 22 Apr
 2010 02:26:58 -0400 (EDT)
In-Reply-To: <1271908244-18910-1-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Thu\, 22 Apr 2010 11\:50\:44 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10536FF8-4DD8-11DF-BAFD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145504>

Bo Yang <struggleyb.nku@gmail.com> writes:

> @@ -56,7 +56,10 @@ include::diff-options.txt[]
>  	commits, and doesn't limit diff for those commits.
>  
>  --follow::
> -	Continue listing the history of a file beyond renames.
> +	Continue listing the history of a file beyond renames/copies.
> +	With this, all files in a commit will be searched for
> +	renames/copies, and it is equal to specify '--follow' with
> +	'--follow -M -C -C'.

Hmm.

Addition of "/copies" is fine, but I do not think the last three lines are
good.  The -M/-C options are about how the changes introduced by the found
commits are shown, and because the pathspec limitation applies _before_
all the diffcore transformations (see "Gaah. Why?" message from Linus in
the thread I pointed at you in another message), and because the --follow
option is defined to work _only_ when you give one single path (it is not
even a "pathspec" in the usual sense; see 750f7b6 (Finally implement "git
log --follow", 2007-06-19)), they are inherently mutually incompatible.

Cf. http://thread.gmane.org/gmane.comp.version-control.git/50512/focus=50513

> diff --git a/diff.c b/diff.c
> index d0ecbc3..6982f79 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2594,6 +2594,9 @@ int diff_setup_done(struct diff_options *options)
>  	else
>  		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
>  
> +	if (DIFF_OPT_TST(options, FOLLOW_RENAMES))
> +		DIFF_OPT_SET(options, FIND_COPIES_HARDER);

I don't think this is correct.  You are touching the diff options on the
"how do we show the found change" side here.

Because the user is fixated on one single path F, it is enough to say "F
is in the child but did not exist in the parent---it appears to have come
from E in the parent" without saying if it is copy or rename.  I think it
is Ok if the change is to pay the cost of full tree scanning for only
commits that try_to_follow_renames() deals with, but this instead makes it
in effect for _all_ the commits, not just the ones that created the path
that has been followed so far, which is unacceptable.

Why isn't it just a one-liner from your previous patch but done without
the conditional?  I think that would indeed be a fix.  With "--follow",
the user expressee that it is Ok to pay extra cost in order to _follow_
that single path, and we haven't been doing as thorough a job as we could.
With that single liner, you are fixing it to pay more attention to the
paths in the parent.

But that is _not_ about how the found commits are _shown_ (it is about how
the commits are _found_).

diff --git a/tree-diff.c b/tree-diff.c
index fe9f52c..0dea53e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -346,6 +346,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 
 	diff_setup(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
-- 
1.7.0.2.273.gc2413.dirty
