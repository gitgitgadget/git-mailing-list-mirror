From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack operation is thrashing my server
Date: Sat, 06 Sep 2008 18:03:40 -0700
Message-ID: <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <20080813145944.GB3782@spearce.org>
 <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
 <20080813155016.GD3782@spearce.org>
 <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
 <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
 <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 03:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc8i6-0007Fh-O2
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 03:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbYIGBDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 21:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbYIGBDz
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 21:03:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYIGBDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 21:03:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B4ADF5EDB1;
	Sat,  6 Sep 2008 21:03:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 90FEE5EDB0; Sat,  6 Sep 2008 21:03:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Fri, 15 Aug 2008 17:34:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D5499F7C-7C78-11DD-8402-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95099>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Interestingly, it turns out that git also hits a sad performance downside 
> of using zlib.
>
> We always tend to set "stream.avail_out" to the exact size of the expected 
> output. And it turns out that that means that the fast-path case of 
> inffast.c doesn't trigger as often as it could. This (idiotic) patch 
> actually seems to help performance on git rev-list by about 5%.
>
> But maybe it's just me seeing things. But I did this because of the entry 
> assumptions in inflate_fast(), that code only triggers for the case of 
> strm->avail_out >= 258.
>
> Sad, if true.

This is reproducible  "rev-list --objects --all" in my copy of the kernel
repo takes around 47-48 seconds user time, and with the (idiotic) patch it
is cut down to 41-42 seconds.

(with patch)
41.41user 0.51system 0:41.93elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+134411minor)pagefaults 0swaps

(without patch)
47.21user 0.64system 0:47.85elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+134935minor)pagefaults 0swaps

One funny thing about your patch is that it also reduces the number of
minor faults; I would have expected that the additional memory wastage
(even though most of the allocated object buffer memory would be freed
immediately as soon as the caller is done with it) would result in larger
number of faults, not smaller, which is puzzling.
