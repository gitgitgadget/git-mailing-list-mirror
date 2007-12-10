From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Mon, 10 Dec 2007 00:23:36 -0500
Message-ID: <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
	 <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 06:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1b7X-0007IM-S0
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 06:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbXLJFXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 00:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbXLJFXh
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 00:23:37 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:34084 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbXLJFXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 00:23:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3128416wah
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 21:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=btbt4rkcU/QuWgINKNBnN961RUfBy2Q0MxJiRAL/aX0=;
        b=qTA5ZxQjfQ1t2mnjKIyVobmh1NwSaMGSIStK7Vu0Hrg7aj7Yr/WfLhLq6Yh5O9l1Xc5lmMVIws5VrJn2HzCYeC83eSYfmngKcIdrG/UeLm/2e/LEr2qJixgOTXzjv9AQK1ZENxBPsGoj+G0tuX1uzhTEeqh1KocNmY642gfIfVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OFWVDR17MLycppb+PSNcTMLZ0v7HvEm6q6L0xRy9aIYTdl9z1qeah7KK9zXIGzbw29k+dGVvQMBdhsYQIqu98ItNUQCBSMnf84S61AaIIU8Sd9i07ZoZ+vdyHpS4HNch0W+5mZVvhgA8mMlfihvSoSU4XPH+JZzqzA8CI9bqhO4=
Received: by 10.115.54.1 with SMTP id g1mr6298633wak.1197264216302;
        Sun, 09 Dec 2007 21:23:36 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sun, 9 Dec 2007 21:23:36 -0800 (PST)
In-Reply-To: <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67680>

On 12/9/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > +               if (victim) {
> > +                       sub_size = victim->remaining / 2;
> > +                       list = victim->list + victim->list_size - sub_size;
> > +                       while (sub_size && list[0]->hash &&
> > +                              list[0]->hash == list[-1]->hash) {
> > +                               list++;
>
> I think you needed to copy sub_size to another variable for this loop

Copying sub_size was wrong. I believe you are checking for deltas on
the same file. It's probably that chain of 103,817 deltas that can't
be broken up.

ChainLength     Objects Cumulative
1:      103817  103817
2:      67332   171149
3:      57520   228669
4:      52570   281239
5:      43910   325149
6:      37520   362669
7:      35248   397917
8:      29819   427736
9:      27619   455355
10:     22656   478011
11:     21073   499084
...

>
> > +                               sub_size--;
> > +                       }
> > +                       target->list = list;
> > +                       victim->list_size -= sub_size;
> > +                       victim->remaining -= sub_size;
> > +               }



-- 
Jon Smirl
jonsmirl@gmail.com
