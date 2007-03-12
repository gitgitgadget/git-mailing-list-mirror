From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 15:08:08 +0100
Message-ID: <20070312140808.GA17450@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx> <20070312121226.GB2268@always.joy.eth.net> <20070312131253.GA16452@moooo.ath.cx> <fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 15:08:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQlCZ-00079p-CV
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 15:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965882AbXCLOIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 10:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965881AbXCLOIO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 10:08:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:39597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965883AbXCLOIL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 10:08:11 -0400
Received: (qmail invoked by alias); 12 Mar 2007 14:08:09 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp044) with SMTP; 12 Mar 2007 15:08:09 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19A2wZN/MdAF6WXHjqewG+er/OGP2z0732JbvBIvI
	Qtd7qca2FLSzuU
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42030>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Let users create $GIT_DIR/workdir themselves. Your way may be less
> confusing to you but might be more confusing to me because I _might_
> expect a relative workdir setting (for example I move the repository
> and the working directory together to another place).

Well, without this patch you havo to do one of these:

    /tmp$ mkdir repository working_directory
    /tmp$ git --git-dir=repository init
    /tmp$ git --git-dir=repository config core.bare false
    /tmp$ echo ../working_directory > repository/workdir

or

    /tmp$ mkdir repository working_directory
    /tmp/repository$ cd repository
    /tmp$ git init
    /tmp/repository$ mv .git/* .
    /tmp/repository$ rmdir .git
    /tmp$ echo ../working_directory > repository/workdir

Where the second example is probably better because git init creates a
bare repository in the first case which might have more settings
different from a 'normal' repository (it actually sets also
core.logallrefupdates = true which probably should be added to the
first example).

With this patch you'd have to do

    /tmp$ mkdir repository working_directory
    /tmp$ git --git-dir=repository --work-dir=working_directory init
    /tmp$ echo ../working_directory > repository/workdir

in case you really want a relative path.

Because the first two ways are so long I think git init should have
some way to handle this case.

I don't want to put $GIT_WORK_DIR 'as is' to $GIT_DIR/workdir because
$GIT_WORK_DIR is normally interpreted as relative path to the current
working directory and not relative to $GIT_DIR.

Perhaps we could add another flag to git init which will be used 'as is'
for $GIT_DIR/workdir:
    git --git-dir=repository init --work-dir=../working_directory

Other things I can think of:

    Add a --not-bare flag to git init:
    $ git --git-dir=repository init --not-bare
    $ echo ../working_directory > repository/workdir

    Tell the user what to do in case the path should be relative:
    $ git --git-dir=repository --work-dir=working_directory init
    You specified a relative working directory and git has
    automatically expanded this to /tmp/working_directory.  If you
    prefer a relative path you can do:
        echo relative_path > repository/workdir
