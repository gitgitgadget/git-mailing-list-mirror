From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Ensure git ls-tree exits with a non-zero exit code
 if read_tree_recursive fails.
Date: Sun, 24 Jul 2011 00:45:35 -0700
Message-ID: <7vei1gw28w.fsf@alter.siamese.dyndns.org>
References: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com>
 <1311469670-15392-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 09:45:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QktNe-0002uG-NL
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 09:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab1GXHpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 03:45:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614Ab1GXHph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 03:45:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 151992C14;
	Sun, 24 Jul 2011 03:45:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x3HDA3y/p3PdSBiit3i28svZC8g=; b=svuyBc
	e7Bos9CgoVBE4cETuvOJtnYUPdFUZtMdvemJ1ISDU8J5gfGHdIqblj0pn1pPmn53
	La4OJ24fXV1KIVAHEKlUWNHbNKdMTPmhvGNQecTCIeYsMGvMD1SvUQfaqyxSa3X0
	NG9Gr3inBArNDwge+jJUfG+qrPM1zXd2Z2MeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xzkao5ku1zduczmbXaVCTFIYKRTVCr3I
	H2z27ywpUf7VZRXr6W19LzBdznfBHKJBd1AdNEOCcdy4kmCaXmtBee9D5wm3cC8g
	sZMU4CpKMlv6wypxvJXqPTPLd06k7w+iFxb3xhxKobgiJxpxhythDQv1SEmp89zH
	0HzOsQbEcYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CF082C13;
	Sun, 24 Jul 2011 03:45:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93AC52C12; Sun, 24 Jul 2011
 03:45:36 -0400 (EDT)
In-Reply-To: <1311469670-15392-3-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Sun, 24 Jul 2011 11:07:50 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB41A3B0-B5C8-11E0-AAD6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177730>

Jon Seymour <jon.seymour@gmail.com> writes:

> In the case of a corrupt repository, git ls-tree may report an error but
> presently it exits with a code of 0.
>
> This change uses the return code of read_tree_recursive instead.
>
> Improved-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  builtin/ls-tree.c               |    6 +++---
>  t/t3103-ls-tree-missing-tree.sh |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index f08c5b0..6d6c992 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -120,7 +120,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  {
>  	unsigned char sha1[20];
>  	struct tree *tree;
> -	int i, full_tree = 0;
> +	int i, full_tree = 0, err;
>  	const struct option ls_tree_options[] = {
>  		OPT_BIT('d', NULL, &ls_options, "only show trees",
>  			LS_TREE_ONLY),
> @@ -173,7 +173,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  	tree = parse_tree_indirect(sha1);
>  	if (!tree)
>  		die("not a tree object");
> -	read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
> +	err = read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
>  
> -	return 0;
> +	return err;
>  }

Makes sense.  Thanks.
