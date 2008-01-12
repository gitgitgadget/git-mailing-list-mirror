From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 17:46:29 +0300
Message-ID: <20080112144629.GE2963@dpotapov.dyndns.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <alpine.LSU.1.00.0801112127040.31053@racer.site> <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org> <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 15:47:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDhdV-0005KT-8H
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 15:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760194AbYALOqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 09:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759920AbYALOqc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 09:46:32 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:56851 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759886AbYALOqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 09:46:32 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 5F6161870FDF;
	Sat, 12 Jan 2008 17:46:30 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id A419F1870FA6;
	Sat, 12 Jan 2008 17:46:29 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JDhcz-00041F-8g; Sat, 12 Jan 2008 17:46:29 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70320>

On Fri, Jan 11, 2008 at 02:08:35PM -0800, Linus Torvalds wrote:
> 
> However, it's not like there is even a simple solution. The right place to 
> do that check would probably be in "add_index_entry()", but doing a check 
> whether the same file already exists (in a different case) is simply 
> *extremely* expensive for a very critical piece of code, unless we were to 
> change that index data structure a lot (ie add a separate hash for the 
> filenames).

After cursory look at the source code, I wonder if converting name1
and name2 to upper case before memcmp in cache_name_compare() can
help case-insensitive systems. This change will change the order of
file names in the index, but I suppose that it should not be a problem,
because the index is host specific. Though, this fix is too simple, so
I guess, I missed something.

> (And that's totally ignoring the fact that case-insensitivity then also 
> has tons of i18n issues and can get *really* messy 

The proper support of i18n is not simple even without case-insensitivity.
For instance, there are four different encodings widely used for Russian
letters. On Windows alone, you have two simulteniously in the default
settings -- Windows-1251 for Windows applications and CP866 for Console
applications... Actually, some console applications can change its default
encoding, and it seems Cygwin programs do that. So, based on whether you
use gcc from Cygwin or Visual C to compile your console program, you can
get a different encoding. On *nix in Russia, koi8-r and utf-8 are most
popular... So, if you have a repository shared between different systems,
you cannot think about a file name just as a sequence of bytes anymore.
OTOH, I doubt that many people are really interested in using non-ASCII
file names with Git right now.

Dmitry
