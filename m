From: Brian Downing <bdowning@lavos.net>
Subject: Re: Serious performance regression in diff between 1.6.6 and 1.7.0
Date: Thu, 10 Jun 2010 13:14:21 -0500
Message-ID: <20100610181421.GC2635@glaurung.lavos.net>
References: <20100610001005.GA2635@glaurung.lavos.net> <20100610170804.GB2635@glaurung.lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:14:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmGt-0002Bf-GR
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759554Ab0FJSO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 14:14:26 -0400
Received: from glaurung.lavos.net ([69.162.133.92]:59346 "EHLO
	glaurung.lavos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0FJSO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:14:26 -0400
Received: by glaurung.lavos.net (Postfix, from userid 1000)
	id 613727417D; Thu, 10 Jun 2010 13:14:21 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100610170804.GB2635@glaurung.lavos.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148902>

On Thu, Jun 10, 2010 at 12:08:04PM -0500, Brian Downing wrote:
> I also ran this through callgrind to see how often the above were called:

(187,456 files)

>         Calls  Symbol
>   -----------  -------------------
>       197,958  unpack_callback
>       208,460  find_cache_pos
>    37,308,336  ce_in_traverse_path
>   156,950,469  do_compare_entry
>   156,950,469  df_name_compare

Here is an identical run (git-diff HEAD) from the Linux kernel tree
(33,307 files):

        Calls  Symbol
   -----------  -------------------
        35,332  unpack_callback
        37,357  find_cache_pos
     4,979,473  ce_in_traverse_path
     6,828,181  do_compare_entry
     6,828,181  df_name_compare

That makes it look sort of exponential (perhaps around files^1.5),
though from what I can understand of the find_cache_pos code in
unpack-trees it would depend on the exact shape of the repository.  It
does seem to linear-search over whole directory trees of the index
repeatedly, though, which would support the exponential theory.

Unfortunately I don't really understand what the code is trying to do.
Is it not the case that trees and the index are always stored sorted in
the same order?  The examples given in the commit messages that
introduced this fix would imply not, but I'm not sure how that could
come about.

-bcd
