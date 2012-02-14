From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/5] git push: verify refs early
Date: Tue, 14 Feb 2012 09:59:19 +0100
Message-ID: <20120214085919.GB1762@ecki>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
 <1329164235-29955-4-git-send-email-drizzd@aon.at>
 <7v4nuucrbm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 10:07:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxEMY-0003S3-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 10:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759752Ab2BNJHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 04:07:45 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:53138 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753602Ab2BNJHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 04:07:42 -0500
Received: from localhost (p5B22E1C5.dip.t-dialin.net [91.34.225.197])
	by bsmtp.bon.at (Postfix) with ESMTP id ACEED13004F;
	Tue, 14 Feb 2012 10:05:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v4nuucrbm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190711>

On Mon, Feb 13, 2012 at 02:16:13PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > I suppose with some effort, this could be done for smart HTTP as well.
> > But I am not sure if we actually want the overhead of the additional
> > ping-pong for HTTP.
> 
> Hrm, I am confused.
> 
> The updated protocol exchange, if I am reading your patch correctly, would
> go like this (S stands for the sender, R for the receiver):
> 
>         R: Here are the tips of my refs
>         ----
>         S: I'd like to update your refs this way
>         ----
>       + R: No you cannot because all updates will fail, go away
>         or
>       + R: You may proceed, as some updates may succeed
>         ----
>         S: Here is the packfile
>         ----
>         R: Here is how I processed your request
> 
> Given that this makes the sender stall for both smart HTTP and native
> protocol, don't your worries about the additional ping-pong apply equally
> to both transports?

That is true. However, my assumption was that the overhead is greater
for HTTP, because the native protocol is full-duplex, while HTTP tears
down the connection and starts from scratch with each request. But to be
honest, I am not confident that this assumption is correct.

So, the stall might be an issue for both the native and the HTTP
protocol, or for neither. We should probably find out and then decide
whether to make this change for both protocols or not at all.

> If it is not worth doing for smart HTTP, I wonder if it is worth doing for
> native transport.  After all, "all updates will fail" is hopefully the
> less likely case, and with this protocol extension, we end up penalizing
> the common case with an extra stall for everybody, regardless of the
> transport.

Indeed. I wish we could make the ref validation asynchronous. The client
would start sending object data right away, while listening for an
"abort" command on the side-band. But if I understand correctly, that is
not possible for HTTP.
