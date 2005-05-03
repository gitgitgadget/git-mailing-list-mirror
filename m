From: Alon Ziv <alonz@nolaviz.org>
Subject: RFC: adding xdelta compression to git
Date: Tue, 3 May 2005 05:57:38 +0200
Message-ID: <200505030657.38309.alonz@nolaviz.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 03 05:52:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSoRv-0001gW-9z
	for gcvg-git@gmane.org; Tue, 03 May 2005 05:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVECD56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 23:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVECD56
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 23:57:58 -0400
Received: from bzq-114-36.red.bezeqint.net ([62.219.114.36]:40978 "EHLO
	wonder.nolaviz.org") by vger.kernel.org with ESMTP id S261352AbVECD5z
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 23:57:55 -0400
Received: from bruno.nolaviz.org (bruno.nolaviz.org [192.168.0.18])
	(authenticated bits=0)
	by wonder.nolaviz.org (8.12.11/8.12.11) with ESMTP id j433xCam030039
	for <git@vger.kernel.org>; Tue, 3 May 2005 06:59:14 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.6.1
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on wonder.nolaviz.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Looking for novel methods of wasting my time :), I am considering adding 
xdelta to git.

I have two concrete proposals, both of which (IMO) are consistent with the git 
philosophy:

1. Add a git-deltify command, which will take two trees and replace the second 
tree's blobs with delta-blobs referring to the first tree. Each delta-blob is 
self-contained; from the outside it looks like any other blob, but internally 
it contains another blob reference + an xdelta. The only function which would 
need to understand the new format would be unpack_sha1_file.
The scripting level will be in charge of deciding which trees to deltify (or 
undeltify--we could also have a "git-undeltify" command). A sane 
deltification schedule, for example, could be to always keep tagged versions 
as stand-alone objects, and deltify intermediate versions against the latest 
tag. It would also do its best to avoid delta chains (i.e. a delta referring 
to another delta).
Pros:
* Interoperates with the existing structure (including pull/push) with almost 
no changes to existing infrastructure.
Cons:
* Changes the repository format.
* Some performance impact (probably quite small).
* Same blob may have different representation in two repositories (one 
compressed, on deltified). [I am not sure this is really a bad thing...]

2. Add a completely external framework which manages a "deltas repository" of 
deltas. The shadow repository will contain delta objects between selected 
trees; again the scripts will need to populate it.
Pros:
* No changes at all to existing code.
Cons:
* Push/pull tools will need to be taught to talk with the new "deltas  
repository".
* Synchronization between the deltas repository and the real one may be lost, 
leading to odd failures.

Personally I'm rooting for #1 above... I would like to begin implementation in 
a few days, so any discussion will be useful.

	-az
