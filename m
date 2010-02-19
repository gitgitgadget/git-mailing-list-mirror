From: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Fri, 19 Feb 2010 14:08:26 -0500
Message-ID: <20100219190825.GD11733@gibbs.hungrycats.org>
References: <20100214011812.GA2175@dpotapov.dyndns.org> <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org> <201002181114.19984.trast@student.ethz.ch> <7vtytee7ff.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002181456230.1946@xanadu.home> <7v635ub8oa.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002181604310.1946@xanadu.home> <20100219010456.GA1789@progeny.tock> <20100219152609.GC11733@gibbs.hungrycats.org> <7vzl35jeph.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiYDI-0002PD-Mw
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 20:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab0BSTI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 14:08:28 -0500
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:48653 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753183Ab0BSTI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 14:08:27 -0500
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
Received: from gibbs.hungrycats.org (gibbs.vpn7.hungrycats.org [10.132.226.42])
	by ginevra.hungrycats.org (Postfix) with ESMTP id 274E58017;
	Fri, 19 Feb 2010 14:08:26 -0500 (EST)
Received: from zblaxell by gibbs.hungrycats.org with local (Exim 4.69)
	(envelope-from <zblaxell@gibbs.hungrycats.org>)
	id 1NiYDC-0000M1-22; Fri, 19 Feb 2010 14:08:26 -0500
Content-Disposition: inline
In-Reply-To: <7vzl35jeph.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140479>

On Fri, Feb 19, 2010 at 09:52:10AM -0800, Junio C Hamano wrote:
> As you may have realized, racy-git solution actually _relies_ on lack of
> concurrent modifications.  

It relies on 1) no concurrent modifications, 2) strictly increasing
timestamps, and 3) consistent timestamps between the working directory
and index.  Believe it or not, out of those three I actually think the
first assumption is the most reasonable, because it's something a
user could prevent without using administrative privileges or changing
filesystems.

For performance reasons I frequently work with GIT_DIR on ext3 and working
directory on tmpfs (though a mix of ext3 and ext4 has the same issues).
One has second resolution, the other nanosecond.  If two event timestamps
with different precisions are compared as values at maximum precision,
the later event might appear to occur before the earlier one.

I try to avoid using anything that relies on mtime on network filesystems
because a lot more than just Git breaks in those cases.

NTP breakage is rarer, mostly because NTP step events are rare, and
negative ones ever rarer.  I've seen negative steps on laptops when they
lose time accuracy during suspend or when Internet access is unavailable
(or asymmetrically laggy), then get it back later.  On the other hand,
I don't actually test for effects of this event anywhere, so I can't say
it hasn't caused breakage I don't know about, although I can say it hasn't
cause breakage I do know about either.
