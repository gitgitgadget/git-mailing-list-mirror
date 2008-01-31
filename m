From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's name.
Date: Wed, 30 Jan 2008 19:06:44 -0800
Message-ID: <7vabmmg0cb.fsf@gitster.siamese.dyndns.org>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br>
	<7vwsprj0sv.fsf@gitster.siamese.dyndns.org>
	<20080131023629.GB7778@c3sl.ufpr.br>
	<7vsl0eg16c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Thu Jan 31 04:07:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKPlx-0006Mp-OI
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 04:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764801AbYAaDG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 22:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764697AbYAaDGz
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 22:06:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764447AbYAaDGx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 22:06:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A4712388A;
	Wed, 30 Jan 2008 22:06:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A7E5387D;
	Wed, 30 Jan 2008 22:06:46 -0500 (EST)
In-Reply-To: <7vsl0eg16c.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 30 Jan 2008 18:48:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72096>

Junio C Hamano <gitster@pobox.com> writes:

> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
> ...
>> Opening the extra file has same problem as the description file. And, as
>> gitweb allow us to create  "description" and "cloneurl" file there is no 
>> problem having another file to open instead finding out who is the owner of
>> the directory asking to the filesystem.
>
> We heard the same argument when cloneurl was added, and a
> newcomer who does not know that may rightly use the same
> argument.  But I think we should work towards _reducing_ the
> number of such ad-hoc one-line-per-information files, not using
> existing ones as an excuse to add _more_ of them.

Rephrasing to be constructive (but remember, this is all post
1.5.4).

 * we would need for historical reasons to keep supporting
   description and cloneurl for some time.  There may be some
   others, but the goal should be to deprecate and remove these
   ad-hoc one-file-per-piece-of-information files.

 * we also need for historical reasons to keep supporting some
   other stuff found in $git_dir/config of the project.

If the config reading interface in gitweb is reasonably fast and
cheap, we can move the existing description/cloneurl to gitweb
config when deprecating them.  New ones such as "owner" would
naturally fit there.

If the config reading interface is too slow (somebody has to
bench it on a large set of repositories), maybe we would need to
optimize _THAT_.  If it turns out to be unreasonable (e.g. we
may really want to keep the implementation that spawns "git
config" to do the work, rather than writing and having to
maintain a pure Perl version of config parser inside gitweb,
which is a reasonable position to take in the longer run, but
spawning a process per repository may be too expensive). An
alternative could be to separate out the pieces of information
that are needed even when drawing the top-level project-list
page, and come up with a _new_ single file that is easily
parsable without spawning "git config" for gitweb to read them
(e.g. "description", "owner", perhaps the toplevel project-list
might want to list "cloneurl" as well in the future).
