From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 12:34:09 -0800
Message-ID: <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Keith Cascio <keith@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:36:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBiB-0000xH-4h
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbZAYUeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbZAYUeT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:34:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbZAYUeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:34:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7934093246;
	Sun, 25 Jan 2009 15:34:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CA82593233; Sun,
 25 Jan 2009 15:34:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8987443E-EB1F-11DD-BAB1-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107092>

Keith Cascio <keith@cs.ucla.edu> writes:

> Introduce config variable "diff.primer".
> Allows user to specify arbitrary options
> to pass to diff on every invocation,
> including internal invocations from other
> programs, e.g. git-gui.
> Introduce diff command-line options:
> --no-primer, --machine-friendly
> Protect git-format-patch, git-apply,
> git-am, git-rebase, git-gui and gitk
> from inapplicable options.
>
> Signed-off-by: Keith Cascio <keith@cs.ucla.edu>

Your Subject is good; in a shortlog output that will be taken 3 months
down the road, it will still tell us what this patch was about, among 100
other patches that are about different topics.

The proposed commit log message describes what the patch does, but it does
not explain what problem it solves, nor why the approach the patch takes
to solve that problem is good.  Lines that are too short and too dense
without paragraph breaks do not help readability either.

> ---
>  Documentation/config.txt       |   14 +++++++
>  Documentation/diff-options.txt |   13 ++++++
>  Makefile                       |    2 +
>  builtin-log.c                  |    1 +
>  diff.c                         |   83 +++++++++++++++++++++++++++++++++++-----
>  diff.h                         |   15 ++++++-
>  git-gui/lib/diff.tcl           |    8 +++-
>  gitk-git/gitk                  |   16 ++++----
>  8 files changed, 129 insertions(+), 23 deletions(-)

You can work around the backward incompatibility you are introducing for
known users that you broke with your patch, by including updates to them,
and that is what your patches to git-gui and gitk are, but that is a sure
sign that the approach is flawed.

The point of lowlevel plumbing (e.g. diff-{files,index,tree}) is to give
people's scripts an interface that they can rely on.  It is not about
giving a magic interface that all the users are somehow magically upgraded
without change, when the underlying git is upgraded.

If a script X does not use "ignore whitespace" without an explicit request
from the end user when it runs diff-tree internally, installing a new
version of diff-tree should *NOT* magically make script X to run it with
"ignore whitespace", because you do not know what the script X uses
diff-tree output for and how, even when the end user sets diff.primer to
get "ignore whitespace" applied to his command line invocation of "git
diff" Porcelain.  Imagine a case where the operation of that script X
relies on seeing at least two context lines around the hunk in order to
correctly parse textual diff output from "diff-index -p", and the user
sets "-U1" in diff.primer --- you would break the script and it is not
fair to blame the script for not explicitly passing -U3 and relying on the
default.

Scriptability by definition means you do not know how scripts written by
people around plumbing use the output; I do not think you can sensibly say
"this should not be turned on in a machine friendly output, but this is
safe to use".

I would not be opposed to an enhancement to the plumbing that the scripts
can use to say "I am willing to take any option (or perhaps "these
options") given to me via diff.primer".  Some scripts may want to be just
a pass-thru of whatever the underlying git-diff-* command outputs, and it
may be a handy way to magically upgrade them to allow their invocation of
lowlevel plumbing to be affected by what the end-user configured.  But
that magic upgrade has to be an opt/in process.

There are funny indentation to align the same variable names on two
adjacent lines and such; please don't.
