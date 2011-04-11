From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 14:04:18 +0400
Message-ID: <BANLkTi=L0rTse2TTNaaO36GUNj5AR1hBXA@mail.gmail.com>
References: <20110411084229.GW5146@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, timar74@gmail.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 12:04:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Dyr-0002YF-Ee
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 12:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab1DKKEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 06:04:20 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50001 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab1DKKET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 06:04:19 -0400
Received: by qyk7 with SMTP id 7so1140332qyk.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=72E5yKVlnoD6zHCNmu0mxXroTEjP0zWHaHruTpPd4q4=;
        b=gYffxWuFWYKukT0DPtLo56NtZBB/Kx9lRkkTSVZ/wKOFNS0OUptV4/HmsdnBXJ/8+G
         sO/uz9Po3C8+DAMQeSCT0U2IizL6dEXprpg2Gr/+plMMk9stSfQJHOhGH+oft0eaFxuF
         kNDyTmkXjSzi/SY35REjzl8vlPEyPpZZJEJtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qR7BPinh346w5NuyoZyzM9q97nOL7GFeksJIBsfbhzb9+lLMzcvW1bpiVsLjo2Ny+t
         KhlB0kP5h1bTrBbSPVUsILPYdiFfNFvKOzUd89mYH39/7OFTE103Xeauux2BtRhDCPUV
         7ilwzSlDGhWfx9RwTe/YX2CTsz9f5ctCW5ChQ=
Received: by 10.229.253.14 with SMTP id my14mr229543qcb.192.1302516259019;
 Mon, 11 Apr 2011 03:04:19 -0700 (PDT)
Received: by 10.229.241.201 with HTTP; Mon, 11 Apr 2011 03:04:18 -0700 (PDT)
In-Reply-To: <20110411084229.GW5146@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171324>

Hi,

On Mon, Apr 11, 2011 at 12:42 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
>
> The problem is that it seems the clean filter - which is supposed to be
> invoked only in case a new blob is created - is invoked even on
> clone/pull, and other developers are claiming that it slows down their
> workflow.
>
> Is this a bug? I don't exactly understand why this would be necessary.

No, it is not a bug. Git may invoke the clean filter when a file is not
changed to make sure that the file is not changed. It is necessary to
prevent a race when a file is changed so quickly that its timestamp does
not change. So, what git does is compare timestamp of your file and the
index file. Because the index file is written after all files, its
timestamp should be later than any file in the repository. However, if
the timestamp resolution is not sufficient (i.e. timestamp is the same),
git may re-read recently checkout file to make sure that there were no
changes to it. During this reading, the clean filter will be invoked.

So, clean filter may be invoked extra time, but smudge filter should not.


Dmitry
