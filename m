From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v2 4/4] gitk: Implement batch lookup and caching of encoding attrs.
Date: Fri, 10 Oct 2008 22:48:34 +1100
Message-ID: <18671.16658.667581.499095@cargo.ozlabs.ibm.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-2-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-3-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-4-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-5-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 13:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoGVk-0002qj-8i
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 13:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbYJJLtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 07:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbYJJLtJ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 07:49:09 -0400
Received: from ozlabs.org ([203.10.76.45]:54955 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbYJJLtI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 07:49:08 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3A752DDF5C; Fri, 10 Oct 2008 22:48:42 +1100 (EST)
In-Reply-To: <1222772422-28020-5-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97929>

Alexander Gavrilov writes:

> When the diff contains thousands of files, calling git-check-attr
> once per file is very slow. With this patch gitk does attribute
> lookup in batches of 30 files while reading the diff file list,
> which leads to a very noticeable speedup.

Why only 30 at a time?  The logic would be simpler if cache_gitattr
just did all the paths in one call to git check-attr, and it should be
able to cope with 1000 paths in one call, I would think, which is the
most that gettreediffline will give it.

Also, I wonder why we now have two levels of caching of the encoding
attribute.  Your patch 1/4 introduced path_encoding_cache, which was
fine, but now we have path_attr_cache as well, which seems to me to
serve exactly the same function since the encoding is the only
attribute we ever ask about.  Surely we don't need both caches?

Even with this batching, I am a bit concerned that adding the encoding
support might make things noticeably slower for people who don't need
any encoding support (which would be the majority, I think).  We may
end up needing an option to turn off the checking of the encoding
attribute.

Paul.
