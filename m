From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Thu, 23 Apr 2009 08:23:06 +0200
Message-ID: <49F0094A.6020609@viscovery.net>
References: <cover.1240115957.git.cloos@jhcloos.com>	<d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>	<alpine.LFD.2.00.0904210054190.6741@xanadu.home>	<m3skk2szgv.fsf@lugabout.jhcloos.org>	<alpine.LFD.2.00.0904211319570.6741@xanadu.home>	<m3d4b5oj76.fsf@lugabout.jhcloos.org>	<m34owgoj08.fsf@lugabout.jhcloos.org>	<7vljps324a.fsf@gitster.siamese.dyndns.org> <m3ab68mi3q.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 08:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwsMd-0006xQ-2L
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 08:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZDWGXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 02:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZDWGXR
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 02:23:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43870 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbZDWGXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 02:23:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LwsKw-0000bO-C9; Thu, 23 Apr 2009 08:23:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2247C4E9; Thu, 23 Apr 2009 08:23:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <m3ab68mi3q.fsf@lugabout.jhcloos.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117302>

James Cloos schrieb:
>>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
> 
> Junio> If input_buffer[ret] _were_ the last octet read, [the] loop would
> Junio> be discarding that octet when [it] call[s] more than one xread()
> Junio> to fill the buffer.
> 
> That did sem more likely, but I thought I'd throw out the possibility.
> 
> I just tried instrumenting fill().
> 
> In the first call to fill() during a fetch, xread() returns 4096.  In
> the second call to fill(), xread() returns 4095.  In all subsequent
> calls to fill(), xread() returns 4096 again.
> 
> So, after the second call to xread(), consumed_bytes & 0xFFF == 0xFFF.
> 
> It always follows the pattern:
> 
> xread() read 0x1000 from fd 0 at 0x80a0900
> ret = 0x1000
> consumed_bytes = 0
> input_len = 0x1000
> 
> xread() read 0xFFF from fd 0 at 0x80a0900
> ret = 0xFFF
> consumed_bytes = 0x1000
> input_len = 0xFFF
> 
> xread() read 0x1000 from fd 0 at 0x80a0900
> ret = 0x1000
> consumed_bytes = 0x1FFF
> input_len = 0x1000
> 
> with all subsequent calls reading 0x1000 and adding 0x1000 to
> consumed_bytes, until the final chuck of tha pack is read.
> 
> Also, all calls to xread() where the status lines are being sent from
> the remote server also return 0x1000 octets.  Only the second chunck of
> a pack ever returns 0xFFF.
> 
> I've tested against a number of remote servers and the pattern holds for
> a wide range of remote server versions.
> 
> The pattern also holds for clones over ssh.
> 
> Does anyone have an idea of why the second call to read(2), when
> receiving a pack from a remote, always leaves the last octet of the
> buffer free, whereas all other read(2)s fill it?

You could instrument upload-pack.c. There is an xread() around l.237; does
it aways return 4096? And send_client_data() at around l.254; when does it
send 4096 and when 4095 bytes? Read the comment in this if-branch.

upload-pack is run on the server-side; therefore, you can test this only
on local repositories (unless you can replace upload-pack on the server, too).

-- Hannes
