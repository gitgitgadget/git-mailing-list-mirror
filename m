From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 23:32:54 -0800
Message-ID: <7vmycqeqqh.fsf@gitster.siamese.dyndns.org>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
 <20090212084811.GA14261@piper.oerlikon.madduck.net>
 <20090212092558.GB21074@skywalker>
 <20090212125621.GB5397@sigill.intra.peff.net>
 <7veiy3l689.fsf@gitster.siamese.dyndns.org>
 <20090212214106.GC26573@piper.oerlikon.madduck.net>
 <7vocx7i6xh.fsf@gitster.siamese.dyndns.org>
 <20090213062818.GB16434@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org,
	pasky@suse.cz
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXsbb-0006jg-5z
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 08:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbZBMHdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 02:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZBMHdJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 02:33:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbZBMHdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 02:33:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3AA6E98D0F;
	Fri, 13 Feb 2009 02:33:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8057A98D0E; Fri,
 13 Feb 2009 02:32:56 -0500 (EST)
In-Reply-To: <20090213062818.GB16434@piper.oerlikon.madduck.net> (martin f.
 krafft's message of "Fri, 13 Feb 2009 07:28:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D541C7E-F9A0-11DD-ADCE-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109718>

martin f krafft <madduck@debian.org> writes:

> also sprach Junio C Hamano <gitster@pobox.com> [2009.02.13.0014 +0100]:
>> > TopGit would need to make a proper branch, merge the bases into
>> > it, merge that branch into the topic branch, and the probably
>> > delete the branch pointer, as it's no longer needed and would
>> > only pollute the refs/heads/* namespace.
>> 
>> So it happens purely inside TopGit and the end user never sees
>> a state that HEAD points outside refs/heads/, right?
>
> Yes.

Now I am confused by your answers.  This "Yes" means that setting HEAD
outside refs/heads/ happens purely as an intermediate state to avoid
setting HEAD to some branch ref.  After the operation finishes correctly,
HEAD will never be left outside refs/heads/.  But this contradicts
directly with what you say next.

>> Why can't the base flipping operation you descibed be done on
>> detached HEAD?  Perhaps with a shell variable or two that hold
>> commit object names you need to keep track of while it is doing is
>> work?
>
> I am not sure I understand. Isn't that what's currently happening?

If you *are* setting HEAD to some ref that is outside refs/heads (or even
inside refs/heads for that matter), at that point the HEAD is *not*
detached, so no, it obviously is *not* what is happening.

I am asking why you need to use a ref to do that, *if* it is a tentative
state while the program is running.  You are probably calling a git
plumbing or Porcelain command that updates HEAD, and the reason why you
point HEAD outside refs/heads/ is beause you would want the command you
call to update one of the refs/top-bases/ ref through HEAD.  I am asking
why you are not running these commands on a normal detached HEAD, and then
use update-ref (not symbolic-ref) plumbing to update the refs/top-bases/
ref you would want to update when it is done.

>> You did not actually answer a larger question.
>
> It wasn't asked to me before... ;)

Go back to the original message and read it again.

> Up until now, however,
>
>   git checkout -q "refs/top-bases/$name"
>
> was not really something undocmented or restricted.

Giving checkout anything that is not "a branch name" meant detaching HEAD
ever since detached HEAD was introduced, and that is a documented feature.
git checkout "refs/heads/master" would behave the same way --- it won't
check out the 'master' branch.

> I can still call e.g. git update-ref (as opposed to e.g. git
> _update-ref)  and potentially turn my repository upside down
> exemplifies this.

The distinction between Porcelain and plumbing is unfortunately not very
clear at places.  The change we reverted was probably a bad one.  The
stricter check was not done at the Porcelain level but was done at the
plumbing level.
