From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] pack-objects: use ALLOC_GROW
Date: Fri, 8 Oct 2010 11:47:40 -0500
Message-ID: <20101008164740.GD9212@burratino>
References: <20101008005256.GA21738@headley>
 <20101008074320.GB4671@burratino>
 <20101008164536.GB9212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 18:51:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4G9q-0003jT-A0
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 18:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368Ab0JHQux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 12:50:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59496 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756963Ab0JHQuw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 12:50:52 -0400
Received: by ewy23 with SMTP id 23so729023ewy.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oyz5icpfhpB2eb5UH01N2VTFRDfkO/SJg3xSt2ZsaHg=;
        b=XGeOg2eo+T4bZu+w9rAJOFyTTfrY/zDnjpSaXYnJzPfc0JpJcTXqQ02xG0RVbXkhCc
         DzUcIW2xlLgiz930BS7e19zIBVwyJyjtun1F3r10toTUo/4HjAeS/0rNECWgoVwN++RF
         yezztm9QVYaukJTI4jn8I7K4+iZqiOh1564WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b4LXYj35P+wAaBV7ms0ul2EaCDho4bcI+bOtUml4XaH/pL0irl3+o0s6QrjsldN7m5
         0+Gz/aROhp+y492QwO2UpRHZmoiaXmvJNgZvq5pQXBKW8B+G4xFfUFpfVF9WABsB/b/t
         4nUS7g+kO0+exC1WpwbwdO5CtMOplcZPDF0Tc=
Received: by 10.14.37.77 with SMTP id x53mr1700463eea.37.1286556651479;
        Fri, 08 Oct 2010 09:50:51 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u9sm5682344eeh.11.2010.10.08.09.50.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 09:50:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101008164536.GB9212@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158505>

Invoke ALLOC_GROW from cache.h instead of recaping its definition
verbatim.  When this code was first written, the ALLOC_GROW macro
didn't exist yet; now that the macro does exist, it can make the
source a little shorter and more readable.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/pack-objects.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3756cf3..60b792d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -896,12 +896,9 @@ static int check_pbase_path(unsigned hash)
 	if (0 <= pos)
 		return 1;
 	pos = -pos - 1;
-	if (done_pbase_paths_alloc <= done_pbase_paths_num) {
-		done_pbase_paths_alloc = alloc_nr(done_pbase_paths_alloc);
-		done_pbase_paths = xrealloc(done_pbase_paths,
-					    done_pbase_paths_alloc *
-					    sizeof(unsigned));
-	}
+	ALLOC_GROW(done_pbase_paths,
+		   done_pbase_paths_num + 1,
+		   done_pbase_paths_alloc);
 	done_pbase_paths_num++;
 	if (pos < done_pbase_paths_num)
 		memmove(done_pbase_paths + pos + 1,
@@ -2248,11 +2245,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list = 1;
-			if (rp_ac >= rp_ac_alloc - 1) {
-				rp_ac_alloc = alloc_nr(rp_ac_alloc);
-				rp_av = xrealloc(rp_av,
-						 rp_ac_alloc * sizeof(*rp_av));
-			}
+			ALLOC_GROW(rp_av, rp_ac + 2, rp_ac_alloc);
 			rp_av[rp_ac++] = arg;
 			continue;
 		}
-- 
1.7.2.3
