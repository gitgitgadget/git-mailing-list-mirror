From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv3 4/9] pack-objects: Teach new option --max-object-count,
 similar to --max-pack-size
Date: Mon, 16 May 2011 00:31:15 +0200
Message-ID: <201105160031.15339.johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-5-git-send-email-johan@herland.net>
 <BANLkTi=qtA=34=pdXuJ_cQu0pv6BnE2uSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 16 00:33:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLjse-0003eG-BY
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 00:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423Ab1EOWbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 18:31:20 -0400
Received: from smtp.getmail.no ([84.208.15.66]:42034 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935371Ab1EOWbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 18:31:19 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL9009ERD860YB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 00:31:18 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id F2EC01EA5FC3_DD05435B	for <git@vger.kernel.org>; Sun,
 15 May 2011 22:31:17 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id CD8691EA31E0_DD05434F	for <git@vger.kernel.org>; Sun,
 15 May 2011 22:31:16 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL900KLSD838020@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 16 May 2011 00:31:16 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <BANLkTi=qtA=34=pdXuJ_cQu0pv6BnE2uSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173680>

On Monday 16 May 2011, Shawn Pearce wrote:
> On Sun, May 15, 2011 at 14:37, Johan Herland <johan@herland.net> wrote:
> > The new --max-object-count option behaves similarly to --max-pack-size,
> > except that the decision to split packs is determined by the number of
> > objects in the pack, and not by the size of the pack.
> 
> Like my note about pack size for this case... I think doing this
> during writing is too late. We should be aborting the counting phase
> if the output pack is to stdout and we are going to exceed this limit.

The patch actually does this in the --stdout case. Look at the last
hunk in builtin/pack-objects.c:

@@ -2349,6 +2366,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
        if (non_empty && !nr_result)
                return 0;
+       if (pack_to_stdout && object_count_limit && object_count_limit < nr_result)
+               die("unable to make pack within the object count limit"
+                       " (%lu objects)", object_count_limit);
        if (nr_result)
                prepare_pack(window, depth);
        write_pack_file();

So in the --stdout case, we have already aborted before we start
writing the pack (i.e. after the counting phase).

The commit message you quote above, are for the case where someone uses
--max-object-count _without_ --stdout, in which case we compare
nr_written to object_count_limit to determine when to split the pack.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
