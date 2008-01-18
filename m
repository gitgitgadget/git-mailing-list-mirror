From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
 characters
Date: Fri, 18 Jan 2008 10:42:05 +0100
Message-ID: <4790746D.1000502@users.sourceforge.net>
References: <20080117153252.GD2816@coredump.intra.peff.net> <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net> <47905F70.5090003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 10:51:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFnsS-0002Vj-QK
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 10:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbYARJuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 04:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129AbYARJuj
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 04:50:39 -0500
Received: from ananke.et.put.poznan.pl ([150.254.29.121]:50814 "EHLO
	ananke.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbYARJui (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 04:50:38 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by ananke.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0I9j2R7012100;
	Fri, 18 Jan 2008 10:45:06 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.77] (pc1077.et.put.poznan.pl [150.254.11.77])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0I9g6D27757;
	Fri, 18 Jan 2008 10:42:06 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <47905F70.5090003@viscovery.net>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.18.13048
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70986>

Hi,

* Johannes Sixt [18 I 2008 09:12]:
> Is it good to die() in this situation? If you are sending a patch series
> and one patch in the middle triggers this condition, then only half of the
> series is sent. Maybe it would be better to warn here only, collect file
> names of the suspects, send the patch nevertheless, and write a summary at
> the end?

Unfortunately, my experience in perl programming is very, very limited. 
So, I did not prepared the final solution for this problem. ;-) The 
patch was intended as a startup of a discussion how to fix this issue.

IMHO it does not make much sense to send such patches nevertheless, if 
we are sure that they will be broken after SMTP transfer. Such a 
situation is similar to spamming. And sending only the ones that can be 
sent is not an option as well.

The proper solution would be to implement conditional encoding of such 
patches, e.g. quoted-printable as suggested by Peff, and warn users that 
some patches were send as encoded. Also an explicit option 
"--transfer-enc" might be added to control such a behaviour manually.

I guess, git send-email might reuse the code from this perl module:
http://search.cpan.org/src/GAAS/MIME-Base64-Perl-1.00/lib/MIME/QuotedPrint/Perl.pm
to implement the encoding routine.

There are although two things to implement:
1) When too long line is detected, the whole message body has to be 
encoded with QP.
2) Proper "Content-Transfer-Encoding: quoted-printable" needs to be set 
in the headers.

BTW, is "git am" or "git apply" able to decode the QP encoded message 
body? I guess yes, since it works with patches attached to emails as well...

Comments?

BR,
/Adam


-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
