From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH] CMIT_FMT_EMAIL: Q-encode Subject: and display-name part of From: fields.
Date: Tue, 16 May 2006 10:49:50 +0000
Organization: Berlin University of Technology
Message-ID: <20060516104949.GA9641@klaus.daprodeges.fqdn.th-h.de>
References: <7vmzdi9ssv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Tue May 16 12:50:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffx8R-0003s5-JJ
	for gcvg-git@gmane.org; Tue, 16 May 2006 12:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWEPKuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 06:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWEPKuh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 06:50:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:50355 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751765AbWEPKug (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 06:50:36 -0400
Received: (qmail invoked by alias); 16 May 2006 10:49:54 -0000
Received: from cable-62-117-27-26.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.27.26]
  by mail.gmx.net (mp042) with SMTP; 16 May 2006 12:49:54 +0200
X-Authenticated: #1642131
Received: from klaus.daprodeges.fqdn.th-h.de (klaus [192.168.0.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 1223F21185
	for <git@vger.kernel.org>; Tue, 16 May 2006 10:49:52 +0000 (UTC)
Received: from klaus.daprodeges.fqdn.th-h.de (klaus [192.168.0.4])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by klaus.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id F09E7DED00
	for <git@vger.kernel.org>; Tue, 16 May 2006 10:49:51 +0000 (UTC)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmzdi9ssv.fsf@assigned-by-dhcp.cox.net>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: klaus.daprodeges.fqdn.th-h.de (FreeBSD 6.1-STABLE i386)
User-Agent: Mutt/1.5.11-pdmef-20060506074251
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20115>

Hi,

* Junio C Hamano [06-05-16 03:18:24 -0700] wrote:

[...]

> Thoughts?

> If we decide to do the header formatting here, there are two
> further enhancements that need to be done:

> (1) The charset must be configurable for projects that use
>     encoding different from UTF-8, perhaps with the .git/config
>     [i18n] commitEncoding.  It is only a convention, not a hard
>     rule, to use UTF-8 for the metainformation.

To write an encoder really fully conforming to RfC2047 is a mess. Not so
much because the algorithms are difficult but because there're many
things to take care of if you want to do it right.

For example, encoded words are required to be at most something below 80
characters long. For names this maybe is not an issue, but for subjects.
I didn't really check whether your patch produces only the minimum
encoding (i.e. only those words that need it and not just all words with
'_' or '=20' in between them) but if not, 80 isn't that much after all.
And you may need to think about header folding (and unfolding for
reading it back in).

Also, supporting any character set (via iconv()) blows up the
implementation. There're character sets for which other RfCs define the
encoding method so only using quoted-printable is not fully correct in
all possible cases.

And, with the first point, several character sets really can become a
mess as you need to produce several encoded words because the input
would exceed RfC limits otherwise. Because for multi-byte character sets
you musn't break within a multi-byte character sequence but only at
their boundaries. So you need a generic way to detect the byte-size of
such a character in any supported character set.

With just the UTF-8 encoding all of this is pretty simple though.

I would rather try to find a way to implement this in a scripting
language that already has standard modules for this or makes it easy to
write one. In C this gets quite lengthy...

   bye, Rocco
-- 
:wq!
