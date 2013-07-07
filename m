From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] merge-recursive: untangle double meaning of o->call_depth
Date: Sun, 07 Jul 2013 11:37:08 -0700
Message-ID: <7v1u7a43or.fsf@alter.siamese.dyndns.org>
References: <cover.1373219466.git.trast@inf.ethz.ch>
	<7e823a9faedf1980912628c3a3f083e26fb0c650.1373219466.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvtpo-0000pA-F8
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab3GGShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:37:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab3GGShL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:37:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B17F52EC5E;
	Sun,  7 Jul 2013 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k5dn6KYC7ZIKuiKxeS8Woy9LClU=; b=al9AGD
	2LlhuK/tzEvk8XYYwO5TKA12ACvpzGTbfKunCuvBD/McJ8/CeaEgob7GTqabh+VN
	srnXfbh+ag0bgPH4Ap0RhYegTlxlneKW8edLwy46B7T0XAXrsT0lx7a3cE4jmT+V
	OQmb1kdW29a3ZPxgFc+66qeL3fTzuxIW36+yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DAEGktAECY4V8L0tVyUPF8ejQr+gbrKU
	bQsk4zWjchG1ilxKB3Z+FbEQwrD5JxYtuNBLv2baJuFGCZy8583rsvrsjfmtYs1P
	ht2g/UrStbldJpTXDVWQzg4RIQVXUFawDXLKKCTRaQerIVS0lQbdBJHuyA5Q9jbI
	BL1DyYqlOzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5EEB2EC5B;
	Sun,  7 Jul 2013 18:37:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 298002EC59;
	Sun,  7 Jul 2013 18:37:10 +0000 (UTC)
In-Reply-To: <7e823a9faedf1980912628c3a3f083e26fb0c650.1373219466.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Sun, 7 Jul 2013 20:02:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BC7A6D8-E734-11E2-80E7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229797>

Thomas Rast <trast@inf.ethz.ch> writes:

> o->call_depth has a double function: a nonzero call_depth means we
> want to construct virtual merge bases, but it also means we want to
> avoid touching the worktree.  Introduce a new flag o->no_worktree for
> the latter.

I do remember discussing this with you the other day, and while I do
agree that we may not want to touch the working tree in the
outermost merge (i.e. o->call_depth is zero) in some applications, I
do not think of a situation where you _do_ want to touch working
tree while performing the inner merge.  I'd feel safer if the code
said that "no matter what no-worktree option says, we won't touch
the working tree if o->call_depth is not zero" clearly in some way,
e.g. 

	if (o->call_depth || o->in_index_merge)
        	return; /* leave without touching working tree */

In other words, I do not like the part of the code that pretends
these two are independent options, when what we really want is to
have two modes for the outermost (o->call_depth == 0) case.
