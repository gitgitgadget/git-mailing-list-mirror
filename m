From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Ad: fast-import problem importing dos format files under cygwin
Date: Wed, 3 Dec 2008 08:04:46 -0800
Message-ID: <20081203160446.GY23984@spearce.org>
References: <43827.194.138.12.144.1228290700.squirrel@artax.karlin.mff.cuni.cz> <43270.194.138.12.144.1228295417.squirrel@artax.karlin.mff.cuni.cz> <49367909.8070605@viscovery.net> <51143.194.138.12.144.1228311791.squirrel@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7uF0-000755-LB
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 17:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbYLCQEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 11:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbYLCQEs
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 11:04:48 -0500
Received: from george.spearce.org ([209.20.77.23]:53159 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYLCQEr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 11:04:47 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B9CE338200; Wed,  3 Dec 2008 16:04:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51143.194.138.12.144.1228311791.squirrel@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102268>

Jan Hudec <bulb@ucw.cz> wrote:
> Dne 3 Prosinec 2008, 13:18, Johannes Sixt napsal(a):
> > Jan Hudec schrieb:
> >> On 3 December 2008, 08:51, Jan Hudec wrote:
> >>> Hello folks,
> >>>
> >>> I have been playing with fast-import in cygwin and I have problems
> >>> importing files with CR/LF line-endings. The size in data command is
> >>> calculated including the CRs and than the file is copied binary to the
> >>> fast-import input stream. However fast-import skips the CRs when
> >>> reading,
> >>> overreads by that number of bytes and fails when it tries to read the
> >>> next command from the middle.
> >
> > Do you happen to have core.autocrlf set in some way and could it make a
> > difference for fast-import? I have it unset.
> 
> I have it set to false explicitly in global config. Tried with not having
> it set at all and gives the same problem. Since the previous version of
> MSys Git worked for me, I suspect it's somehow cygwin-related.

Huh.  So fast-import *never* does auto-CRLF conversion, even if the
property is set.  It just doesn't make those calls internally.
It blindly copies data from the input stream into the pack.
No exceptions.

fast-import under-reading near CRs and getting misaligned on its
input indicates that the stdio library has given us a FILE* for stdin
which is converting CRLF pairs into LFs, even within an fread() call.

My guess here is fast-import's stdin is set in text mode, but it
really needs to be in binary mode.  fast-import.c never attempts
to correct that when it starts, so on DOS based systems we are
probably totally screwed from the beginning...

-- 
Shawn.
