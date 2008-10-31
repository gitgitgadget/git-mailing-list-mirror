From: "Thanassis Tsiodras" <ttsiodras@gmail.com>
Subject: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 11:43:43 +0200
Message-ID: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 10:45:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvqYu-0002Zh-24
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 10:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbYJaJnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 05:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbYJaJnq
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 05:43:46 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:18473 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbYJaJnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 05:43:45 -0400
Received: by fk-out-0910.google.com with SMTP id 18so956882fkq.5
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=i/Ji5+z7IMTmqtSwup/Dm8jJsnJIHCYD9TPsdGXh7yA=;
        b=RmPVGj22Uau1z+CbmKWK4FLpyVIJUpEN6x5IzQNaGzs+fZ4ZsQiOgXn5hmAcI/w1GJ
         NEU5nUkkNHAMABhrAg0WJ07q6Vc8QtXUZbRvvrSv9Sh7k0pG54lUjinuF9jn/nlvSnmf
         3I1sVOEDyBCz6cG64QGG3yAhswOvHogBFfwq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ame4OGwTdRHDuer0PyMjsLiRDp4C3NVNhU5xPiTcNqfSbu0O4wb3/NAqxSBUB5TCVE
         l8TeSsGrMreSYgUMcD3x/nerxgCwNHfQB+PWwqcgi6KeZmzYyweITijNQspK8DqoUScX
         S6SPir6aATyqcTsU1XR1LPjqV4EybJeq9lt7s=
Received: by 10.181.10.7 with SMTP id n7mr2991341bki.103.1225446223545;
        Fri, 31 Oct 2008 02:43:43 -0700 (PDT)
Received: by 10.181.5.13 with HTTP; Fri, 31 Oct 2008 02:43:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99569>

Hi everyone.

I've been usig Git for the last couple of months and am quite happy with it.
In one of my Git repositories, I am storing uncompressed .tar files
(since being uncompressed allows git to detect and store
only their "real"differences).

However, when I introduce a new filename in the repos (with a minor
set of differences compared to an existing file with a different filename)
I've been unsuccessful in finding a way to tell Git to do it efficiently...

This is what I mean:

bash$ mkdir -p /var/tmp/tst
bash$ cd /var/tmp/tst
bash$ git init
bash$ cp /var/www/renderer-2.0e.tar .
bash$ git add renderer-2.0e.tar
bash$ git commit -m "First version"
bash$ du -s -k .git/
1724    .git/
bash$ cp renderer-2.0e.tar renderer-2.0f.tar
bash$ git add renderer-2.0f.tar
bash$ git commit -m "To add new version, first copy the first, so Git
detects it"
bash$ du -s -k .git/
1740    .git/
bash$ echo Good, Git detected it is the same
bash$ cp /var/www/renderer-2.0f.tar .
bash$ git add renderer-2.0f.tar
bash$ git commit -m "Real new version, slightly different to first"
bash$ du -s -k .git/
3344    .git/
bash$ echo What... did I do something wrong
bash$ xdelta delta renderer-2.0e.tar renderer-2.0f.tar delta
bash$ ls -l
total 7788
-rw-r--r-- 1 ttsiod ttsiod    8181 2008-10-31 11:27 delta
-rw-r--r-- 1 ttsiod ttsiod 3962880 2008-10-31 11:23 renderer-2.0e.tar
-rw-r--r-- 1 ttsiod ttsiod 3993600 2008-10-31 11:25 renderer-2.0f.tar
bash$ git-gc
bash$ du -s -k .git/
1660    .git/

So even though the xdelta is just 8KB, and git-gc actually finds out
that indeed
the new file is very similar to the old one, the initial commit of the
new version
in the repos is not taking advantage.

I found out about this when I tried to "git push" over a PSTN modem...

Then again, I must confess I only did the git-gc after I pushed.
Does the git-push actually take advantage of the similarities only if
I do a git-gc first?

If that is the case, I will create an alias to always git-gc after commits...

--
What I gave, I have; what I spent, I had; what I kept, I lost. -Old Epitaph
