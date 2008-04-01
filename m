From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] add pre-auto-gc hook for git-gc --auto (try2)
Date: Tue, 01 Apr 2008 16:18:01 -0700
Message-ID: <7vhceldv12.fsf@gitster.siamese.dyndns.org>
References: <cover.1207049697.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 01:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgpkp-0002rF-4k
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 01:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbYDAXSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 19:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391AbYDAXSQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 19:18:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbYDAXSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 19:18:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E24E720A1;
	Tue,  1 Apr 2008 19:18:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C29082077; Tue,  1 Apr 2008 19:18:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78669>

Miklos Vajna <vmiklos@frugalware.org> writes:

> - removed unnecessary stdout_to_stderr from builtin-gc.c::run_hook()

Wait, a, minute, please.  Not so fast.  I did not say "I think this is
wrong, please fix it".

I only asked why it is so.

Care to explain why it was thought to be necessary, and why you now think
it is unnecessary?

This comment is not just for you, but when I ask why it is so, I expect
that the contributor would do the homework and present an argument to
defend what was submit (or "it was wrong for such and such reasons so
let's do it differently like this because this is better for such and such
reasons").  The original contributor has thought about the issues much
longer and deeper than I, who only just look at the email and kibitz,
after the contribution was perfected into a patch form.  There must have
been a lot more thinking than what can be seen in the submitted material
in the contributor's head.  I want to see that in the open.  Please do not
change your mind and retract your change without explaining why.

The argument to respond to such "why is it so?" question would perhaps
look like this for this case.

(begin example #1)

Well, I just cut and pasted from existing code.  Because all these hooks
redirect their stdout to stderr, I think it is consistent to do so with
the new hook.

(example #1 ends here)

(begin example #2)

"git grep -n -e stdout_to_stderr" followed by "git blame" reveals the
following pattern:

 - builtin-checkout.c:41
   782c2d6 (Build in checkout, 2008-02-07)

 - builtin-commit:382
   f5bbc32 (Port git commit to C., 2007-11-08)

 - help.c:62
   6494998 (help: add "man.viewer" config var to use "woman" or "konqueror", 2008-03-07)

 - receive-pack.c:120,157
   f43cd49 (Change {pre,post}-receive hooks to use stdin, 2007-03-10)
   1d9e8b5 (Split back out update_hook handling in receive-pack, 2007-03-10)

 - transport.c:165,218,297
   cd547b4 (fetch/push: readd rsync support, 2007-10-01)

I think all of these are the result of cut&paste from the original one in
receive-pack.c's hook handling.

The ones in the protocol handler may not write to the standard output,
because the other end does not expect random diagnostic string in the
protocol message at the point these hooks are called.  But the other ones
could go either way.

However, because existing hooks all show their script output to stderr, it
would make sense for this new pre-auto-gc hook to do so as well from the
consistency viewpoint.  So use of stdout_to_stderr is the right thing to
do here.

(example #2 ends here)
