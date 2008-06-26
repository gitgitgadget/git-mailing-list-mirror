From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 22:16:37 -0700
Message-ID: <7vprq4u66i.fsf@gitster.siamese.dyndns.org>
References: <48620C1A.6000509@panasas.com>
 <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net>
 <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu>
 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080625195003.GB15077@mit.edu>
 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
 <20080625203822.GA7827@mit.edu> <7v8wwtz1c1.fsf@gitster.siamese.dyndns.org>
 <20080625210535.GA8610@mit.edu> <7vod5pxknh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 26 07:18:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBjsE-0006Em-UG
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 07:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbYFZFQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 01:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbYFZFQx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 01:16:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbYFZFQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 01:16:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8C9AE417;
	Thu, 26 Jun 2008 01:16:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 697A5E412; Thu, 26 Jun 2008 01:16:40 -0400 (EDT)
In-Reply-To: <7vod5pxknh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 25 Jun 2008 14:35:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15C33540-433F-11DD-B184-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86392>

Junio C Hamano <gitster@pobox.com> writes:

> Theodore Tso <tytso@mit.edu> writes:
>
>> On Wed, Jun 25, 2008 at 01:50:06PM -0700, Junio C Hamano wrote:
>>> I just replied to Avery about that.  -- is always the way to disambiguate
>>> between refs (that come before --) and paths (that come after --), not
>>> limited to "git checkout" but with other commands such as "git log", "git
>>> diff", etc.
>>
>> Stupid quesiton --- where is this documented?  I don't see this
>> documented either in the man page for git or git-checkout.
>
> You are asking a wrong person.  My git knowledge mostly comes from
> yearlong reading of the mailing list articles, and doing a bit myself also
> helps ;-).

I couldn't find a good central place to place this as this is more or less
used consistently throughout the UI (log, diff, grep, and then I just
fixed reset as well).

Whereever the description should end up to be in, here is what I think we
should talk about.


 Documentation/gitcli.txt |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 8fb5d88..2316049 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -13,8 +13,37 @@ gitcli
 DESCRIPTION
 -----------
 
-This manual describes best practice in how to use git CLI.  Here are
-the rules that you should follow when you are scripting git:
+This manual describes the convention used throughout git CLI.
+
+Many commands take revisions (most often "commits", but sometimes
+"tree-ish", depending on the context and command) and paths as their
+arguments.  Here are the rules:
+
+ * Revisions come first and then paths.
+   E.g. in `git diff v1.0 v2.0 arch/x86 include/asm-x86`,
+   `v1.0` and `v2.0` are revisions and `arch/x86` and `include/asm-x86`
+   are paths.
+
+ * When an argument can be misunderstood as either a revision or a path,
+   they can be disambiguated by placing `\--` between them.
+   E.g. `git diff \-- HEAD` is, "I have a file called HEAD in my work
+   tree.  Please show changes between the version I staged in the index
+   and what I have in the work tree for that file". not "show difference
+   between the HEAD commit and the work tree as a whole".  You can say
+   `git diff HEAD \--` to ask for the latter.
+
+ * Without disambiguating `\--`, git makes a reasonable guess, but errors
+   out and asking you to disambiguate when ambiguous.  E.g. if you have a
+   file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
+   you have to say either `git diff HEAD \--` or `git diff \-- HEAD` to
+   disambiguate.
+
+When writing a script that is expected to handle random user-input, it is
+a good practice to make it explicit which arguments are which by placing
+disambiguating `\--` at appropriate places.
+
+Here are the rules regarding the "flags" that you should follow when you are
+scripting git:
 
  * it's preferred to use the non dashed form of git commands, which means that
    you should prefer `"git foo"` to `"git-foo"`.
@@ -34,8 +63,8 @@ the rules that you should follow when you are scripting git:
    if you happen to have a file called `HEAD` in the work tree.
 
 
-ENHANCED CLI
-------------
+ENHANCED OPTION PARSER
+----------------------
 From the git 1.5.4 series and further, many git commands (not all of them at the
 time of the writing though) come with an enhanced option parser.
 
