From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: frustrated forensics: hard to find diff that undid a fix
Date: Sat, 5 Mar 2011 06:51:00 -0600
Message-ID: <20110305125100.GA14547@elie>
References: <4D71D63E.3030907@gmail.com>
 <m37hcd7qfv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Monsen <haircut@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 13:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvqx1-00080h-QC
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 13:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab1CEMvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 07:51:09 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59447 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab1CEMvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 07:51:08 -0500
Received: by iwn34 with SMTP id 34so2660176iwn.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 04:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4U1h77DPukE/U/i/V02BMJvtG3/18eKSulbUWHh6IPk=;
        b=tUu1auTvvS9nZc+Q+WEiiK9EElJPxupCkFp3GuyGQL37szVhrF+ZHFGb6KEtT0ha9f
         OxHlbpj5GF+od1eY5LCw2BzsCcHtmF6JJNoTBGHLnD+Y4ehT/x+OBmr39GLU0FSutXWJ
         MIK6IWspF1bpdpIMtRsxyioRyj3xcpqDTHP9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aty5DeqmY+J/hcERPccIVtjJQA1XU2NJLdAkeVYZAGY2EVyh6Z1sZ7Lny4NpIzKN6W
         /+yOvPO195MmFDvTfvmVi3ZIxmZGzkpP5wN7amJQcaUTOQcZjN+nSJogMhT7Ui+vC194
         YopBcoBvJCkEKdjebNmQxXcgeuL32Twgn3rCA=
Received: by 10.231.195.222 with SMTP id ed30mr1224329ibb.114.1299329467577;
        Sat, 05 Mar 2011 04:51:07 -0800 (PST)
Received: from elie (adsl-69-209-58-75.dsl.chcgil.ameritech.net [69.209.58.75])
        by mx.google.com with ESMTPS id u9sm568310ibe.8.2011.03.05.04.51.05
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 04:51:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m37hcd7qfv.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168491>

Hi,

Jakub Narebski wrote:

> I guess that pickaxe also needs -c or -m.

I am not so sure.

Pickaxe is used to ask, "what commit introduced this string?".  Using
"git log --raw -c", I can see that the current state of
contrib/fast-import/git-p4 came about in commit 6d74e5c9d (Merge
branch 'mh/p4', 2011-03-04):

| $ git log --oneline --raw -c
| 07873dc Merge branch 'maint'
| 
| 6d74e5c Merge branch 'mh/p4'
| 
| ::100755 100755 100755 a4f440d... 8b00fd8... 2df3bb2... MM
| contrib/fast-import/git-p4
[...]

Now, working backwards, I ask git:

| $ git log --oneline -S "$(cat contrib/fast-import/git-p4)" maint..master
| $

No hits.  Maybe it's from one of those mergey diffs?

| $ git log --oneline -m -S "$(cat contrib/fast-import/git-p4)" maint..master
| 07873dc (from 964498e) Merge branch 'maint'
| 6d74e5c (from 08fd871) Merge branch 'mh/p4'
| 6d74e5c (from c9dbab0) Merge branch 'mh/p4'
| $

Too many hits (it includes every merge in which one side contains
the string and the other does not).  How about -c, which seemed to
produce such nice output with --raw?

| $ git log --oneline -c -S "$(cat contrib/fast-import/git-p4)" maint..master
| 07873dc Merge branch 'maint'
| 6d74e5c Merge branch 'mh/p4'
| 08fd871 Merge branch 'mg/maint-difftool-vim-readonly'
| 5cb3c9b Merge branch 'jn/maint-commit-missing-template'
| 1538f21 Merge branch 'jk/diffstat-binary'
| 24161eb Merge branch 'lt/rename-no-extra-copy-detection'
| [...]

Oh.  diff_tree_combined_merge simply doesn't know about pickaxe,
so -c and --cc with -S print _all_ merges.

So the only sensible way to use pickaxe with merges is

| $ git log --oneline -m --first-parent \
|	-S "$(cat contrib/fast-import/git-p4)" maint..master
| 6d74e5c Merge branch 'mh/p4'

for now.  I'd be happy to help anyone hoping to improve this.
(Hopefully all that is needed is something like the
diff_queue_is_empty() check from v0.99~504 --- Diffcore updates,
2005-05-22.)
