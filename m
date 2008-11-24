From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Best practices for maintaining a subversion mirror?
Date: Mon, 24 Nov 2008 10:37:35 -0500
Message-ID: <eaa105840811240737t37578c8dp77adf5da27ac7e45@mail.gmail.com>
References: <5641883d0811240255i21aef729ld202bd5a3211dad9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Oliver Charles" <oliver.g.charles@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 16:39:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4dWY-0000m6-V5
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 16:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbYKXPhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 10:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbYKXPhi
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 10:37:38 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:40692 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbYKXPhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 10:37:38 -0500
Received: by yw-out-2324.google.com with SMTP id 9so845265ywe.1
        for <git@vger.kernel.org>; Mon, 24 Nov 2008 07:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=TkwuVVCSMK3H+6aGMFDUgy+pvL/uQF1OJ6UQhuQ0Wu8=;
        b=iVt222Ntw0nCyrFSYJIaNEImxqgM88OwkCCHsJbUDNvm9JfUgBKCYKH3k7yN755OCJ
         NilEdJhqDUIsltS4qZY8Z6zahSOS7ADTmCOQXy4depioLkiUhAjmLBBC0rC5kH1BE2je
         znKxpRiid0g97saqPQl3Z+YjKs+sLijPUQCoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ZZR4MsGRdOIgvFHjnNcb2gBbbmmss230CltZOsvihDfy8+tTCXYYvbCKSNbtHF07C0
         XFZejUZV2w0EApPa+8EAsnOe1oSpTTjviXaSAVWPFvj5v3eVGKLFrtHeclKJtvA1Aiti
         OpNGLFkz8DmypbK33f4ovDaSETIVccYHv8naI=
Received: by 10.65.214.19 with SMTP id r19mr3441191qbq.20.1227541055938;
        Mon, 24 Nov 2008 07:37:35 -0800 (PST)
Received: by 10.65.177.2 with HTTP; Mon, 24 Nov 2008 07:37:35 -0800 (PST)
In-Reply-To: <5641883d0811240255i21aef729ld202bd5a3211dad9@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 36f4c7756560241d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101609>

On Mon, Nov 24, 2008 at 5:55 AM, Oliver Charles wrote:
> This seems to be working nicely as a readonly interface, but when I
> clone this repository (git clone git://foo/repo.git) - served via
> git-daemon - I can't seem to get svn rebase to work on it, which means
> I can't dcommit my changes back to Subversion.
>
> Am I doing things generally the right way, or am I doing it completely
> wrong? :-) Any tips appreciated!

First, make sure you aren't using the --no-metadata flag. git svn
rebase needs that metadata to rebuild its index.

Second, a simple "git clone" will not set up the svn remotes; you have
to do that by hand. This is what I do when I clone my svn mirror:

mkdir project
cd project
git init
git remote add origin git://mirror/project
git config --add remote.origin.fetch +refs/remotes/*:refs/remotes/*
git fetch
git svn init -Ttrunk svn://upstream/project
git config --add svn-remote.svn.fetch branches/foo:refs/remotes/foo
git config --add svn-remote.svn.fetch branches/bar:refs/remotes/bar
git reset --hard trunk
git svn rebase

Once you have it nailed down, you can put it into a script so all your
co-workers don't have to do that by hand too.

(Also, I quickly reset my cron job to run every five minutes; I found
an hour was way too long for my taste. YMMV, of course)

Peter Harris
