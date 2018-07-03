Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22AB61F516
	for <e@80x24.org>; Tue,  3 Jul 2018 07:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeGCHG5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 03:06:57 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55916 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753720AbeGCHGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 03:06:55 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1faFOk-0002zD-S9; Tue, 03 Jul 2018 16:06:50 +0900
Date:   Tue, 3 Jul 2018 16:06:50 +0900
From:   Mike Hommey <mh@glandium.org>
To:     peff@peff.net, git@vger.kernel.org
Subject: Checks added for CVE-2018-11235 too restrictive?
Message-ID: <20180703070650.b3drk5a6kb4k4tnp@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

(Background) I'm the author of a git remote-helper that can talk
directly to mercurial servers, known as git-cinnabar. One of the design
decisions was to use git objects to store all the metadata necessary to
reconstruct mercurial changesets, manifests and files, and one special
thing that's done is that git trees are (ab)used to store mercurial
sha1s in commit references. This design decision was made so that the
metadata could possibly be exchanged, allowing to jumpstart clone of
large repositories faster than by converting from scratch from
mercurial.

I had a first shot at that a few months ago, but the format of the
metadata branch made it impossible to push to github, hitting its push
size limit. With some pre-processing work, I was able to push the data
to github, with the intent to come back with a new metadata branch
format that would make the push directly possible.

Fast forward to this week, where I was trying to upload a new metadata
branch, and failed in a rather interesting way: multiple lines looking
like:

remote: error: object 81eae74b046d284c47e788143bbbcc681cb53418: gitmodulesMissing: unable to read .gitmodules blob

which, apart from the fact that they have some formatting issue, appear
to be new from the fixes for CVE-2018-11235.

I can see what those fixes are trying to prevent, but they seem to be
overly restrictive, at least in the context of transfer.fsckObjects.

The core problem is that the mercurial repository has some .gitmodules
files in some subdirectories. As a consequence, the git objects storing
the info for those mercurial files contain trees with .gitmodules files
with a commit ref, and that's what the remote is complaining about.

(Surpringly, it doesn't hit the "non-blob found at .gitmodules" case
first, which is weird).

A small testcase to reproduce looks like this:

$ git init bar; cd bar
$ git fast-import <<EOF
commit refs/heads/bar
committer Bar <bar@bar> 0 +0000
data 0
                                                                 
M 160000 81eae74b046d284c47e788143bbbcc681cb53418 bar/.gitmodules
                                                                 
EOF
$ git init ../qux
$ git -C ../qux config receive.fsckObjects true
$ git push -q ../qux bar
remote: error: object 81eae74b046d284c47e788143bbbcc681cb53418: gitmodulesMissing: unable to read .gitmodules blob
remote: fatal: fsck error in pack objects
error: remote unpack failed: unpack-objects abnormal exit
To ../qux
 ! [remote rejected] bar -> bar (unpacker error)
error: failed to push some refs to '../qux'

Would it be reasonable to make the transfer.fsckObject checks ignore
non-blob .gitmodules?

Cheers,

Mike
