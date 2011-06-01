From: Dmitry Ivankov <divanorama@gmail.com>
Subject: git clone (ssh://) skips detached HEAD
Date: Thu, 2 Jun 2011 03:30:37 +0600
Message-ID: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 23:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRt00-0004Ns-I5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 23:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759797Ab1FAVaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 17:30:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61880 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758951Ab1FAVaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 17:30:39 -0400
Received: by ewy4 with SMTP id 4so78471ewy.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=XhjJuDSXz4qKeH+S78YoQi4TDFmqugpMfBlRl6ts9+w=;
        b=Lpu0U13geiJG0orpcCM5+SRgz+y5AWJprXY0rLhR2Vjay3NgUctN8Nu7OdNM9NEnp0
         4VxUEFctm2WI/qg2G0NuLYVOc2hj7SbvK4ViA9HqT4lwRZrrLDcIwf+ZYMNDM6MUkKhA
         hfLm+fCglK1VazSF6VZhRC6Ix1oho1gNeuZ6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=w6tn1aRd2UwU4HpTqsYpXlnvngt5OnCP8PPN6G2t9hCdPYH+eX8gXp3sozqdjQZ1W9
         /pV4vAdKj1ard5jr9sghSLmoS5s9gTKVfNa0EV3saIo7+Du7cI144g7QI8g4NDvvCscj
         BQ1hNXVN5yjYecXUv4oZ4FYStWrisNp8O8OVM=
Received: by 10.14.25.144 with SMTP id z16mr3140770eez.61.1306963837902; Wed,
 01 Jun 2011 14:30:37 -0700 (PDT)
Received: by 10.14.22.4 with HTTP; Wed, 1 Jun 2011 14:30:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174904>

For some reason git doesn't try to fetch detached HEAD object if it's
not needed by needed heads.
It could be just work on top of detached HEAD or checked out remote branch.

Steps to reproduce:
git init test && cd test
touch 1 && git add 1 && git commit -m 123
touch 2 && git add 2 && git commit -m 345
git reset --hard HEAD^
git checkout HEAD@{1}

cd ../
git clone ssh://127.0.0.1/`pwd`/test test2

remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (3/3), done.
error: Trying to write ref HEAD with nonexistant object
91dbc2403853783f637744c31036f94a66084286
fatal: Cannot update the ref 'HEAD'.

HEAD seems to be treated in a special way in various places, so
haven't found any easy patch to fix this.

And by the way, clone --no-hardlinks test test2 still goes to is_local
codepath and avoids the bug.
