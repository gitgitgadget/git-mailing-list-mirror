From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 13:26:54 +0100
Message-ID: <87myrdhnn5.fsf@rho.meyering.net>
References: <874pdmhxha.fsf@rho.meyering.net>
	<alpine.LSU.1.00.0801101204120.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 10 13:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCwVJ-0006e1-0Y
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 13:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbYAJM04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 07:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbYAJM04
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 07:26:56 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:53050 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbYAJM0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 07:26:55 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E996E17B544
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:26:54 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C39E817B592
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:26:54 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 5098A554BC;
	Thu, 10 Jan 2008 13:26:54 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0801101204120.31053@racer.site> (Johannes
	Schindelin's message of "Thu, 10 Jan 2008 12:05:50 +0000 (GMT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70065>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> However, you also have this:
>
>> -	close(keep_fd);
>> +	if (close(keep_fd))
>> +		die("failed to write keep file");

Yes.  I mentioned that in the commit log:

    * bundle.c (create_bundle): Die upon write failure.
    * fast-import.c (keep_pack): Die upon write or close failure.

But even the summary is accurate if you interpret
"write" not as the syscall, but as the semantic
push-data-through-OS-to-disk operation.

> I recently read an article which got me thinking about close().  The
> author maintained that many mistakes are done by being overzealously
> defensive; die()ing in case of a close() failure (when open() succeeded!)
> might be just wrong.

No.  Whether open succeeded is a separate matter.
Avoiding an unreported write (or close-writable-fd) failure is not
being "overzealously defensive."

>From "man 2 close",

    -------------
    NOTES
       Not  checking  the return value of close() is a common but nevertheless
       serious programming error.  It is quite possible that errors on a  pre-
       vious  write(2) operation are first reported at the final close().  Not
       checking the return value when closing the file may lead to silent loss
       of data.  This can especially be observed with NFS and with disk quota.
    -------------
