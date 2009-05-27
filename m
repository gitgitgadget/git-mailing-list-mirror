From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH] imap-send: add support for IPv6
Date: Wed, 27 May 2009 12:50:11 +0200
Message-ID: <4A1D1AE3.9030900@googlemail.com>
References: <4A1AEDF2.7060307@googlemail.com> <7v7i03kqjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mike@codeweavers.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 12:50:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9GiG-0006Wf-St
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 12:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758907AbZE0KuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 06:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758843AbZE0KuP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 06:50:15 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:49565 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758352AbZE0KuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 06:50:13 -0400
Received: by bwz22 with SMTP id 22so4488442bwz.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Xch6FPVegB+Csx2rtiZ1+CP31BDCKkbXGmTxAEU+lWU=;
        b=fjozMtMCMwJf+37BHVB6G5wFVqNgiHX0wbhIBYGIpXjc5q69c6P/WmtlptyX9iG2QM
         piZRQX7gqZ6cNKqM20ZhurdcAryBXSH5yLaahO3KCoo8WMEHk5FmwWqpysmRH25FPhv9
         mbGcYljimoLg3rF0QTbCtNtDT/C2+5Na64cfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=iZujI5YlnF6tn/ZX8AHWNDfvg1WNDp7V3yd4aPCb1EFGIV5iIalzDb6fyirvIWAGBP
         9DkhW9eiQbdi0fTjq5MUpGvT2UNTJPuFV/3u+JUpvxLWnKPV+MdAa/AX454vpflr6BpX
         YXt6MCQzotVq8XoflmTeoGnjGVzUXMvPvvl3k=
Received: by 10.103.105.15 with SMTP id h15mr2180128mum.56.1243421414010;
        Wed, 27 May 2009 03:50:14 -0700 (PDT)
Received: from golden.local (p5B01F2D3.dip.t-dialin.net [91.1.242.211])
        by mx.google.com with ESMTPS id i7sm5293552mue.48.2009.05.27.03.50.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 03:50:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <7v7i03kqjq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120055>

Junio C Hamano wrote:
> We already use %h length specifier to explicitly say the parameter is
> a short in the IPV4 part of this program, so I am sure this won't regress
> anything for people, but I wonder what the point of it is...  (I am not
> asking nor even suggesting to change this, by the way).

getaddrinfo(3) takes the port as a string so we have to convert it. I tried
to match the style of the existing code with the format string. The portstr
buffer is 6 chars long so the highest possible unsigned short 65535 fits in
exactly.

> It is Ok for now (as existing codepath liberally uses fprintf() and
> fputs() to report errors), but ideally we should start converting these to
> error() calls, I think, in a follow-up patch.

Looking at the number of fprintfs in imap-send.c a simple search/replace
probably won't do the job here. I tried to contact the original author but
his mail address seems to be dead ...

> Is forcing to NUMERICHOST done to match IPV4 codepath that does
> inet_ntoa()?  I guess that makes sense.

We need to get the IP string, otherwise the output of imap-send would
make no sense. Here's what imap-send outputs when I try to connect to
localhost.

Without the patch:
    Resolving localhost... ok
    Connecting to 127.0.0.1:993... connect: Connection refused

With the patch:
    Resolving localhost... ok
    Connecting to [::1]:993... connect: Connection refused
    Connecting to [fe80::1%lo0]:993... connect: Connection refused
    Connecting to [127.0.0.1]:993... connect: Connection refused
    Error: unable to connect to server.

Using the hostname instead of the IP address here wouldn't be very useful.
