From: Joey Hess <id@joeyh.name>
Subject: proposal for extending smudge/clean filters with raw file access
Date: Thu, 12 May 2016 14:24:32 -0400
Message-ID: <20160512182432.GA27427@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 20:24:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0vHy-0000Pt-7q
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 20:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbcELSYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 14:24:42 -0400
Received: from kitenet.net ([66.228.36.95]:41244 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbcELSYm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2016 14:24:42 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=dXuNJbg7;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1463077472; bh=LoX4NqMGowiRyp3xHGGMPnAKnDD5WNK95LkDAC3nB38=;
	h=Date:From:To:Subject:From;
	b=dXuNJbg7vdRMXpgynpbCwHwxaQY6BGIULYyw3Oz90lUm7HZ8tSZERnPqd32cDFPaM
	 +KiOPk3RjhOM4qbPqToK4rlrk8KLwfRe7JOk/I14JK6bkP6arYjr75SAzLTThWqK3G
	 NN9sItPcHyaYezqH0fN0SdFMJv9AmtdQ2h3IXVQg=
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294425>

I'm using smudge/clean filters in git-annex now, and it's not been an
entirely smooth fit between the interface and what git-annex wants
to do.

The clean filter has to consume the whole file content on stdin;
not reading it all will make git think the clean filter failed.
But, git-annex often doesn't need to read the whole content of a
work-tree file in order to clean it.

The smudge filter has to output the whole file content to stdout. But
git-annex often has the file's content on disk already, and could just
move it into place in the working tree. This would save CPU and IO and
often disk space too. But the smudge interface doesn't let git-annex use
the efficient approach.

So I propose extending the filter driver with two more optional
commands. Call them raw-clean and raw-smudge for now.

raw-clean would be like clean, but rather than being fed the whole
content of a large file on stdin, it would be passed the filename, and
can access the file itself. Like the clean filter, it outputs the
cleaned version on stdout.

raw-smudge would be like smudge, but rather than needing to output the
whole content of a large file on stdout, it would be passed a filename,
and can create that file itself.

To keep this backwards compatible, and to handle the cases where the
object being filtered is not a file on disk, the smudge and clean
filters would be required to be configured too, in order for raw-clean
and raw-smudge to be used.

It seems fairly easy to implement raw-clean. In sha1_file.c, index_path
would use raw-clean when available, while index_fd etc keep on using
the clean filter. I have not investigated what would be needed to implement
raw-smudge yet.

-- 
see shy jo
