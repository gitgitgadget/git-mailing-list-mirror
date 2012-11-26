From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Mon, 26 Nov 2012 14:23:58 +0100
Message-ID: <CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
	<7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
	<CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:24:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcyfY-0000Cs-2f
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab2KZNYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:24:00 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37914 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab2KZNX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:23:59 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so4461772eek.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 05:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=urw3SNAR0JgphBsIaLkke5YHUjwPwMAhAlF9NP6P6JE=;
        b=x+OiyrnB4g1xknmJFe8n+gjvEVucYmFkJBrA2zLD+Hph5Li3Ue3yxGNfp0W/xajnGb
         gGGzpJN6laOcrmy+6hITX7Iy5aiaDFf896zOUKyC2CBh7pMsj7SC5nTy7sF7HY2KRDhr
         eTXvV5QLcHzqZiYa/y8ijT1GGB2poB/8DCR1ayA9JVWC4DNKVAoUv7dUV8Ye/7tLF/Cm
         e76mCfg/T8SuR7aP8WAoCpVBGtJeG4kD6KSnacn9/TMJ6oUkoTTHj3zpRs0fEAkLOUsS
         NIzhoriUHVHJZ28i1J5czr39swjpr7oViaWpqmrtF1Hza8hlmB/uVAkpMjPgWy7b34QP
         AvUg==
Received: by 10.14.179.69 with SMTP id g45mr45569850eem.42.1353936238589; Mon,
 26 Nov 2012 05:23:58 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Mon, 26 Nov 2012 05:23:58 -0800 (PST)
In-Reply-To: <CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210442>

On Mon, Nov 26, 2012 at 12:37 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Nov 26, 2012 at 5:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Is this a safe and sane thing to do, and if so why?  Could you
>> describe that in the log message here?
> Why would fast-export try to export something that was pruned? Doesn't
> that mean it wasn't reachable?

Hello Junio,
Hello Felipe,

Actually the issue happened while using Felipe's branch with his
git-remote-hg.  Everything was going fine until I (or did it run
automatically, I dont remember) ran git gc that pruned unreachable
objects. Of course some of the branch I had pushed to the hg remote
had been changed (most likely rebased).  References no longer exists
in the repository (cleaned by gc), but the reference still exists in
mark file, as it was exported earlier.  Thus the failure when git
fast-export reads the mark file.

Then, is it safe ?
Updating the last_idnum as I do in the patch doesn't work because
if the reference is the last, the number is going to be overwriten
in the next run.
From git point of view, I guess it is fine. The file is fully read at
the beginning of fast-export and fully written at the end.
The issue is more for git-remote-hg that keeps track of
matches between git marks and hg commits. The marks are going to
change and be overriden. It will most likely need to read the mark
file to see if a ref has changed, and update it's dictionary.

One of the solution I'm thinking of, is to update the mark file
with marks of newly exported objects instead of recreating it,
and let obsolete references in the file. But of course that is
not acceptable.

Cheers,
Antoine
