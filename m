From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 2/6] Automatically close stderr pipes created by run_command
Date: Fri, 15 Feb 2008 20:45:37 +0100
Message-ID: <200802152045.37755.johannes.sixt@telecom.at>
References: <20080214062229.GB30516@spearce.org> <47B3F51C.3060002@viscovery.net> <7vfxvui1pz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 20:46:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ6Vl-0001YS-Kv
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 20:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbYBOTpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 14:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbYBOTpn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 14:45:43 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:36817 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbYBOTpm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 14:45:42 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id B863D10ADFD;
	Fri, 15 Feb 2008 20:45:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CD9794E8A1;
	Fri, 15 Feb 2008 20:45:38 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfxvui1pz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73979>

On Friday 15 February 2008 18:11, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> > Shawn O. Pearce schrieb:
> >> Like the out pipe and in pipe, we now automatically close the err
> >> pipe if it was requested by the caller and it hasn't been closed
> >> by the caller.  This simplifies anyone who wants to get a pipe to
> >> the stderr stream for another process.
> >
> > IMHO, this is backwards.
> >
> > The .in, .out, .err members of struct child_process serve two different
> > purposes:
> >
> > 1. Caller sets them to some fd > 0. This means:
> >    "Here is a readable (.in) or writable (.out, .err) fd; use it."
> >
> > 2. Caller sets them to -1: This means:
> >    "Create a pipe and give me the writable (.in) or readable (.out,
> >    .err) end of it back."
> >
> > Notice that in a clean implementation:
> >
> > - case 1. would imply that the fd is "given away", i.e.
> >   start_command/finish_command take ownership and close it;
> >
> > - case 2. would imply that the caller takes ownership of the returned
> >   fd and has to close it.
>
> I am puzzled.  In a clean implementation perhaps the fds belong
> to the caller in both cases.  Or belong to the callee in both
> cases.  Or perhaps sometimes belong to the caller and someimes
> to the callee as you wrote above, but that seems arbitrary.

Heh. In a clean implementation you also don't use the same thing to do two 
completely different things. For example, note how in one case .in contains a 
readable, in the other a writable fd, and how fds are used in completely 
different ways.

> I suspect from the caller's point of view, if we can always make
> them owned by the caller, that would be the most consistent and
> convenient.  "Here is a fd --- I lend it to you so use it but do
> not close --- I may have other uses for it later".

Well, I think we could do that, theoretically. But practically in the case 
where a fd > 0 is assigned to .in/.out/.err:

- case .out, .err: the caller is required to close the fd early after 
start_command() because (if this is a pipe) the child won't see EOF;

- case .in: the caller must not read from the fd anyway, else the child gets 
inconsistent input.

So, while there *is* some inconsistency, the inconsistent cases can be clearly 
separated into the cases fd > 0 and fd == -1.

-- Hannes
