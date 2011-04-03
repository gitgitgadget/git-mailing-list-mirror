From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are well-known
Date: Sun, 3 Apr 2011 11:07:18 +0700
Message-ID: <BANLkTind3zWEZYxgTXx=spOnAo_xnRx5eQ@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
 <1301535481-1085-4-git-send-email-dpmcgee@gmail.com> <BANLkTi=QK0_P3=rGFLXzZzk7c7JSNxuBmA@mail.gmail.com>
 <BANLkTi=MupnQ9Ovy=A0nD+wDaK7wkVDryw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 06:07:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6EbR-0007nq-IQ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 06:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838Ab1DCEHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 00:07:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44488 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1DCEHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 00:07:48 -0400
Received: by pvg12 with SMTP id 12so985470pvg.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 21:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=yQfEZSFBoEWGtvZUZiAwTWXBWmNisEc7b4oxS4JTXJM=;
        b=dI+XTcORzHjAlRoH295MUqMhMHHoWSQVyMP7WsjFbMyugyhqKJpv9KiIDkTdvbPRSa
         s+ZmMFirDnbNq1z3l7pwMU+g2GOzSd69qC2xVptHW/itGmsHcDPkPWikotI/kMD5IrIO
         Vsu2SX+4klWfmE0Z34nNXVZvQPDSRFXXYp4x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tjoscloBjMtCgGiiz0HZlub3m/i5GbL2y3YaiQqL22oSuSycranTQdxzMIGFZJG/QX
         lDFhBNPjdr9dI6JyqUVZDext2Mi6gJnJMSxPZMacsa0ftFAANfpk1TwC69oGYbFjEdaO
         dit5y746oYwgzm2TjrYmU4XZyaaMkqqgBoPAk=
Received: by 10.143.87.1 with SMTP id p1mr4738174wfl.271.1301803668068; Sat,
 02 Apr 2011 21:07:48 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Sat, 2 Apr 2011 21:07:18 -0700 (PDT)
In-Reply-To: <BANLkTi=MupnQ9Ovy=A0nD+wDaK7wkVDryw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170675>

On Sun, Apr 3, 2011 at 12:28 AM, Dan McGee <dpmcgee@gmail.com> wrote:
> On Sat, Apr 2, 2011 at 4:28 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Thu, Mar 31, 2011 at 8:38 AM, Dan McGee <dpmcgee@gmail.com> wrote:
>>> We know our mode entry in our tree objects should be 5 or 6 characters
>>> long. This change both enforces this fact and also unrolls the parsing
>>> of the information giving the compiler more room for optimization of the
>>> operations.
>>
>> I'm skeptical. Did you measure signficant gain after this patch? I
>> looked at asm output with -O3 and failed to see the compiler doing
>> anything fancy. Perhaps it's because I'm on x86 with quite small
>> register set.
>
> I'm on x86_64 and was just using -O2; -O3 produces the same output
> actually. You can see it below. I had taken a look at this before I
> submitted, and noticed a few things:
> 1. We do use multiple registers now since we aren't constrained to a loop.
> 2. movzbl (for the string parts) and cmb instructions tend to get
> clustered first.
> 3. mozbl (for the mode shifting) and leal instructions tend to get
> clustered later.
> 4. The normal case now involves no conditional jumps until the ' '
> (space) comparison.
>
> Call these "trivial", but on my worst case operation times went from
> (shown below) 27.41 secs to 26.49 secs. Considering this operation is
> called 530,588,868 times (that is not a typo) during this operation,
> every saved instruction or non-missed branch prediction does seem to
> make a difference.

If it makes it better for you, I'm good.
-- 
Duy
