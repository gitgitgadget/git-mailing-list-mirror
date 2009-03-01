From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Add init-serve, the remote side of "git init
 --remote=host:path"
Date: Sat, 28 Feb 2009 21:54:56 -0800
Message-ID: <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
 <1235865822-14625-2-git-send-email-gitster@pobox.com>
 <1235865822-14625-3-git-send-email-gitster@pobox.com>
 <20090301031609.GA30384@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 06:58:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdegZ-00022M-Qo
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 06:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbZCAFzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 00:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbZCAFzG
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 00:55:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbZCAFzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 00:55:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BB832503;
	Sun,  1 Mar 2009 00:55:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5CD5C2501; Sun, 
 1 Mar 2009 00:54:58 -0500 (EST)
In-Reply-To: <20090301031609.GA30384@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 28 Feb 2009 22:16:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 80C5C7AA-0625-11DE-ABDA-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111817>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 28, 2009 at 04:03:41PM -0800, Junio C Hamano wrote:
>
>> +/*
>> + * Notice any command line argument that we may not want to invoke
>> + * "git init" with when we are doing this remotely, and reject the
>> + * request.
>> + */
>> +static int forbidden_arg(const char *arg)
>> +{
>> +	if (!prefixcmp(arg, "--shared=") ||
>> +	    !strcmp(arg, "--shared") ||
>> +	    !strcmp(arg, "--bare"))
>> +		return 0;
>> +	return 1;
>> +}
>
> I started this mail to complain that this function was "disallow known
> bad" instead of "allow known good". But then after reading it carefully
> three times, I see that it is in fact "not allow known good". Can we
> make it "allowed_arg" to prevent double negation?

I originally had "arg_ok()", but the implementation checked that the
argument is not --template, which is the only known to be bad one at the
moment, so that we would allow things by default.  Later I switched both
name and the implementation ;-)

I think renaming it to affirmative form (and swapping the return value, of
course) would be a good idea.

One issue I did not describe in the message was to what extent we would
want to allow operations other than the creating of a new repository
itself.

"Other than the creation" includes things like these:

 - "chgrp project-group" and "chmod g+s".

   It is typical for the system administrator to set up two classes of
   groups in /etc/groups file.  One group per user that is the primary
   group for a user, so that $HOME/ can be owned by that primary group and
   its permission bits set to 2775, and one group per project, so a user
   can belong to groups of the projects he works on.

   With the patch series:

    $ git init --remote=central.xz:/pub/projects/mine.git --shared --bare

   would take care of the "shared" (i.e. g+w) part, but the "mine.git"
   repository will either inherit the group ownership from /pub/projects
   (if /pub/projects is marked with g+s) or owned by the creating user's
   primary group, which would not be usable for use by a project the user
   belongs to.  IOW, --shared by itself is not very useful with its
   current form.

 - Writing to .git/description

   Primarily for use with gitweb; the need for this goes without saying.
   This shouldn't have security implications (even if the current
   implementation had one, it could easily be squashed).

 - Other administrative bits that have security implications:

   In a friendly environment without security concerns, e.g. company
   intranet setting, the user may want to do these things:

   - Installing custom hooks
   - Updating .git/config

   But these should never be allowed in a hosting-site setting.

My current thinking is that "init --remote" should not cater to the third
kind.  In a friendly environment the user would have a shell access, and
if the system does not give a shell access, then the user should not
allowed to muck freely with the repository.

I think the "chgrp/chmod g+s" part is necessary, and I envisioned that it
would be done by a new option to "git init", but I haven't thought things
through.  The options to "init" will not be visible to git-shell because
they are carried over pkt-line protocol as the payload, and programs like
gitosis may have hard time implementing limited access to certain groups,
even if they wanted to; I do not think gitosis would care, as it does not
rely on the UNIX group permission model for its access control, but other
implementations may care.
