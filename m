From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Sun, 12 Aug 2012 09:12:58 -0700
Message-ID: <20120812161258.GA3829@mannheim-rule.local>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1447696.eZjtSkvvWp@flomedio>
 <20120801194247.GE24357@copier>
 <1636924.tANzCnKezB@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 18:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0amh-0004NA-RZ
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 18:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab2HLQMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 12:12:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50580 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab2HLQMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 12:12:44 -0400
Received: by pbbrr13 with SMTP id rr13so5807491pbb.19
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r6lrJ//ajop8eXpE/rOIusAbquBv87ePB7xpF1qPkRg=;
        b=V1pdX0sSUmyT/rjEZLFqPdlzkxJIjuQGov/2Tvp7TrGBchCtIvCWgG7JUd2xDwfYhv
         J2dF33TjIEUkHA9DO0/aKkwuiZjoONfOqTqeGFbB1gJ5qLALJVtiI9BzLrNpwJB0wD4M
         oT1LHZxaJd3BEiKqoAjqZLnIM27mw6dzXvUunMgbBSknW++Clxn5Xq/Ocq18xieeRgm2
         0xhk/CCMgI9L6IJJt0JY4C0Yr1H9Ac3/Vw+4QcexiFNkujQX/h//5hALs2rUNGRhq+Ef
         cDdJlcTYesO4oggltiWb4fwyBT8KJwDnFi0br8J9KDafZ+x3+cDCQA+ED1OXPsTq90bh
         95Uw==
Received: by 10.68.202.133 with SMTP id ki5mr28006728pbc.10.1344787964211;
        Sun, 12 Aug 2012 09:12:44 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id nr2sm3539999pbc.48.2012.08.12.09.12.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Aug 2012 09:12:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1636924.tANzCnKezB@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203311>

Hi again,

Florian Achleitner wrote:

> back to the pipe-topic.

Ok, thanks.

[...]
>> The way it's supposed to work is that in a bidi-import, the remote
>> helper reads in the entire list of refs to be imported and only once
>> the newline indicating that that list is over arrives starts writing
>> its fast-import stream.
[...]
> This would require all existing remote helpers that use 'import' to be ported 
> to the new concept, right? Probably there is no other..

You mean all existing remote helpers that use 'bidi-import', right?
There are none.

[...]
> I still don't believe that sharing the input pipe of the remote helper is 
> worth the hazzle.
> It still requires an additional pipe to be setup, the one from fast-import to 
> the remote-helper, sharing one FD at the remote helper.

If I understand correctly, you misunderstood how sharing the input
pipe works.  Have you tried it?

It does not involve setting up an additional pipe.  Standard input for
the remote helper is already a pipe.  That pipe is what allows
transport-helper.c to communicate with the remote helper.  Letting
fast-import share that pipe involves passing that file descriptor to
git fast-import.  No additional pipe() calls.

Do you mean that it would be too much work to implement?  This
explanation just doesn't make sense to me, given that the version
using pipe() *already* *exists* and is *tested*.

I get the feeling I am missing something very basic.  I would welcome
input from others that shows what I am missing.

[...]
> Another alternative would be to use the existing --cat-pipe-fd argument. But 
> that requires to open the fifo before execing fast-import and makes us 
> dependent on the posix model of forking and inheriting file descriptors, while 
> opening a fifo in fast-import would not.

I'm getting kind of frustrated with this conversation going nowhere.  Here
is a compromise to explain why.  Suppose:

- fast-import learns a --cat-blob-file parameter, which tells it to open a
  file to write responses to "cat-blob" and "ls" commands to instead of
  using an inherited file descriptor

- transport-helper.c sets up a named pipe and passes it using --cat-blob-file.

- transport-helper.c reads from that named pipe and copies everything it sees
  to the remote helper's standard input, until fast-import exits.

This would:

 - allow us to continue to use a very simple protocol for communicating
   with the remote helper, where commands and fast-import backflow both
   come on standard input

 - work fine on both Windows and Unix

Meanwhile it would:

 - be 100% functionally equivalent to the solution where fast-import
   writes directly to the remote helper's standard input.  Two programs
   can have the same pipe open for writing at the same time for a few
   seconds and that is *perfectly fine*.  On Unix and on Windows.

   On Windows the only complication with the pipe()-based  is that we haven't
   wired up the low-level logic to pass file descriptors other than
   stdin, stdout, stderr to child processes; and if I have understood
   earlier messages correctly, the operating system *does* have a
   concept of that and this is just a todo item in msys
   implementation.

 - be more complicated than the code that already exists for this
   stuff.

So while I presented this as a compromise, I don't see the point.

Is your goal portability, a dislike of the interface, some
implementation detail I have missed, or something else?  Could you
explain the problem as concisely but clearly as possible (perhaps
using an example) so that others like Sverre, Peff, or David can help
think through it and to explain it in a way that dim people like me
understand what's going on?

Puzzled,
Jonathan
