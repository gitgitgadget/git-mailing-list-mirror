From: "H. Peter Anvin" <hpa@zytor.com>
Subject: The behaviour of git bisect skip
Date: Mon, 13 Oct 2008 16:42:35 -0700
Message-ID: <48F3DCEB.1060803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 01:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpX4m-0000Ui-Tc
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 01:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422AbYJMXmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 19:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757023AbYJMXmh
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 19:42:37 -0400
Received: from terminus.zytor.com ([198.137.202.10]:56556 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756645AbYJMXmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 19:42:36 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m9DNgZLT010012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Oct 2008 16:42:36 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m9DNgZY4014522;
	Mon, 13 Oct 2008 16:42:35 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m9DNgZLN002397;
	Mon, 13 Oct 2008 16:42:35 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Virus-Scanned: ClamAV 0.93.3/8417/Mon Oct 13 00:34:29 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98164>

I recently had the unhappy experience of trying to bisect a tree with a 
large region of the history obscured by auxilliary bugs.  "git bisect 
skip" will stay in the central region, thus being largely useless.

I was thinking about how to possibly do it better.  This is something I 
came up with, and thought it might be interesing.

a. we obviously cannot move the start and end (good and bad) markers, 
since they have not been shown one way or the other.

b. however, the practice of testing the centermost point is merely the 
*optimal*, corresponding to 1 bit of information per iteration.  An 
off-center test is also possible (as long as the value depends on both 
endpoints, and isn't fixed from one of the endpoints; in that case we 
have a linear search), corresponding to a smaller amount of information 
- for example, sampling at the one-quarter point corresponds to 
3/4*log2(3/4) + 1/4*log2(1/4) =~ 0.811 bits of information.

I would suggest something based on the following algorithm:

Given an interval with a certain number of skip points, subdivide the 
interval into subintervals each separated by a skip point.  Pick the 
centermost point of the *largest* of these intervals.  If there is more 
than one largest interval, choose the one centermost point that ends up 
being centermost in the overall interval.

This algorithm obviously needs some adjustment (as does plain binary 
search) in order to deal with a branched history, but I thought it might 
be an interesting starting point.  It has the desirable property that it 
can make forward progress even in the presence of skip points, and that 
it avoids needlessly searching close to skip points.

	-hpa
