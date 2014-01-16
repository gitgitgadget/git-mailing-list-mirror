From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] revision: mark contents of an uninteresting tree uninteresting
Date: Wed, 15 Jan 2014 16:35:16 -0800
Message-ID: <xmqq61pk227v.fsf@gitster.dls.corp.google.com>
References: <1389830384-22851-1-git-send-email-gitster@pobox.com>
	<1389830384-22851-2-git-send-email-gitster@pobox.com>
	<20140116001607.GN18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 01:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3avd-0004ha-5C
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 01:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbaAPAfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 19:35:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbaAPAfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 19:35:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7545B64A25;
	Wed, 15 Jan 2014 19:35:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8gMflv+T/64muWCz/JP5o4KFgcM=; b=QNvm2S
	5ZbDL++/M+O5gTwachHgT23rNUqjrV0eMQGEZFoq83eKps3k8Xa2wmCq8+CnI47g
	1yEDsEGIoRMvtLe6ZRDdjgFrxjGU0WAEcu+lMlpfVgqq/+QVSlEOCd0VK47anAj8
	knOa7A4egUbQVwTDFlveIQ1C0Vh8ppFQLY9Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=irALkb7e/RsxhH8NEKlk5ihGAWvU5J+F
	Hx2eVTv0lXhAMY/Dbs0HxCto9ree1a61XWDaUFhQMx6hzicppbLoAWas8Z0Xr/q1
	zReYM5j8JhOBC/1Kek0DdrLUXs4eR94c0xPtSh+sfaer120pFtQXZiSfHFdc9hZd
	DoeMyJzN37w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6876B64A22;
	Wed, 15 Jan 2014 19:35:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7E2264A21;
	Wed, 15 Jan 2014 19:35:18 -0500 (EST)
In-Reply-To: <20140116001607.GN18964@google.com> (Jonathan Nieder's message of
	"Wed, 15 Jan 2014 16:16:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1353BE68-7E46-11E3-BF14-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240496>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> we see the top-level tree marked as uninteresting (i.e. ^A^{tree} in
>> the above example) and call mark_tree_uninteresting() on it; this
>> unfortunately prevents us from recursing into the tree and marking
>> the objects in the tree as uninteresting.
>
> So the tree is marked uninteresting twice --- once by setting in the
> UNINTERESTING flag in handle_revision_arg() and a second attempted
> time in mark_tree_uninteresting()?   Makes sense.

It is that the original code, the setting of the mark on the object
itself was inconsistent.  For commits, we did that ourselves; for
trees, we let the mark_tree_uninteresting() do so.

And mark_tree_uninteresting() has this quirk that it refuses to
recurse into the given tree, if the tree is already marked as
uninteresting by the caller.

We did not have the same problem on commits, because we make a
similar call to mark-parents-uninteresting but the function does not
care if the commit itself is already marked as uninteresting.

The distinction does not matter when tags are not involved.  But
once we start propagating the flags from a tag to objects that the
tag points at, it starts to matter.  The caller will mark the object
uninteresting in the loop that peels the tag, and the resulting
object is uninteresting.  It is not a problem for commits.  It was a
problem for trees, which used mark_tree_uninteresting() to mark all
the objects inside the tree uninteresting, including the tree itself.
