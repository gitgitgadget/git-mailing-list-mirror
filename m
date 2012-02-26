From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sha-1 check in rev-list --verify-objects redundant?
Date: Sun, 26 Feb 2012 00:30:01 -0800
Message-ID: <7vk43af14m.fsf@alter.siamese.dyndns.org>
References: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 09:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1ZUl-0007eX-B2
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 09:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab2BZIaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 03:30:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62689 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab2BZIaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 03:30:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2328A4463;
	Sun, 26 Feb 2012 03:30:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IxKKJjfhtmmB4W6DpgbehCCGL0E=; b=jUlOQH
	x+jSJ6vcBAvTO9WxfHm0E+PCpZF1AhJAD901+ChJfnkaP9xtt/6T66vDpgiHqsHQ
	lsL31LCBARGN1phUHHGeEp07iBqA1MozfZUxxej3y1WBY+rCzm4jBirb7JQMF8En
	gS/ux5WBIY+pv9BkG3wO79emZfzOXT6WC3nwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G2Cioz2cvJuvR36YuVEHvhuSpnk1uNlx
	kDyHvsn/lf5mzAifmmBjcvv2nUyc+qTJFn2ob2mOhQoGRwwQlBb1ooFAGA1XsUyV
	vtjYzd0SkotmZdK1t095STbI2X+zXhsofqbcStrWW7Yv0nbHaSwLe9gN3jGqEh4O
	TnvvXwBSEIk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 164444462;
	Sun, 26 Feb 2012 03:30:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF3894461; Sun, 26 Feb 2012
 03:30:02 -0500 (EST)
In-Reply-To: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 26 Feb 2012 00:15:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 142DFE32-6054-11E1-9392-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191556>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> ... I wonder if this is a
> redundant check. --verify-objects is called to verify new packs.

I do not think --verify-objects does not have anything to do with
verifying the integrity of packs, whether new or old.

The check is about the integrity of the *history* we _might_ already have
on our side, when we find ourselves wanting to fetch up to a commit $X,
whose reachability from the tips of our refs (i.e. the objects that are
guaranteed to be present in our repository) is unknown, and we somehow
already have the commit $X itself in the repository.

We cannot just declare victory upon seeing commit $X and omit fetching the
history leading to the commit, because we may or may not have its parent
commit object, or the tree object that is recorded in it (it may be that
we killed an HTTP walker after we fetched $X but not its parents or
trees).  We need to walk back from $X until we hit one of the tips of our
refs, and while doing so, we also need to make sure the trees and blobs
referenced from the walked commits are also healthy.

As 5a48d24 (rev-list --verify-object, 2011-09-01) explains, we used to do
this with --objects instead, but that check does not even make sure blobs
exist [*1*] let alone checking to see if these blobs were healthy.  The
whole point of using --verify-objects instead of --objects is to make sure
that we do not miss blob objects.


[Footnote]

*1* The --objects code reads the commits and trees in order to _list_
objects to the blob level, so implicitly, it validates that commits and
trees reachable from the commit $X we happened to have in our repository,
relying on the fact that we would error out if we fail to read them.
