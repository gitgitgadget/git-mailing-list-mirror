From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/workdir: create logs/refs and rr-cache in the
 origin repository
Date: Sun, 18 Jan 2009 11:59:35 -0800
Message-ID: <7vskngwfko.fsf@gitster.siamese.dyndns.org>
References: <1232208943-31756-1-git-send-email-dato@net.com.org.es>
 <7vbpu54cxe.fsf@gitster.siamese.dyndns.org>
 <20090118113830.GA1394@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sun Jan 18 21:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdpT-0007bh-F6
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 21:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbZART7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 14:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbZART7n
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:59:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbZART7m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 14:59:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F04591AED;
	Sun, 18 Jan 2009 14:59:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7252591AEC; Sun,
 18 Jan 2009 14:59:38 -0500 (EST)
In-Reply-To: <20090118113830.GA1394@chistera.yi.org> (Adeodato =?utf-8?Q?S?=
 =?utf-8?Q?im=C3=B3's?= message of "Sun, 18 Jan 2009 12:38:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B2E43C6-E59A-11DD-ABAB-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106273>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> However, I've as of late directly created bare repositories knowing t=
hat
> I wanted to work just with workdirs against it. In this case, the log=
s
> for each checkout'ed branch will be stored in the workdirs and not th=
e
> repo, so deleting the workdir will make you lose those logs. Which is
> bad, since workdirs should always be safe to delete.

I had to think about the above for a while, but after realizing that yo=
u
have a strict distinction between a "workdir" and a normal "repository
with a work tree" in mind, I can see where you are coming from.  A work=
dir
is transient in nature and you should be able to dismiss it safely as l=
ong
as the repository it borrows from is intact.

But "safely" is somewhat relative.

What state would you be discarding when you remove a workdir?  I can th=
ink
of:

 - local uncommitted changes, in the work tree contents and in the inde=
x
   (obviously);

 - reflog for the HEAD (aka branch switching);

 - what branch you had checked out when you discarded the workdir;

and everything else (commits created, the tips and histories of refs,
configuration changes) are kept in the .git repository of the original.

But what if the original does _not_ want to keep track of changes of
certain nature?  It is nonsensical for the original not to want to keep
the commits nor the tips of the refs, but it is not unreasonable for a
bare repository used as a distribution point not want to keep reflogs, =
for
example.  A workdir could be defined as "a transient work tree created =
on
an existing repository, the side effects of working in which are saved =
to
the original repository (except for the ones listed above).  The kind o=
f
side effects saved are however limited to the ones that are saved while
working in the original repository."

With such a definition, you can "safely" create a workdir out of a bare
repository, without fear of contaminating it with unwanted reflogs.

I tend to think the definition your patch seems to use would be more
useful in practice, though.

    A workdir is a new work area that is not a normal "work tree with a
    full repository", but borrows from an existing repository.  Any sid=
e
    effect from the work you do in a workdir will be saved in the origi=
nal
    repository, and removing one would lose only the three kind of
    information listed above.  Creating a new workdir has the side effe=
ct
    of enabling reflogs and rerere in the original repository.

But the last sentence somehow feels dirty.
