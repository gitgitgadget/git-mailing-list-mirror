From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] diff_tree_sha1: skip diff_tree if old == new
Date: Fri, 01 Apr 2011 15:28:53 -0700
Message-ID: <7vfwq1ehcq.fsf@alter.siamese.dyndns.org>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 00:29:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5mqL-0004nR-1c
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 00:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795Ab1DAW3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 18:29:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251Ab1DAW3D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 18:29:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 805C748D9;
	Fri,  1 Apr 2011 18:30:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rIbAtKaPobtqSkbxGLP78yAU8dA=; b=hMA26E
	Ct1cGfsQXMZOfi1/LUiJnVb8sQIVclstjejFwKW4NsUMu+H3+4J1qo/f9eIY0KGi
	uAXbzoDkNNFKNAqcOfRrhZlXoVZtcaElM8oyE3Gvtaf0DWZC6H7OT+JsmCV+aHI+
	+gv9zMzN2ekxYgPe5hW//dAJujFGOgaXByJg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U+i1d0sgCvySv0yxos/9J/1ugjrUyyZZ
	Zvn+Q2h6V1WkyMdWMFMBdS18k2of8UOz7BBcIaO7zJFZJHwwVifXMLtWkJh3QbAn
	3Cc3jV2zmwYkCsM97YqJ6JNo94HhXzE1O7B4RDKS9Z3K+7hI8Jb1c5aIGNmAd0bF
	B0Eh0eDswC0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E81448D7;
	Fri,  1 Apr 2011 18:30:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7A8D548D6; Fri,  1 Apr 2011
 18:30:45 -0400 (EDT)
In-Reply-To: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Wed, 30 Mar 2011 20:37:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1334B6E-5CAF-11E0-85C0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170632>

Dan McGee <dpmcgee@gmail.com> writes:

> This was seen to happen in some invocations of git-log with a filtered
> path. Only do it if we are not recursively descending, as otherwise we
> mess with copy and rename detection in full tree moves.

There is no code that corresponds to your "Only do it..." description in
your patch, though.  The existing code already takes care of that part
with or without your patch, no?

> diff --git a/tree-diff.c b/tree-diff.c
> index 76f83fc..ab90f1a 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -286,6 +286,9 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
>  	unsigned long size1, size2;
>  	int retval;
>  
> +	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(old, new))
> +		return 0;
> +

I am very curious why this patch makes a difference; doesn't an existing
test in compare_tree_entry() oalready cull extra recursion?  There is:

	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) &&
		mode1 == mode2)
		return 0;

before a recursive call to diff_tree_sha1() to dig deeper.
