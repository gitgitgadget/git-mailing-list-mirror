From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] start_command(), if .in/.out > 0, closes file descriptors, not the callers
Date: Sun, 17 Feb 2008 10:29:17 +0100
Message-ID: <200802171029.17850.johannes.sixt@telecom.at>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org> <1203183399-4813-2-git-send-email-johannes.sixt@telecom.at> <7vmyq07bqe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 10:30:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQfqR-0000ZX-Iy
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 10:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbYBQJ3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 04:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYBQJ3Y
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 04:29:24 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:43147 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbYBQJ3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 04:29:20 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 4366110A8C1;
	Sun, 17 Feb 2008 10:29:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0FAA714A93;
	Sun, 17 Feb 2008 10:29:18 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmyq07bqe.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74109>

On Saturday 16 February 2008 23:55, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> >  	need_in = !cmd->no_stdin && cmd->in < 0;
> >  	if (need_in) {
> > -		if (pipe(fdin) < 0)
> > +		if (pipe(fdin) < 0) {
> > +			if (cmd->out > 1)
> > +				close(cmd->out);
>
> Why check for "2 or more"?

Later in the code, where we set up the redirections in the child process, we 
have this:
		...
		} else if (cmd->out > 1) {
			dup2(cmd->out, 1);
			close(cmd->out);
		}

and I thought it was good to also compare cmd->out > 1 in other situations. 
But now that I think about it, this > 1 is to be understood like this:

		if (cmd->out > 0)
			dup2(cmd->out, 1) unless cmd->out == 1;

so it's an optimization - an unnecessary one since dup2(1, 1) is supposed to 
succeed and be a noop.

> > +	 * - Specify > 0 to give away a FD as follows:
> > +	 *     .in: a readable FD, becomes child's stdin
> > +	 *     .out: a writable FD, becomes child's stdout/stderr
> > +	 *     .err > 0 not supported
> > +	 *   The specified FD is closed by start_command(), even in case
> > +	 *   of errors!
>
> Perhaps you would need to spell out the semantic differences you
> are assigning to "inherit" vs "give away".  I presume the former
> is something run_command() would not touch vs the latter is
> closed by run_command()?

I'll clearify it.

-- Hannes
