From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/7] gitweb: support filename prefix in git_patchset_body/git_difftree_body
Date: Fri, 27 Apr 2007 12:55:22 +0200
Message-ID: <200704271255.24200.jnareb@gmail.com>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699701308-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699713715-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Apr 27 16:46:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhRiV-0003jb-EZ
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 16:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbXD0Oqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 10:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbXD0Oqa
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 10:46:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:2139 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbXD0Oq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 10:46:28 -0400
Received: by ug-out-1314.google.com with SMTP id 44so830809uga
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 07:46:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a64Bb6wVoIMOCI/mNj/QxNqBQXRsrI/+QQDxnbc9aacjMKfSfHJPfpgCdvEZ9HXp7NP3h8gQ68Lh748hlE6OWedhOUUypBfGt1ECIIOPh1DKab2iBV/37qPN66Aac52k3u0sOEv3puk8jUwf3q+QlSTe6+y41AFI3tiLFaJb0yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LXmnbQBle+0NL7IF6zTHhbKVb2ePvBduixz0gkeKO2O/j0ASQRdo/unfUt2+YCmM72uVitor8O1RaPTBiaz3COfIWuJSUjbTC6Tohvo+G9Caff9M5oYe4uYPSkSqwsVwEaO+v/MFWk90xYcIDmxv5Eqq2Ph2+PT7mRovPuT2Ty8=
Received: by 10.67.30.6 with SMTP id h6mr3044922ugj.1177685186958;
        Fri, 27 Apr 2007 07:46:26 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id x26sm5589638ugc.2007.04.27.07.46.24;
        Fri, 27 Apr 2007 07:46:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <11766699713715-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45719>

On Sunday, 15 April 2007, Martin Koegler wrote:
> git_treediff supports comparing subdirectories. As the output of
> git-difftree is missing the path to the compared directories,
> the links in the output would be wrong.

You mean that git-diff-tree output for diff between two non-toplevel
trees lacks the path to compared tree, e.g.
  $ git diff-tree <commit1>:<path1> <commit2>:<path2>
lacks <path1> prefix in the from part, and <path2> prefix in to part,
and the goal is to add those missing prefixes in the links, without
changing the visible output of git_patchset_body/git_difftree_body.
 
> The patch adds two new parameters to add the missing path prefix.

...and makes use of them while generating links.

Although I'm not sure if it wouldn't be better to put e.g.
$prefix_from.$diff{'file'} in $diff{'file_from_url'} or something
like that.

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
> I renamed the parameters to to/from_prefix.
> 
> Modifying the file name in $diff would require bigger changes
> and cause new problems: 
> * new output rewriter for plain view needed
> * for modified files only one file name, but possibly two prefixes

Looks nice, although I think this patch is needed only when we have
"treediff" (and "treediff_plain") views, i.e. when we are able to
compare not only top level trees (like in "commitdiff" view),
or individual files (in "blobdiff" view), but also arbitrary trees.

It can be usefull to compare for example git-gui/ directory in git.git
mainline branch with the root directory from git://repo.or.cz/git-gui
or gitweb/ directory after including gitweb in git repository with the
gitweb.git commits. Although not that useful in first example: there is
as far as I know no development of git-gui directly in git.git
repository so the only difference is that in mainline git-gui stuff
resides in git-gui/ and in git://repo.or.cz/git-gui in top directory

-- 
Jakub Narebski
ShadeHawk on #git
Poland
