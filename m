From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Pluggable backends for refs,wip
Date: Tue, 5 Aug 2014 14:40:50 -0700
Message-ID: <CAL=YDWk5C+bQS76_+jx1BSYSxecCxaS95RG181ecbJBLCNWLkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 05 23:40:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEmTX-0005jG-SG
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 23:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbaHEVkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 17:40:51 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:46674 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbaHEVkv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 17:40:51 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so2656415vcb.6
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=xJIqquT0rHwKywf5j+Udp72i0MT/4HY1g9r/wVrT99s=;
        b=Zm06ae/bVdi4RQbfPwrbIrXhp0idg3ZyMzSaIJr6DW9MwTiHqBs3/F/rl0I8/6hhY0
         O5JVOmkoMbx8feP2vuiCWdNShbI7q3xLlaIv8ztuS8mnPO1S0eZBr/pQ5UCskSXhuWLv
         dqCAjV8WhIXBOB3uj7fR9TWuqJ0pYSbEfT7/bBcwYOVlZWfzXftzba8DDQ3FvrBgNvri
         8lQTqZdegX+MKDjrTT4D+mgaSuQoAhDmNaiDSWLpG7mSeZXB+CB/iOEteS9cKtfzDhnb
         CazueKFdDECqYCzLxRANjGTDunpTItZ7yjIuagRQtxG2JOqV88x/hExfjcoBTZGgdyVq
         B8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=xJIqquT0rHwKywf5j+Udp72i0MT/4HY1g9r/wVrT99s=;
        b=OoTUOyWGV9g6mZaDQs8tdW0ztjtdvoDRzF1UK1ej3dV5D4QU5rdWr8/7P4Jnqbd4nC
         j/KOFQfBQ7u80XuFQ16rltL3naIiHOLecaRmi3naN7CDzeadfzcI14W9J5h4VuR6mPQN
         yBzcRlA1M6SX2Cyw5Mjnv8GFyCzv+2gEEOFI18Gq/q6BhB3yn50cOU5YOVdh6Q6x7LUc
         09j5rxzIlehAWR5cbdbswz0Aqz+CaYEypVfUjTeWZsipxxZ3f5kKADrOz7JY9dM+12Qy
         xX2S5gu+ksoTx+as+1coVWHDZpX0i6SgCPSU2AyzgIw2v6uz2OHx8gBNCnjHg8UlucdW
         U/Tw==
X-Gm-Message-State: ALoCoQncr1PGEy4XwhdTjSqfI6X7pyPDYfMWmBbNGbf3ARbXia+fqkANapeJpzaf/c2V9P5V3HP+
X-Received: by 10.52.120.83 with SMTP id la19mr4694147vdb.68.1407274850335;
 Tue, 05 Aug 2014 14:40:50 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Tue, 5 Aug 2014 14:40:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254829>

List, Michael,

Please see
https://github.com/rsahlberg/git/tree/backend-struct-db-2
for an example of a pluggable backend for refs storage.

This series contain changes to make it possible to add new backends
for handling/storage of refs and implements one new backend :
refs-be-be.c .

This new backend offloads the actual refs handling to a small database
daemon with which ita talks via a very simple rpc protocol. That
daemon in turn then connects to the datastore and read/writes the
values to it.

By having an always running database daemon it will allow faster
startup of the git commands since they will now only need to connect
to a domain socket instead of having to traverse a potentially very
large number of files during the "build ref cache" phase.
Another nice feature is that it can allow running one single database
daemon and use it to host the refs for multiple independent git
repositoris (by using the new repository name config to distinguish
between them).

It can not yet apply to origin/* since it is based on some small
series that have yet not arrived there
and is still a wip. But if you want to test/look at what we could be
doing one day, please feel free to clone this repo.


FAQ:
Q:
This sound cool. How do I test this?

A:
1, Clone https://github.com/rsahlberg/git/tree/backend-struct-db-2 and
build git.

2, gcc refsd-tdb.c -o refsd-tdb -l tdb
3, ./refsd-tdb /tmp/refsd.socket /tmp /tmp/refsd.log

4, git clone --db-repo-name=ROCKet --db-socket=/tmp/refsd.socket <some-repo> foo

./foo should now contain a git repository that store its refs in a
separate database.
(teh databases are store under /tmp  so don't use this for anything
important because bad things happens to things stored under /tmp)


regards
ronnie sahlberg
