From: Junio C Hamano <gitster@pobox.com>
Subject: Re: prevent push of irrelevant tags
Date: Thu, 12 Apr 2012 13:07:11 -0700
Message-ID: <7v1uns67f4.fsf@alter.siamese.dyndns.org>
References: <4F873153.9060004@rolf.leggewie.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rolf Leggewie <foss@rolf.leggewie.biz>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:07:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQIi-00061j-4l
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965959Ab2DLUHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:07:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965971Ab2DLUHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 16:07:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F270D6993;
	Thu, 12 Apr 2012 16:07:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x1pfYlRtkp9q6ViY7zivqLSKCxo=; b=KVq41S
	L+mHiZc3hmknLnxrT74hrO7tFgVtvqz1WqLyfpH66WiOPU6DJPOOtGXBppbVWEe8
	cYChs2lYM0w/NpRXaowexo1VcI327HBNDypmCavieKLcz/P+SCKoJMyPShr3c80T
	tVQvFskGDlUWuLRKsyXj6YSzaW9+s7RUNJn3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DnPyGCOARMkKh3WP09mw/SwHon45DaQN
	9Rw25K3sxHpu+MCRVSZEMewM2YF1B3jz99qnnFcrpOAtKu0ccXuNeUZ50NAa9qz6
	MbqGH/TmFAZSwvg/4el+6C89uyCqDzvEOXtGEsAe2WS3r8j00pzsjZmtpFxoCVXA
	QKmlGEwVQic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E903C6992;
	Thu, 12 Apr 2012 16:07:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8031D6991; Thu, 12 Apr 2012
 16:07:12 -0400 (EDT)
In-Reply-To: <4F873153.9060004@rolf.leggewie.biz> (Rolf Leggewie's message of
 "Fri, 13 Apr 2012 03:47:31 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17889622-84DB-11E1-9BBB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195361>

Rolf Leggewie <foss@rolf.leggewie.biz> writes:

> I just ran into the situation that "git push --tags" pushed tags to the
> remote repo that point to commits that do not exist there.  How can this
> happen?

The "--tags" option is to request to push every ref under refs/tags/
hierarchy, so the answer is "because the user asked to".

> Git has the information to know...

No, it doesn't.  

>  that tag X will be useless in repo Y
> because the commit Z it points to does not exist in Y.

Think of a case where:

 1. You have cloned from your origin.

 2. You built history on top of your 'master' branch, and pushed the
    result. The 'master' at your origin now points at this commit.

 3. Somebody working on the project cloned from the same origin, built
    some history, and pushed the result.  The 'master' at your origin is
    again updated to point at this commit (which is a descendant of the
    commit you made in #2).

 4. You tagged the tip of your 'master' as v1.0.

 5. You give the magic "--relevant-tags-only" option to your "git push".

Now what happens?

The only two things your "git push" knows are that your origin does not
have v1.0 tag, and that its 'master' branch points at the commit created
by somebody else at #3.  Most importantly, it does not have the history
leading to this commit ("push" never fetches); it does not have a way to
tell if it is a descendant of commit you created in #2.  In other words,
the magic "--relevant-tags-only" is fundamentally flawed as a concept.
