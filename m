X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Christian Thaeter <ct@pipapo.org>
Subject: handling symlinks proposal
Date: Sun, 26 Nov 2006 17:59:36 +0100
Message-ID: <4569C7F8.4030303@pipapo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 17:00:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Icedove 1.5.0.7 (X11/20061013)
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32358>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoNM6-0001fq-AN for gcvg-git@gmane.org; Sun, 26 Nov
 2006 17:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934430AbWKZQ7k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 11:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757944AbWKZQ7j
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 11:59:39 -0500
Received: from pipapo.org ([217.140.77.75]:3336 "EHLO mail.pipapo.org") by
 vger.kernel.org with ESMTP id S1757943AbWKZQ7j (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 11:59:39 -0500
Received: from [10.20.40.100] (unknown [10.20.40.100]) by mail.pipapo.org
 (Postfix) with ESMTP id 8F73A13C61A for <git@vger.kernel.org>; Sun, 26 Nov
 2006 17:59:37 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Git currently keep symlinks always as symlink, I would like to see some
optional functionality when handling symlinks.

Sometimes it is not intended to store information external to a source
tree in git. Problems are that it might break a checkout, just loosing
information or even have security implications.

What are are the diffrent kinds of symlinks:
 - they can point to a file local to the tree
 - or point to a file outside of the tree

 - they can be absolute
 - or relative

how can we handle symlinks:
 - 'keep' what git currently does, store the symlink as it is
 - 'file' store it as file (dereference it), information that it was a
    symlink gets lost, checkouts will produce a file.
 - 'relative' store it as a relative symlink
 - 'absolute' store it as a absolute symlink
 - 'error' refuse to checkin and abort commit
 - 'warn' display a warning

How to add this to git?
make config options (defaults in [core] ?)
 symlink[.{local|extern}?_?{absolute|relative}?] = action

per branch overrides in [branch]

Example:
[core]
  # in-tree symlinks shall not break a checkout to another place
  symlink.local = relative
  # we don't want out-of-tree symlinks, store them as file
  symlink.extern_absolute = file
  # a relative symlink out-of-tree is likely a typo/error?
  symlink.extern_relative = error

[branch]
  # some local feature branch keeps all symlinks
  myfeature.symlink = keep

Default will be 'keep' so without this options it is what git currently
does.

Additional thoughts:
An existing symlink in the tree is not altered by check in, only the
repository is affected.
New checkouts or switching branches may alter it.
Merging between branches where one stores something as file and the
other symlink should be straightforward, does this need to be resolved?

So far thats just an idea how I would like it. If People like it this
way or we can refine it even better, I am going to implement it sometime
next.

