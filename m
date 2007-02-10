From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 16:45:33 +0100
Message-ID: <e5bfff550702100745t4467d4eco30b2b66dc7f3bea7@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 10 16:45:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFuPy-0004dS-AB
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 16:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbXBJPpf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 10:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbXBJPpf
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 10:45:35 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:38687 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659AbXBJPpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 10:45:34 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1215431wri
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 07:45:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tj4dUYGziYEltdi2YVTCrzMEjyFpX6Q0pdgHNbKeMbA6ypmABe0HqLyO/XjplfmKmRUMB2n87qf7B8hoakyWiMDfO4jw03E8xyf+WgGuOm9iYaQlmhgxqAWmXQFE5Py8VwafOI9g09exaat17XIflUh1NtvSD7KdS72KVvjFBYo=
Received: by 10.114.131.2 with SMTP id e2mr331413wad.1171122333790;
        Sat, 10 Feb 2007 07:45:33 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 07:45:33 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39230>

On 2/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> Not really. The thing is, git-status does a lot more than what you need.
> And what you need is _only_ what "git diff --name-only HEAD" does already!
>
> It _also_ checks the index, it _also_ only checks the files with different
> stat information, but it does _not_ try to update the index and prepare a
> message to be displayed when committing.
>
> So, what is the big problem about accepting that patching git-status for
> one obscure use is wrong, wrong, wrong, when git-diff already does what is
> needed???
>
Probably I'm doing something wrong, but that's how working dir
detection is currently implemented in qgit:

void Git::getDiffIndex() {

	QString status;
	if (!run("git status", &status)) // git status refreshes the index,
run as first
		return;

	if (!run("git diff-index HEAD", &_wd.diffIndex))
		return;

	// check for files already updated in cache, we will
	// save this information in status third field
	if (!run("git diff-index --cached HEAD", &_wd.diffIndexCached))
		return;

          ...... other stuff .....


The first call to git-status has been there for ages and with the only
goal to refesh the index so to avoid stale data in following 'git
diff-index' calls.

If I have understood correctly you suggest to remove that call because
useless? And rely  'git diff-index' info directly. Of course if there
are no side effects I'will be happy to drop the call, but I'm not sure
it's the safest way to go.

Another option would be to accept a broken working dir detection in
these corner cases. It's a realistic option and probably the best.
Indeed also subsitute 'git status' with 'git runstatus' as long as I
get back _all_ the repo files it seems to me a lesser option, IMHO
it's better failing with empty case than have a big flow of incorrect
data.

Marco
