From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 12:31:33 +0200
Message-ID: <4C63CD85.10304@viscovery.net>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org> <4C63BD9B.6000608@viscovery.net> <20100812102125.GA19498@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@MIT.EDU>, Elijah Newren <newren@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Aug 12 12:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjV4c-0001lf-Aj
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 12:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371Ab0HLKbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 06:31:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64509 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934Ab0HLKbj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 06:31:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OjV4Q-0008FT-3H; Thu, 12 Aug 2010 12:31:34 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CF1B61660F;
	Thu, 12 Aug 2010 12:31:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100812102125.GA19498@LK-Perkele-V2.elisa-laajakaista.fi>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153363>

Am 8/12/2010 12:21, schrieb Ilari Liusvaara:
> On Thu, Aug 12, 2010 at 11:23:39AM +0200, Johannes Sixt wrote:
> 
>>> * il/rfc-remote-fd-ext (2010-07-31) 4 commits
>>>  - Rewrite bidirectional traffic loop
>>>  - gitignore: Ignore the new /git-remote-{ext,fd} helpers
>>>  - New remote helper: git-remote-ext
>>>  - New remote helper git-remote-fd
>>
>> We do not have EWOULDBLOCK on Windows. Is it needed or could the
>> respective write() loop in remote-ext.c not be replaced by write_in_full()?
> 
> No, the writes can't be replaced by write_in_full() without changing what
> the code does, because write_in_full() retries short writes, whereas current
> code does not retry reads nor writes. And retrying reads/writes in code
> juggling with multiple fds is usally no-no.

builtin/remote-ext.c uses a loop that looks very much like what
write_in_full() does; transport-helper.c's checks for EAGAIN look very
similar to xwrite(). Why can't you reuse these functions?

> The EWOULDBLOCK is needed on some systems if fds involved are nonblocking[1]. I
> think the easiest way to handle system that has EAGAIN but not EWOULDBLOCK
> would be:
> 
> #ifndef EWOULDBLOCK
> #define EWOULDBLOCK EGAIN
> #endif
> 
> [1] Some systems return EAGAIN on read/write failed due to blocking (with
> EAGAIN == EWOULDBLOCK), others return EWOULDBLOCK.

But shouldn't then xwrite() and xread() be extended to check also for
EWOULDBLOCK?

-- Hannes
