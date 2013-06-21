From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff returns fatal error with core.safecrlf is set to true.
Date: Fri, 21 Jun 2013 08:44:15 -0700
Message-ID: <7vobazo4ds.fsf@alter.siamese.dyndns.org>
References: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 17:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq3Vf-0004S3-4d
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 17:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161492Ab3FUPoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 11:44:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161367Ab3FUPoS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 11:44:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 623B329128;
	Fri, 21 Jun 2013 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kVkad38prepwMytzlEuXeugMb8I=; b=wFAgjF
	7BPUzFwbK9icGevJRFuNXyDMjIaH9+JspTUNOPLepWlK92aEZNJEs+rfyxsmGh5e
	YVFHMdcrgy/YQWIbMl26fsOXhyNyf76w7Fxg3AKPsPV/nX0rXbTaF/ZX17MEwKwB
	ehXHMFcaeno/kAGDt6+y4DwbQaHmMj//3a+RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tJ3Eik+EnYoazKO8CT8/Cnb72y/UkmEU
	AEdBfN2JVVhrX07Z3bLFnUCbNJsqrH/kErx3lySJ6vBbWgczkKSRGcmfRP4BtcG8
	i6e6tSKwPdZAhE1d+n08J+p42dA+w6gdv3Voi5xD7QJDOis8Lh+t4GfgQ7Z5E+Fu
	QjqfElXA6rc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5934A29127;
	Fri, 21 Jun 2013 15:44:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C72EF29124;
	Fri, 21 Jun 2013 15:44:16 +0000 (UTC)
In-Reply-To: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org> (Yann Droneaud's
	message of "Fri, 21 Jun 2013 15:26:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E2B48D0-DA89-11E2-8258-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228620>

Yann Droneaud <ydroneaud@opteya.com> writes:

> While testing the behavor of Git regarding CRLF handling,
> when core.safecrlf is set to true, I've found that "git diff" is
> returning
> "fatal: CRLF would be replaced by LF" without returning any kind of
> diff.
>
> This make me wonder if its the correct behavor for git diff to (only)
> fail:
> It should be fatal for git add / git commit ( / git cherry-pick /
> ... ?),
> but non fatal for git diff.

Yeah, I agree.

This is a diff between something and the working tree file, right?
It needs to convert from the working tree representation to the
canonical repository representation before doing the actual
comparison, and most likely the same helper function that is reused
for the check-in codepath, which needs to error out, is erroring out
after finding an input in your working tree that cannot safely
round-trip between LF/CRLF world.

The helper may want to learn a way to be told to demote that error
to a warning.
