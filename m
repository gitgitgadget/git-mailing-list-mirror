From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge, .gitignore, and silently overwriting untracked files
Date: Tue, 17 Aug 2010 12:33:25 -0700
Message-ID: <7viq39avay.fsf@alter.siamese.dyndns.org>
References: <4C6A1C5B.4030304@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 21:33:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlRum-0004uq-IG
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 21:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936Ab0HQTde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 15:33:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab0HQTdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 15:33:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07756CE754;
	Tue, 17 Aug 2010 15:33:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t+V0IJc0r6rtl/dHwU31sWHl7uM=; b=Ggw2GD
	Oi4EO0YcXgkojyb4ZIkS8lIrlljquho0U0VVJjfR2uiEjGTLTio9Se855qicy+SZ
	K/r80V96d0gq8dkLJDimXXo2yBo+RpKh5wUi+TcPJcc93SLLh07dxDCMgEybBMUI
	Tm5b2fPYU4ZFYgtVeWmx851FBid6DCfy1VdOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QuwmuIgURo2P/Cl0qH3+kLKDLzVLOSdW
	l4us662QHAzxdmR0cYHO9sduej3f9tiI5W+djkgxDqC7gBOB4+wyqox3m6/ebFGN
	BSYkk0pB4C5px3fFI5jgCE6tT273cjdU9lraJ+DXYoOdMb+PDNKnVCRjdCf95nhp
	SotESCXOAec=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D480CCE752;
	Tue, 17 Aug 2010 15:33:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36758CE751; Tue, 17 Aug
 2010 15:33:27 -0400 (EDT)
In-Reply-To: <4C6A1C5B.4030304@workspacewhiz.com> (Joshua Jensen's message of
 "Mon\, 16 Aug 2010 23\:21\:31 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50692C58-AA36-11DF-8402-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153775>

There are only two kinds of untracked paths in git.  Ones that git is
allowed to remove in order to carry out operations asked by the end user,
i.e. ones that are trashable, are registered to the gitignore mechanism,
and the ones that are precious are not in gitignore; the latter can
interfere with git and prevent it from carrying out certain operations.
E.g. an untracked and unignored file F will prevent you from switching to
a branch that has file F tracked, or that has file F/G (iow, F is a
directory in that branch) tracked.

Ancient git didn't honor gitignore and considered no files trashable,
which caused a lot of trouble to users.  It may be illuminating to check
discussions in the list archive during the period the following commits
were made.  f8a9d42 (read-tree: further loosen "working file will be lost"
check., 2006-12-04), ed93b44 (merge: loosen overcautious "working file
will be lost" check., 2006-10-08), c819353 (Fix switching to a branch with
D/F when current branch has file D., 2007-03-15).

We could enhance the mechanism to categorize untracked paths into three
instead of two: trashable, unknown and precious.
