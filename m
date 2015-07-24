From: Junio C Hamano <gitster@pobox.com>
Subject: "git am" and then "git am -3" regression?
Date: Fri, 24 Jul 2015 10:48:18 -0700
Message-ID: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 24 19:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIh58-0007hL-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 19:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbbGXRsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 13:48:22 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32997 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbGXRsV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 13:48:21 -0400
Received: by padck2 with SMTP id ck2so17705017pad.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=Qf5DG5H0iWFLvL3bT5/JlHiZ706cdbgQ+kBRvSEysxc=;
        b=FRfpkQI62cmEZ136EQ8JH1z6UKlIuMvlkGyijZ3FMRdDDo1lzVpK7ZlqrtiN+f9dOD
         Lm/IY2iE/XeGYDTps1IGEhR9TTuIeW00u0agfA9AjSsQItAx4ih0C5NI0ezgQ9GOQYb9
         5Tm5eXs4PEbv7Db5pwXd5eYneoqSeqvjqxfui67qQWvgIEBp7liXuxxAhGZDCYb/urYl
         /IrFbvbzdZ3qQuV2g0KqlNwtUUJM2xlQf+mBJwXzuQWqONYvAtLw3pO9GS0OuI9dCgFS
         EZIpOYHIp9O+SPs72a1TaUb0s42Q79Zo23i7aY3Sc7kgkZfvxKVw0Ye85cYaL0DoilzU
         XcoA==
X-Received: by 10.66.139.234 with SMTP id rb10mr33652845pab.118.1437760101419;
        Fri, 24 Jul 2015 10:48:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id cf7sm15791910pac.41.2015.07.24.10.48.19
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 10:48:20 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274574>

Hmm, there seems to be some glitches around running "am -3"
after a failed "am" between 'maint' and 'master'.

When I try the following sequence, the 'am' from 'maint' succeeds,
but 'am' in 'master' fails:

 * Save Eric's "minor documetation improvements" $gmane/274537
   to a file.  

 * "git checkout e177995" (that's "next^0") and then apply them with
   "git am" (no -3 necessary).

 * "git checkout 272be14" (that's "es/worktree-add-cleanup^0") and
   then apply them with "git am" (without -3).

   This is expected to stop at 2/6, as the context has changed
   between 272be14 and the tip of 'next'.

 * "git am -3".  This should restart and resolve cleanly.

Reverting d96a275b91bae1800cd43be0651e886e7e042a17 seems to fix it,
so that is what I'll do for 2.5 final.

I think Paul's builtin-am has the same issues, that would need a
separate fix.

commit d96a275b91bae1800cd43be0651e886e7e042a17
Author: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Date:   Thu Jun 4 17:04:55 2015 +0200

    git-am: add am.threeWay config variable
    
    Add the am.threeWay configuration variable to use the -3 or --3way
    option of git am by default. When am.threeway is set and not desired
    for a specific git am command, the --no-3way option can be used to
    override it.
