From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/6] merge-trees: let caller decide whether to renormalize
Date: Tue, 3 Aug 2010 22:21:10 -0500
Message-ID: <20100804032110.GC19699@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 05:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgUYs-00006g-78
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 05:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab0HDDW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 23:22:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59338 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab0HDDW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 23:22:28 -0400
Received: by ywh1 with SMTP id 1so1782013ywh.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 20:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xmMqswAG1E1PDjVfZxKirxWG7FVmh9xAZ20ltKAIWfc=;
        b=WLB3z8QMV+Yae7KnVIHmxyYOOGtbGYLVg2y8ZAaOG8YYIOEOLz4vgXzVKK8orY8kqz
         YLotnVbCn2fG5oZsPG6EaKjWg9NUkMwexeXudzskNQ2YB18Ny0HB7jjzKoXTJidZ152U
         QFyDgQaZWOcfWjZY9UwPjpmOVjldRiHOh3uBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ipGdl+y3neS1+oxrW7rxkxiUWIIRjQDYZtoY1bskNfpPEgpJDZYuRhgpm8vANBVmRP
         IWXIoC4K900lKKJWvNoLr44kZk7fym7mmmiE0Zf2Q90Zk5xO7WLDB3ZKMmy6RdmhppuM
         7PTVwIckmQKVL4TFIS3iddKp9yQ3WukObC9Js=
Received: by 10.100.134.8 with SMTP id h8mr9233652and.11.1280892147971;
        Tue, 03 Aug 2010 20:22:27 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id a12sm12884534and.16.2010.08.03.20.22.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 20:22:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100804031935.GA19699@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152557>

Add a "renormalize" option to struct merge_options so callers can
decide on a case-by-case basis whether the merge is likely to have
overlapped with a change in smudge/clean rules.  The option defaults
to the global merge_renormalize setting for now.

No change in behavior intended.

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 merge-recursive.c |    3 ++-
 merge-recursive.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2b55fc2..8a49844 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1112,7 +1112,7 @@ static int process_entry(struct merge_options *o,
 	print_index_entry("\tpath: ", entry);
 	*/
 	int clean_merge = 1;
-	int normalize = merge_renormalize;
+	int normalize = o->renormalize;
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
 	unsigned b_mode = entry->stages[3].mode;
@@ -1484,6 +1484,7 @@ void init_merge_options(struct merge_options *o)
 	o->buffer_output = 1;
 	o->diff_rename_limit = -1;
 	o->merge_rename_limit = -1;
+	o->renormalize = merge_renormalize;
 	git_config(merge_recursive_config, o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =
diff --git a/merge-recursive.h b/merge-recursive.h
index b831293..cdb97e9 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -17,6 +17,7 @@ struct merge_options {
 	int verbosity;
 	int diff_rename_limit;
 	int merge_rename_limit;
+	int renormalize;
 	int call_depth;
 	struct strbuf obuf;
 	struct string_list current_file_set;
-- 
1.7.2.1.544.ga752d.dirty
