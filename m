From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 12:31:07 -0700 (PDT)
Message-ID: <20061012193107.44651.qmail@web31805.mail.mud.yahoo.com>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 12 22:04:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY6Gw-0003oV-C7
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 21:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWJLTbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 15:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWJLTbJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 15:31:09 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:61869 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750844AbWJLTbI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 15:31:08 -0400
Received: (qmail 44653 invoked by uid 60001); 12 Oct 2006 19:31:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DKPb/vZRVzr8+GvSznmmE71qS+8nSjrrzfZPDBgGEeFHFGuBUpy802n6ViBbcch/ZW3g7PBXZbpzc5fGThrdSc5N/XbMMMXsvShTm9Bd6HVvviCx7RhrwkFYmW2bILknrfpm5P7r2nPlhympu7hz19GQkAkj9gvaOX788hHEmUI=  ;
Received: from [64.215.88.90] by web31805.mail.mud.yahoo.com via HTTP; Thu, 12 Oct 2006 12:31:07 PDT
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28793>

--- Junio C Hamano <junkio@cox.net> wrote:
> Currently it does what git-blame does, but only faster.
> 
> More importantly, its internal structure is designed to support
> content movement (aka cut-and-paste) more easily by allowing
> more than one paths to be taken from the same commit.

Good work.
 
> I have given only cursory check to its output (some files are
> blamed slightly differently from how git-blame does), but it

Details?  How differently?

> appears that there is no major breakage.  You can see for
> example try annotating builtin-apply.c starting from v1.4.0;
> there are two differences, which pickaxe assigns blame to older
> commits and both of them seem to be sensible.

Renames are naturally supported?

> diff --git a/Documentation/git-pickaxe.txt b/Documentation/git-pickaxe.txt
> new file mode 100644
> index 0000000..7f30cdf
> --- /dev/null
> +++ b/Documentation/git-pickaxe.txt
> @@ -0,0 +1,104 @@
> +git-pickaxe(1)
> +==============
> +
> +NAME
> +----
> +git-pickaxe - Show what revision and author last modified each line of a file
[...]
> +THE PORCELAIN FORMAT
> +--------------------
> +

Let's quantify the output:
---cut---
The porcelain format is as follows:

<SHA-1> <orig line> <line> [<num lines>
author <name>
author-mail <email format>
author-time <time>
author-tz <TZ>
committer <name>
committer-mail <email format>
committer-time <time>
committer-tz <TZ>
filename <string>
summary <string>]
<TAB><line data>

Where
  <SHA-1> is the SHA-1 of the commit which introduces this line.
  <orig line> it the line number where this line is introduced.
  <line> is the line number of the final file (at SHA-1 commit)

Then, if <SHA-1> is different from the previous line's SHA-1 (if no
previous then always different), a header follows.  It starts by the
number of lines that this <SHA-1> commit introduces, then on a new
line, information about about the commit is printed for the following
seveal lines, then newline, TAB, and the line data.

If, OTOH, <SHA-1> is the same as the previous line's <SHA-1> then the
header is not printed as indicated by brackets. Just newline,
TAB, and the line data.
---cut----

This kind of makes it slightly clearer.

Junio, is it possible to also print the "previous" commit?
I mean, is it tenable to print the commit such that
a "git-diff C B -- A:file" will give a diff of the block of lines
we're looking at?

Picture:

Annotate A:file
C B line 1
X D line 2
C B line 3
F G line 4
...

Currently we do not print "C, X, F", but only "B, D, G".
So in effect, <orig line> is the line of, wlg, "C:file"
where line 1 was introduced (by commit B). I.e.
the "parent" commit of that commit, which doesn't always
exist. (e.g. if the commit added the file)

Is this tenable?  If it is not or if it is going to make
it slow or ambiguous, lets forget about it.

     Luben
