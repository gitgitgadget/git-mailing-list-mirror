From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 11:11:54 -0400
Message-ID: <5213873A.6010003@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 17:11:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBnbA-0001YD-JG
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 17:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab3HTPLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 11:11:52 -0400
Received: from mail.windriver.com ([147.11.1.11]:44100 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3HTPLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 11:11:51 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r7KFBmnv015229
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 20 Aug 2013 08:11:48 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.2.342.3; Tue, 20 Aug 2013
 08:11:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232610>

TL;DR -- "git apply --reject" implies verbose, but the similar
"git apply --check" does not, which seems inconsistent.

Background:  A common (non-git) workflow can be to use "patch --dry-run"
to inspect whether a patch is feasible, and then use patch again
a 2nd time (w/o --dry-run) to actually apply it (and then work
through the rejects).

You can also do the above in a git repo, but you lose out because
"patch" doesn't (yet) capture the patched function names[1] in the
rejected hunks, making it hard to double check your work.

My initial thought was to replace the above two steps with
"git apply --check ..." and then "git apply --reject ..." so
that I could just abandon using patch altogether.

That works great, with just one snag that had me go reading the
source.  It seems that "git apply --reject" is verbose, and kind
of looks like the identical output I'd get if I used patch.  But
"git apply --check" is quite reserved in its output and doesn't
look at all like "patch --dry-run".  I initially believed that
"--check" was stopping at the 1st failure, based on the output.

Only when I read the source did I realize it was checking all the
hunks silently, and adding a "-v" would make it similar to the
output from "patch --dry-run".

Not a critical issue by any means, but having the "-v" implied
by "--check" (or perhaps having both default to non-verbose?)
might save other users from getting confused in the same way.

Thanks,
Paul.
--

[1] https://savannah.gnu.org/bugs/index.php?39819
