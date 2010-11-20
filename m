From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/15] svn-fe: support for property deltas (but not text
 deltas yet)
Date: Fri, 19 Nov 2010 18:45:25 -0600
Message-ID: <20101120004525.GA17445@burratino>
References: <20101118050023.GA14861@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:46:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbav-0007rH-9S
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab0KTAqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:46:16 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42009 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab0KTAqP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:46:15 -0500
Received: by gxk23 with SMTP id 23so3101069gxk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/i4YUUSnGcP+8IVjkZFgrlHwowskW9qfBAW8ACXQIlg=;
        b=CGnjQGb0DnTy1VXdGLy1c79xCitWQ8ZQf0rSBX09LFOmq2pGr6H5kIOHe8rrl15iwd
         N8WJm2oEHyhMFqrBNhu0tOgjLArEVSFTvrGAz48wZHIXzgaQE/7msBGO4+xjIkE8x4lk
         zfFFiET5mAE023tL3qv5b12Ne0olUx+58OwhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rdmZQY/E7s8AXQdcegytg5mGFv6pD73H3zxURtvuatN+EfxgyGr3NV23uTyOzAxY2t
         r0CaBSYp05ckP8MA0owkoQmdt8sVl1v88RmuhL+HhQohjLTDBvMBUZ0lLLVcbHM90K8C
         mTBSFKJZmaomspEXw3rHZf4DSrHUtzScj6wvk=
Received: by 10.151.155.16 with SMTP id h16mr4580219ybo.409.1290213974596;
        Fri, 19 Nov 2010 16:46:14 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j64sm1438993yha.24.2010.11.19.16.46.12
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:46:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101118050023.GA14861@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161800>

Hi,

Jonathan Nieder wrote:

> This mini-series is part of an effort to get David and Ram's svn
> import work integrated into mainline git[1].

Another chapter.  This one is mostly David's work.  One can test
it (I haven't tried) by taking out the safety

	die("text deltas not supported");

and letting it import from some real-world deltified dump file,
treating deltas as the full text.  Then one can validate as usual, by
checking the modes of files in each revision of the imported tree.

I've done a little refactoring to more easily understand the patch,
but the heart of the work is still David's.  Any bugs and infelicities
are probably mine (especially the evil hack to support switching
between executables and symlinks).

Especially useful would be a nicer set of tests.  A tool to create
dump files based on a more concise description would make this and
some future tasks a lot easier (hint, hint).

Thoughts?  Improvements?  Any of these ready to go?  I can rearrange
to put the uncontroversial patches at the beginning once it is clear
what those are.

David Barr (1):
  vcs-svn: Implement Prop-delta handling

Jonathan Nieder (14):
  vcs-svn: Check for errors from open()
  vcs-svn: Eliminate node_ctx.srcRev global
  vcs-svn: Eliminate node_ctx.mark global
  vcs-svn: Unclutter handle_node by introducing have_props var
  vcs-svn: Use mark to indicate nodes with text
  vcs-svn: handle_node: Handle deletion case early
  vcs-svn: Replace = Delete + Add
  vcs-svn: Merge repo_replace and repo_modify functions
  vcs-svn: Delay read of per-path properties
  vcs-svn: Reject path nodes without Node-action
  vcs-svn: More dump format sanity checks
  vcs-svn: Make source easier to read on small screens
  vcs-svn: Split off function for handling of individual properties
  vcs-svn: Sharpen parsing of property lines

 contrib/svn-fe/svn-fe.c |    3 +-
 t/t9010-svn-fe.sh       |  301 ++++++++++++++++++++++++++++++++++++++++++++++-
 test-svn-fe.c           |    3 +-
 vcs-svn/repo_tree.c     |   21 +--
 vcs-svn/repo_tree.h     |    3 +-
 vcs-svn/svndump.c       |  191 +++++++++++++++++++-----------
 vcs-svn/svndump.h       |    2 +-
 7 files changed, 436 insertions(+), 88 deletions(-)

-- 
1.7.2.3
