From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Thu, 05 Feb 2009 09:14:11 +0100
Message-ID: <498A9FD3.2020601@viscovery.net>
References: <cover.1233751281.git.barvik@broadpark.no> <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no> <49899FA4.2020003@viscovery.net> <7vfxiut57t.fsf@gitster.siamese.dyndns.org> <86tz7ayo51.fsf_-_@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:15:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzOg-0003vT-Tf
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbZBEIOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754330AbZBEIOP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:14:15 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31374 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZBEIOP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:14:15 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LUzNE-0003bI-7r; Thu, 05 Feb 2009 09:14:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F235869F; Thu,  5 Feb 2009 09:14:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <86tz7ayo51.fsf_-_@broadpark.no>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108530>

Kjetil Barvik schrieb:
>   And, yes, since each lstat() call cost approximately 44 microseconds
>   compared to 12-16 for each lstat() on my Linux box, there was a little
                               ^^^^^^^ fstat()?
>   performance gain from this patch.

This does look like a good gain. But do you have hard numbers that back
the claim?

If you can squeeze out a 10% improvement on Linux with this patch, we
should take it, and if it turns out that it doesn't work on Windows, we
could trivially throw in an #ifdef MINGW (or even #ifdef WIN32 if Cygwin
is affected, too) that skips the fstat() optimization.

But we really should have numbers that justify this effort.

BTW, the statement from the Windows documentation was:

  "The only guarantee about a file timestamp is that the file time is
   correctly reflected when the handle that makes the change is closed."

In the case of this patch, the timestamp is queried via the handle that
made the change, and in this case special case the timestamp could be
correct nevertheless. The guarantee doesn't cover this case, but it would
be natural, and perhaps it Just Works?

-- Hannes
