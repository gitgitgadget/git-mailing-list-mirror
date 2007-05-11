From: "Chris Riddoch" <riddochc@gmail.com>
Subject: Another fast-import/import-tars issue
Date: Fri, 11 May 2007 14:08:18 -0600
Message-ID: <6efbd9b70705111308v47a76b04n9328ebf393a209e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 22:08:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmbPd-0007xu-PE
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbXEKUIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 16:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758961AbXEKUIU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:08:20 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:19476 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742AbXEKUIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:08:19 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1123931nzf
        for <git@vger.kernel.org>; Fri, 11 May 2007 13:08:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rba4TWrm6DEmFXD7bzR1Rq6babNfDaQ/ChDf5Bfu3i+FNNxe/NwP5AjX3R88687EYAgP4aphOBOyqrrV3Z6WbTAH/PHSOCWi12j45hqRcgRMEGTxuz+QvC/QK336E7yLOoNX7AjgyzPfsrS7Y9nkZM09lRh/NhtY2CDwkJGYjKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mzBuZkfCnh9pCBA0an0D0TSQ6USsstRECKNM2msjiq+o5DGFw28JXxo2vWu39NUz2VuTcZ/AjanAmaaDf/0SySOsie6ZoLQ9HhKyBvFoEVQka4DYqqnVoEAf2IayJBax9rShsjKKbMp2EOZe/G4XDJfFV0fDQQeN3m8yrJZDWQc=
Received: by 10.114.12.9 with SMTP id 9mr7301wal.1178914098166;
        Fri, 11 May 2007 13:08:18 -0700 (PDT)
Received: by 10.115.22.19 with HTTP; Fri, 11 May 2007 13:08:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46977>

Hi, folks.

I believe I've uncovered an issue in fast-import, but I don't know the
code well enough yet to debug it.  So, I'll produce my evidence and
let others work on finding the solution.  It should be pretty easy to
reproduce.

First, I'm running: 1.5.2.rc1.9.g6644

Grab the tarball of Perl 5.8.8 - http://www.perl.com/CPAN/src/perl-5.8.8.tar.bz2

Note its md5, just so you know it's not corrupted from the outset.
b8c118d4360846829beb30b02a6b91a7  perl-5.8.8.tar.gz
a377c0c67ab43fd96eeec29ce19e8382  perl-5.8.8.tar.bz2

Try this:

$ tar -xjf perl-5.8.8.tar.bz2
$ cd perl-5.8.8
$ git init
$ git add .
$ git commit -a -m "Import from working tree copy"

Now, for convenience of debugging, I have myself a script I call
~/bin/fast-import-filter.sh:

#!/bin/bash
tee fast-import.log | git fast-import --quiet

Then, I have a slightly-changed ~/bin/import-tars script, like so:

20c20,21
< open(FI, '|-', 'git', 'fast-import', '--quiet')
---
> #open(FI, '|-', 'git', 'fast-import', '--quiet')
> open(FI, '|-', 'fast-import-filter.sh')

Now,

$ import-tars.pl ../perl-5.8.8.tar.bz2

Okay, so the trees pointed to by the tips of the master and
import-tars branches *should* be identical here, right?

$ git diff-tree master: import-tars: | wc -l
229

Not so good.

-- 
epistemological humility
  Chris Riddoch
