From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jn/svn-fe-maint 0/2] intermittent repo_tree corruption
Date: Sun, 5 Dec 2010 03:33:57 -0600
Message-ID: <20101205093357.GD4332@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120005334.GL17445@burratino>
 <20101130194833.GA9064@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 10:34:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPAzJ-0006OV-Tz
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 10:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab0LEJeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 04:34:17 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51231 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0LEJeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 04:34:16 -0500
Received: by yxt3 with SMTP id 3so4997959yxt.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dnzFk0gE/fxW/5nw3C/F63sttNBT2pFphQdkj7ITH2Q=;
        b=TKwlAOtBDphasNRNzAsI3xFP65aQvdfS1JqadyP8Bw+mEY9Sej4opDTsq/EGnC9kRb
         BizAw8VhGPe7+Yc8ovFji/zRKrUKaGbY0xPNZPkIZllhk6+nRRawFuwaWX00itOhaxml
         O0+u4XGeVWuXAH1Tuc5o49hKr6/fh/PtfJd0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=txAC3FsCZKEKq8tw1B8qRK4wH++9/Z5z+RG9l1EeVobRzyKqDMNiY3aNP0r+CUXqSn
         4IZe/TYCC9ROm82TngUI3poKnKT6gLisbWV1uXx+rgE/BwrlsEWldrXA9dmggizeFY7w
         08OZiO36k45LOF64ZHCKCw6Qjw/grGqci9fMU=
Received: by 10.100.174.17 with SMTP id w17mr2998472ane.15.1291541655608;
        Sun, 05 Dec 2010 01:34:15 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id w4sm4023965anw.16.2010.12.05.01.34.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 01:34:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101130194833.GA9064@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162932>

[mailer usage fail.  resending to git@vger; sorry for the noise]

Hi David,

Jonathan Nieder wrote:
> Jonathan Nieder wrote:

>> +++ b/vcs-svn/svndump.c
>> @@ -181,12 +181,22 @@ static void handle_node(void)
> [...]
>> +		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
>> +			die("invalid dump: cannot modify a directory into a file");
>
> This is tripping for me in a revision like so:
[...] 
>  Node-path: lxanew/DCNsnetwork.cpp
>  Node-kind: file
>  Node-action: add
[...]
> DCNsnetwork.cpp was added in r688, which looks like so:
[...]
>  Node-path: DCNsnetwork.cpp
>  Node-kind: file
>  Node-action: add

This is a bad one.  Currently, repo_copy builds new nodes for all
directories containing the destination directory, like so:

	for each path component:
		find that node, creating if missing
		make sure it is in the active commit (cloning if not)
		set mode to MODE_DIR and set up the next iteration to look there.
	set mode and content based on source path

Unfortunately the "create if missing" and "make sure it is the active
commit" steps call realloc without updating the corresponding
pointers.

svn-fe2 (as contained in git 1.7.3) and svn-fe3 are both affected,
presumably.  Probably existing testing missed this because the
repo_tree pool quickly grows large enough that glibc allocates with
mmap(), with little need to change addresses within a huge 64-bit
address space.

Jonathan Nieder (2):
  treap: make treap_insert return inserted node
  vcs-svn: fix intermittent repo_tree corruption

 test-treap.c        |   11 ++++++++---
 vcs-svn/repo_tree.c |    4 ++--
 vcs-svn/trp.h       |    3 ++-
 vcs-svn/trp.txt     |   10 ++++++++--
 4 files changed, 20 insertions(+), 8 deletions(-)

-- 
1.7.2.4
