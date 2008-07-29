From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Support copy and rename detection in fast-export.
Date: Tue, 29 Jul 2008 09:11:57 -0700
Message-ID: <7v7ib4hdpu.fsf@gitster.siamese.dyndns.org>
References: <200807211216.01694.angavrilov@gmail.com>
 <200807262249.18005.angavrilov@gmail.com>
 <20080726202103.GA15769@spearce.org>
 <200807270052.55370.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 18:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNrp3-0004lD-LR
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 18:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbYG2QML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 12:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbYG2QML
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 12:12:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbYG2QMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 12:12:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D68B41246;
	Tue, 29 Jul 2008 12:12:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DE9B141241; Tue, 29 Jul 2008 12:12:01 -0400 (EDT)
In-Reply-To: <200807270052.55370.angavrilov@gmail.com> (Alexander Gavrilov's
 message of "Sun, 27 Jul 2008 00:52:54 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1741300C-5D89-11DD-85FD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90652>

Alexander Gavrilov <angavrilov@gmail.com> writes:

> Although it does not matter for Git itself, tools that
> export to systems that explicitly track copies and
> renames can benefit from such information.
>
> This patch makes fast-export output correct action
> logs when -M or -C are enabled.
>
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
> ---
>
> 	On Sunday 27 July 2008 00:21:03 Shawn O. Pearce wrote:
> 	> Do you mean to say git-fast-export in the end of the first line of
> 	> that last paragraph?
>
> 	Yes, of course. Thank you.

Alexander, Shawn, what is the status of this patch?  Has it been reviewed
sufficiently and is ready for application?

>  Documentation/git-fast-export.txt |    9 +++++++
>  builtin-fast-export.c             |   28 +++++++++++++++++++++-
>  t/t9301-fast-export.sh            |   46 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> index 332346c..bb2f9a8 100644
> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -36,6 +36,15 @@ when encountering a signed tag.  With 'strip', the tags will be made
>  unsigned, with 'verbatim', they will be silently exported
>  and with 'warn', they will be exported, but you will see a warning.
>  
> +-M, -C::
> +	Perform move and/or copy detection, as described in the
> +	linkgit:git-diff[1] manual page, and use it to generate
> +	rename and copy commands in the output dump.

I think it is more fashionable to do what 3240240 (Docs: Use
"-l::\n--long\n" format in OPTIONS sections, 2008-06-08) did these days,
i.e.:

	-M::
        -C::
        	Description...

> ++
> +Note that these options were always accepted by git-fast-export,
> +but before a certain version it silently produced wrong results.
> +You should always check the git version before using them.
> +

I do not quite follow the mention of "before a certain version", but I
think it is talking about the earlier "fast-export" that took any diff
options but did not act differently upon renamed/copied entries.  If that
is the case, I think we can say something like this instead:

	Note that earlier versions of this command did not complain and
	produced incorrect results if you gave these options.

because docs always talk about the current version.  My reading of Dscho's
original 'show_filemodify' suggests me that "wrong results" does not just
mean missing rename/copy information but a renamed old entity did not get
removed correctly, resulting in an incorrect tree in the commit, right?
Maybe we would want to be a bit more explicit about what kind of breakage
you are talking about here.

> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 8bea269..3225e8f 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -118,10 +118,27 @@ static void show_filemodify(struct diff_queue_struct *q,
>  {
>  	int i;
>  	for (i = 0; i < q->nr; i++) {
> +		struct diff_filespec *ospec = q->queue[i]->one;
>  		struct diff_filespec *spec = q->queue[i]->two;
> -		if (is_null_sha1(spec->sha1))
> +
> +		switch (q->queue[i]->status) {
> +		case DIFF_STATUS_DELETED:
>  			printf("D %s\n", spec->path);
> -		else {
> +			break;
> +
> +		case DIFF_STATUS_COPIED:
> +		case DIFF_STATUS_RENAMED:
> +			printf("%c \"%s\" \"%s\"\n", q->queue[i]->status,
> +			       ospec->path, spec->path);
> +
> +			if (!hashcmp(ospec->sha1, spec->sha1) &&
> +			    ospec->mode == spec->mode)
> +				break;
> +			/* fallthrough */

If you see a copied or renamed entry, you emit "this old path to that old
path" first, and then say that same path got modified.  It appears from my
quick glance of fast-import that touching the same path more than once in
a same commit like this sequence does would work fine (it will involve two
calls to tree_content_set() for the same path but that is not something it
has to forbid, and the function doesn't).

> diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
> index f18eec9..bb595b7 100755
> --- a/t/t9301-fast-export.sh
> +++ b/t/t9301-fast-export.sh
> @@ -162,4 +162,50 @@ test_expect_success 'submodule fast-export | fast-import' '
>  
>  '
>  
> +export GIT_AUTHOR_NAME='A U Thor'
> +export GIT_COMMITTER_NAME='C O Mitter'
> +
> +test_expect_success 'setup copies' '
> +
> +	git config --unset i18n.commitencoding &&

These are somewhat unusual.  Was there any reason for these exports and
config?
