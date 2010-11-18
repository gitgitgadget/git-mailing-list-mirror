From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] A loose object is not corrupt if it cannot be read
 due to EMFILE
Date: Thu, 18 Nov 2010 19:18:37 +0100
Message-ID: <AANLkTi=rrcc5tia03K-Rtqs3vyjOv9P1NArnmbYhCQ27@mail.gmail.com>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com>
 <1288299210-27092-2-git-send-email-gitster@pobox.com> <AANLkTi=L1Z6kxubMf3yPUfpY9ugd+Qan+yCxi3dp4oR4@mail.gmail.com>
 <4CE55794.7050201@viscovery.net> <AANLkTikns0Rm5znC7FOa72qZXKpQzazKiYsPe-oDNMAk@mail.gmail.com>
 <20101118172920.GC16610@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 19:19:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ94b-0003KQ-Jd
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 19:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758685Ab0KRSS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 13:18:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54173 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab0KRSS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 13:18:58 -0500
Received: by fxm10 with SMTP id 10so188312fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 10:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=0QxKN0baQgB5hew3HWQL/VELIQ0gDEJfSYOThhQlhmg=;
        b=mQL49dFS5tdvrgOSUbxe2a2tAkPxlC20cRXw2uEWKLgmoW7toX4UfL/oNsmZ0HoPRN
         lxmu+Nwza8n6a2c7dIu5Ij4hqU8Ea+7V5Cb//s1GNsrSn/r76/Rd8/PUe5kdeZ1PEy7B
         eCAqvJzmlQG/6KWd1OzkjebbtnYZKLXt+vK0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=gi6C8Tr7oYJIC5kp9e/cdt7l5lEpeACFgVfsXfnG+CuvtI/DcqvssFPFmztPUGlyGI
         N0ZKNnnitznSu8PNnvZ5qXkELlIIkRsV0/5qgD/x+8JGDSqqUoGPCphgv3iBckto172U
         sOHZhn+D0hoJw3z+epbrU/7/Uho9E+smtZB74=
Received: by 10.223.100.4 with SMTP id w4mr931677fan.26.1290104337137; Thu, 18
 Nov 2010 10:18:57 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 18 Nov 2010 10:18:37 -0800 (PST)
In-Reply-To: <20101118172920.GC16610@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161699>

On Thu, Nov 18, 2010 at 6:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Erik Faye-Lund wrote:
>
>> I was wondering about the same thing, I don't think this approach is
>> very easy to follow. But either way I think we should make sure
>> opendir/closedir/readdir doesn't mess with errno.
>
> Other platforms and are allowed to (and do) clobber errno in many
> non-error situations, so the main effect would be to work around/hide
> some git bugs.

I don't think that's the case; K&R (section B1.7) says "In addition,
the integer expression errno (declared in <errno.h>) may contain an
error number that contains information about the most recent error.".
A non-error condition would not be information about the most recent
error. I interpret the use of the word "may" to mean "some functions
does not update errno, so errno could also have information about
older errors" not as "some functions can clear errno", but other might
disagree with me.

POSIX (which defines opendir) says "No function in this volume of IEEE
Std 1003.1-2001 shall set errno to 0", so I think it's clear cut in
this case. (see
http://www.opengroup.org/onlinepubs/009695399/functions/errno.html for
the full text)

We also seem to depend quite heavily on errno being preserved on
non-errors some places around in the code.
