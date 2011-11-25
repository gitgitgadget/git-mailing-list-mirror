From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Fri, 25 Nov 2011 16:43:41 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1111251629500.22588@shipon.roxen.com>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1932422408-1322235821=:22588"
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 16:43:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTxwU-0006k9-FC
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 16:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab1KYPny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 10:43:54 -0500
Received: from mail.roxen.com ([212.247.29.220]:59765 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab1KYPnx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 10:43:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id BD3FA628133;
	Fri, 25 Nov 2011 16:43:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 74IMrMczV0SN; Fri, 25 Nov 2011 16:43:41 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id C740E628160;
	Fri, 25 Nov 2011 16:43:41 +0100 (CET)
In-Reply-To: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185934>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1932422408-1322235821=:22588
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 23 Nov 2011, Henrik Grubbström wrote:

> Hi.
>
> My git repository walker just got bitten by what seems to be a reasonably new 
> bug in convert.c:cascade_filter_fn() (git 1.7.8.rc3 (gentoo)).

After some tracing, the problem is triggered by the variable "remaining"
being set to 1 in the beginning of the cascade_filter_fn() loop, which 
causes filter "two" to be called with an output buffer size of 1.
Filter "two" in this case is lf_to_crlf_filter_fn(), and the next input 
character is a "\n". lf_to_crlf_filter_fn() wants to convert this to 
"\r\n", but that doesn't fit into the buffer, so it breaks out and returns 
zero. Upon seing the zero cascade_filter_fn() thinks all is well, even 
though nothing has happened, and loops.

The bug is probably that lf_to_crlf_filter_fn() should return non-zero in 
this case (ie o and/or i being zero).

> Thanks,

--
Henrik Grubbström					grubba@roxen.com
Roxen Internet Software AB
---559023410-1932422408-1322235821=:22588--
