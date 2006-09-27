From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Tue, 26 Sep 2006 23:49:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0609262320260.9088@attu4.cs.washington.edu>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
 <7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
 <7vejtxhlv6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 08:49:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSTEU-0001O3-Pg
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 08:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965396AbWI0GtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 02:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965397AbWI0GtY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 02:49:24 -0400
Received: from mx2.cs.washington.edu ([128.208.2.105]:37612 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S965396AbWI0GtX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 02:49:23 -0400
Received: from attu4.cs.washington.edu (attu4.cs.washington.edu [128.208.1.140])
	by mx2.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id k8R6nKJ2018389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Sep 2006 23:49:20 -0700
	(envelope-from rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost)
	by attu4.cs.washington.edu (8.13.7/8.13.7/Submit/1.2) with ESMTP id k8R6nKVc010153;
	Tue, 26 Sep 2006 23:49:20 -0700
	(envelope-from rientjes@cs.washington.edu)
X-Authentication-Warning: attu4.cs.washington.edu: rientjes owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejtxhlv6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27882>

On Tue, 26 Sep 2006, Junio C Hamano wrote:

> Well, the thing is, I end up being the guy who needs to stare at
> git code longer than you do ;-).
> 

Really?  This is the only community that hacks git?  There _are_ people 
out there that make their own changes specifically tailored to their 
purposes or that of their organization.

> Before --stat-width was introduced there was code like this:
> 
> 	if (max + len > 70)
> 		max = 70 - len;
> 
> Here "len" is the width of the filename part, and "max" is the
> number of changes we need to express.  The code is saying "if we
> use one column for each changed line, does graph and name exceed
> 70 columns -- if so use the remainder of the line after we write
> name for the graph".  Your "constant at right" rule makes this
> kosher.
> 
> If we make that to a variable, say line_width, we can still
> write:
> 
> 	if (max + len > line_width)
>         	...
> 
> I however tend to think "if line_width cannot fit (max + len)
> then we do this", which would be more naturally expressed with:
> 
> 	if (line_width < max + len)
>         	...
> 

First of all, it's not my "constant at right" rule, it's a preference that 
the _majority_ of computer programmers have used in virtually every 
language that you see source code for.

The grammar for C is

  relational-expression:
	shift-expression
	relational-expression < shift-expression

in this case.  Now while this supports both your variations above, it 
_suggests_ that the higher degree of computation is associated on the left 
side because the less-than operator associates that way.

What happens here:
	a < b < c

it turns out that this is equivalent to:
	(a < b) < c

so if you want your entire code base to conform to a particular style, 
it's _preferable_ to place the constant on the right.  And that's what the 
majority of programmers do.  Your taste is in the minority and out of 
respect to the code base you should make your code conform to what is most 
popular in the surrounding code.

Your argument of saying to yourself "if line_width cannot fit max + len 
then we do this" has no relevance at all.  I can say "if max + len is too 
big for line_width we do this" just the same.

If we're going by what sounds better in your head, then I expect _no_ 
argument when I write a function called conseguir_la_linea_longitud 
instead of get_line_length because Spanish is my first language.

Please respect what the majority of computer programmers write and unify 
the code base so that it's a similar style everywhere.

> > To change the code itself because of a hard 80-column limit or because 
> > you're tired of hitting the tab key is poor style.
> 
> Well, the program _firstly_ matches the logic flow better, and
> _in_ _addition_ if you write it another way it becomes
> unnecessarily too deeply indented.  So while I agree with you as a
> general principle that indentation depth should not dictate how
> we code it does not apply to this particular example.
> 

This is a ridiculous argument.  The C code will emit the exact same 
assembly regardless of how you write it.  You say that you wrote it that 
way to avoid idents which is an absolutely horrible way to dictate the 
code you use.  There are tons of opportunities where you can write cryptic 
source code that functions great with the least number of tokens and least 
number of lines to get the job done in every large project.  But, given 
that there are no assembler or performance tradeoffs, it should be written 
as clearly and nicely as possible for the reader.  I assert again what I 
did previously: if that if clause runs the length of my screen the indents 
will help me later to remember we're still in a conditional.  That's the 
SOLE purpose of indents: to make it easy for the reader to tell you're 
inside a block.  

And in one of your patches you had:
	if (...)
		;
	else {
		...
	}

without any other if statements.  If you're supporting that type of code, 
I'll simply consider this entire thread a lost cause.

		David
