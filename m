From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: squelch progress indicator if client does not request sideband
Date: Mon, 15 Jun 2009 22:02:43 -0700
Message-ID: <7vprd4hito.fsf@alter.siamese.dyndns.org>
References: <200906142238.51725.j6t@kdbg.org>
	<20090615145716.GW16497@spearce.org> <200906152324.43435.j6t@kdbg.org>
	<7vski1i2ov.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.0906152109240.16467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 07:02:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGQov-0001qI-DR
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 07:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbZFPFCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 01:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbZFPFCm
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 01:02:42 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44951 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbZFPFCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 01:02:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616050244.ZWDQ17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 16 Jun 2009 01:02:44 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4V2j1c00S4aMwMQ04V2jjb; Tue, 16 Jun 2009 01:02:44 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=GCefh4Sw5xkA:10 a=6VC1-P1-AAAA:8
 a=qAs0gmM5Xvq60EJfAQkA:9 a=KkIrL8TCsGpWKajx75Q7gc887J0A:4 a=LRnQQUT8V1QA:10
 a=dk4Mozrj_yGYF3dw:21 a=522HgM-jvlPjZ67X:21
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.00.0906152109240.16467@xanadu.home> (Nicolas Pitre's message of "Mon\, 15 Jun 2009 21\:16\:46 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121653>

Nicolas Pitre <nico@cam.org> writes:

>>      How did we drive upload-pack over native or ssh connection before we
>>      introduced sideband?  I vaguely recall that we relied on stderr going
>>      to the invoking terminal in the local case.  With this change, does
>>      the user suddenly stop seeing progress if the client is older than
>>      583b7ea (upload-pack/fetch-pack: support side-band communication,
>>      2006-06-21)?  If so, that would be a regression.
>
> Native, or git:// style, certainly never was able to get any kind of 
> progress display without sideband support.
>
> As to old clients using ssh... well... that could be a regression.  But 
> do we really care?  This is pre v1.4.1 after all, and even the previous 
> Debian stable was using a later git version.

I guess both ssh and local would regress, and we do care about regressions
in general, but I think it is not a grave offense in this case, because
the combination between such an old fetch and the updated upload-pack will
still transfer the objects and will update the refs as expected; only the
progress indication and chatter on the stderr stream will be lost.

So I would say it is Ok to regress in this particular case, _if_ there is
no easy way to avoid it.  That was why I asked:

>> I think it is a very good idea to squelch progress output that will never
>> go to the client (it will be wasted traffic, regardless of the "syslog"
>> thing), but
>> 
>>  (1) Is "not using sideband" the same as "client won't see the progress
>>      output" for all vintages of clients that work with the current
>>      server?

Stated differently, I think "not using sideband _and_ spawned via daemon"
would be an indication that "the client won't see the progress anyway even
if it were sent."  So the question becomes "will it be a small enough
change to detect if the upload-pack is driven by the daemon in the
codepath J6t added 'if (!use_sideband)' to, and if so shouldn't we do so?"
