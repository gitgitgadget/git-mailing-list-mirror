From: Joey Hess <id@joeyh.name>
Subject: git ls-files wildcard behavior considered harmful
Date: Mon, 30 Mar 2015 19:04:59 -0400
Message-ID: <20150330230459.GA13927@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 01:05:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycik7-0000il-7n
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 01:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbbC3XFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 19:05:10 -0400
Received: from kitenet.net ([66.228.36.95]:55054 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbbC3XFJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2015 19:05:09 -0400
X-Question: 42
Authentication-Results: kitenet.net; dkim=pass
	reason="1024-bit key; unprotected key/testing"
	header.d=joeyh.name header.i=@joeyh.name header.b=l9l8h+vL;
	dkim-adsp=pass; dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1427756699; bh=3OGAp5Niddaya2kdiY+iShWKVRTU4Y4TfHueB7pIMfU=;
	h=Date:From:To:Subject:From;
	b=l9l8h+vLrejf6OgeJBTG2GsC/Wd4HTsW4sDPqsMWouo8SFHbCgLhhl7N5cDO8UCep
	 2Sm2tzLjIG25u0knjD7xETIVjqwxnOesxfItF3VCUGxxe7bpifbnFAMaa0bbsqaNao
	 FOjdC7teQF+DfE+GcNY0kYHY2pCOcb8ziMdp+s0M=
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-93.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266486>

I was very surprised to learn the other day that git ls-files 'foo*'
will expand wildcards (including character classes), in the absence of
expansion by the shell. (git version 2.1.4)

joey@darkstar:~/tmp/aaa>git ls-files 'foo*bar'
foo*bar
foobazbar
joey@darkstar:~/tmp/aaa>git ls-files '[abc]'
[abc]
a
b

As far as I can see this behavior is not documented on the man page,
except for a tiny mention in the --with-tree documentation, where
it says "<file> (i.e. path pattern)".

Since I wanted to avoid this wildcard expension, I tried slash-escaping
the wildcard characters. This works:

joey@darkstar:~/tmp/aaa>git ls-files 'foo\*bar'
foo*bar
joey@darkstar:~/tmp/aaa>git ls-files '\[abc\]'
[abc]

But, there is a weird behavior here with subdirectories. While normally
ls-files would recurse, slash-escaped wildcard characters in the directory
name prevent recursion.

joey@darkstar:~/tmp/aaa>git ls-files 'foo[d]'
foo[d]/subfile
food
joey@darkstar:~/tmp/aaa>git ls-files 'foo\[d\]'
joey@darkstar:~/tmp/aaa>

The above example shows a case where it's impossible to get ls-files
to only list files in a directory and not other files that match the
wildcard. This seems like it must be a bug, and it means it's impossible
to reliably work around the wildcard expansion behavior.

I suspect that this wildcard expansion behavior is useful somewhere.
But from the perspective of using ls-files as plumbing, where you want
to get out some subset of what was put in, it's not nice.

-- 
see shy jo
