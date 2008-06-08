From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Use SUDO_UID to guess committer identity
Date: Sat, 07 Jun 2008 17:57:28 -0700
Message-ID: <7vprqsn3pj.fsf@gitster.siamese.dyndns.org>
References: <20080607071130.GZ12896@spearce.org>
 <7v63slnegm.fsf@gitster.siamese.dyndns.org>
 <20080608002343.GG12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 02:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59F0-0002kT-Rb
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 02:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbYFHA5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 20:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbYFHA5q
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 20:57:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbYFHA5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 20:57:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 587A81918;
	Sat,  7 Jun 2008 20:57:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7FB7A1917; Sat,  7 Jun 2008 20:57:39 -0400 (EDT)
In-Reply-To: <20080608002343.GG12896@spearce.org> (Shawn O. Pearce's message
 of "Sat, 7 Jun 2008 20:23:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6206A26-34F5-11DD-92B5-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84240>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > When invoking Git commands though sudo against a bare repository
>> > with reflogs enabled we should attempt to record the actual user's
>> > information in the reflog, not the identity of the user sudo entered.
>> >
>> > For example when executing:
>> >
>> > 	sudo -u gitadm git --git-dir=/srv/git.git branch -f pu master
>> >
>> > We want record information about the caller of sudo, not gitadm.
> ...
> The issue is when users run commands though sudo, but forget to set a
> value for GIT_COMMITTER_NAME/EMAIL, or to configure ~/.gitconfig in
> their personal account.

In your scenario, is the above "sudo -u gitadm" the exact command line
the end users type, or is it wrapped in the script you give to them?

> Eh, I'm myself not entirely happy with the patch.  It honors the
> real user's $HOME/.gitconfig user.name/email settings and not the
> SUDO_UID data.  I'd almost prefer favoring SUDO_UID over whatever
> we inherit in from the enviroment or from $HOME/.gitconfig when it
> comes to committer identity.

The thing is, I personally hate pseudo and wish that your solution did not
rely on SUDO_UID which is too specific to that hack.

Sometimes people need to lie to their SCM when doing things in behalf of
somebody else, and I agree we would want to give them a way to do so.  And
we do, just like RCS and CVS honor LOGNAME.

If you have /etc/hosts under RCS control but you do not want all the log
entries to say 'root', and you would do:

	$ cd /etc
	$ su
	root# edit /etc/hosts
	root# LOGNAME=me ci -u -m 'Add host bar' hosts

When omebody asks you to help him fixing his bug, you go to his keyboard,
show him how it should be done, and you concude the session with:

	his shell$ LOGNAME=me ci -u -m 'Fix foo' foo.c

The point is that the same mechanism works (because it is designed to) in
both cases.
