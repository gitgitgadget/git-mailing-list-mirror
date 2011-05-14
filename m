From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] add, merge, diff: do not use strcasecmp to compare config
 variable names
Date: Sat, 14 May 2011 15:19:21 -0500
Message-ID: <20110514201921.GA10758@elie>
References: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com>
 <20110514190122.GA16851@elie>
 <BANLkTi=MSfRhUhY1jkRC0agQNp7WHDG9FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 22:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLLKf-0000PT-Vs
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 22:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab1ENUTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 16:19:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45769 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab1ENUT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 16:19:29 -0400
Received: by iwn34 with SMTP id 34so3037525iwn.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Maivc4x4QY88luPvoH5ycFikLBulzSjGXXbDbTKkq5g=;
        b=gMjMxAUxb/+fu4v7d2LfixDusyg1gAStsMcN82dS1uZMV1UwAPExzs9ZF3ET02o6Ye
         VA3CxXsYT8EEKRvhwdnGxChPLH03WT2oL5ZOOS2Z9yDI39HO5bchLPnhQJCYl2GZawD4
         vVjj80EmlbrbeLlUoYbh1Q3wT/CFXioCR3g5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eOABKnZekJDQUcZlJdkp7FxyU8TtGTzxkITiQZ7CEI2unC8s27P73ocX3xjdMcdYlT
         J/f4HpN5Otl5KHG7s94xuwBfHptutrZ70haXTBGZymh4b0h9C7Apkj32+A4XgvBmLjXz
         G3dTb67IxYcuh1dAIZi1ZgCF2mEmOuX6Wjvhg=
Received: by 10.43.54.193 with SMTP id vv1mr3445241icb.338.1305404368378;
        Sat, 14 May 2011 13:19:28 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id jv9sm1356155icb.1.2011.05.14.13.19.26
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 13:19:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=MSfRhUhY1jkRC0agQNp7WHDG9FQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173604>

The config machinery already makes section and variable names
lowercase when parsing them, so using strcasecmp for comparison just
feels wasteful.  No noticeable change intended.

Noticed-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jay Soffian wrote:
> On Sat, May 14, 2011 at 3:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> No need to use strcasecmp --- the vars passed to config functions
>> already have the section and variable names in lowercase.
>
> Okay, it was a cut-and-paste from ignore-errors I think.

Good catch.

 builtin/add.c     |    4 ++--
 merge-recursive.c |    6 +++---
 xdiff-interface.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 704141f..e57abdd 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -331,8 +331,8 @@ static struct option builtin_add_options[] = {
 
 static int add_config(const char *var, const char *value, void *cb)
 {
-	if (!strcasecmp(var, "add.ignoreerrors") ||
-	    !strcasecmp(var, "add.ignore-errors")) {
+	if (!strcmp(var, "add.ignoreerrors") ||
+	    !strcmp(var, "add.ignore-errors")) {
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index ecb1806..07ad1a3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1721,15 +1721,15 @@ int merge_recursive_generic(struct merge_options *o,
 static int merge_recursive_config(const char *var, const char *value, void *cb)
 {
 	struct merge_options *o = cb;
-	if (!strcasecmp(var, "merge.verbosity")) {
+	if (!strcmp(var, "merge.verbosity")) {
 		o->verbosity = git_config_int(var, value);
 		return 0;
 	}
-	if (!strcasecmp(var, "diff.renamelimit")) {
+	if (!strcmp(var, "diff.renamelimit")) {
 		o->diff_rename_limit = git_config_int(var, value);
 		return 0;
 	}
-	if (!strcasecmp(var, "merge.renamelimit")) {
+	if (!strcmp(var, "merge.renamelimit")) {
 		o->merge_rename_limit = git_config_int(var, value);
 		return 0;
 	}
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 164581f..0e2c169 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -347,7 +347,7 @@ int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value, void *cb)
 {
-	if (!strcasecmp(var, "merge.conflictstyle")) {
+	if (!strcmp(var, "merge.conflictstyle")) {
 		if (!value)
 			die("'%s' is not a boolean", var);
 		if (!strcmp(value, "diff3"))
-- 
1.7.5.1
