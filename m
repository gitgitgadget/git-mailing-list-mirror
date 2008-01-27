From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Sun, 27 Jan 2008 14:56:46 -0800
Message-ID: <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org>
References: <20080127103934.GA2735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:57:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJGRM-0001RZ-D5
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 23:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbYA0W46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 17:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbYA0W45
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 17:56:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbYA0W45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 17:56:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A299E41D3;
	Sun, 27 Jan 2008 17:56:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B64D41D0;
	Sun, 27 Jan 2008 17:56:52 -0500 (EST)
In-Reply-To: <20080127103934.GA2735@spearce.org> (Shawn O. Pearce's message of
	"Sun, 27 Jan 2008 05:39:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71837>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This isn't anywhere near ready for application, but I'm floating
> it out there to see what people think.  Its a cool new feature that
> will certainly *not* be in 1.5.4.  :-)
>
> In a central repository configuration users may not have access
> to write new objects into a Git repository, or to edit the refs,
> especially if the repository is being protected by an update hook
> (e.g. contrib/hooks/updated-paranoid).

Sorry, but I am puzzled about what this assumption is trying to
achieve here.

If the configuration is based on central repository model,
wouldn't the users who are participating in the project have
write access to the repository by being in the project's group
and the repository initialized with core.sharedrepository=true?

> This change allows any repository owner to setup a git-daemon
> that other users on the same host can connect through to perform
> upload-pack or receive-pack.

My reading of this is that it creates a backdoor for people who
cannot (either "are not allowed to", or "cannot be bothered to")
create and maintain project specific access control by the
traditional means of filesystem access control based on user
groups, by allowing others to run controlled stuff under the
repository owner's uid.  In addition to having to worry about
the in-repo data properly being protected from people outside
the group, you now need to worry about the access through that
backdoor does not extend outside of the repository.  E.g. the
repository owner's $HOME that is outside the repository would be
writable that owner, but is not meant to be accessible by
project participants.  If you allow others to "run as" you, the
only thing that forbids that process running as you from
accessing $HOME is an additional audit of git-daemon and the
programs it spawns.

In short, my initial reaction to this is not very supportive,
not because of the way it is coded but because of its security
design.

But I may probably have misread the intention.
