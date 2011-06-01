From: Junio C Hamano <gitster@pobox.com>
Subject: Re: speed of git reset -- file
Date: Wed, 01 Jun 2011 13:51:43 -0700
Message-ID: <7vvcwpff6o.fsf@alter.siamese.dyndns.org>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
 <20110601195831.GA30070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRsOU-00047k-SP
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 22:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759830Ab1FAUvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 16:51:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759797Ab1FAUvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 16:51:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12F2C59AE;
	Wed,  1 Jun 2011 16:54:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZjZ81KhC/QAkGxWZnnoYKW+Fy48=; b=KVL3cx
	dDUhANULGyXOPbzFeS2qzbcqlWmaRx0FcQkahYIj6X2M23cu3f1z5vgBR4OZK6Yd
	F8hOWGBpIbewHSOihwuyoHL6bwguVn592jyex5IvwUrpuELESVVVEIKVI+7uCSQr
	EqWQNalh9g8tSRqDowabZJnLikjy3/iwK+fno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t4XQIKpT5YjzTlopA3KmnWNK1IB+DrmD
	Dh22q7hzTRZAYfV3iZc4daMyvJ0HcJ5SimRagbGboWNM+ZHJpDKaJ+wgk0jQqYzq
	qJn07TETZrF73iO07KochkDXXP2NLQPx4vy2It930c3QZXxZti442Zo3HXigGiqX
	hso2z81R0xM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CFB2F59AA;
	Wed,  1 Jun 2011 16:53:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B04FE59A9; Wed,  1 Jun 2011
 16:53:53 -0400 (EDT)
In-Reply-To: <20110601195831.GA30070@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 1 Jun 2011 15:58:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 450DBEDA-8C91-11E0-9161-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174901>

Jeff King <peff@peff.net> writes:

> So implementing the "optimization" to drop the refresh here doesn't seem
> worth it. It inroduces an awful inconsistency, and it probably isn't
> saving much in practice...

You could make it less inconsistent by introducing core.autorefreshindex
for people who _do_ care about the latency. We already have a precedent in
diff.autorefreshindex and the new configuration would supercede it.

Usually we refresh the cached lstat information in the index at strategic
places so that later operations do not have to pay the penalty, but at the
same time, the higher level commands that want to make sure they are not
fooled by stale lstat differences do refresh the index themselves anyway,
so leaving cached stat information stale is not exactly the end of the
world.

All the high-level commands like "reset" that do _not_ absolutely need to
refresh the index for them to work, but do refresh the index to help later
invocation of other commands, could be taught to pay attention to the
core.autorefreshindex. After many operations the users usually do not see
changes from diff-files, people who set this to false will see phantom
changes due to stale cached lstat information, and they will see them
consistently. They know exactly when having up-to-date lstat information
in the index really matters, and they will run "update-index --refresh"
themselves when needed.

I however personally doubt it would be worth the effort. The _only_ person
who complained about this doesn't even use "update-index --refresh" but
uses "git status", which does more than refreshing the index, and seems to
think the extra latency coming from the overhead is acceptable.

So...
