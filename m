From: Dan Johnson <computerdruid@gmail.com>
Subject: [PATCH] fetch --all: pass --tags/--no-tags through to each remote
Date: Sat,  1 Sep 2012 00:25:33 -0400
Message-ID: <1346473533-24175-1-git-send-email-ComputerDruid@gmail.com>
References: <7vr4qmn8va.fsf@alter.siamese.dyndns.org>
Cc: Dan Johnson <ComputerDruid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <ossi@kde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 06:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7fPf-0007td-7D
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 06:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028Ab2IAEdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 00:33:39 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43325 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab2IAEdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 00:33:38 -0400
Received: by yenl14 with SMTP id l14so738989yen.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 21:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8uVALCjp7R/k07KZvzMPDZsz8iXOIiNVZJPIFldg4o8=;
        b=Oa+9Na0cZwpsEY18eHIMNfBu0R+VTnzlnNYvfFoQQsYg0jULWT47T8PD3OeC0pGiVj
         r5osEDzlvOwfg/lhuLwyY62fAag3FMFJdQa5i3Bfq7sQ13ZVAKtfFynVssQkHNiluo5D
         0Czpi4IEyaveDkWA6Cxayrj75DJLqHihCIZLZuHvcAye8lECsfpFgGG7vSj1sMREA1u9
         BrIi1MBbZ5LYITa1iKgO+SowqkoOej7C7Vne/mLVa1S74EvnFwP9NED7AK008TNNm66y
         +ZOFa97GDG52RPGZKzBRWrugbsBgM2c/2K7ZO/CzNehN3fkvnHLUFD1BatWdo0r/1EoE
         8sJQ==
Received: by 10.236.114.72 with SMTP id b48mr10543644yhh.7.1346473519662;
        Fri, 31 Aug 2012 21:25:19 -0700 (PDT)
Received: from localhost.localdomain (c-50-142-147-202.hsd1.tn.comcast.net. [50.142.147.202])
        by mx.google.com with ESMTPS id l7sm12114911yhk.22.2012.08.31.21.25.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2012 21:25:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.59.gbc9e7dd.dirty
In-Reply-To: <7vr4qmn8va.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204615>

Reported-by: Oswald Buddenhagen <ossi@kde.org>
Signed-off-by: Dan Johnson <ComputerDruid@gmail.com>
---

Junio C Hamano <gitster@pobox.com> writes:
>Dan Johnson <computerdruid@gmail.com> writes:
>
>> I believe that is bad interaction with "--all" (probably a bug). If I
>> am remembering correctly, --no-tags is internally a per-remote
>> setting, so I'm guessing it's not getting set on all remotes here.
>>
>> I'll look into this more a bit later tonight. Does fetch --no-tags
>> work when you specify a remote?
>
>Thanks.

And here it is. Apparently we just don't pass those options through. I didn't
look to see if there are any other options we should consider passing through;
it's quite possible there are. I also have not written a test to ensure that
this doesn't break in the future. I will hopefully have time for these things
tomorrow. It's getting too late for me to be able to put sentences together,
so hopefully this mail comes out readable ;)

 builtin/fetch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb9a074..c6bcbdc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -857,6 +857,10 @@ static void add_options_to_argv(int *argc, const char **argv)
 		argv[(*argc)++] = "--recurse-submodules";
 	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
 		argv[(*argc)++] = "--recurse-submodules=on-demand";
+	if (tags == TAGS_SET)
+		argv[(*argc)++] = "--tags";
+	else if (tags == TAGS_UNSET)
+		argv[(*argc)++] = "--no-tags";
 	if (verbosity >= 2)
 		argv[(*argc)++] = "-v";
 	if (verbosity >= 1)
-- 
1.7.11.1.59.gbc9e7dd.dirty
