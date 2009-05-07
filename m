From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH/RFC] daemon.c: replace inet_ntop with getnameinfo
Date: Thu, 07 May 2009 16:30:43 +0200
Message-ID: <4A02F093.50003@googlemail.com>
References: <4A02D288.6040804@googlemail.com> <4A02D70B.6090305@op5.se> <EC96A79E-4D4E-467A-A10F-D905FE02E508@gmail.com> <4A02DEE3.1080006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, jdl@jdl.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 07 16:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M24cl-0006xH-T6
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 16:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbZEGOat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 10:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZEGOat
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 10:30:49 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38224 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZEGOas (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 10:30:48 -0400
Received: by fxm2 with SMTP id 2so824087fxm.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=sZFieN7g/M6SdBhuAC0aX1rbeEjdtxPwo82YqI2/rzw=;
        b=DCbjCSPTfbZhA/gwk5YFPbEyu8QyUI5hITQisH7eG61T0twNX4hiJgwctmgZ7sJWi8
         yB5RIafLXt9pSbddDxHKtRvaeG0anqupeDr3HKIiFYtXK6gdhI0hc4ciMUX8dGZPwMF9
         +036g0F3EIHFe42YwiENiO5WvdDXoB4yaSWyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=q3bWKv8v313npOL6m6Rmt3auAPofsCyH8gZf/JMRF7ZMBhdTWNDUg5BN/TUMi70Sbc
         OMxCK3559hdN4bN/MZpOALqZKAu3AXgJcmINJDSPfda3scbrmUtEYAnmtOAaQLd+GLWD
         uGFwm8artnzC1LQnVQbR6xiQJg52VNKPjoIOQ=
Received: by 10.103.165.18 with SMTP id s18mr1427360muo.124.1241706647739;
        Thu, 07 May 2009 07:30:47 -0700 (PDT)
Received: from golden.local (p5B01CB42.dip.t-dialin.net [91.1.203.66])
        by mx.google.com with ESMTPS id i5sm364137mue.25.2009.05.07.07.30.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 07:30:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <4A02DEE3.1080006@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118481>

Johannes Sixt schrieb:
> 
> I don't particularly care about git-daemon on Windows at this time because
> we don't build it anyway. But others have already had limited success, and
> they might care since getnameinfo() is not available. If we did have IPv6
> support on Windows, we would indeed have troubles with those path names.

The getnameinfo(3) code is in a #ifndef NO_IPV6 block anyways, so it won't
hurt non-ipv6 builds. afaik getnameinfo(3) is available when getaddrinfo(3)
is and that seems to be the case on newer windows versions.

> But even on non-Windows, a directory name with colons does not look kosher
> to me. Don't they look like PATH values? Or like remote addresses? Are
> IPv6 addresses used in this way by other software?
> 
> Moreover, I think that since IPv6 addresses can have at most one '::'
> abbreviation, but not in an unambiguous way, users of path-interpolation
> of IPv6 addresses are at the mercy of whether and how getnameinfo() makes
> use of '::'.

I did a quick test with apache's VirtualDocumentRootIP and it looks like
they are using :: only when it's unambigous. And yes, they use colons
in the file name.

::1 stays ::1

2001:db8::abab:abab:0:abab:abab becomes 2001:db8:0:abab:abab:0:abab:abab

I don't know if they also use colons on windows because I don't have a
windows box with IPv6 to test.


-->8-->8--

httpd.conf:
VirtualDocumentRootIP /foo/bar/%0

now point your browser to http://[::1]/ and watch your logs.
