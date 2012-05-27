From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] clone --local fixes
Date: Sat, 26 May 2012 23:32:44 -0700
Message-ID: <7vsjemp20j.fsf@alter.siamese.dyndns.org>
References: <20120526034226.GA14287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 27 08:33:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYX2f-00025c-6a
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 08:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab2E0Gcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 02:32:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab2E0Gcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 02:32:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D88742EA;
	Sun, 27 May 2012 02:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G//svnVet0BpJt9DtLwsdceVp6k=; b=fphFSd
	B++9hnjql3Qlexkx6BmzdMmAO7wr4vunLHFvj2E3Qdx5HHFHXuZbZC8CzZF11OqC
	xyMThpHbodkhV3sNAejM3TeXbohkkczTCgSjdY5AUE5snm+BRCaP/753u4FPj1wS
	udi7Bm2wR1Sb9Ke0RNwUHrDrslJ+zdYiyMdbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hA9jTyEMBrVG5oXl/TXMNBYp7ZRcXjZi
	u9Srr05GG85kTQAlrzGPjqpsN5EENVCaPl8lbfMuNyueROsXDWIDgx9S+m5jHTAp
	9L6RgN7EMA2KcZUdNrKtU2jO7skDJipa+vJwWACsFRG7DmjS+qwnpzBLd+XQdIhU
	5WHxG5o00yU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 651B442E9;
	Sun, 27 May 2012 02:32:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED2A942E8; Sun, 27 May 2012
 02:32:46 -0400 (EDT)
In-Reply-To: <20120526034226.GA14287@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 25 May 2012 23:42:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5FBA016-A7C5-11E1-85E1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198578>

Jeff King <peff@peff.net> writes:

> Emeric mentioned that he was confused by the behavior of
>
>   git clone --local file:///path/to/repo
>
> in that the --local is silently ignored. Looking over the documentation,
> it is quite unclear whether it is supposed to do anything or not.

According to 23d5335 (git clone: do not issue warning while cloning
locally across filesystems, 2007-08-20) and 3d5c418 (git-clone:
aggressively optimize local clone behaviour., 2007-08-01), in the very
early days we only used the local optimization when the end user
explicitly asked for it with the '--local' option.

After 3d5c418f, the option has been made a no-op, because the local-ness
of the $repository parameter, where the definition of the local-ness is
"does 'cd $repository' succeed?", is all that is needed to trigger the
codepath.

The logic to choose the local optimization has since been "is it a path to
a local directory---if so, use the optimizaiton.  Otherwise do the usual
URL based thing".  And that is why we tell people when they want to try
cloning without local optimization to add "file://" in front of the path.

So your example "file:///" should *not* work even if --local is given,
unless you happen to have a directory called "file:" in your current
directory and it has path/to/repo subdirectory, which is a git repository.
Specifically, the repository at /path/to/repo is not what the command line
is naming.

I think we probably should stop advertising --local in the documentation
and help text.
