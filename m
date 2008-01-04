From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wherefore art thou, git-applymbox? - Adding non-self signoffs
Date: Thu, 03 Jan 2008 19:32:17 -0800
Message-ID: <7vr6gymfjy.fsf@gitster.siamese.dyndns.org>
References: <20080104015028.GC3989@mail.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 04:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAdIn-0005mx-G7
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 04:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbYADDcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 22:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbYADDca
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 22:32:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbYADDca (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 22:32:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 31AD34F79;
	Thu,  3 Jan 2008 22:32:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 87CD14F77;
	Thu,  3 Jan 2008 22:32:24 -0500 (EST)
In-Reply-To: <20080104015028.GC3989@mail.oracle.com> (Joel Becker's message of
	"Thu, 3 Jan 2008 17:50:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69547>

Joel Becker <Joel.Becker@oracle.com> writes:

> We used to do this very easily with git-applymbox:
> (from http://oss.oracle.com/osswiki/GitRepositories/ForMaintainers)
>
> $ echo "Julie Hacker <julieh@my.site.com>" > /tmp/signoff
> $ git branch to-push master
> $ git checkout to-push
> $ git format-patch -C -k --stdout master..workingbranch > /tmp/changes-to-push
> $ git applymbox -k /tmp/changes-to-push /tmp/signoff
> $ git push ssh://my.server.com/path/project.git to-push:master
>
> 	The <signoff> file argument to applymbox allowed us to add the
> approvers signoff to an entire series in one go.  git-am does not have
> this feature.  As far as I can tell, I have to edit each patch by hand
> to add the new signoff.  Is there a better way?

Heh, applymbox's removal is an ancient news.  May 20 2007?

My reading of an old copy of git-applypatch seems to suggest
that the above example you quoted is probably wrong anyway;
shouldn't the first one be like this instead?

 $ echo "Signed-off-by: Julie Hacker <julieh@my.site.com>" >/tmp/signoff

It was actually a bug that applymbox allowed only a single
e-mail address to be added without doing any sanity checking of
the address with the author nor committer information.

If it were designed to allow adding sign-offs from other people,
the command would have allowed more than one lines in the file.
It did not.  It was not designed for that purpose.

It was designed to allow one's own sign-off; it should have
verified that it matched the committer identity.  It did not.
That was not strictly a bug for people who used the mechanism to
sign their own patches anyway, but not checking meant a misuse
like yours went unnoticed.  Not quite ideal.

I guess you can run filter-branch to munge the commit messages
after you run the

	git format-patch ... | git am

pipeline to build the to-push branch.

I do not mind a patch to enhance "git am", but not before 1.5.4.
Most likely the change would take a form of an extra parameter
that names a script (or command) that gets the commit log
message as its argument and edits it in any way it wants (in
your case you would add the S-o-b: lines in that script).
