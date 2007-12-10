From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Mon, 10 Dec 2007 01:06:59 -0500
Message-ID: <9e4733910712092206o40e0c748s3796b95f637bf2b3@mail.gmail.com>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
	 <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
	 <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
	 <9e4733910712092159s24cf5a7cx4610f797f61b1de5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1bnc-0005wf-B3
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 07:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXLJGHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 01:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbXLJGHH
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 01:07:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:15944 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbXLJGHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 01:07:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3147184wah
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 22:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9eOqM76+UuVMEhA9Dv1+USz57anb9Vo4QYLZtFUO7M0=;
        b=KwzhRAQ2Y104IWZQRJyPfDk+pfWPqKg0/TElGeUAerCxKmhLPy1FlfluhvgtXc9ERCy70wlWEnbvbNjWRs2A9/x2sL6G+/gH3+hDyYVZW4MluB97QGDi0MzRlAccWdLN18EEWhA7rH4zx7QyhaIwpNWAhdRQx/pofTqLOXw482A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HVT4X2ZlfBjkhsNl82JZ0Fh9cJETzL1HrUNoqMGdCik3xN90iRjjw8/bY7mKNaCTXmxKw6Pm9fivI6ZPG13F8STeogw3LqMO3fe9oYy+BlrdDnmEzwiFEttU1XkCVLymh8MqfVaPmUdPZrSHDoKCbbJe2vjfKvDaRxQ+XeyrJbA=
Received: by 10.114.15.1 with SMTP id 1mr6130920wao.1197266824439;
        Sun, 09 Dec 2007 22:07:04 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sun, 9 Dec 2007 22:06:59 -0800 (PST)
In-Reply-To: <9e4733910712092159s24cf5a7cx4610f797f61b1de5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67682>

On 12/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> I just deleted the section looking for identical hashes.
>
> +                       while (sub_size && list[0]->hash &&
> +                              list[0]->hash == list[-1]->hash) {
> +                               list++;
> +                               sub_size--;
> +                       }
>
> Doing that allows the long chains to be split over the cores.
>
> My last 5% of objects is taking over 50% of the total CPU time in the
> repack. I think these objects are the ones from that 103,817 entry
> chain. It is also causing the explosion in RAM consumption.
>
> At the end I can only do 20 objects per clock second on four cores. It
> takes 30 clock minutes (120 CPU minutes) to do the last 3% of objects.

It's all in create_delta...

samples  %        symbol name
10344074 98.5961  create_delta
138010    1.3155  create_delta_index
4380      0.0417  find_deltas
2526      0.0241  patch_delta
776       0.0074  unpack_entry



>
> Can the chains be limited to not grow over some reasonable number, say
> 5,000? It will make the pack a little bigger but it will help a lot
> with performance.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
