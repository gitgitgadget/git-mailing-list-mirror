From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 08:01:15 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001040755130.3630@localhost.localdomain>
References: <87ljgfgbl0.fsf@catnip.gol.com> <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com> <877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain> <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net> <7vbphaquwl.fsf@alter.siamese.dyndns.org> <20100104064408.GA7785@coredump.intra.peff.net> <7vhbr2pcsh.fsf@alter.siamese.dyndns.org> <20100104072659.GA10611@coredump.intra.peff.net>
 <20100104080940.GA4815@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:01:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpN2-0002Rf-Ic
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab0ADQBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408Ab0ADQBY
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:01:24 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35115 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753374Ab0ADQBX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 11:01:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o04G1GJ0004768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jan 2010 08:01:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o04G1Fj4003312;
	Mon, 4 Jan 2010 08:01:15 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20100104080940.GA4815@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.447 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136120>



On Mon, 4 Jan 2010, Jeff King wrote:
> 
> However, gprof reports that for the pcre dfa case, we spend more time in
> grep.c:end_of_line than we do actually running the regex. So clearly
> there are some other micro-optimizations in GNU grep that are making a
> difference, too.

Don't use gprof. You're _much_ better off using the newish Linux 'perf' 
tool. It's quite competent, and doesn't need the code to be compiled with 
-pg (which totally changes all performance characteristics).

Do something like this:

	perf record git grep qwerty

followed by

	perf report
	perf annotate grep_buffer_1

(that "perf report" gives a per-symbol overview, the "perf annotate" gives 
a disassembly with source annotations and per-instruction costs). It works 
with inlining too, so you get things like this:

	...
         :      static char *end_of_line(char *cp, unsigned long *left)
         :      {
         :              unsigned long l = *left;
         :              while (l && *cp != '\n') {
   24.76 :        476a50:       80 3b 0a                cmpb   $0xa,(%rbx)
   10.46 :        476a53:       0f 84 e7 00 00 00       je     476b40 <grep_buffer_1+0x1b0>
         :                      l--;
         :                      cp++;
   21.19 :        476a59:       48 83 c3 01             add    $0x1,%rbx
         :      }
         :
         :      static char *end_of_line(char *cp, unsigned long *left)
         :      {
         :              unsigned long l = *left;
         :              while (l && *cp != '\n') {
    0.94 :        476a5d:       49 83 ed 01             sub    $0x1,%r13
    4.85 :        476a61:       75 ed                   jne    476a50 <grep_buffer_1+0xc0>
         :
	...

and yes, it's all the per-line crap.

The perf tools are included with modern kernels in tools/perf (which also 
has a Documentation subdirectory). I can pretty much guarantee that once 
you start using it, you'll never use gprof or oprofile again.

		Linus
