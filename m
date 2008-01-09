From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - Added recurse command to git submodule
Date: Wed, 09 Jan 2008 12:26:12 -0800
Message-ID: <7vhchmhhjv.fsf@gitster.siamese.dyndns.org>
References: <1199857906-26321-1-git-send-email-imyousuf@gmail.com>
	<7vmyrfjsw1.fsf@gitster.siamese.dyndns.org>
	<8c5c35580801090242g3f755814pa56e896d0a8723bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: imyousuf@gmail.com, git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:27:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChVy-0003aM-7q
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 21:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348AbYAIU0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 15:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756332AbYAIU0f
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 15:26:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249AbYAIU0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 15:26:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A3573633;
	Wed,  9 Jan 2008 15:26:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 900F43630;
	Wed,  9 Jan 2008 15:26:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70010>

"Lars Hjemli" <hjemli@gmail.com> writes:

> A possible extension is to specifiy "inter-submodule" paths to the
> init subcommand, i.e. for a possible KDE layout:
>   git submodule -r init kdelibs kdelibs/admin
>
> This should then recursively initialize the kdelibs submodule and the
> admin-submodule (in the kdelibs submodule).

Beautiful.

> Btw: from my reading of the code, the git-command specified for
> 'recurse' will be done top-to-bottom: I guess that's what you want for
> something like 'git submodule recurse diff', but not for something
> like 'git submodule recurse commit' (but IMHO the latter one should
> never be executed ;-)

Thanks for raising a very good point.  Yes, some commands
inherently wants depth first.

While I agree that making a recursive is a grave usage error
(submodule commit and toplevel commit are logically different
events and even their commit log message should be different, as
they talk about changes in logically different levels) from
project management point of view, I do not think it is something
a tool has to explicitly forbid the users to do.  I view it as a
kind of a long rope, a misuse the users can be allowed to
inflict on themselves if they really wanted to.

Also, some commands cannot be made recursive by driving them
from a higher level recursive wrapper.  "git submodule recursive
log" would not make much sense, not only because the order of
the log entries are output from different invocations would not
be useful, but because the revision range specifier would need
to be different in different submodules (e.g. library submodules
and application submodule will not share version name namespace,
i.e. "log v1.0..v2.0" is undefined, and worse yet, running "log
v1.0:path/to/sub..v2.0:path/to/sub" in a submodule when running
"log v1.0..v2.0" in the toplevel is not a correct solution
either in general).  
