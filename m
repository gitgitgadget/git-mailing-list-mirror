From: Fernando Correia <fernandoacorreia@gmail.com>
Subject: Concurrent fetches and pushes
Date: Wed, 1 Oct 2014 18:51:12 -0300
Message-ID: <CAH8bp3K01Bkr939S62zYjrtRKeotJoGw+4pEnuE8MXtVk_DbrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 01 23:51:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZRns-0004jG-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 23:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbaJAVvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 17:51:15 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38004 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbaJAVvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 17:51:14 -0400
Received: by mail-wi0-f180.google.com with SMTP id em10so2148626wid.7
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=H4oncR1XabN7hmoTyqKs+McnN+HZlDpYSGeVQ5pUr70=;
        b=IKc0SLkNRlwyJwgRom4alb1J7fMM4FkvDCpu6TqtKa56RQ1IJxRONeVIatrDTx4UEx
         zVb50zhNuaiQY58iPWxin7kIRdyVW1Uax56tuyRFcGO2jZTotytFYYzG+5ijenOiqAZM
         qtCyTqJWvCkkMBbfH+gmqshMeewhHW3Cho1DDlFnJUX1S1pdAgx7iE6JMpVLIs7R93hb
         oxmESSUdZoa5xns6EFfKj2jYY25KxdixNv9oD0hanrrmsOMYE3IqDWgv3d87q5D0pU4b
         6s0GX3Dc3ShmBIXfH4n94g1yZO4Pic4tcWI6R0s0Zgd0dHzV6jPjKh5jKKUA+COIi28W
         t5YQ==
X-Received: by 10.180.8.73 with SMTP id p9mr8399033wia.32.1412200272997; Wed,
 01 Oct 2014 14:51:12 -0700 (PDT)
Received: by 10.27.178.18 with HTTP; Wed, 1 Oct 2014 14:51:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257768>

Are concurrent pushes and fetches to the same repository via HTTP supported?

Considering this architecture:

git --(smart HTTP protocol)--> apache -> git-http-backend

git version is 2.1.1 on client and server.

Multiple clients are fetching from and pushing to the same
repositories, sometimes concurrently.

Some pushes are failing with this error:

To https://username:password@host.com/projectrepos/project.git
+ 3711f16...0bdfbc5 master -> master (forced update)
error: RPC failed; result=52, HTTP code = 0
fatal: The remote end hung up unexpectedly

remote: error: failed to lock refs/heads/master
To https://username:password@host.com/projectrepos/project.git
! [remote rejected] master -> master (failed to lock)
error: failed to push some refs to
'https://username:password@host.com/projectrepos/project.git'

It says it failed to lock but we're not sure why. Error code 52 means
it "got nothing".

On the server logs, there are errors like these (I'm not sure if
caused by fetch or push requests):

error: Ref refs/heads/master is at
f38a8a79752eac8a53fd195bc37fc56c0faf5cfa but expected
a586117cd41604b8b2cb9776a98715c591071ad1

error: Ref refs/heads/master is at
6e1108c108ae464a37cbb3ccc84db934656cbcb4 but expected
f38a8a79752eac8a53fd195bc37fc56c0faf5cfa

fatal: git upload-pack: not our ref f38a8a79752eac8a53fd195bc37fc56c0faf5cfa

error: Ref refs/heads/master is at
6e1108c108ae464a37cbb3ccc84db934656cbcb4 but expected
f38a8a79752eac8a53fd195bc37fc56c0faf5cfa

error: Ref refs/heads/master is at
cc853c06962b3562e46cfefb3986abef914809b5 but expected
6e1108c108ae464a37cbb3ccc84db934656cbcb4

These errors don't happen when accessing a repository on the
filesystem instead of via HTTP transport.

Does git support concurrent fetch and push operations?

Are there any restrictions to doing that via the HTTP backend?
