From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn and repository hierarchy?
Date: Tue, 3 Mar 2009 14:35:28 -0500
Message-ID: <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com>
References: <20090224223412.GA4573@raven.wolf.lan>
	 <49A50EB2.80300@drmicha.warpmail.net>
	 <20090227171248.GB14187@raven.wolf.lan>
	 <49A826C8.1060300@drmicha.warpmail.net>
	 <20090227220512.GC14187@raven.wolf.lan>
	 <49A97B7A.8010005@drmicha.warpmail.net>
	 <20090303185108.GA11278@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 20:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaQQ-0001Pc-FP
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbZCCTfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 14:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZCCTfl
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:35:41 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:60499 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbZCCTfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 14:35:41 -0500
Received: by qw-out-2122.google.com with SMTP id 5so4329422qwi.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=IFU9X6VlDNa8T4i4mgaJYNk6mYbfLjjGOHVpceR19/0=;
        b=Ob+XCpjWQyewX/Ak/wezPF9K8V1iJrFh4YRtFtrIFfeeRkq19I296TGUPU0OT7uNXm
         t8EUjyNDk3iqHJL3R7UQR/ams1vEQv3v7rLdxbJOuTq283n9D02r412pcmyi77Dj4IMH
         wPX0ELo85P3TjEUOyJNaEkgYod8yrCWEN6XAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=pzu/odOBpXlBKB3idbo1VMbNhQkArpxJsxrIHbmH386AdyJkFhZvnBbPC62TKgAaIV
         g7wV03AzIdcWwMxw6npsFXdtPxD7DaEr3/8Cbrd0DJ5YsPQvgktwLzzeq4QA7ZOFt1FE
         9egd3N9ksjQT53VfbHKQzpPEXST9OdQGX/bpI=
Received: by 10.229.85.11 with SMTP id m11mr4199228qcl.96.1236108929308; Tue, 
	03 Mar 2009 11:35:29 -0800 (PST)
In-Reply-To: <20090303185108.GA11278@raven.wolf.lan>
X-Google-Sender-Auth: 7036277153ff4d0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112156>

On Tue, Mar 3, 2009 at 1:51 PM, Josef Wolf wrote:
> =A0# work on clones, pull work into git-svn-repos when we're done
> =A0#
> =A0for clone in 1 2 3; do
> =A0 =A0(
> =A0 =A0 =A0cd clone$clone
> =A0 =A0 =A0git pull --rebase
> =A0 =A0 =A0for commit in 1 2 3; do
> =A0 =A0 =A0 =A0echo change $clone $commit >>test
> =A0 =A0 =A0 =A0git commit -a -m "commit $clone $commit"
> =A0 =A0 =A0done
> =A0 =A0)
> =A0 =A0(cd git-svn-repos; git pull --rebase ../clone$clone)
> =A0done

Um. This has each clone basing their commits on the work of some other
clone. This line, specifically:

>    (cd git-svn-repos; git pull --rebase ../clone$clone)

breaks the "git-svn-repos only ever pulls from subversion" model I
suggested elsewhere.

Also, this line says "rebase my changes onto those of ../clone$clone",
which isn't what you want. It will end up rebasing svn commits that
the client didn't have on top of the client's commits, and will break
git-svn's index. Don't use --rebase here.

> =A0# Although we have resolved the conflict, spurious conflicts are
> =A0# propagated to the clones

=2E..and this is because you had clones all merge from each other (via
git-svn-repos) *before* the changes were in svn.

Worse, since the git clients don't know that their work has been
rebased, they can wind up conflicting with themselves too. Which is
why I suggested "git svn dcommit" from each client, not from the
central repository.

This can be made work if you do something more like (untested):
    (cd git-svn-repos; git pull ../clone$clone topic-branch;
    git svn dcommit)
    (cd clone$clone; git checkout master; git pull;
    have a human verify that changes to master are correct;
    git branch -D topic-branch)

instead of

>    (cd git-svn-repos; git pull --rebase ../clone$clone)

ie. throw away each topic branch as you push it to git-svn-repos, and
take the changes that have gone through git-svn back via a pull of
master.

But that starts to look to me like more work for each clone than "git
svn dcommit" - YMMV, of course.

Peter Harris
