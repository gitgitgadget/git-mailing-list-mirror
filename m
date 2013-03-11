From: Jeff King <peff@peff.net>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Mon, 11 Mar 2013 01:18:41 -0400
Message-ID: <20130311051840.GB13510@sigill.intra.peff.net>
References: <5139D76D.80703@bernhard-posselt.com>
 <20130308212831.GA9217@sigill.intra.peff.net>
 <513A7D80.5000501@bernhard-posselt.com>
 <20130309044850.GB12167@sigill.intra.peff.net>
 <513B14EC.4040504@bernhard-posselt.com>
 <20130310070505.GA15324@sigill.intra.peff.net>
 <513C7267.2090608@bernhard-posselt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernhard Posselt <mail@bernhard-posselt.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 06:19:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEv8h-0005WU-I6
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 06:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab3CKFSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 01:18:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45734 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab3CKFSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 01:18:44 -0400
Received: (qmail 10971 invoked by uid 107); 11 Mar 2013 05:20:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Mar 2013 01:20:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Mar 2013 01:18:41 -0400
Content-Disposition: inline
In-Reply-To: <513C7267.2090608@bernhard-posselt.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217854>

On Sun, Mar 10, 2013 at 12:45:43PM +0100, Bernhard Posselt wrote:

> >   valgrind -q --trace-children=yes --log-file=/tmp/valgrind.out \
> >     git pull --rebase https://github.com/Raydiation/core
> 
> The log file was empty and it seemed to apply everything nice when
> running valgrind. When i tried to run it without valgrind it failed
> with memory corruption.

Thanks, we are maybe getting closer. It's weird that it works OK with
valgrind. If the valgrind log is empty, though, I'm confused about where
the output you pasted below came from.

> ==22291== Invalid write of size 1
> ==22291==    at 0x4C2DB93: memcpy@@GLIBC_2.14 (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==22291==    by 0x4076B1: update_pre_post_images (in /usr/lib/git-core/git)
> ==22291==    by 0x40A60F: apply_fragments (in /usr/lib/git-core/git)
> ==22291==    by 0x40C29F: check_patch_list (in /usr/lib/git-core/git)
> ==22291==    by 0x40CC35: apply_patch (in /usr/lib/git-core/git)
> ==22291==    by 0x40F584: cmd_apply (in /usr/lib/git-core/git)
> ==22291==    by 0x4058E7: handle_internal_command (in /usr/lib/git-core/git)
> ==22291==    by 0x404DD1: main (in /usr/lib/git-core/git)

Hmm, it would be nice to have line numbers. Can you try compiling with
"-g -O0"?

The function where the problem is deals with whitespace munging. Just a
guess, but do you have any whitespace config options set (e.g.,
apply.whitespace)?

-Peff
