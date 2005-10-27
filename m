From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 02:16:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 27 02:16:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUvRp-0008Iz-U8
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 02:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbVJ0AQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 20:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbVJ0AQr
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 20:16:47 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8157 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751516AbVJ0AQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 20:16:46 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id CF78313F4DE
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 02:16:45 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id BA2239CCE0
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 02:16:45 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id A64808E9A2
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 02:16:45 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 7D88F13F4DE
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 02:16:45 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10696>

Hi,

the fetch-pack/upload-pack protocol as of now goes like this:

- server sends the refs it has, then an empty packet
- client sends what it wants, then an empty packet
- client sends a rev-list via "have" lines in the hope to find a common
  rev. Interspersed, it sends empty packets.
- server answers to those empty packets with a NAK message, until it
  receives a "have" line for a commit it has (and which is therefore a
  common commit). This is answered by an ACK message, and no NAK or ACK is 
  sent after that
- client sends "done"
- server only responds if no common commit was found, with a NAK
- server sends pack

after thinking about my earlier approach, I think there's a better, less 
intrusive, and all in all just simpler approach:

- client asks for multi_ack protocol by sending " multi_ack" at the end
  of at least one "want" line
- server appends " continue" to the ACK message, but continues sending
  ACK (but not NAK) messages
- after receiving "done", server repeats last ACK message without 
  " continue" appended

After much fun with non-working, fragile code which had to be retracted 
from master, I hope that this approach is less prone to errors.

Note that this is incompatible to the multi_ack protocol I described 
earlier, but given that my patches were buggy anyway, I'd say it does not 
matter at all.

Thoughts, comments, objections?

Ciao,
Dscho
