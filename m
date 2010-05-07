From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 16:18:28 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>  <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com>
 <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org>  <384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org>  <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> 
 <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> <h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 01:20:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAWqV-0007j8-MR
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 01:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab0EGXUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 19:20:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35423 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751524Ab0EGXUd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 19:20:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47NKQ0A004247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 16:20:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47NKPaT017612;
	Fri, 7 May 2010 16:20:25 -0700
In-Reply-To: <h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146618>



On Fri, 7 May 2010, Avery Pennarun wrote:
> 
> Maybe we should rethink this from the top.  Imagine that we currently
> have no crlf options whatsoever.  What *should* it look like?  I
> suggest the following:
> 
> Config:
>    core.eolOverride = lf / crlf / auto / binary / input
>    core.eolDefault = lf / crlf / auto / binary / input

Ugh. Hell no. What an ugly format. What does that crazy "override vs 
default" even _mean_?

So no.

Plus the above is confused anyway. The only reason to ever support 'lf' is 
if you're a total moron of a SCM, and you save files you know are text in 
CRLF format internally. That's just f*cking stupid.

So the above is just crazy talk.

The options that make sense is:

 - disabling all "text" issues, and considering everything to be pure 
   binary. This is the "I know I'm sane and unix" option, or the "doing 
   any conversion is always wrong" option.

   We'd call this "binary" or "off" or "false".

 - if you recognize a text-file, and consider it text and different from 
   binary, at a _minimum_ it needs what we call "input". Anything else is 
   crazy-talk. We don't save the same text-file in different formats, and 
   we know that CRLF (or CR) is just a stupid format for text.

   So there are zero options for the input side. If we don't do CRLF -> LF 
   conversion on input, it's worthless even _talking_ about text vs binary.

 - For output, there are exactly three choices: "do nothing" (aka just 
   "input", aka "LF"), output in native format (CRLF on Windows, LF on 
   UNIX), or "force CRLF" regardless of any defaults (and the last 
   probably doesn't make sense in practice, but is good for test-suites, 
   so that you can get CRLF output even on sane platforms.

So I think the _only_ sane choices are basically

	core.crlf=[off|input|on|force]

where you may obviously have aliases (ie "off", "false" and "binary" could 
all mean the same thing, and you could alias "input" to "lf" and "force" 
to "crlf").

And the above is basically what we have. Except that for historical 
reasons (ie we didn't even _have_ any attributes) it got mixed it up with 
"do we want to do this automatically", so "autocrlf=on" actually ends up 
being "yes, do automatic detection" _and_ what I'd call "core.crlf=force" 
above.

			Linus
