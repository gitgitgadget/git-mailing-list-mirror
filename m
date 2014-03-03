From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/14] Use ALLOC_GROW() instead of inline code
Date: Mon, 03 Mar 2014 15:02:57 -0800
Message-ID: <xmqqwqganavy.fsf@gitster.dls.corp.google.com>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:03:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbt8-0006GX-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbaCCXDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:03:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005AbaCCXDC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:03:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C20FF6B731;
	Mon,  3 Mar 2014 18:03:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SoBTEtG8AkOaDbWNkgDtqlkm1Cg=; b=qQCPHf
	SHJ/mdMLj33tE5nPNH1DIQviqVRfFIfmSCYnAQsAsA9mL4RUUzAm+9VPXLz03yYJ
	fMNbGEXcPVisSnygLpbkhYUXa6wnb30vtZ6fYGHeq4D2wk3y/cGuOGx3pPTZ2ha5
	bUbwVMa+PVy/rVG51lS9VR/InASzHWDVM4An0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aBPWDxrLxIkm6dg/m6hA/a+LPnjzKcAh
	YCjjuPetIFGBaLjpH2r1uQ4VU++ow4qy+4Cx6g+T1hI/orpA67cxBc9w8USqiIwV
	7PvSMiz5AMx5tqjtec+RUMAhdDDs+5++jvLHs/3k2rZ4xq5SMBHRMnvKenIHH/Li
	2MMFNEdO/qc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CDE36B730;
	Mon,  3 Mar 2014 18:03:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB20D6B72B;
	Mon,  3 Mar 2014 18:03:00 -0500 (EST)
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
	(Dmitry S. Dolzhenko's message of "Tue, 4 Mar 2014 02:31:48 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7CDDDAC-A327-11E3-9D79-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243300>

> Dmitry S. Dolzhenko (14):
>   builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
>   bundle.c: use ALLOC_GROW() in add_to_ref_list()
>   cache-tree.c: use ALLOC_GROW() in find_subtree()
>   commit.c: use ALLOC_GROW() in register_commit_graft()
>   diff.c: use ALLOC_GROW()
>   diffcore-rename.c: use ALLOC_GROW()
>   patch-ids.c: use ALLOC_GROW() in add_commit()
>   replace_object.c: use ALLOC_GROW() in register_replace_object()
>   reflog-walk.c: use ALLOC_GROW()
>   dir.c: use ALLOC_GROW() in create_simplify()
>   attr.c: use ALLOC_GROW() in handle_attr_line()
>   builtin/mktree.c: use ALLOC_GROW() in append_to_tree()
>   read-cache.c: use ALLOC_GROW() in add_index_entry()
>   sha1_file.c: use ALLOC_GROW() in pretend_sha1_file()

All looked cleanly done.

The resulting code of 1, 3, 4, 6 and 8 share this pattern:

	ALLOC_GROW(table, number + 1, alloc);
        number++;

which may be easier to understand if done the other way around:

        number++;
	ALLOC_GROW(table, number, alloc);

That is, "we know we want one more, so make sure they fit in the
table".

But that is just a minor issue; I suspect many existing callsites to
ALLOC_GROW() already follow the former pattern, and if we decide to
to switch the former to the latter, we shouldn't be doing so within
this series (we should do that as a separate series on top of this).

Thanks; will queue.
