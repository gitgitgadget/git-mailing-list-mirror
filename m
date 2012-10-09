From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: 'git grep needle rev' attempts to access
 'rev:.../.gitattributes' in the worktree
Date: Tue, 9 Oct 2012 19:01:44 +0700
Message-ID: <20121009120144.GA8780@do>
References: <5073E87D.9020100@viscovery.net>
 <CACsJy8BFmUr5_E47900T6j9Lgdvj96_dNbo2LHP5hLYq3w7ZLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:02:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLYVl-0006NS-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 14:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab2JIMBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 08:01:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40268 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab2JIMBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 08:01:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5083238pbb.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8gQ1iGtkUQTvxUY82yH6OPCPJABEw0VCRXF7Q3tOHhM=;
        b=WdguNKmwXtNzVAAtie2W15IfCfy1MtPH1Hraq4xfp9wDBFLop6cRJ7Yu452rHUrA9c
         P092Ojmqt+ubBJLJRLq6k3A+J2x6AWTYqSGQmVmmkhVXbkqEnIiMsBBzN84QTVxT/C5I
         9QQ7XmNHD4iA6Rl7ovIRsv78VduS2X7Ts2sNC0AHCvfVVU/XsGEtzT4eA5nOhGv6qMk0
         ySpLooQOxKq+MtPkOOiM6Lw4CFOk7PMDVctbKe9zoHXmUdzVXWVvnaUCy7TDOGemCL+o
         dh+R1cshgOSmE2ft9EPq+M7AI5XnNiN3NT9O4wCvmYrNGpSupSv/62AtXPvJ0ULeds5R
         2RFA==
Received: by 10.68.225.7 with SMTP id rg7mr64032099pbc.32.1349784112366;
        Tue, 09 Oct 2012 05:01:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id w10sm12487323paz.22.2012.10.09.05.01.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Oct 2012 05:01:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 09 Oct 2012 19:01:44 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8BFmUr5_E47900T6j9Lgdvj96_dNbo2LHP5hLYq3w7ZLA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207317>

On Tue, Oct 09, 2012 at 04:38:32PM +0700, Nguyen Thai Ngoc Duy wrote:
> #5  0x0815e736 in userdiff_find_by_path (path=0x820e7f0
> "HEAD:Documentation/.gitattributes") at userdiff.c:278
> #6  0x081058ca in grep_source_load_driver (gs=0xbfffd978) at grep.c:1504

A bandage patch may look like this. But it does not solve the real
problem:

 - we should be able to look up in-tree .gitattributes, not just
   ignore like this patch does

 - gs->name seems to be prepared for human consumption, not for
   accessing files. grep_file() with opt->relative is true can put
   quotes in gs->name, for example.

I feel like we should make this function a callback and let git-grep
deal with driver loading itself.

-- 8< --
diff --git a/grep.c b/grep.c
index edc7776..c5ed067 100644
--- a/grep.c
+++ b/grep.c
@@ -1501,7 +1501,8 @@ void grep_source_load_driver(struct grep_source *gs)
 		return;
 
 	grep_attr_lock();
-	gs->driver = userdiff_find_by_path(gs->name);
+	if (gs->type == GREP_SOURCE_FILE)
+		gs->driver = userdiff_find_by_path(gs->name);
 	if (!gs->driver)
 		gs->driver = userdiff_find_by_name("default");
 	grep_attr_unlock();
-- 8< --

-- 
Duy
