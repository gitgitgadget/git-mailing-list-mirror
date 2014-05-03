From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Sat, 3 May 2014 07:52:10 +0700
Message-ID: <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat May 03 02:52:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgOC6-0000ct-Op
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 02:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbaECAwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 20:52:43 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:57993 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbaECAwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 20:52:42 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so1088017qgd.1
        for <git@vger.kernel.org>; Fri, 02 May 2014 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l9DfM900LwKuEGEObGPnMcF79H3pl48AeRHJ+4m1T4c=;
        b=JETFTsfXd8Gtj93xcUD9nvOMnsAbEikGqeJftKVxa5JWp81VDV9g1XbW2/bMWuUGnb
         nlzTGE0qN3t0Zf3tCSpPE9WwmxSE5e2ZWrkUzPYm9cvc0k3U/IUxNEz+R6sbRYn94M/g
         k0Z2vq/VSwS/mOcJoY6IsiLin7pG9JWB1xqAqvh5ukqAchLnXYzV1EVztC+sVq1zCRDi
         e+v1/uUZTQbntCHmw4yDHeus/db08eav8WgG8Cdr0yvxxJ7RgxoE43t9NKlE7s9uSoBN
         bb/2HS68qNCpjfTAbN0s5p/z7TwCqA8HU9JkeT746efATW2tEiRzowZYCGgvD4hnUN8i
         Isqg==
X-Received: by 10.224.47.8 with SMTP id l8mr26999475qaf.24.1399078362008; Fri,
 02 May 2014 17:52:42 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 2 May 2014 17:52:10 -0700 (PDT)
In-Reply-To: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248013>

On Sat, May 3, 2014 at 6:14 AM,  <dturner@twopensource.com> wrote:
> The index format change might be less important with the split index;
> I haven't investigated that since at the time I wrote these patches,
> it didn't exist.

This is the worst case scenario of "git status" on webkit.git (182k
files, path name 74 byte long on average), hot cache, no SSD

   366.379ms gitmodules_config:199 if (read_cache() < 0) die("index file
     0.004ms cmd_status:1294 read_cache_preload(&s.pathspec);
   488.433ms cmd_status:1295 refresh_index(&the_index, REFRESH_QUIE
   456.495ms cmd_status:1299 update_index_if_able(&the_index, &inde
    13.088ms wt_status_collect:616 wt_status_collect_changes_worktree(s)
   706.926ms wt_status_collect:621 wt_status_collect_changes_index(s)
   100.495ms lazy_init_name_hash:136 { int nr; if (istate->name_hash_initia
   921.185ms wt_status_collect:622 wt_status_collect_untracked(s)

real    0m2.969s
user    0m1.943s
sys     0m1.021s

Index v4 and split index (and the following read-cache daemon,
hopefully) should help reduce numbers of the 1st and 4th lines, I
expect to less than 50ms each line. lazy_init_name_hash could be taken
away with read-cache daemon also.

core.preloadindex can cut the total number of 2nd and 3rd lines by
half. Watchman should help in these two lines, but it should do better
than core.preloadindex.

wt_status_collect_changes_index() depends on how damaged cache-tree is
(in this case, totally scraped). watchman does not help this either.
We need to try to "heal" cache-tree as much as possible to reduce the
number.

The last line could be a competition between watchman and my coming
"untracked cache" series. I expect to cut the number in that line at
least in half without external dependency.

Patch 2/3 did not seem to make it to the list by the way.. initial
reaction is storing the list of all paths seems too much, but I'll
need to play with it a bit to understand it.
-- 
Duy
