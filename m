From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible regression in git-rev-list --header
Date: Sat, 30 Dec 2006 17:45:47 -0800
Message-ID: <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	<Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
	<7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 02:46:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0pm6-0007ct-KV
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWLaBpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWLaBpt
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:45:49 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37890 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598AbWLaBps (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:45:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231014547.FWCK15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 20:45:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5Dl11W00V1kojtg0000000; Sat, 30 Dec 2006 20:45:02 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 31 Dec 2006 02:13:27 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35644>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 30 Dec 2006, Junio C Hamano wrote:
>
>> Another thing.  I think it would make sense to remove "encoding" header 
>> after pretty_print_commit successfully re-codes the buffer.  An 
>> alternative is to rewrite "encoding" header to show which encoding the 
>> log now uses (and omit it if it is UTF-8).
>
> I think it would be wrong. Sure, the output may be encoded differently, 
> but the _original_ commit was not. And this is the information I want 
> to see when I look at the raw commit.

When you want to see the raw commit, you would not ask for it to
re-code, so "removal after successfully re-codes" would not kick
in (if you _really_ want to look at the raw commit, I guess
cat-file can help, but let's not go there).  Re-coding the
message but still showing what the original encoding was does
not sound making much sense to me.

I've pushed this out after a small rework.

The rule is:

 - if you ask for re-coding (either by i18n.* configuration or
   an explicit --encoding option from the command line), and if
   re-coding successfully does its job, you do not see
   "encoding" header;

 - if the buffer cannot successfully be re-coded, no re-coding
   is done, and the caller can inspect "encoding" header.

 - if you do not ask for re-coding, "encoding" header is left as
   is, so is the commit log message.  The caller can deal with
   any re-coding itself.
