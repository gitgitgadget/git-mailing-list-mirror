From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: cg-clone, tag objects and cg-push/git-push don't play nice
Date: Wed, 19 Oct 2005 19:38:16 +1300
Message-ID: <46a038f90510182338k6d3d52fbyc2057e9b775d5b14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 19 08:40:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES7br-00061O-F6
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 08:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbVJSGiR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 02:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbVJSGiR
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 02:38:17 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:45596 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751550AbVJSGiQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 02:38:16 -0400
Received: by qproxy.gmail.com with SMTP id v40so18770qbe
        for <git@vger.kernel.org>; Tue, 18 Oct 2005 23:38:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eEw6BMy/zjaE3G4VkKJYrxNoDG2rIcaPNwgZayM/8qVbNZDoy1BATMo1FWmvTbpXMv0IkcA+0lw3ktuDkfWfKZcDhzzniKG9+00qI33Bahu+EQwMzl18oi9Ln1fpiG9Im7ULhXqP7uqagvdkDbR8wNA5vhGS07ZjUa1Oixz/awA=
Received: by 10.65.205.15 with SMTP id h15mr222062qbq;
        Tue, 18 Oct 2005 23:38:16 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Tue, 18 Oct 2005 23:38:16 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10267>

I am seeing very strange issues with cloning one head with cg-clone
from a repo that holds many heads and tags. The session looks like
this:

  cg-clone git+ssh://locke.catalyst.net.nz/var/git/moodle-test.git#mdl-topnz
testdir
  cd testdir
  echo "sillychange" >> version.php
  cg-commit -m "testing" version.php
  cg-push
  updating 'refs/heads/mdl-topnz' using 'refs/heads/master'
    from 06ca8b3c4826d60e8cf5850c6474e66f816ba5c7
    to   482d4b88aa482dfea7f7549470902049a050020a
  fatal: bad object 1b0efdd8f31e5b8c7d32c85d11492db122b62a0a
  Packing 0 objects
  Unpacking 0 objects

  error: unpack should have generated
482d4b88aa482dfea7f7549470902049a050020a, but I can't find it!

I get the same error if I try git-push manually. Apparently, there's a
set of tag objects pointing nowhere.

git-fsck-objects --full --strict 482d4b88aa482dfea7f7549470902049a050020a
bad sha1 file: .git/objects/44/7472d455667e426a96acf116e27c2f1efe674e
3ae8dc25c642d8c59f3c44c5ba48faa6a0e7a2ee
2ddfec0dfd0cffd4892af9aaf48ee29c40c7ada3
missing commit 1b0efdd8f31e5b8c7d32c85d11492db122b62a0a
dangling commit 3e9472b3ef980e667d00d5374ccfa741cfb93fbc
broken link from     tag 447472d455667e426a96acf116e27c2f1efe674e
              to  commit 1b0efdd8f31e5b8c7d32c85d11492db122b62a0a
dangling tag 447472d455667e426a96acf116e27c2f1efe674e
missing commit 5a0bdfb0f7af34d002c6ced40f96f977fd6471e2
dangling commit 715b3b0a7c94cb31760e87a320f0f612b962e3c3
missing commit 961bf469c6b309b8fc10d064368fd14480d231be
broken link from     tag 984bed44df42422839705aa4bd6d8f00086b1307
              to  commit 961bf469c6b309b8fc10d064368fd14480d231be
dangling tag 984bed44df42422839705aa4bd6d8f00086b1307
broken link from     tag ce3602d6a60c648402048b0970657a2961e1ed54
              to  commit dd8c6c172fbab9905dd306c17d83b8d21ea5bfda
dangling tag ce3602d6a60c648402048b0970657a2961e1ed54
missing commit dd8c6c172fbab9905dd306c17d83b8d21ea5bfda
broken link from     tag ddb658d070ba6688541e5b91e963f629ddd63b6a
              to  commit 5a0bdfb0f7af34d002c6ced40f96f977fd6471e2
dangling tag ddb658d070ba6688541e5b91e963f629ddd63b6a

Now, if I go to the repository, it _has_ all the tags with their
matching commits. So the problem is in the cloned repo. It looks like:

 + cg-clone (cg-fetch actually) has brought in all the tag refs and
objects, regardless of whether they are relevant to this branch, but
did not fetch the commits, trees, or any other related bits and
pieces.

 + git-push is trying to walk all the refs it knows about when it does
the "what do I have that the repo doesn't" part, and it breaks on
those incomplete tag fetches.

Removing  .git/refs/tags/* didn't help. If I actually rm all the
problematic tag objects from the object repository, I can then push
correctly. Lucky it wasn't packed.

I am going to write a quick'n'dirty script to fix our repos when this
happens, and I'll try my hand at a patch to cg-fetch. Can git-push be
taught to be smarter in these cases?

regards,



martin
