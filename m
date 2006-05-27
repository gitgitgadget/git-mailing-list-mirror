From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: [PATCH] Fixed Cygwin CR-munging problem in mailsplit
Date: Sat, 27 May 2006 21:57:29 +0400
Message-ID: <44789309.1030002@Intel.com>
References: <4477262A.5000301@Intel.com> <7virnsk6fe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 19:58:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk33F-00040R-6a
	for gcvg-git@gmane.org; Sat, 27 May 2006 19:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWE0R6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWE0R6F
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 13:58:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:30897 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750999AbWE0R6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 13:58:04 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101-1.jf.intel.com with ESMTP; 27 May 2006 10:58:03 -0700
Received: from fmsmsx331.fm.intel.com (HELO fmsmsx331.amr.corp.intel.com) ([132.233.42.156])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2006 10:58:04 -0700
X-IronPort-AV: i="4.05,180,1146466800"; 
   d="scan'208"; a="42328822:sNHT15851164"
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 27 May 2006 10:58:03 -0700
Received: from mssmsx402.ccr.corp.intel.com ([10.125.2.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 27 May 2006 10:58:03 -0700
Received: from [10.125.11.160] ([10.125.11.160]) by mssmsx402.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sat, 27 May 2006 21:57:58 +0400
User-Agent: Thunderbird 1.5 (Windows/20051201)
In-Reply-To: <7virnsk6fe.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 27 May 2006 17:57:59.0229 (UTC) FILETIME=[170BDED0:01C681B7]
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20864>


Do not open mailbox file as fopen(..., "rt")
as this strips CR characters from the diff,
thus breaking the patch context for changes 
in CRLF files.

Signed-off-by: Salikh Zakirov <Salikh.Zakirov@Intel.com>

---

Junio C Hamano wrote:
> 
> 	git init-db
> 	echo 'abc@' | tr '[@]' '[\015]' >a
>         git add a
>         git commit -m initial
> 	echo 'def@' | tr '[@]' '[\015]' >>a
>         git commit -a -m second
>         git format-patch HEAD^
> 	git reset --hard HEAD^
>         git am 0*.txt
> 

This reproduction scenario results in exactly the same problem.
The problem is observed on Cygwin.
My initial evaluation of the problem turned out to be completely bogus.

I've tracked the problem down to the fopen(file, "rt") in mailsplit.c,
which then truncates the CR character from the patch file.
This changes the patch context lines and it no longer applies.
Changing it to fopen(file, "r") fixes the problem.

> Having said that, CRLF is unsafe for E-mail transfers anyway, so
> I think we would need a special option to tell git-apply that it
> should match '\n' that appears in the patch with '\r\n' in the
> file being patched.  But I do not think that has anything to do
> with the breakage you saw in your reproduction recipe.

My use case does not involve e-mail transfers at all.
I'm using git-format-patch and git-am to rewrite the
patch sequence with different commit messages. 

Unfortunately, some of my fellow developers are not quite
careful, and occasionally some of the source files acquire
CR characters, sometimes in several lines only.

fd405a0843f3efd474bc7897b06d813d6498fbf4
 mailsplit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

fd405a0843f3efd474bc7897b06d813d6498fbf4
diff --git mailsplit.c mailsplit.c
index c529e2d..70a569c 100644
--- mailsplit.c
+++ mailsplit.c
@@ -162,7 +162,7 @@ int main(int argc, const char **argv)
 
 	while (*argp) {
 		const char *file = *argp++;
-		FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "rt");
+		FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
 		int file_done = 0;
 
 		if ( !f )
-- 
1.3.3.gfd40
