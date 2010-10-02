From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/7] environment: use alloc_permanent() for computed
 git_dir and co
Date: Sat, 2 Oct 2010 03:39:58 -0500
Message-ID: <20101002083958.GG29638@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:43:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xgX-0004zT-Vb
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab0JBInI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:43:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35005 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab0JBInH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:43:07 -0400
Received: by iwn5 with SMTP id 5so4742304iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=m6ufvJAOB3u0x/a+cHivZwiI7g/FGROM67q2JPyxp00=;
        b=HaMIX4EqRMk+cxADAuNSGeQGbZ3Zbub8L/rpMEb5v0EpnoMkztNFFTNnIcWRy+uHoG
         e5DqqJM2HpILCCkM1QUsev4kyklDIzs+3iZI/eU7zYm1rWf3hhys6N/07mSn863tCTtR
         6fy+fYnZ543z9r0GEbp4uNCUsO+DtFjHT+/So=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mu4OfChKXEwOnkGI1kUZGYF8boA49CNfuAA98tuM52Wv1YYoYSldN8JnkhbNkrNb81
         j9tW3FbsEP4lhcPqr/bTFv7QKlprpx62XxQMpvxqfL6NDkHPJ9VFB+y3FrntqLFc3jCV
         ukRwzgTniiH3eoEapJtfKD6RoGLM4VFzH/Izc=
Received: by 10.231.152.78 with SMTP id f14mr6973715ibw.60.1286008986628;
        Sat, 02 Oct 2010 01:43:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id h8sm2234344ibk.3.2010.10.02.01.43.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:43:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002082752.GA29638@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157801>

The in-core variables to match $GIT_DIR, $GIT_OBJECT_DIRECTORY, etc
come from three sources:

 a) environment variables [getenv("GIT_INDEX_FILE")]
 b) computation [git_pathdup("objects")]
 c) static strings [".git"]

Only in case (b) are they malloc()'d; even in that case, it
would not make sense to free the values until program termination,
when _exit() takes care of freeing all memory already.

So mark the allocations in case (b) as permanent so no one wastes
time trying to fix the leak.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 environment.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/environment.c b/environment.c
index de5581f..9bd18c7 100644
--- a/environment.c
+++ b/environment.c
@@ -89,23 +89,23 @@ static void setup_git_env(void)
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir) {
 		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-		git_dir = git_dir ? xstrdup(git_dir) : NULL;
+		git_dir = git_dir ? strdup_permanent(git_dir) : NULL;
 	}
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 	git_object_dir = getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
-		git_object_dir = xmalloc(strlen(git_dir) + 9);
+		git_object_dir = alloc_permanent(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
 	}
 	git_index_file = getenv(INDEX_ENVIRONMENT);
 	if (!git_index_file) {
-		git_index_file = xmalloc(strlen(git_dir) + 7);
+		git_index_file = alloc_permanent(strlen(git_dir) + 7);
 		sprintf(git_index_file, "%s/index", git_dir);
 	}
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
-		git_graft_file = git_pathdup("info/grafts");
+		git_graft_file = git_pathdup_permanent("info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs = 0;
 }
-- 
1.7.2.3
