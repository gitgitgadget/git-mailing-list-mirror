From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let transport.c use git without a dash
Date: Tue, 01 Jan 2008 18:31:52 -0800
Message-ID: <7vbq85555z.fsf@gitster.siamese.dyndns.org>
References: <1199216375-22161-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Jan 02 03:32:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9tPD-0002pq-9c
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 03:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbYABCcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 21:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbYABCcD
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 21:32:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbYABCcB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 21:32:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 33419DA0E;
	Tue,  1 Jan 2008 21:32:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AF215DA0D;
	Tue,  1 Jan 2008 21:31:56 -0500 (EST)
In-Reply-To: <1199216375-22161-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
	Bie's message of "Tue, 1 Jan 2008 20:39:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69449>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> This fixes transport.c by using "git upload-pack" and "git receive pack".
> Using the old dashed form, git fetch would fail on a remote installation where
> the git binaries are installed in a separate dir
> ---
>
> I think this might have been on the list before, but then it was never applied
> to master. git fetch fails when you have used make gitexecdir=/somewhereelse
> on the remote side, as it can't find git-upload-pack.

Two questions.

 (1) There has long been a support for specifying where your
     out-of-PATH receive-pack and upload-pack are to be found.
     Is it inadequate, and if so why?

 (2) data->receivepack is copied to args.receivepack in
     git_transport_push() and then eventually given as prog
     parameter to git_connect(), which is sent to the shell on
     the other end.  If the git restricted shell is in use, that
     is compared to the list of commands shell.c::cmd_list[];
     and separating "git-receive-pack" into two words like your
     patch would break it, I suspect.  Have you tested this
     codepath?

In the longer term (definitely before 1.6.0), we should rethink
the way --receive-pack (given to "git push") and --upload-pack
(given to "git fetch") options are handled.  We are heading
towards "a single git binary to rule them all", so it might make
sense to deprecate these two options and instead have the caller
specify the path to "git" itself (which in turn knows how to
invoke receive-pack and upload-pack subcommands).
