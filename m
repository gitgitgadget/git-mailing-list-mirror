From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/11] Introduce filter_independent() in commit.c
Date: Thu, 19 Jun 2008 20:03:58 -0700
Message-ID: <7vabhgq02p.fsf@gitster.siamese.dyndns.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org> <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org> <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org> <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org> <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org> <6323597c45d409498ce231b063737bb36c52ef9f.1213917600.git.vmiklos@frugalware.org> <172740d7c998269dd0c454a1365a429acdf7cae2.1213917600.git.vmiklos@frugalware.org> <c83288c0995a7b4463b66e2f45d1a14839f0901c.1213917600.git.vmiklos@frugalware.org> <0d95a099ad6e47c60894983ab7bfd94a3aeddce7.1213917600.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 05:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9WwL-00017J-BC
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 05:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbYFTDEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 23:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbYFTDEc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 23:04:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYFTDEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 23:04:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 273AD1DC2D;
	Thu, 19 Jun 2008 23:04:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B23461DC28; Thu, 19 Jun 2008 23:04:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 90BE72F6-3E75-11DD-886A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85593>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This is similar to git-show-branch --independent: It filters out commits
> which are reachable from any other item from the input list.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  commit.c |   16 ++++++++++++++++
>  commit.h |    1 +
>  2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 6052ca3..0dbf4b7 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -705,3 +705,19 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
>  	free_commit_list(bases);
>  	return ret;
>  }
> +
> +struct commit_list *filter_independent(unsigned char *head,
> +	struct commit_list *heads)
> +{
> +	struct commit_list *i, *bases, *ret = NULL;
> +	struct commit_list **pptr = &ret;
> +
> +	commit_list_insert(lookup_commit(head), &heads);
> +
> +	bases = get_octopus_merge_bases(heads);
> +
> +	for (i = heads; i; i = i->next)
> +		if (!(i->item->object.flags & RESULT))
> +			pptr = &commit_list_insert(i->item, pptr)->next;

Hmm.  How well was this function tested?

Because RESULT is an implementation detail of merge_bases(), I do not
think we would want to expose it outside of it.

More worryingly, the flag is supposed to be cleaned from the objects after
get_merge_bases() returns.  I am not sure what you'll learn by looking at
the flag here.
