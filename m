From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] pack-objects: don't loosen objects available in 
 alternate or kept packs
Date: Sat, 21 Mar 2009 21:43:14 -0700
Message-ID: <7vbpru9nh9.fsf@gitster.siamese.dyndns.org>
References: <ee63ef30903211526n47c40052mc40dc018f25c99fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 05:44:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlFYL-0005WN-Jk
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 05:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbZCVEnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 00:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbZCVEnY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 00:43:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZCVEnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 00:43:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9516881DB;
	Sun, 22 Mar 2009 00:43:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C027781DA; Sun,
 22 Mar 2009 00:43:15 -0400 (EDT)
In-Reply-To: <ee63ef30903211526n47c40052mc40dc018f25c99fd@mail.gmail.com>
 (Brandon Casey's message of "Sat, 21 Mar 2009 17:26:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F814E440-169B-11DE-9AB4-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114117>

Brandon Casey <drafnel@gmail.com> writes:

> If pack-objects is called with the --unpack-unreachable option then it will
> unpack (i.e. loosen) all unreferenced objects from local not-kept packs,
> including those that also exist in packs residing in an alternate object
> database or a local kept pack.  The primary(sole?) user of this option is
> git-repack.  In this case, repack will follow the call to pack-objects with
> a call to prune-packed which will delete these newly loosened objects,
> making the act of loosening a waste of time.  The unnecessary loosening can
> be avoided by checking whether an object exists in a non-local pack or a
> local kept pack before loosening it.
>
> This fixes the 'local packed unreachable obs that exist in alternate ODB
> are not loosened' test in t7700.
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>

Thanks.

Both patches are whitespace damaged, but I can cope.  But I am not sure
about one thing...

>  builtin-pack-objects.c |   26 +++++++++++++++++++++++++-
>  t/t7700-repack.sh      |    2 +-
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 6222f19..3f477c5 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1944,6 +1944,29 @@ static void
> add_objects_in_unpacked_packs(struct rev_info *revs)
>  	free(in_pack.array);
>  }
>
> +static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
> +{
> +	static struct packed_git *last_found = (void *)1;
> +	struct packed_git *p;
> +
> +	p = (last_found == (void *)1) ? packed_git : last_found;

Why (void *)1, not like:

	static struct packed_git *last_found;
	struct packed_git *p = last_found ? last_found : packed_git;

Am I missing something?

> +	while (p) {
> +		if ((!p->pack_local || p->pack_keep) &&
> +			find_pack_entry_one(sha1, p)) {
> +			last_found = p;
> +			return 1;
> +		}
> +		if (p == last_found)
> +			p = packed_git;
> +		else
> +			p = p->next;
> +		if (p == last_found)
> +			p = p->next;
> +	}
> +	return 0;
> +}
