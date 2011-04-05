From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Share color list between graph and show-branch
Date: Tue, 05 Apr 2011 09:29:16 +0200
Message-ID: <201104050929.17135.johan@herland.net>
References: <1301535506-1166-1-git-send-email-dpmcgee@gmail.com>
 <7v7hbbcfoj.fsf@alter.siamese.dyndns.org>
 <BANLkTint1+c0h9DExydWeeafdgawEJPuMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 09:29:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q70ha-0000cW-I2
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 09:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab1DEH3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 03:29:21 -0400
Received: from smtp.getmail.no ([84.208.15.66]:37899 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab1DEH3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 03:29:20 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJ600MKB4SUIN90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 05 Apr 2011 09:29:18 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D4D801EA56B1_D9AC4CEB	for <git@vger.kernel.org>; Tue,
 05 Apr 2011 07:29:18 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id B93261EA2E65_D9AC4CEF	for <git@vger.kernel.org>; Tue,
 05 Apr 2011 07:29:18 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJ600CPQ4SUYG20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 05 Apr 2011 09:29:18 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <BANLkTint1+c0h9DExydWeeafdgawEJPuMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170872>

On Tuesday 05 April 2011, Dan McGee wrote:
> On another note, we also have this whole crazy "- 1" bit and the RESET
> element at the end, and yet I see nowhere that slot is actually used.
> It looks like this was introduced by commit 1e3d4119d21df28.

Read that commit again. You'll see that in graph.c:strbuf_write_column() it 
replaces

  strbuf_addstr(sb, GIT_COLOR_RESET);

with

  strbuf_addstr(sb, column_get_color_code(column_colors_max));

which resolves to the same thing. The reason for that extra indirection is 
to enable replacing the column_colors_ansi array with a different color 
array, to do graph coloring in non-ANSI contexts. Specifically, it was done 
to enable HTML/CSS coloring of graphs in CGit: 
http://hjemli.net/git/cgit/commit/?id=268b34af23cdcac87aed3300bfe6154cbc65753e

It should be obvious that if we replace the ANSI coloring scheme with some 
other coloring scheme, we also need to change the RESET entry (resetting a 
HTML "color" with the ANSI reset code is nonsense). Therefore I opted to 
move the RESET code into the column_colors array, and make column_colors_max 
indicate both (a) the length of the column_colors array, and (b) the index 
of the RESET code in that same array. That's why we need the crazy "- 1" bit 
when defining COLUMN_COLORS_ANSI_MAX.

BTW, this is documented graph.h:graph_set_column_colors() from the same 
1e3d4119d21df28 commit.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
