From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3 v2] Teach git diff-tree --stdin to diff trees
Date: Sat, 09 Aug 2008 13:41:23 -0700
Message-ID: <7vwsip53bg.fsf@gitster.siamese.dyndns.org>
References: <20080809095605.GA10804@diana.vm.bytemark.co.uk>
 <20080809120816.11085.66578.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 22:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRvGk-00062D-EP
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 22:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYHIUlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 16:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYHIUlc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 16:41:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYHIUlb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Aug 2008 16:41:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 69F5452B44;
	Sat,  9 Aug 2008 16:41:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A1A9452B43; Sat,  9 Aug 2008 16:41:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B2C64DC-6653-11DD-9288-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91780>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> When feeding trees on the command line, you can give exactly two
> trees, not three nor one; --stdin now supports this "two tree" form o=
n
> its input, in addition to accepting lines with one or more commits.
>
> When diffing trees (either specified on the command line or from the
> standard input), the -m, -s, -v, --pretty, --abbrev-commit,
> --encoding, --no-commit-id, -c, --cc, and --always options are
> ignored, since they do not apply to trees.

I've commented on this part already; -m, -c, --cc are excluded because
they make sense only when you are dealing with three or more trees.

> diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
> index ebbd631..0bdb1cf 100644
> --- a/builtin-diff-tree.c
> +++ b/builtin-diff-tree.c
> @@ -42,21 +42,48 @@ static int stdin_diff_commit(struct commit *commi=
t, char *line, int len)
>  	return log_tree_commit(&log_tree_opt, commit);
>  }
> =20
> +/* Diff two trees. */
> +static int stdin_diff_trees(struct tree *tree1, char *line, int len)
> +{
> +	unsigned char sha1[20];
> +	struct tree *tree2;
> +	if (len !=3D 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sh=
a1)) {
> +		error("Need precisely two trees, separated by one space");
> +		return -1;
> +	}

error() returns -1, so:

	if (len !=3D 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1)=
)
		return error("Need two trees, separated by one space");

> +	tree2 =3D lookup_tree(sha1);
> +	if (!tree2 || parse_tree(tree2))
> +		return -1;

Don't you want to make error() say something here as well?

> +	printf("%s %s\n", sha1_to_hex(tree1->object.sha1),
> +			  sha1_to_hex(tree2->object.sha1));

Since this is strictly for Porcelain's use, you may want to document th=
is
output format.

Two-tree form from the command line does not have anything like this, a=
nd
two-commit form from --stdin have either a single object name, the log
message under -v or --pretty options.  I notice that these are not
documented but we may want to document it while at it.

Other than that, the patch looks good.  Thanks.
