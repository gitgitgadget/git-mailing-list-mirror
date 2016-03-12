From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: add `--shallow-submodules` flag
Date: Sat, 12 Mar 2016 11:29:50 -0800
Message-ID: <xmqq60wra40h.fsf@gitster.mtv.corp.google.com>
References: <1457739683-1972-1-git-send-email-sbeller@google.com>
	<xmqqa8m4a5nx.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYc1WR9CTBi1F3KpLaYRUSxNPQkQ2jk+P09pshR3jG8aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 20:30:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aepEx-0001We-9R
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 20:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbcCLT34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 14:29:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750782AbcCLT3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 14:29:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0A42489E2;
	Sat, 12 Mar 2016 14:29:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H0IKb+IoG8uHMmgrVrL2gNaocMc=; b=X5Q0W5
	tnWxSJG3bC2sOgm35eEnfk+xYtM3cnXoM5ISNUSIti2VGXLmUaDCSLm/AeucLD/h
	2Q3qP3O8HHAMVklFqMnc0Xqj/IoxJdeAG5YElvHaUnl6AKUadNeqys+5qqTEqRd7
	qKEiHdstQxVLxHPlF5PJCjs/wCMA3Rehi4d24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lPh6wjgYhbcCXQfu3da7364TfL8uAE2L
	TfRZlzQkadsvWwm3U5R/RJ1aCkKvwJYZjWpA98Hn8yTd4cpmAsVnHQ3QrZAwimf5
	DnJ14wzSVYSaWEAdnjji81gO3Ky8Vkt4u/EA0Pqh35PK4KUQA/NRvU4STy1vFKhN
	cwMJxrgLj/c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8390489E1;
	Sat, 12 Mar 2016 14:29:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 52462489DF;
	Sat, 12 Mar 2016 14:29:52 -0500 (EST)
In-Reply-To: <CAGZ79kYc1WR9CTBi1F3KpLaYRUSxNPQkQ2jk+P09pshR3jG8aw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 11 Mar 2016 16:56:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAFE77D4-E888-11E5-8090-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288750>

Stefan Beller <sbeller@google.com> writes:

> Why is it interesting for submodules but not for standard repositories?
>
> If I clone a repository without submodules, it is also not recorded
> that I cloned with an explicit depth=1. If you fetch, you may end up with
> a deeper history as git fetch doesn't do a "reshallow" to the configured
> depth.

Very simple.

If you do not have submodule, you would always interact with the
other side directly with "git fetch" or "git pull" and have total
control over when you choose to pass or not to pass extra options to
choose to 1. incrementally extend, 2. deepen, or 3. unshallow.  The
user will always explicitly tell you, and knowing how you got there
would not help you, as there is no need to guess for you.

The user can do the same explicit "cd dir && git fetch" update in
each submodule directory and give appropriate options to choose
among the three, but I have an impression that your recent work is
going in the direction of making commands that are run in the
superproject recurse into submodules that automatically fetches and
updates the history down there, discouraging users from working on
individual submodules.  You lose the flexibility to explicitly
choose among the three for individual submodules, and you may want
to have some smart in your "run from the superproject and recurse"
tools.

A submodule that was initially cloned with depth=1, perhaps because
the user didn't know if the module was interesting to her in the
context of working on the superproject before she had her clone of
the superproject hence she only wanted to see what's there, and a
submodule that was not even fetched initially when the superproject
was cloned and later was "submodule init"ed and fetched with
depth=1, would have the same shallow boundary, but the intent of the
user would clearly be different in the larger picture.  I imagined
that your "run in top-level and recurse to fetch in submodules"
tools would benefit if it has more information to intuit what the
end user meant.
