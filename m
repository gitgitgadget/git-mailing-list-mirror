From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rev-parse incorrectly uses --default parameter when invalid revision is supplied
Date: Mon, 07 Jan 2008 16:21:11 -0800
Message-ID: <7vmyrhxj48.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071653460.31161@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 08 01:22:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC2EJ-0002Rj-MN
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 01:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbYAHAVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 19:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbYAHAVe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 19:21:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbYAHAVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 19:21:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C0BECF2C;
	Mon,  7 Jan 2008 19:21:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 000D5CF2B;
	Mon,  7 Jan 2008 19:21:27 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0801071653460.31161@torch.nrlssc.navy.mil>
	(Brandon Casey's message of "Mon, 7 Jan 2008 17:38:42 -0600 (CST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69829>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> When rev-parse is called with an invalid revision parameter and
> --default has been used to set a default revision, the output
> will be based on the parameter to --default.
>
> For example:
>
>  This likely fails:
>    $ git rev-parse --verify foobar
>    fatal: Needed a single revision
>
>  This likely succeeds but probably should fail:
>    $ git rev-parse --verify --default refs/heads/master foobar
>    b2e62a7dc6ba20a354d7590bf6a1d9264de7efe3
>
>
> The documentation for rev-parse says:
>   --default <arg>::
>         If there is no parameter given by the user, use `<arg>`
>         instead.
>
>
> git-stash uses this command, so a typo could cause the wrong stash
> to be applied.
>
>   git stash apply stsh@{1}
>
> If stash@{0} exists, it will be applied which is definitely not
> what the user would want.
>
> It is not straight forward to me how to modify builtin-rev-parse.c
> to fix this.

Two points.

 * The description for --default you quoted says "no parameter",
   but it should read "no non-flag rev parameter".

 * --verify needs to be whole lot more special cased in the
   codepath;

Currently, --verify just runs the command as if it was not
specified at all, but dies (1) as soon as it sees a second
non-flag rev arg (worse --- it dies *after* emitting it!), or
(2) at the end if it notices it did not emit any.  It does not
even barf if you say "git rev-parse --verify ^HEAD", which I
think is a misdesign.
