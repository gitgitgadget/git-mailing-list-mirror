From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] obstack.c: Fix some sparse warnings
Date: Wed, 14 Sep 2011 00:18:55 +0100
Message-ID: <4E6FE4DF.7060200@ramsay1.demon.co.uk>
References: <4E6D0B7D.9070602@ramsay1.demon.co.uk> <CAGdFq_ifU2WWbCpRY_EFY=_hwwtFs0eqMhJ7sRoUhrivABFoFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 01:26:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3cNH-0006Md-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 01:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933074Ab1IMX0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 19:26:39 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:36284 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933030Ab1IMX0i (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 19:26:38 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1R3cN1-0005B9-e5; Tue, 13 Sep 2011 23:26:37 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <CAGdFq_ifU2WWbCpRY_EFY=_hwwtFs0eqMhJ7sRoUhrivABFoFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181324>

Sverre Rabbelier wrote:
> Heya,
> 
> On Sun, Sep 11, 2011 at 21:26, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>>    compat/obstack.c:399:1: error: symbol 'print_and_abort' redeclared with \
>>        different type (originally declared at compat/obstack.c:95) \
>>        - different modifiers
> 
>> @@ -395,7 +395,6 @@ _obstack_memory_used (struct obstack *h)
>>  # endif
>>
>>  static void
>> -__attribute__ ((noreturn))
>>  print_and_abort (void)
>>  {
>>   /* Don't change any of these strings.  Yes, it would be possible to add
> 
> Wouldn't the better solution be to add noreturn to the declaration at
> compat/obstack.c:95?

Hmm, well ... maybe; it is at least debatable. But I decided no! :-D

First, although I would not dismiss the possibility of some optimization
of the code of print_and_abort() (the *callee*), the main benefit of the
noreturn attribute should in fact be at the call sites (ie the *caller*).
So, yes, in general, the declaration of the function should have the
noreturn attribute applied, in addition to the definition, in order to
allow the compiler to apply some optimizations to the call sites.

[Note, also, that we should use the NORETURN and NORETURN_PTR macros.]

In this case, however, there are no (direct) call sites. This function
would only be called indirectly via the 'obstack_alloc_failed_handler'
function pointer. So, this would require the use of NORETURN_PTR on
that function pointer. In order to keep both the compiler(s) and sparse
happy, the required change would look like the diff given at the end
of this mail.

This would work fine, and I would happily change the patch to include
this if it is deemed the better approach. However, I looked at the
call sites in _obstack_begin[_1](), and  _obstack_newchunck() and could
not see any great opportunity for optimizing the code ... so I decided
to go for the simpler patch ...

ATB,
Ramsay Jones

-- >8 --
diff --git a/compat/obstack.c b/compat/obstack.c
index a89ab5b..2029b8f 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -92,8 +92,8 @@ enum
    abort gracefully or use longjump - but shouldn't return.  This
    variable by default points to the internal function
    `print_and_abort'.  */
-static void print_and_abort (void);
-void (*obstack_alloc_failed_handler) (void) = print_and_abort;
+static void NORETURN print_and_abort (void);
+NORETURN_PTR void (*obstack_alloc_failed_handler) (void) = print_and_abort;
 
 # ifdef _LIBC
 #  if SHLIB_COMPAT (libc, GLIBC_2_0, GLIBC_2_3_4)
@@ -395,7 +395,7 @@ _obstack_memory_used (struct obstack *h)
 # endif
 
 static void
-__attribute__ ((noreturn))
+NORETURN
 print_and_abort (void)
 {
   /* Don't change any of these strings.  Yes, it would be possible to add
diff --git a/compat/obstack.h b/compat/obstack.h
index d178bd6..122f93f 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -194,7 +194,7 @@ void obstack_free (struct obstack *, void *);
    more memory.  This can be set to a user defined function which
    should either abort gracefully or use longjump - but shouldn't
    return.  The default action is to print a message and abort.  */
-extern void (*obstack_alloc_failed_handler) (void);
+extern NORETURN_PTR void (*obstack_alloc_failed_handler) (void);
 
 /* Pointer to beginning of object being allocated or to be allocated next.
    Note that this might not be the final address of the object
