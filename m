From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Replace $((...)) with expr invocations.
Date: Tue, 06 Nov 2007 13:06:00 -0800
Message-ID: <7vtznzf5jb.fsf@gitster.siamese.dyndns.org>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	<20071106201809.GD6361@ins.uni-bonn.de>
	<20071106202600.GH6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 22:07:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpVd0-0001vX-33
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbXKFVGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 16:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754351AbXKFVGH
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:06:07 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52084 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbXKFVGF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 16:06:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 88DDD2F9;
	Tue,  6 Nov 2007 16:06:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A33191E3F;
	Tue,  6 Nov 2007 16:06:23 -0500 (EST)
In-Reply-To: <20071106202600.GH6361@ins.uni-bonn.de> (Ralf Wildenhues's
	message of "Tue, 6 Nov 2007 21:26:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63725>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> * Ralf Wildenhues wrote on Tue, Nov 06, 2007 at 09:18:09PM CET:
>> ---
>>  git-filter-branch.sh       |    4 ++--
>>  git-rebase--interactive.sh |    8 ++++----
>>  git-rebase.sh              |    8 ++++----
>>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> Hmm, maybe this one is overkill.  $((...)) is POSIX, I temporarily
> forgot (thanks Beno=C3=AEt!).
>
> I'm unsure whether git targets non-POSIX Bourne shells like Solaris
> /bin/sh.  That would however mean replacing stuff like $(cmd) with
> `cmd` as well, and from grepping the source it looks like you'd rathe=
r
> avoid that.

=46or git, two rough rules are:

 - Most importantly, we never say "It's in POSIX; we'll happily
   screw your system that does not conform."  We live in the
   real world.

 - However, we often say "Let's stay away from that construct,
   it's not even in POSIX".

=46or shell scripts specifically (not exhaustive):

 - We prefer $( ... ) for command substitution; unlike ``, it
   properly nests.  It should have been the way Bourne spelled
   it from day one, but unfortunately isn't.

 - We use ${parameter-word} and its [-=3D?+] siblings, and their
   colon'ed "unset or null" form.

 - We use ${parameter#word} and its [#%] siblings, and their
   doubled "longest matching" form.

 - We use Arithmetic Expansion $(( ... )).

 - No "Substring Expansion" ${parameter:offset:length}.

 - No shell arrays.

 - No strlen ${#parameter}.

 - No regexp ${parameter/pattern/string}.

 - We do not use Process Substitution <(list) or >(list).

 - We prefer "test" over "[ ... ]".

 - We do not write noiseword "function" in front of shell
   functions.
