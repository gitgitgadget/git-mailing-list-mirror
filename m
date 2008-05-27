From: Junio C Hamano <gitster@pobox.com>
Subject: Re: setup_git_directory_gently contract question?
Date: Tue, 27 May 2008 15:46:48 -0700
Message-ID: <7vmymbz7on.fsf@gitster.siamese.dyndns.org>
References: <8e04b5820805270710v3a06e5c2if2dcf3b94ef40c1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 00:48:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K17xY-0007qk-0P
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 00:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493AbYE0WrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 18:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757327AbYE0WrH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 18:47:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749AbYE0WrG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 18:47:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 27D435CBF;
	Tue, 27 May 2008 18:47:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 479845CBD; Tue, 27 May 2008 18:46:59 -0400 (EDT)
In-Reply-To: <8e04b5820805270710v3a06e5c2if2dcf3b94ef40c1f@mail.gmail.com>
 (Ciprian Dorin Craciun's message of "Tue, 27 May 2008 17:10:42 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D30E620E-2C3E-11DD-AA37-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83056>

"Ciprian Dorin Craciun" <ciprian.craciun@gmail.com> writes:

>     Is the function setup_git_directory_gently supposed to change the
> current working directory, or should it keep the initial one?
>     What is the meaning of nongit_ok?

Most commands that work from subdirectory use setup_git_directory()
interface, because major parts of the guts of the git internal want you to
be at the top of the work tree (e.g. so that you grab a path out of the
index, and be able to open(2) or lstat(2) that path).  A normal sequence
for a command is: (1) use setup_git_directory() to learn "prefix", (2) use
get_pathspec() and/or prefix_path() to add "prefix" to the paths given
from the command to make it a path relative to the work tree, (3) do its
thing.  setup_git_directory() chdir's up to the top of the work tree for
this reason.

Some commands can optionally work from even outside a git repository, but
they would want to operate the same way as other comands, when they are
started within a git repository.  In such a case, you use "gently"
variant, and give a pointer to int to store an additional return value to
signal you if you are inside a git repository or outside.

 * When NULL is given as nongit_ok to gently(), it does not behave gentle
   at all.  Outside a git repository it dies loudly.

 * If you are inside a git repository, it behaves pretty much the same as
   setup_git_directory().  "*nongit_ok" is set to zero to signal that you
   are inside a git repository.

 * If you are outside a git repository, *nongit_ok is set to non-zero so
   that the caller can tell that it is not in any git repository's work
   tree.  There is no need to chdir (nor a sensible place to chdir to) in
   this case, so it doesn't.

The caller thinks of the parameter as "are we operating in non-git mode?"
boolean, and the callee (i.e. setup_git_directory_gently()) thinks of it
as "is it ok to be called outside a git repository?" (if it is NULL, the
caller expects to be inside a repository and wants it to barf otherwise).
That is why caller's variable are often called "int nongit", and the
callee's parameter is called "int *nongit_ok".
