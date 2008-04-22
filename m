From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log-tree.c: Make log_tree_diff_flush() honor
 line_termination.
Date: Mon, 21 Apr 2008 19:58:27 -0700
Message-ID: <7vskxe8ujw.fsf@gitster.siamese.dyndns.org>
References: <5d46db230804211918u1444a80cwe1e977d37c2eb257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 04:59:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo8j5-0001Cd-56
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 04:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286AbYDVC6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 22:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756766AbYDVC6g
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 22:58:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbYDVC6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 22:58:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E198015A9;
	Mon, 21 Apr 2008 22:58:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 11E3515A8; Mon, 21 Apr 2008 22:58:29 -0400 (EDT)
In-Reply-To: <5d46db230804211918u1444a80cwe1e977d37c2eb257@mail.gmail.com>
 (Govind Salinas's message of "Mon, 21 Apr 2008 21:18:48 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80054>

"Govind Salinas" <govind@sophiasuchtig.com> writes:

[no justification here]

> Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>

> diff --git a/log-tree.c b/log-tree.c
> index 5b29639..374b277 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -347,7 +347,7 @@ int log_tree_diff_flush(struct rev_info *opt)
>  			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
>  			if ((pch & opt->diffopt.output_format) == pch)
>  				printf("---");
> -			putchar('\n');
> +			putchar(opt->diffopt.line_termination);
>  		}
>  	}
>  	diff_flush(&opt->diffopt);

What this "\n" separates are the commit log message (potentially followed
by the three-dash marker to signal "the patch follows") and the textual
diff (potentially with diffstat, which also is textual).

Lines in the textual diff part is always separated with "\n".  The patch
is line oriented by definition, and it does not make it any easier for the
tools to grok even if you made it NUL terminated.  The log message when
given by log-tree is typically indented by four spaces, so the beginning
of diff/patch part which is not indented can be detected easily without
the help fro NUL termination.  In other words, I do not think the tool
downstream you are writing is helped much with this change.  While I can
understand why you wanted to do it (i.e. "being consistent"), I do not
think the consistency buys us much in this particular case.

However, the tool downstream other people have already written to read
from the log-tree output already knows that there will be LF at this place
even if they drive log-tree with a "-z" option, as that has been the way
from the beginning.  I have a suspicion that tools like qgit may start
barfing with this change if they read from "-z" output.

Which makes the purist in me feel somewhat sad, but the pragmatist in me
is not convinced until he is shown how this will help the downstream tools
that read from the output from log-tree, which you didn't do with zero
line of a proposed commit log message.

A possible defense for this patch is that it _could_ make the output
easier to parse in the presense of a commit log message with a line that
begins with "diff --git" when log-tree is driven with --pretty=raw.
