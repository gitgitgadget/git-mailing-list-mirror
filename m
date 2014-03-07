From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Fri, 07 Mar 2014 08:23:05 +0100
Message-ID: <531973D9.9070803@viscovery.net>
References: <20140305003639.GA9474@sigill.intra.peff.net> <5316D922.9010501@viscovery.net> <20140306212835.GA11743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 07 08:23:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLp7l-0000pa-7K
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 08:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbaCGHXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 02:23:12 -0500
Received: from so.liwest.at ([212.33.55.23]:45734 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbaCGHXL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 02:23:11 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WLp7Z-0006wH-Vt; Fri, 07 Mar 2014 08:23:06 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 99BB316613;
	Fri,  7 Mar 2014 08:23:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20140306212835.GA11743@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243603>

Am 3/6/2014 22:28, schrieb Jeff King:
> On Wed, Mar 05, 2014 at 08:58:26AM +0100, Johannes Sixt wrote:
>> The pattern I chose also catches variable definition, not just
>> functions. That is what I need, but it hurts grep --function-context
>> That's the reason I didn't forward the patch, yet.
> 
> If by variable definition you mean:
> 
>    struct foo bar = {
>   -       old
>   +       new
>    };
> 
> I'd think that would be covered by the existing "struct|class|enum".
> Though I think we'd want to also allow keywords in front of it, like
> "static". I suspect the original was more meant to find:
> 
>    struct foo {
>   -old
>   +new
>    };

No, I meant lines like

    static double var;
   -static int old;
   +static int new;

The motivation is to show hints where in a file the change is located:
Anything that could be of significance for the author should be picked up.

But that does not necessarily help grep --function-context. For example,
when there is a longish block of global variable definitions and there is
a match in the middle, then --function-context would provide no context
because the line itself would be regarded as the beginning of a
"function", i.e., the context, and the next line (which also matches the
pattern) would be the beginning of the *next* function, and would not be
in the context anymore.

> 
>> The parts of the pattern have the following flaws:
>>
>> - The first part matches an identifier followed immediately by a colon and
>>   arbitrary text and is intended to reject goto labels and C++ access
>>   specifiers (public, private, protected). But this pattern also rejects
>>   C++ constructs, which look like this:
>>
>>     MyClass::MyClass()
>>     MyClass::~MyClass()
>>     MyClass::Item MyClass::Find(...
> 
> Makes sense. I noticed your fix is to look for end-of-line or comments
> afterwards.  Would it be simpler to just check for a non-colon, like:
> 
>   !^[ \t]*[A-Za-z_][A-Za-z_0-9]*:($|[^:])

I want to match [[:space:]] after the label's colon, because I have lot's
of C++ files with CRLF, and I need to match the CR. Your more liberal
pattern would fit as well, although it would pick up a bit field as in

   struct foo {
      unsigned
        flag: 1;
   -old
   +new

I would not mind ignoring this case ("garbage in, garbage out" ;-).

>> - The second part matches an identifier followed by a list of qualified
>>   names (i.e. identifiers separated by the C++ scope operator '::')
>> [...]
> 
> A tried to keep the "looks like a function definition" bit in mine, and
> yours loosens this quite a bit more. I think that may be OK. That is, I
> do not think there is any reason for somebody to do:
> 
>     void foo() {
>     call_to_bar();
>    -old
>    +new
>     }
> 
> That is, nobody would put a function _call_ without indentation. If
> something has alphanumerics at the left-most column, then it is probably
> interesting no matter what.
> 
>> - The third part of the pattern finally matches compound definitions. But
>>   it forgets about unions and namespaces, and also skips single-line
>>   definitions
>>
>>     struct random_iterator_tag {};
>>
>>   because no semicolon can occur on the line.
> 
> I don't see how that is an interesting line. The point is to find a
> block that is surrounding the changes, but that is not surrounding
> the lines below.

I more often than not want to have an answer to the question "where?", not
"wherein?" Then anything that helps locate a hunk is useful.

(The particular example, an empty struct, looks strange for C programmers,
of course, but it's a common idiom in C++ when it comes to template
meta-programming.)

>> Notice that all interesting anchor points begin with an identifier or
>> keyword. But since there is a large variety of syntactical constructs after
>> the first "word", the simplest is to require only this word and accept
>> everything else. Therefore, this boils down to a line that begins with a
>> letter or underscore (optionally preceded by the C++ scope operator '::'
>> to accept functions returning a type anchored at the global namespace).
>> Replace the second and third part by a single pattern that picks such a
>> line.
> 
> Yeah, this bit makes sense to me.
> 
> Both yours and mine will find the first line here in things like:
> 
>    void foo(void);
>   -void bar(void);
>   +void bar(int arg);
> 
> but I think that is OK. There _isn't_ any interesting surrounding
> context here. The current code will sometimes come up with an empty
> funcline (which is good), but it may just as easily come up with a
> totally bogus funcline in a case like:
> 
>    void unrelated(void)
>    {
>    }
> 
>    void foo(void);
>   -void bar(void);
>   +void bar(int arg);
> 
> So trying to be very restrictive and say "that doesn't look like a
> function" does not really buy us anything (and it creates tons of false
> negatives, as you documented, because C++ syntax has all kinds of crazy
> stuff).
> 
> _If_ the backwards search learned to terminate (e.g., seeing the "^}"
> line and saying "well, we can't be inside a function"), then such
> negative lines might be useful for coming up with an empty funcname
> rather than the bogus "void foo(void);". But we do not do that
> currently, and I do not think it is that useful (the funcname above is
> arguably just as or more useful than an empty one).

As I said, my motivation is not so much to find a "container", but rather
a clue to help locate a change while reading the patch text. I can speak
for myself, but I have no idea what is more important for the majority.

-- Hannes
