From: Allan Gardner <allanegardner@gmail.com>
Subject: git fetch sha1
Date: Fri, 4 Jul 2014 19:51:10 +0200
Message-ID: <CABo2x6A_cA8KoFbe4Hcg0SJw+gOGeOFun3VDM1gx3ZVWK8wy3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 19:51:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X37do-00042M-2h
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 19:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760078AbaGDRvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 13:51:13 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:47945 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760075AbaGDRvL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 13:51:11 -0400
Received: by mail-ve0-f182.google.com with SMTP id oy12so1963065veb.27
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=SA0ulzqW3bAzXQ/qJalk74YG+2QpO7XLGvJHfybFqNo=;
        b=Mv3WJfe9HVNu3vwbvqkzi9PAU04Hn+t4QCBvloSOTn2/JdKhG7f6tP+uZk9RZ63V0o
         dbOVBQhCqqiFdADs3oxqPOhn+SxTHFeRrZtz4FM4PXxoUEfvF3NG1Tizsizi3mbmPJlb
         E0jVSzi+aJWZVgOzBYCRiz5XrTxGBNLWP4An8AqeVrhpTz4NtxRSE2/tDWmC4qkhdiK1
         Cu7n1xksK/t19nLom8jF5VxvPiI8y1D86TppRzN5VL/yfFd/1k90fDDA/jCMvuBu2kAO
         osJw9ijUmEpNrestUNSU+P0AzOk0mm49GgzMPGkpgbyy6IL3tpnhhtBDa5J9mwSDyNlA
         vZOQ==
X-Received: by 10.52.135.7 with SMTP id po7mr29680vdb.50.1404496270751; Fri,
 04 Jul 2014 10:51:10 -0700 (PDT)
Received: by 10.58.179.131 with HTTP; Fri, 4 Jul 2014 10:51:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252900>

Currently fetching a sha1 fails on git.kernel.org:

$ git --version && uname -a
git version 1.9.4
Linux nixos 3.12.23 #1-NixOS SMP Thu Jan 1 00:00:01 UTC 1970 x86_64 GNU/Linux

$ rm -rf test && mkdir test && cd test && git init
Initialized empty Git repository in ~/test/.git/

$ git fetch --depth 1 https://git.kernel.org/pub/scm/git/git.git
782735203c316041df120748e5e88c1787cdf4da
error: no such remote ref 782735203c316041df120748e5e88c1787cdf4da

I tried with head, same error. However, if I clone the full repository
and then manually execute git upload-pack, it successfully fetches the
commit:

$ git fetch https://git.kernel.org/pub/scm/git/git.git master
<wait an hour>
$ git checkout -b sha1 782735203c316041df120748e5e88c1787cdf4da
$ printf "0045want %s multi_ack_detailed\n000Ddeepen
1\n00000009done\n0000" "782735203c316041df120748e5e88c1787cdf4da"
>input
$ cat input | git upload-pack --stateless-rpc . > output
$ sed -z "s/.*0008NAK\n//" < output > output.pack
$ git index-pack output.pack && git verify-pack -v output.pack | grep commit
f239687a5dbbd1bbb761d09edec582418c66c297
782735203c316041df120748e5e88c1787cdf4da commit 374 234 12

So theoretically this is supported server-side. Unfortunately
kernel.org does not agree:

$ curl --data-binary @input --header "Content-Type:
application/x-git-upload-pack-request" --header "Accept-Encoding:
gzip" --header "Accept: application/x-git-upload-pack-result" --header
"Expect:" https://git.kernel.org/pub/scm/git/git.git/git-upload-pack >
output
$ wc -c output
0 output

Why is there a discrepancy between git.kernel.org and upload-pack
--stateless-rpc?

-- Allan Gardner
