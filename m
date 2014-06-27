From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tackling Git Limitations with Singular Large Line-seperated
 Plaintext files
Date: Fri, 27 Jun 2014 12:47:12 -0700
Message-ID: <CA+55aFwFne6gj6P_Vm+uGffbF--vd-yke0899k==iVgHkb+gWQ@mail.gmail.com>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
	<CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>
	<xmqqegya2qgu.fsf@gitster.dls.corp.google.com>
	<CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Jarrad Hope <me@jarradhope.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 21:47:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0c7B-00087P-A2
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbaF0TrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 15:47:13 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:51062 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbaF0TrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 15:47:13 -0400
Received: by mail-ve0-f170.google.com with SMTP id i13so5769535veh.15
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Cq3bNAU9vcqxlQVP4qVm66J3gnoXYBX3pb9w6kSZieM=;
        b=ch1dp227mYPpXI/4hOx25bjhRTUkmeI701njLEeRPoN/84LF/CvVg81UfEjypjf4MS
         zGAg1DLW52lGV//MYKlIhhKBOgqL0UoyQAX+aN+Txky73Sve3ntmnBZPNevJEMVaz5uN
         UNxuG9wEsvdrrVAGZXk1VhYH6WqiWTInMzQ+W4sB8lqwAFKbaP4qX7/x9tWduDRL3Khp
         o6+uwuxSwoCRWHR8emEu1NVRd5F/NQYp0KuwHHjn8nSK0iY0XVvarxx5V+67frUR311Y
         0uRZhqzLdGmFtWmEWXckbRBTaQ/QSRP3hNOUR4PZg+TbU6FCAaQzof4rDFe2D2lY0ziV
         grJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Cq3bNAU9vcqxlQVP4qVm66J3gnoXYBX3pb9w6kSZieM=;
        b=DLSSKzs8nGbi5ZrmGkkL4Hd8gHm07lTOdsv5bYe1sv9NrZr6Z7R4q7InEtrdxzWTVg
         BX4TwPSaujnG5eZRkgljdis84qYvOr7W304Nk+QjsxKGCWh1c26smPx7O12dk32zBmp7
         iWoZxH+AbXIiIrUWjJW4WgiorHmKFWRZnrKpo=
X-Received: by 10.52.249.41 with SMTP id yr9mr3423042vdc.51.1403898432300;
 Fri, 27 Jun 2014 12:47:12 -0700 (PDT)
Received: by 10.221.58.77 with HTTP; Fri, 27 Jun 2014 12:47:12 -0700 (PDT)
In-Reply-To: <CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
X-Google-Sender-Auth: 266Rp9ctADAb3foemlWNdsyIDdI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252576>

On Fri, Jun 27, 2014 at 12:38 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think it might be possible to just specify a special diff algorithm
> (git already supports that, obviously), and just introduce a new "use
> binary diffs with a textual representation" model.

Another model would be to just insert newlines in the data, and use
the regular textual diff on that "preprocessed" format.

The problem of *where* to insert the newlines is somewhat interesting,
since the stupid approaches ("chunk it up in 64-byte lines") don't
work with data insertion/deletion (all the lines will now be different
just because the data is offset), but there are algorithms that handle
that reasonably well, like breaking lines at certain well-defined
patterns (the patterns can then be defined either explicitly or
algorithmically - like calculating a hash/crc over the last rolling N
characters and breaking if the result  matches some modulo
calculation).

                Linus
