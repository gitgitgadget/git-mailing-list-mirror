From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 11:42:12 -0800
Message-ID: <7vtzzh5dnv.fsf@assigned-by-dhcp.cox.net>
References: <200612271300.kBRD082j007703@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 20:42:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzefJ-0008S2-F5
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 20:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbWL0TmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 14:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbWL0TmO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 14:42:14 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40638 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbWL0TmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 14:42:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227194212.KEGI16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 14:42:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3viS1W0061kojtg0000000; Wed, 27 Dec 2006 14:42:26 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200612271300.kBRD082j007703@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Wed, 27 Dec 2006 10:00:08 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35475>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Jakub Narebski <jnareb@gmail.com> wrote:
>
> [...]
>
>> Perhaps that is the idea, but that idea is not described in above
>> new feature announcement. "... to reencode the message to UTF-8 
>> when displaying, if needed." would cover it, but perhaps better
>> would be to cover this in more detail: "reencode message to UTF-8
>> if i18n.commitencoding is not set to something other than UTF-8",
>> or "reencode ... to i18n.commitencoding ... if needed".
>
> And what happens to the people who can't/won't display UTF-8? This is a
> both a project wide configuration (how does stuff get saved) + a user/local
> configuration (how to display stuff).

Presumably you would do something like:

	git log | tcs -f utf -t latin1 | less

The point being that the input to tcs will be uniformly UTF-8
even the committers used Latin-1 and UTF-8, either carelessly or
deliberately [*1*].

Maybe i18n.displayencoding set to latin1 is what you are after?
I think it might make sense...

In any case, as Jakub and others pointed out, the description
was not nice nor clear.  How about this as an update?

* I18n

 - We have always encouraged the commit message to be encoded in
   UTF-8, but the users are allowed to use legacy encoding as
   appropriate for their projects.  This will continue to be the
   case.  However, a non UTF-8 commit encoding _must_ be
   explicitly set with i18n.commitencoding in the repository
   where a commit is made; otherwise git-commit-tree will
   complain if the log message does not look like a valid UTF-8
   string.

[Side note: in v1.5.0 preview, it only warns about this
 situation; I have a feeling that it might be better to promote
 this to an error and refuse to commit until the user sets
 i18n.commitencoding to the name of the legacy encoding used for
 the project -- this will be a one-time inconvenience but will
 be much better in the long run.]

 - The value of i18n.commitencoding in the originating
   repository is recorded in the commit object on the "encoding"
   header, if it is not UTF-8.  git-log and friends notice this,
   and reencodes the message to the encoding specified with
   i18n.commitencoding when displaying, if they are different.


[Footnote]

*1* For encoding as simple as Latin I do not think it is an
issue, but we do not want to encode everything to UTF-8 at
commit time, because non-reversible conversion can lose
information.  I do not want to rule out a situation where a
particular commit log entry needs to be in an encoding different
from the project norm, which hopefully is UTF-8, because it
needs to describe something in a character that cannot be
reversibly converted to UTF-8 (maybe the project is about iconv
enhancement, the commit fixes something related to irreversible
conversion and the log message wants to give an example).
