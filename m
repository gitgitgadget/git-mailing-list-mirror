From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: write out cache-tree information
Date: Tue, 02 Aug 2011 11:13:40 -0700
Message-ID: <7vmxfrel63.fsf@alter.siamese.dyndns.org>
References: <9f5e031045b55c4738de8bc9aae290827e128cd3.1312302862.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 02 20:13:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoJTQ-0007qw-Cf
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 20:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1HBSNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 14:13:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab1HBSNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 14:13:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 258153D2D;
	Tue,  2 Aug 2011 14:13:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8J+DBRCNA6hkg5tn0FgQoP9h3O4=; b=b6FGLQ
	wPwb6arHE9ts4mAHo6FBzN65AY9a8aj5QqmQstjPzkDqbzOypkogCBg9bu121fr+
	pF0eisFhHj+a7wKMcuIoxeEjc2v+BpZ42NlH00FO1elixSP+OkbCfR90GF/3CR1N
	hrEW059qXDX4NKzxSbs99ppPNEY4BxpbVVNnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kFl71gSCorGPGb22tzVfsO6zFAfojP4n
	P2BFvjlhZgFjL61D4dq7+zvD3+V28DovNC8zQ8JgMww9EejKCgv0NGEBrXDBoqxi
	WvnGArHIcoaQp3sVB356igrC2QyIGB79imyAp3npBFncDNiSrFUSnJ2KSNqbi2Yr
	KaXUDoHrBjg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CB843D2C;
	Tue,  2 Aug 2011 14:13:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A53053D2B; Tue,  2 Aug 2011
 14:13:41 -0400 (EDT)
In-Reply-To: <9f5e031045b55c4738de8bc9aae290827e128cd3.1312302862.git.trast@student.ethz.ch> (trast@student.ethz.ch's message of "Tue, 2 Aug 2011 18:36:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 270748E8-BD33-11E0-BF3D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178493>

<trast@student.ethz.ch> writes:

> From: Thomas Rast <trast@student.ethz.ch>
>
> While write-tree has code to write out the cache-tree information
> (since we have to compute it anyway if the cache is stale), commit
> lost this capability when it became a builtin and moved away from
> using write-tree.

Earlier the code read from the index, made sure that it is not unmerged by
running cache_tere_update(), before running prepare-commit-msg hook. The
hook used to see the index that was read in this codepath which is the
same as what pre-commit left us.

Why run an extra I/O here? The index file could be quite large, and I do
not want people to writing it out without good reason.

The tree object that is committed is taken from active_cache_tree->sha1 in
cmd_commit() and not from the cache tree you are writing out to the index
file.
