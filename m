From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Tue, 6 Apr 2010 20:16:55 -0700
Message-ID: <20100407031655.GA7156@spearce.org>
References: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com> <alpine.LFD.2.00.1003231945480.31128@xanadu.home> <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com> <alpine.LFD.2.00.1003241133430.694@xanadu.home> <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com> <alpine.LFD.2.00.1003241435300.694@xanadu.home> <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com> <alpine.LFD.2.00.1003241613020.694@xanadu.home> <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com> <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 05:17:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzLlT-0007Pb-2u
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 05:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513Ab0DGDRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 23:17:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63560 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab0DGDRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 23:17:05 -0400
Received: by gwb19 with SMTP id 19so358074gwb.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 20:17:04 -0700 (PDT)
Received: by 10.150.194.2 with SMTP id r2mr836106ybf.92.1270610224560;
        Tue, 06 Apr 2010 20:17:04 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm1852792yxd.35.2010.04.06.20.16.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 20:17:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144191>

Nicolas Pitre <nico@fluxnic.net> wrote:
> To avoid a deadlock if try_to_free_from_threads() is called while
> read_lock is already locked within the same thread (may happen through
> the read_sha1_file() path), a simple mutex ownership is added. This 
> could have been handled automatically with the PTHREAD_MUTEX_RECURSIVE 
> type but the Windows pthread emulation would get much more complex.
...
> +static void try_to_free_from_threads(size_t size)
> +{
> +	int self = pthread_equal(read_mutex_owner, pthread_self());
> +	if (!self)
> +		read_lock();
> +	release_pack_memory(size, -1);
> +	if (!self)
> +		read_unlock();
> +}

Is there any concern that a partially unset read_mutex_owner might
look like the current thread's identity?

That is, memset() can be setting the bytes one by one.  If the lock
is being released we might observe the current owner as ourselves
if we see only part of that release, and our identity is the same
as another thread, only with the lower-address bytes unset.

-- 
Shawn.
