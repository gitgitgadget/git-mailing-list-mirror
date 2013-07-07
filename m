From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] name-rev: fix assumption about --name-only usage
Date: Sun, 07 Jul 2013 11:18:23 -0700
Message-ID: <7v61wm44k0.fsf@alter.siamese.dyndns.org>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
	<1373200996-9753-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtXZ-0007c6-Ng
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab3GGSS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:18:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab3GGSSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:18:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CEDC2EF66;
	Sun,  7 Jul 2013 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=GeqwgPEhHBBhkgnoIteV9udRkWs=; b=MuY88MvdjCpnAUMel7xe
	9zXmHirVlxA65WzGy4gHdXgpVKuF3WfFTS2LJjlpNR6qXDQRT+3wmBce0shWHJKI
	rd6LexScpfoUj/DL1rD+BhOCb1f01yGLRAi5YEz39XtIezr2hkmWg2o2iAhvNs6A
	Fv7zhkHTyGQoffeuV5+40c0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=alEoaKW6EC5zOTYno1yadhed9aTTQLxPWD08TyHE87DyfR
	7AD0nhoyt5yIepiOy5PPplUvcCJPW6LkgpD2fnQnbhZiyapTxSnvxWauPO4Su/qV
	IEjQqqht/ilj9gRUkzAlosu8qHYGkml1o7Z/OkcxU23lmcKP2PHdiSdMKW3OM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 223082EF65;
	Sun,  7 Jul 2013 18:18:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F1222EF57;
	Sun,  7 Jul 2013 18:18:24 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CD71A9C-E731-11E2-B0D2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229793>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 236157 (Teach git-describe how to run name-rev, 2007-05-21) introduced
> `git name-rev --name-only`, with the intent of using it to implement
> `git describe --contains`.  According to the message, users wanted to
> use describe to figure out which tags contains a specific commit.
> name-rev already did this, but didn't print out in the same format as
> describe:
>
>   $ git describe v1.8.3~1
>   v1.8.3-rc3-8-g5e49f30
>
> ...  As a result, while
>
>   $ git describe --contains v1.8.3~1
>   v1.8.3~1

The above two look consistent, yes.

>
> would get name-rev to print output in the same format as describe,
>
>   $ git describe --contains --all v1.8.3~1
>   tags/v1.8.3~1
>
> would not strip the leading "tags/".

If you _know_ v1.8.3 does not appear outside "tags/", this does look
inconsistent, but I do not think the code checks it.  Ahd if the
code does not, I am not sure not stripping "tags/" is necessarily a
bad thing, because "--all" allows names to come outside "tags/"
hierarchy.

Also how should this interact with v1.8.3-1-g98c5c4a that changed
the rule somewhat so that the common prefix is stripped when we know
the result is not ambiguous?
