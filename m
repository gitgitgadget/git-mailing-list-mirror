From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] remerge diff proof of concept/RFC
Date: Tue, 04 Feb 2014 15:04:35 -0800
Message-ID: <xmqq1tzi7a4c.fsf@gitster.dls.corp.google.com>
References: <cover.1391549294.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Feb 05 00:05:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAp3O-0006lQ-4X
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 00:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934222AbaBDXFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 18:05:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964778AbaBDXEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 18:04:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F9A67E6C;
	Tue,  4 Feb 2014 18:04:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MhGGer/LPGCJT4yry40R+AqGoho=; b=LtoQ2C
	4zIxWGuLwZr/18b5f8D4nKINX53LBnkDrzRrmZtyK8QvimSTFTCZJsh5Bhw3ffc6
	ABH/JgALvcyBxljLVz56OWh22ubBegqd6a2wYMMC+sJoEIDnC1osMeizblOWJj0J
	e7xfhCIq85A9CQZnSPWKBvtrABiYF2ZRJO7nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nTihiQfpIZZO7MyCbORHuH/iDBMUAnO5
	lfN8zBaqYY3WxTz6IhBORk4szrY/7paxeyhdU2SaQ0i++ia7JaNaJfGG89Kb+uyA
	txvIvf/tzTrHzoos5SeuF22jhW1psEqk9I6QGC5rifzE18OeCAwbAc6F4ywELM2R
	TTH8udicJm0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B35D367E6A;
	Tue,  4 Feb 2014 18:04:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C388A67E68;
	Tue,  4 Feb 2014 18:04:37 -0500 (EST)
In-Reply-To: <cover.1391549294.git.tr@thomasrast.ch> (Thomas Rast's message of
	"Tue, 4 Feb 2014 23:17:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B87CE414-8DF0-11E3-B002-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241585>

Thomas Rast <tr@thomasrast.ch> writes:

>   log --remerge-diff: show what the conflict resolution changed

Yay ;-)

> This series explores another angle, which I call "remerge diff".  It
> works by re-doing the merge in core, using features from patches 1-3
> and 7.  Likely that will result in conflicts, which are formatted in
> the usual <<<<<<< way.  Then it diffs this "remerge" against the
> merge's tree that is recorded in history.

Yup, that is the obvious way to recreate what would have been shown
to the person who recorded the merge result.  I like that approach.

> So I would welcome comments, and/or better ideas, on the following
> proposed resolution:
>
> * Implement what I described last, to take care of delete/modify
>   conflicts.

Naively, I would have thought that

 - If the recorded result of the merge does not have the path, then
   show the deletion of the contents relative to the side that
   modified it.

 - If the recorded result of the merge has the path, then show the
   change between the side that modified it and the recorded result.

might be more useful.  Then we will know what we lost in full (if
the recorded result is to "delete" it), but it is very likely that
we won't see anything if the recorded result blindly took what the
modifying side left.  Comparing with the synthetic stages 2+3 will
at least show us there was something funky going on, so your
approach would be reasonable in this case.

> * Punt on more complex conflicts, by removing those files from the
>   index, and emitting a warning about those files instead.

Sensible.
