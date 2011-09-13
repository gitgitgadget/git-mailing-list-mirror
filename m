From: Dmitry Ivankov <divanorama@gmail.com>
Subject: git checkout --orphan skips reflogging
Date: Wed, 14 Sep 2011 00:28:50 +0600
Message-ID: <CA+gfSn-tVgj=FYiVGK7kmH4gpnXF3HUbs+f=DfRey6GrpadVYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 20:37:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Xr7-00029O-27
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 20:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187Ab1IMShG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 14:37:06 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44539 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab1IMShF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 14:37:05 -0400
Received: by qyk7 with SMTP id 7so748953qyk.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=zQw1kQsuxugA2yRNtQ0emX18GynCcXIuW9hjOXTDtO4=;
        b=KDBhXBfKxChABtrI8xkuJsshZnJQwLEN6XRNQRd+wy+9++j9Oo/35v7fruCFs0W0ra
         jk8bvz8lAkiTIp/rSxYbLmr/GkhrzrlsxGinwOJjXhqunZ9d/rhXdB9PLBrf9LOWxmKk
         6Y9Ade7RFZ5XWZ8B8d1McjN71YRwDmST9SOEk=
Received: by 10.229.215.138 with SMTP id he10mr2647619qcb.16.1315938530911;
 Tue, 13 Sep 2011 11:28:50 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Tue, 13 Sep 2011 11:28:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181301>

In short, git checkout --orphan doesn't write
HEAD_sha1 -> 00000
entry to logs/HEAD, while git-comit will write
00000 -> new_orphan_HEAD_sha1
entry. And then reflog backward walk will stop on 000 -> entry and
won't see earlier history.

How to reproduce:
$ git init test && cd test
$ git commit -m A --allow-empty
$ git checkout --orphan topic
$ git commit -m B --allow-empty
$ git log -g --oneline HEAD
some_sha1 HEAD@{0}: commit (initial): B
# oops, where are my old HEADs?
$ cat .git/logs/HEAD
000.. another_sha1 ... commit (initial): A
000.. some_sha1 ... commit (initial): B
# phew, at least I can find them by hand

Isn't  it also a bug in reflog walking that we rely on each old_sha1
being new_sha1 of a previous entry?
