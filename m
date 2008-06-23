From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 10:06:52 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
 <20080623164917.GA25474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApXP-0003yU-1t
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbYFWRIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 13:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbYFWRII
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:08:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33542 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754701AbYFWRIH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 13:08:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NH6rQA017515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 10:06:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NH6qdQ006655;
	Mon, 23 Jun 2008 10:06:52 -0700
In-Reply-To: <20080623164917.GA25474@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85887>



On Mon, 23 Jun 2008, Jeff King wrote:
> On Mon, Jun 23, 2008 at 09:25:10AM -0700, Linus Torvalds wrote:
> 
> > Could you handle the "recursive" use of parse_options() in builtin-blame.c 
> > by teaching it about recursion? Yes. But again, it's just _simpler_ to 
> > just teach parse_options() to parse the things it knows about, and leave 
> > the other things in place.
> 
> If I know that I have option "-a", what is the correct partial parsing
> of:
> 
>   git foo -b -a
> 
> ?

You'd start off with argv[] looking like [ "foo" "-b" "-a" ] and then 
after calling parse_options with that, depending on whether it has 
PARSE_OPT_CONTINUE_ON_UNKNOWN or not, you'd either end up with the "-a" 
handled (and argv[] now being just [ "foo" "-b" ]), or if you have 
PARSE_OPT_STOP_ON_UNKNOWN then parse_options() would return without having 
done anything, and expecting you to handle the unknown option first and 
then restarting the argument parsing.

The problem with parse_options() right now is:

 - it cannot do this at all (it can stop or ignore *non*arguments, but 
   not things that start with "-" and will always error out)

 - it actually puts the result somewhere different than the source, which 
   makes it very annoying to work with together with anything else that 
   also wants to look at, or change, argv/argc.

   IOW, right now it takes it's arguments from argv[1...], but then puts 
   back the remainder into argv[0...]. Similarly, it takes a "count plus 
   one" value of argc, but then _returns_ a "count plus zero".

That second thing is an annoyance, and could be handled either with a new 
flag (PARSE_OPT_PUT_BACK_IDENTICALLY), or by just changing the calling 
convention. The latter is the "right thing", but it needs trivial changes 
in all existing callers.

I actually suspect that the best fix for the second issue is to yes, 
change the calling convention so that it puts things back where it found 
them, and returns a "count plus one" count, *but* have a special case 
where "if all arguments are used, return zero".

[ IOW, it would never ever return "1". If there is one argument left in 
  argv[1], it returns 2 because it counts "argv[0]" even if it doesn't 
  _use_ it. That's exactly the same way argv/argc works normally. But 
  then, if it actually used up everything, it wouldn't return 1, but 
  return 0 to make it

   (a) easier and more obvious to test for "done" in general

   (b) easier to convert existing users that basically expect a zero 
       return value to mean "I ate all the arguments". Many existing users 
       of "parse_options()" don't care about anything else, and wouldn't 
       need any changes at all.

  but I haven't actually looked too closely yet to be able to say whether 
  this would avoid the bulk of the problems with changing the existing 
  practice of 'parse_option()' callers. ]

Hmm?

		Linus
