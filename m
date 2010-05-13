From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Wed, 12 May 2010 18:38:54 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 03:42:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCNRb-0005pr-NB
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 03:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab0EMBmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 21:42:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43079 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754375Ab0EMBmX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 May 2010 21:42:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4D1exgH013648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 May 2010 18:41:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4D1ewhn000736;
	Wed, 12 May 2010 18:40:58 -0700
In-Reply-To: <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146974>



On Thu, 13 May 2010, Eyvind Bernhardsen wrote:
>  
>  ------------------------
> -*.txt          crlf
> -*.vcproj       crlf=crlf
> -*.sh           crlf=lf
> -*.jpg          -crlf
> +*.txt          eolconv
> +*.vcproj       eolconv=crlf
> +*.sh           eolconv=lf
> +*.jpg          -eolconv
>  ------------------------
...
>  ------------------------
> -*	crlf=auto
> +*	eolconv=auto
>  ------------------------

If you are doing the renaming, then I seriously object to this.

It makes no sense to say "eolconv=crlf" and then say "eolconv=auto". They 
are two totally different things. One is _how_ line endings should look 
like, and the other is _whether_ line endings exist or not.

And "eolconv=crlf" makes no sense anyway.  I assume "conv" is
conversion, but a conversion implies a from and a to.  That's just a
"to", and it would make much more sense to just say "eol=crlf" for that
case. 

Now, it _does_ make sense to say "eolconv=auto", but that's because it's
that totally different case: it's not about what the line ending
character is, it's about whether any eol conversion is done at all.  So
for _that_ case, it makes sense to use "eolconv", although even for that
case I think the name is not very _good_. 
So if you rename these things, keep them separate.  Make the "am I a
text-file" boolean be a boolean (plus "auto"), and just call it "text". 
And make the "what end of line to use" be just "eol" then.

So you can have

	*	text=auto,eol=crlf

that means "autodetect whether it is text, and use crlf as eol".

Now, I'd further suggest:

 - "eol=xyz" with no "text" attribute automatically implies "text" being 
   true.
 - "text=xyz" with no "eol" attribute implies "eol=native"

so now you can write:

	*.jpg -text
	*.txt text
	*.vcproj eol=crlf
	*.sh eol=lf
	* text=auto

and that means:

 - jpg files are binary
 - *.txt files are text, and we use the default ("native") line ending for 
   them (implicit, since we don't have any matcing eol rule)
 - *.vcproj files are text (implicit), and we use CRLF line endings
 - *.sh files are text (implicit), and we use UNIX style line endings
 - everything else is auto-detected, and we implicitly use native line 
   endings for them

Doesn't that look finally sane?

Because if we really renaem the attributes, let's rename them _right_.

			Linus
