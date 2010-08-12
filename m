From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 13:21:25 +0300
Message-ID: <20100812102125.GA19498@LK-Perkele-V2.elisa-laajakaista.fi>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@MIT.EDU>, Elijah Newren <newren@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 12:18:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjUrm-0005FV-9d
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 12:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759653Ab0HLKSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 06:18:24 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:57642 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab0HLKSY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 06:18:24 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 62274EF902;
	Thu, 12 Aug 2010 13:18:22 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A071B328E30; Thu, 12 Aug 2010 13:18:22 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id D3C21404C;
	Thu, 12 Aug 2010 13:18:14 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4C63BD9B.6000608@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153361>

On Thu, Aug 12, 2010 at 11:23:39AM +0200, Johannes Sixt wrote:

> > * il/rfc-remote-fd-ext (2010-07-31) 4 commits
> >  - Rewrite bidirectional traffic loop
> >  - gitignore: Ignore the new /git-remote-{ext,fd} helpers
> >  - New remote helper: git-remote-ext
> >  - New remote helper git-remote-fd
> 
> We do not have EWOULDBLOCK on Windows. Is it needed or could the
> respective write() loop in remote-ext.c not be replaced by write_in_full()?

No, the writes can't be replaced by write_in_full() without changing what
the code does, because write_in_full() retries short writes, whereas current
code does not retry reads nor writes. And retrying reads/writes in code
juggling with multiple fds is usally no-no.

The EWOULDBLOCK is needed on some systems if fds involved are nonblocking[1]. I
think the easiest way to handle system that has EAGAIN but not EWOULDBLOCK
would be:

#ifndef EWOULDBLOCK
#define EWOULDBLOCK EGAIN
#endif

[1] Some systems return EAGAIN on read/write failed due to blocking (with
EAGAIN == EWOULDBLOCK), others return EWOULDBLOCK.

-Ilari
