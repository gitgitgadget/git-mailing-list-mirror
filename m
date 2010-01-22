From: Jay Soffian <jaysoffian@gmail.com>
Subject: git-svn question: adding a branch to a local clone of an upstream 
	git-svn clone
Date: Fri, 22 Jan 2010 14:15:10 -0500
Message-ID: <76718491001221115r56c1f6e4qbf6cecc30ce4af58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:23:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYP6I-0004N6-4m
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 20:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab0AVTXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 14:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560Ab0AVTXP
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 14:23:15 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:58001 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab0AVTXO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 14:23:14 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2010 14:23:14 EST
Received: by iwn16 with SMTP id 16so401709iwn.33
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 11:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=ES2efYR6DmnahhPc1s5x8p7OfqQnShJMqJ++HZyV9Xw=;
        b=Xl3urOle33LGViuMili+C8dTImqoD87UslfZOlYoH5X4nTfDLuwRb9Y6uIOErubzQU
         fljj53H/IFw/QWSLHT3hEXIBNEZm7IUNnWacmPiBXD0T2JR1fjeDFPd+zCWkS07QbiyY
         K2TP8WI68n6fpwVuhmJSXrvQ9NNTkBTu92PYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=JybfQwwDPUHtFzdsl7eqb0gDwuIOJAnLoCDuW+JSdBxqaGeIZAcwIBQ/Seq05dQywj
         X3+srLnPQMUnPAWvy288mmaVy6w42WfykF7vHM8LSWDJ9tfcD1BFM1RUHC7UvqVr5sWZ
         2Kkc2L/duxdk+U6JmYn9YotOEwVPsb5/pp5Cg=
Received: by 10.231.154.197 with SMTP id p5mr2425945ibw.28.1264187710585; Fri, 
	22 Jan 2010 11:15:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137775>

I have a clone of a repo that is itself a git-svn clone:

git://git.chromium.org/chromium.git

So my .git/config has (obviously):

[remote "origin"]
	url = git://git.chromium.org/chromium.git
	fetch = +refs/heads/*:refs/remotes/origin/*

The upstream repo has only trunk. I want to use git-svn to add an
additional branch:

http://src.chromium.org/svn/branches/249/

So I added this to my .git/config:

[svn-remote "svn"]
	url = http://src.chromium.org/svn
	fetch = branches/249/src:refs/remotes/branches/249

I looked up the branch point for 249 and created a new branch:

$ svn log http://src.chromium.org/svn/branches/249
------------------------------------------------------------------------
r32060 | laforge@chromium.org | 2009-11-16 11:34:43 -0500 (Mon, 16 Nov
2009) | 1 line

Branching for 249 @32041
------------------------------------------------------------------------
$ git rev2sha | grep src@32041
bf6f4ed svn://svn.chromium.org/chrome/trunk/src@32041
$ git checkout -b 249 bf6f4ed

And then attempted a git svn fetch. Which wanted to grab the entire
svn history. I then realized that the origin git clone is from a
different upstream URL (to which I don't have access), so I tried
adding rewriteRoot:

[svn-remote "svn"]
	url = http://src.chromium.org/svn
	fetch = branches/249/src:refs/remotes/branches/249
	rewriteRoot = svn://svn.chromium.org/chrome

Same problem. Ah, UUID is also different. Unfortunately, git-svn
doesn't have a "rewriteUUID" config (I'm working on a patch), but I
did try hacking .git/svn/.metadata to look like this:

[svn-remote "svn"]
	reposRoot = http://src.chromium.org/svn
	uuid = 4ff67af0-8c30-449e-8e8b-ad334ec8d88c
	svnsync-uuid = 0039d316-1c4b-4281-b951-d872f2087c98
	svnsync-url = svn://svn.chromium.org/chrome

Then changed my .git/config to:

[svn-remote "svn"]
	url = http://src.chromium.org/svn
	fetch = branches/249/src:refs/remotes/branches/249
	useSvnsyncProps = true

I blew away .git/svn/refs and tried again:

$ git svn fetch
Found possible branch point: http://src.chromium.org/svn/trunk/src =>
http://src.chromium.org/svn/branches/249/src, 32041
Initializing parent: refs/remotes/branches/249@32041
r3 = c14d891d44f0afff64e56ed7c9702df1d807b1ee (refs/remotes/branches/249@32041)

Sadly, git svn is still trying to fetch the entire history.

Hmpfh. Any suggestions? Maybe I should just not worry about trying to
have a connected history locally (I'll never be dcomitting) and just
use git svn fetch -r 32041:HEAD ?

j.
