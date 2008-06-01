From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH review] Build: make PERL_PATH = /usr/bin/env perl
Date: Sun, 01 Jun 2008 02:01:54 -0700
Message-ID: <7vej7hbkal.fsf@gitster.siamese.dyndns.org>
References: <1212258886-87484-1-git-send-email-mfwitten@mit.edu>
 <vpqabi5o992.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 01 11:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2jSx-0001Ju-Om
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 11:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbYFAJCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 05:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbYFAJCK
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 05:02:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbYFAJCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 05:02:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF05E37E9;
	Sun,  1 Jun 2008 05:02:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0617737E8; Sun,  1 Jun 2008 05:01:59 -0400 (EDT)
In-Reply-To: <vpqabi5o992.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun, 01 Jun 2008 10:22:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 67C9737A-2FB9-11DD-A052-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83440>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Note that this is indeed different from the original proposal in the
> case of a multi-user system: here, the perl installation is chosen
> once and for all by the guy who installs git, but can't be overridden
> later (e.g by a user having his own custom perl installation in his
> $HOME). I don't know which is better.

"env" is Ok to make the same scripts you have privately in your $HOME/bin/
(which is mounted across different platforms) work with perl or python or
whatever from different places, but it is very unsuitable for scripts that
are meant to be installed per machine, such as ours, for use by many
people.

If you do not have (or want to use) common programs at usual place, you
tell "make" where they are, and the resulting scripts will use the same
program for everybody.  That way, you don't have to worry about confusing
people by having scripts use different perl depending on who they are, and
by failing for some people and working for others.

You _can_ use "/usr/bin/env" for your own build and I won't stop you, but
please don't tell me to ship such ugliness in the default Makefile.  We
will not do SHELL_PATH = $(shell which sh) either, ever.

By the way, "which" is probably Ok when you know there _is_ an instance of
the program somewhere on the $PATH, but be careful if you suspect there
might not be any.  Depending on whose "which" it is, it may not exit with
non-zero status nor be silent on the standard output.  If you are shooting
for portability, don't use it in your scripts, ever.  Also "type" is not
much better either ("type -p" is a bash-ism).

Probably the closest to the most portable would be "command -v"; this is a
POSIXly kosher way and seems to be Ok with /bin/ksh and OpenBSD /bin/sh as
well, not just bash and dash.
