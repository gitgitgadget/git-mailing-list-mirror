From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Best way to apply textconv to a working tree file
Date: Tue, 01 Jun 2010 18:07:06 +0200
Message-ID: <vpqd3walot1.fsf@bauges.imag.fr>
References: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <diane.gasselin@ensimag.imag.fr>,
	<axel.bonnet@ensimag.imag.fr>
To: clement.poulain@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 01 18:10:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJU2k-0007fV-Nl
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 18:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102Ab0FAQKM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 12:10:12 -0400
Received: from imag.imag.fr ([129.88.30.1]:49967 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757027Ab0FAQKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 12:10:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o51G767L020707
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Jun 2010 18:07:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OJTze-0006cI-Eu; Tue, 01 Jun 2010 18:07:06 +0200
In-Reply-To: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr>
 (=?iso-8859-1?Q?=22Cl=E9ment?= Poulain"'s message of "Tue\, 01 Jun 2010
 15\:41\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 01 Jun 2010 18:07:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148135>

[ Just had IRL discussion with Cl=E9ment and his co-workers ]

Cl=E9ment Poulain <clement.poulain@ensimag.imag.fr> writes:

> In order to add textconv support to "git-gui blame", we have to run
> textconv on a file which is in the working tree.
> Currently, "git-gui blame" uses the Tcl function 'open' to display th=
e
> content of the working-tree file. This doesn't allow us to run textco=
nv on
> it.

There are actually two distinct issues :

1) The textconv functionality has an API, but isn't available as
   plumbing for scripting purposes (and git gui would like to be able
   to call textconv from the command-line).

2) If one solves issue 1) by adding textconv support to "git
   cat-file", then we can call textconv on a blob in the object
   database, but not on a worktree file. Hence, we still need to add
   support to display worktree files in "git cat-file".

> - For revisions, "git-gui blame" is based on "git cat-file blob
> <sha1:path>". Therefore, we thought of adding a "--textconv" option o=
n
> cat-file as well as a "--working-tree" option ("git cat-file --workin=
g-tree
> <file>" will display the content of <file> in the working-tree)
>
> - Use the "-p" (pretty print) cat-file's option, with a path beginnin=
g by
> ./ (to avoid ambiguous name like HEAD)

After thinking about it, I think a mix of these solutions would be
OK:

git cat-file --textconv <blob-sha1>            # Run textconv on blob

git cat-file --textconv <tree-sha1>:<filename> # Run textconv on file
                                               # (in object database)

git cat-file --textconv ./<filename>           # Run textconv on file
                                               # (in worktree)

This preserves the property "1st argument is an option, 2nd argument
is the thing to do the cat-file on", hence avoid any possible
ambiguities in command-line option parsing.

Another option would be to resurect the WOKRTREE/STAGE magit tokens [1]
proposal, and allow

git cat-file --textconv WORKTREE:<filename>

That sounds the most natural to me, but it's probably the most
controversial too ...

[1] http://thread.gmane.org/gmane.comp.version-control.git/133087

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
