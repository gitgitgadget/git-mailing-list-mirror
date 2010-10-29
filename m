From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Restart submodule update --recursive
Date: Fri, 29 Oct 2010 04:12:02 -0500
Message-ID: <20101029091202.GA26442@burratino>
References: <loom.20101028T090353-376@post.gmane.org>
 <20101028181515.GB14212@burratino>
 <loom.20101029T085153-262@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Lukasz Palczewski <l.palczewski@prevac.pl>
X-From: git-owner@vger.kernel.org Fri Oct 29 11:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBl0W-0006Wz-IB
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 11:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409Ab0J2JMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 05:12:15 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51071 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374Ab0J2JMN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 05:12:13 -0400
Received: by ywk9 with SMTP id 9so1827725ywk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yxTakD0xAlT/NPRC/9PMEga7pg6kyZUaPE57jCeRocQ=;
        b=NUBc2dTaUDIa9evXPR9nnDsqjz54LvW0GpONlaX3zMGlt6gmiUBHA4Zz+Q7movFTR0
         vULbOYHzBB7tikoyH6XtHldRTVbXIVbS0mWEkB4d49rqbgR313k1OgH9V6WQkSl2/4AV
         ButlqMHz93PCcluSrY1OovHVsYQeT6yNgwSFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YxGc+KSmTFDhFF5q+C++qzV2TCGLvPsUE/0wbMk9fJtLLxBIXcluL4mKtk5XgkcPIg
         jziNPTicO4XKz2dG0LwrJy/jfldJ2yoVdAH2XbXlMDYLsXkKaAg4yuHu43zhI+xAuskF
         EGX3Hn6OiMfk8/FqDohzShMCC8fQpirq2lTdA=
Received: by 10.150.143.21 with SMTP id q21mr21906918ybd.142.1288343533035;
        Fri, 29 Oct 2010 02:12:13 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m65sm1554331yha.23.2010.10.29.02.12.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 02:12:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20101029T085153-262@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160323>

Hi Lukasz,

[side note: if you use a newsreader, please reply by mail instead of
through gmane so the Cc: list can be preserved.]

Lukasz Palczewski wrote:

> I think modyfying the git-submodule.sh will be better for me. So I looked into
> it and first problem araised: 
> How do I get a name of submodule with a name of a previous submodule?
[...]
> It would be nice if I could get name like this sub1/nsub1 when I am in submodule
> sub1.

What path do you want to get when there are three levels of submodules?

To understand how git-submodule works, it helps to see how low-level it
is.  The core is this function:

 #
 # Get submodule info for registered submodules
 # $@ = path to limit submodule list
 #
 module_list ()
 {
	git ls-files --error-unmatch --stage -- "$@" | grep '^160000 '
 }

which is just reading submodule entries from the index in the current
repository.  Like all index entries, they are attached to paths relative to
the toplevel of the current repository.

To get a path relative to the toplevel of the superproject using module_list,
you need to build it up as you go along.  For example,

	git submodule foreach --recursive 'echo $prefix'

does this (see cmd_foreach).
---
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1ed331c..e9bdbca 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -145,17 +145,21 @@ summary::
 
 foreach::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path, $sha1 and
-	$toplevel:
+	The command has access to the variables $name, $path, $prefix, $sha1,
+	and $toplevel:
 	$name is the name of the relevant submodule section in .gitmodules,
 	$path is the name of the submodule directory relative to the
 	superproject, $sha1 is the commit as recorded in the superproject,
-	and $toplevel is the absolute path to the top-level of the superproject.
+	$toplevel is the absolute path to the top-level of the superproject,
+	and $toplevel/${prefix}$path is the absolute path for any file
+	in the submodule worktree.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given --quiet, foreach prints the name
 	of each submodule before evaluating the command.
 	If --recursive is given, submodules are traversed recursively (i.e.
-	the given shell command is evaluated in nested submodules as well).
+	the given shell command is evaluated in nested submodules as well)
+	and the superproject used to define $toplevel and $prefix is the
+	outermost project.
 	A non-zero return from the command in any submodule causes
 	the processing to terminate. This can be overridden by adding '|| :'
 	to the end of the command.
-- 
