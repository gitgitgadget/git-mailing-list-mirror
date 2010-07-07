From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/6] fast-export: Fix output order of D/F changes
Date: Wed, 07 Jul 2010 14:40:53 -0700
Message-ID: <7vy6dnrmvu.fsf@alter.siamese.dyndns.org>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
 <1278480034-22939-6-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 07 23:42:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWcNg-0002M1-O7
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 23:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892Ab0GGVlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 17:41:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757907Ab0GGVlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 17:41:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB901C202E;
	Wed,  7 Jul 2010 17:41:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5Jnw/FxIm6h28pbWSCqItogMD2o=; b=Ml+ubbBRR9XINGDL/FriIZN
	cwz2qHpezXN/Atdmr7KbGX5yR9akvp2dGWIkolxfedq4nz3sMhqSBqkdLd44ERoe
	JfwCFlob/P9XcfInwqfFsThz/RB3lZpTL397tMCskoiOLFs/Qbfpr5VqdgeOnP7Q
	Wa6aksRcTT2fy+NPCnE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TuK/dXdzVuSRKN6dHT+QsTBfI7ELZ3h0J/3DYKla/wTU2tm5v
	1dykmCCaUEL+xr4zOWvEE2In7Pzw4atgg/hAFtxhV8PzSE6XGHD/0G71flD2VON1
	Bzjb89OeZj/Y2wurj9tSyGKUzVphdIcmHZ8zQ283iO63PSNhsIWYaIHR/M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B54BC202D;
	Wed,  7 Jul 2010 17:40:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8AEBC202C; Wed,  7 Jul
 2010 17:40:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5502FDCA-8A10-11DF-B220-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150509>

newren@gmail.com writes:

> From: Elijah Newren <newren@gmail.com>
>
> The fast-import stream format requires incremental changes which take place
> immediately, meaning that for D->F conversions all files below the relevant
> directory must be deleted before the resulting file of the same name is
> created.  Reversing the order can result in fast-import silently deleting
> the file right after creating it, resulting in the file missing from the
> resulting repository.
>
> We correct the order by instructing the diff_tree machinery to compare
> entries using df_name_compare instead of base_name_compare.

I am not so sure about this one.

You can be walking two trees, one of which has "b-1" (blob), "b-2" (blob)
and then "b" (tree), while the other one has "b" (blob), "b-1" (blob) and
then "b-2" (blob).  The patch tells the machinery that "b" (tree) sorts
just like "b" (blob) only during comparison, but the actual data stream it
is walking is sorted differently.  Without some form of lookahead, can you
reliably "correct the order"?
