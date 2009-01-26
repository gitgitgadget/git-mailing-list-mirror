From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool: respect autocrlf by using checkout-index
Date: Mon, 26 Jan 2009 16:31:14 +0000
Message-ID: <20090126163114.GD32604@hashpling.org>
References: <20090121210348.GD9088@mit.edu> <1232578668-2203-1-git-send-email-charles@hashpling.org> <7v1vuuvt11.fsf@gitster.siamese.dyndns.org> <83skn6doxm.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:33:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUOC-0001hW-DY
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbZAZQbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbZAZQbS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:31:18 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:65053 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751531AbZAZQbR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 11:31:17 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAN0fUnUnw6S/2dsb2JhbADKKIVL
Received: from ptb-relay02.plus.net ([212.159.14.146])
  by relay.ptn-ipout02.plus.net with ESMTP; 26 Jan 2009 16:31:15 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1LRUMk-0007u6-UG; Mon, 26 Jan 2009 16:31:15 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0QGVE3t004157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Jan 2009 16:31:14 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0QGVETm004156;
	Mon, 26 Jan 2009 16:31:14 GMT
Content-Disposition: inline
In-Reply-To: <83skn6doxm.fsf@kalahari.s2.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 0779eaf9ff8cd08e9571c1cc58f4a41d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107228>

On Mon, Jan 26, 2009 at 06:15:01PM +0200, Hannu Koivisto wrote:
>
> Now that I tried the patch, I observed that while the stage2 and
> stage3 temporary files have CRLF line endings, the merge result
> buffer/file has LF line endings.  I'm again using Cygwin git,
> mergetool -t emerge and native Windows Emacs.  So when I quit the
> mergetool, I get
> 
> ...
> Hit return to start merge resolution tool (emerge):
> warning: LF will be replaced by CRLF in kala.txt
> warning: LF will be replaced by CRLF in kala.txt
> 
> and indeed hexdump proves that the file in my worktree now has LF
> line endings even though it had CRLF line endings before invoking
> mergetool.
> 
> I wonder why I didn't notice this the first time.  I can certainly
> reproduce it now without Charles' patch as well so I suppose this
> is a separate issue and the patch does what it is supposed to do.

mergetool doesn't touch the destination file, it just asks the merge
tool to overwrite it.

I suspect that the LF endings in the file is due to the fact that in
builtin-merge-file.c, the file is opened (fopen) in binary mode
("wb"), but xdl_merge terminates all lines with a raw '\n'.

The obvious fix would be to change fopen in builtin-file-merge.c to
use "w" instead, but this doesn't work in a number of scenarios. In
particular, it is wrong for repositories on windows with core.autocrlf
set to false, and would not fix non-windows repositories with
core.autocrlf set to true.

Currently, I've no idea as to what the solution should be.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
