From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: ??? Re: [PATCH/RFC v1 1/6] symlinks.c: small cleanup and
 optimisation
Date: Thu, 29 Jan 2009 15:19:05 +0100
Organization: private
Message-ID: <86iqnygppi.fsf@broadpark.no>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
 <1233004637-15112-2-git-send-email-barvik@broadpark.no>
 <7vskn3np6u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXku-0001ky-SM
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZA2OTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbZA2OTI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:19:08 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:59637 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbZA2OTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:19:07 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE8001WYL3UMC40@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 29 Jan 2009 15:19:06 +0100 (CET)
Received: from localhost ([80.203.78.10]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE800BAHL3TH590@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 29 Jan 2009 15:19:06 +0100 (CET)
In-reply-to: <7vskn3np6u.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107682>

* Kjetil Barvik <barvik@broadpark.no> writes:
> +	/*
> +	 * Is the cached path string a substring of 'name', is 'name'
> +	 * a substring of the cached path string, or is 'name' and the
> +	 * cached path string the exact same string?
> +	 */
> +	if (i >= max_len && ((i < len && name[i] == '/') ||
> +			     (i < cache.len && cache.path[i] == '/') ||
> +			     (len == cache.len))) {

* Junio C Hamano <gitster@pobox.com> writes:
> As you described in your commit log message, what this really wants to
> check is (i == max_len).  By saying (i >= max_len) you are losing
> readability, optimizing for compilers (that do not notice this) 

  When the compiler see the source line:

    'while (i < max_len && name[i] == cache.path[i])'

  it will, from what I know about compilers and machine instructions for
  intel cpu's, generate the following pseudo instructions for this line
  (before more compiler optimisation is done):

   1    test !(i < max_len)   /* which is (i >= max_len) */
   2    jump-if-not-zero  first_instruction_address_outside_the_loop
   3    "some instructions to retrieve some memory locations and test
         name[i] == cache.path[i]"
   4    jump-if-not-zero instruction-address-to-continue-to-loop

  So, I thought that if I could use the exact same test as the compiler
  have to generate for line 1, then I would maybe saved a test, and
  maybe also a jump instruction.

  Compiling with 'gcc -Os' (optimise for text segment size) I was able to
  save 4 bytes for this file, which I think shows that gcc is able to
  take advantage of this trick.

> and pessimizing for human readers (like me, who had to spend a few
> dozens of seconds to realize what you are doing, to speculate why you
> might have thought this would be a good idea, and writing this
> paragraph).  I do not know if it is a good trade-off.

  But, it was not easy to come up with a real test which shows a
  noticeable time difference from this trick, so, I guess this is only a
  trick for the kernel people (at most), so I revert it and will use
  '==' for version 2, such that we keep a little better readability.

  -- kjetil

  ps! Compiling with '-march=core2 -O2 -g0 -s -fomit-frame-pointer', the
      difference in text segment was 64 bytes when using this trick.
