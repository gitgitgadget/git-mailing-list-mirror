From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/8] gitweb: Faster project search
Date: Mon, 20 Feb 2012 00:33:56 -0800
Message-ID: <7vk43hnbt7.fsf@alter.siamese.dyndns.org>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
 <1329338332-30358-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 09:34:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzOhC-0002dn-32
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 09:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab2BTIeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 03:34:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab2BTId7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 03:33:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE3B3F0E;
	Mon, 20 Feb 2012 03:33:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QZzwVrImvfqjQemmnATRjdH6IwI=; b=uyezD3XMaT2s3WGeq5/J
	pQkcb3Gew0QPYLUeQ1Oz0vcnndbsm6Dqs0rm6CQHF8aSq06wJpQdulpbqDEoJ5xj
	73ULr48VEDOFvIB4OJxYUg9jqMfY5zHFtd9mR8V++UiQmCUodPDHiU7df7FS+2JJ
	E5IyNarl1ew/O16Q3dMK0ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gYumC+08eXaH0ZmQqqD6b59RqPDPmIsIxK4ycJM7CHyLug
	vr7oKBY0EpfeEBwswVyrpBrUjEDLdxc0vYpYhQ+/nA54Y7s1c5Ef6JbQNEP/Aou7
	2VbHE8k2GVa7tYEU1H+Wl4Bc1iYDi814U68OsBD7ilgU2lrHuCBxaS4KPK1O0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E483F0D;
	Mon, 20 Feb 2012 03:33:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54E783F0B; Mon, 20 Feb 2012
 03:33:58 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1FDFA34-5B9D-11E1-AA69-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191053>

Jakub Narebski <jnareb@gmail.com> writes:

> Before searching by some field the information we search for must be
> filled in.  For this fill_project_list_info() was enhanced in previous
> commit to take additional parameters which part of projects info to

"must be filled in." is correct, but that happens without the previous
patch.  The first sentence must also say:

	In order to search by some field, the information we look for must
	be filled in, but we do not have to fill other fields that are not
	involved in the search.

to justify the previous "fill_project_list_info can be asked to return
without getting unused fields" patch.  The rest of the log message then
makes good sense.

> fill.  This way we can limit doing expensive calculations (like
> running git-for-each-ref to get 'age' / "Last changed" info) only to
> projects which we will show as search results.
>
> With this commit the number of git commands used to generate search
> results is 2*<matched projects> + 1, and depends on number of matched
> projects rather than number of all projects (all repositories).
>
> Note: this is 'git for-each-ref' to find last activity, and 'git config'
> for each project, and 'git --version' once.
