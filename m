From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Wed, 05 Mar 2014 08:58:26 +0100
Message-ID: <5316D922.9010501@viscovery.net>
References: <20140305003639.GA9474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 08:58:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL6ir-0007mx-Ix
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 08:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbaCEH6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 02:58:33 -0500
Received: from so.liwest.at ([212.33.55.23]:40247 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbaCEH6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 02:58:32 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WL6ig-0000ZZ-Dj; Wed, 05 Mar 2014 08:58:26 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 03F7D16613;
	Wed,  5 Mar 2014 08:58:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20140305003639.GA9474@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243424>

Am 3/5/2014 1:36, schrieb Jeff King:
> The current funcname matcher for C files requires one or
> more words before the function name, like:
> 
>   static int foo(int arg)
>   {
> 
> However, some coding styles look like this:
> 
>   static int
>   foo(int arg)
>   {
> 
> and we do not match, even though the default regex would.
> 
> This patch simplifies the regex significantly. Rather than
> trying to handle all the variants of keywords and return
> types, we simply look for an identifier at the start of the
> line that contains a "(", meaning it is either a function
> definition or a function call, and then not containing ";"
> which would indicate it is a call or declaration.

Here is a patch that I'm carrying around since... a while.
What do you think?

The pattern I chose also catches variable definition, not just
functions. That is what I need, but it hurts grep --function-context
That's the reason I didn't forward the patch, yet.

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 25 Sep 2012 14:08:02 +0200
Subject: [PATCH] userdiff: have 'cpp' hunk header pattern catch more C++ anchor points

The hunk header pattern 'cpp' is intended for C and C++ source code, but
it is actually not very useful for the latter, and even hurts some
use-cases for the former.

The parts of the pattern have the following flaws:

- The first part matches an identifier followed immediately by a colon and
  arbitrary text and is intended to reject goto labels and C++ access
  specifiers (public, private, protected). But this pattern also rejects
  C++ constructs, which look like this:

    MyClass::MyClass()
    MyClass::~MyClass()
    MyClass::Item MyClass::Find(...

- The second part matches an identifier followed by a list of qualified
  names (i.e. identifiers separated by the C++ scope operator '::')
  separated by space or '*' followed by an opening parenthesis (with space
  between the tokens). It matches function declarations like

    struct item* get_head(...
    int Outer::Inner::Func(...

  Since the pattern requires at least two identifiers, GNU-style function
  definitions are ignored:

    void
    func(...

  Moreover, since the pattern does not allow punctuation other than '*',
  the following C++ constructs are not recognized:

  . template definitions:
      template<class T> int func(T arg)

  . functions returning references:
      const string& get_message()

  . functions returning templated types:
      vector<int> foo()

  . operator definitions:
      Value operator+(Value l, Value r)

- The third part of the pattern finally matches compound definitions. But
  it forgets about unions and namespaces, and also skips single-line
  definitions

    struct random_iterator_tag {};

  because no semicolon can occur on the line.

Change the first pattern to require a colon at the end of the line (except
for trailing space and comments), so that it does not reject constructor
or destructor definitions.

Notice that all interesting anchor points begin with an identifier or
keyword. But since there is a large variety of syntactical constructs after
the first "word", the simplest is to require only this word and accept
everything else. Therefore, this boils down to a line that begins with a
letter or underscore (optionally preceded by the C++ scope operator '::'
to accept functions returning a type anchored at the global namespace).
Replace the second and third part by a single pattern that picks such a
line.

This has the following desirable consequence:

- All constructs mentioned above are recognized.

and the following likely desirable consequences:

- Definitions of global variables and typedefs are recognized:

    int num_entries = 0;
    extern const char* help_text;
    typedef basic_string<wchar_t> wstring;

- Commonly used marco-ized boilerplate code is recognized:

    BEGIN_MESSAGE_MAP(CCanvas,CWnd)
    Q_DECLARE_METATYPE(MyStruct)
    PATTERNS("tex",...)

  (The last one is from this very patch.)

but also the following possibly undesirable consequence:

- When a label is not on a line by itself (except for a comment) it is no
  longer rejected, but can appear as a hunk header if it occurs at the
  beginning of a line:

    next:;

IMO, the benefits of the change outweigh the (possible) regressions by a
large margin.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 userdiff.c                                 | 8 +++-----
 13 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index ed958ef..49b2094 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -125,11 +125,9 @@ PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
 PATTERNS("cpp",
 	 /* Jump targets or access declarations */
-	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
-	 /* C/++ functions/methods at top level */
-	 "^([A-Za-z_][A-Za-z_0-9]*([ \t*]+[A-Za-z_][A-Za-z_0-9]*([ \t]*::[ \t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"
-	 /* compound type at top level */
-	 "^((struct|class|enum)[^;]*)$",
+	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
+	 /* functions/methods, variables, and compounds at top level */
+	 "^((::[[:space:]]*)?[A-Za-z_].*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-- 
1.9.0.1398.g59a4f1b
