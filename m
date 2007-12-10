From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Mon, 10 Dec 2007 00:59:38 -0500
Message-ID: <9e4733910712092159s24cf5a7cx4610f797f61b1de5@mail.gmail.com>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
	 <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
	 <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1bgP-0004ja-09
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 07:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbXLJF7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 00:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXLJF7j
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 00:59:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:60835 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbXLJF7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 00:59:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3144184wah
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 21:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sQ9CNxCee5l9pi6xVIqq1ph61q81tgB3mZvCRzNPNoQ=;
        b=xNMjXCA0qxNdDnRFURbons+d9hUSb0oEE0QsRzrq+TLAurqzkAJigzFQHPu+Xp6s5SgzLJ+qL0f1CUBM1YoiFzgTKmbLZ+bA62UCHYLVuEEWY3BP7xvG5RbI4KRmd4g28kT5rYQ/sFwEvH6bWcQTt4hvzvY1Uxqf7EVcZJQ++3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wV7tnoNR5Ut4ok4oG7O4cSzFWQ4mif73DsnNW/O0tokjeTHsTG9A3XsTcyk7/RGvrdOh9zCouLADIxelRw/fnzd6p75S8dmhiDxIgmsdGCLxkZeBe2RB06gtstpx0yboPH1eTOgenwquVWJWLN/Vh1RDMs0hQJVOShmKILrvxJI=
Received: by 10.114.125.2 with SMTP id x2mr254872wac.1197266378443;
        Sun, 09 Dec 2007 21:59:38 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sun, 9 Dec 2007 21:59:38 -0800 (PST)
In-Reply-To: <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67681>

I just deleted the section looking for identical hashes.

+                       while (sub_size && list[0]->hash &&
+                              list[0]->hash == list[-1]->hash) {
+                               list++;
+                               sub_size--;
+                       }

Doing that allows the long chains to be split over the cores.

My last 5% of objects is taking over 50% of the total CPU time in the
repack. I think these objects are the ones from that 103,817 entry
chain. It is also causing the explosion in RAM consumption.

At the end I can only do 20 objects per clock second on four cores. It
takes 30 clock minutes (120 CPU minutes) to do the last 3% of objects.

Can the chains be limited to not grow over some reasonable number, say
5,000? It will make the pack a little bigger but it will help a lot
with performance.

-- 
Jon Smirl
jonsmirl@gmail.com
