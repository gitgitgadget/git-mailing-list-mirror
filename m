From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Fri, 13 Jul 2012 13:40:30 -0400
Message-ID: <50005D8E.1020407@windriver.com>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com> <7vhatcc1ql.fsf@alter.siamese.dyndns.org> <4FFF1821.7030705@windriver.com> <7va9z4byl3.fsf@alter.siamese.dyndns.org> <4FFF2720.6090705@windriver.com> <7v629sbvh8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 19:40:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spjr7-00084H-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 19:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab2GMRkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 13:40:37 -0400
Received: from mail1.windriver.com ([147.11.146.13]:54146 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab2GMRkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 13:40:35 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6DHeVAM022393
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 13 Jul 2012 10:40:31 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Fri, 13 Jul 2012
 10:40:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7v629sbvh8.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201411>

On 12-07-12 04:00 PM, Junio C Hamano wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>>>>> This is _NOT_ fine, especially if you suggest "patch" the user may
>>>>> not have, and more importantly does not have a clue why "git apply"
>>>>> rejected it ("am" does _not_ use "patch" at all).
>>>>
>>>> I'm not 100% sure I'm following what part here is not OK.  If you
>>>> can help me understand that, I'll respin the change accordingly.
>>>
>>> Do not ever mention "patch -p1".  It is not the command that "git
>>> am" uses, and it is not what detected the breakage in the patch.
>>
>> This may be true, but it _is_ the command that I (and others) have
>> defaulted to using, if for no other reason than ignorance.
>>>
>>> The command to guide the user to is "git apply".
>>
>> OK.  But I don't see a "--dry-run" equivalent -- and "git apply --check"
>> just gives me a repeat of the same fail messages that "git am" did.
>>
>> With "patch -p1 --dry-run"  I get information that immediately
>> lets me see whether the patch is viable or not.
> 
> What do you mean by "viable"?  

Sorry, that description was a bit context free.  Two typical cases:

1) applying a series of commits (e.g. preempt RT feature) to a newer
baseline. Some of those commits may have been upstreamed and now
present in mainline.  The "git am" failure doesn't really hint that
"already applied" may be the case -- e.g. consider and compare the
output when we extract and then intentionally try to re-apply something
already in tree, created with:

-------------
$git format-patch 50fb31cf~..50fb31cf
0001-tty-hvc_opal-Fix-debug-function-name.patch
-------------

With "git am":
--------------------------
$git am 0001-tty-hvc_opal-Fix-debug-function-name.patch
Applying: tty/hvc_opal: Fix debug function name
error: patch failed: drivers/tty/hvc/hvc_opal.c:401
error: drivers/tty/hvc/hvc_opal.c: patch does not apply
Patch failed at 0001 tty/hvc_opal: Fix debug function name
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
---------------------------

...versus 

---------------------------
$patch -p1 --dry-run < 0001-tty-hvc_opal-Fix-debug-function-name.patch 
patching file drivers/tty/hvc/hvc_opal.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/tty/hvc/hvc_opal.c.rej
---------------------------

...versus

---------------------------
$git apply -p1 0001-tty-hvc_opal-Fix-debug-function-name.patch
error: patch failed: drivers/tty/hvc/hvc_opal.c:401
error: drivers/tty/hvc/hvc_opal.c: patch does not apply
---------------------------

Maybe there is an easy way to teach git am/apply to detect "previously
applied" in a way similar to patch?  The closest I could come to that
was "git apply --check -R ..." and seeing what it said (or didn't say).

2) In maintaining linux stable releases (esp older ones), the dry-run
output, if say it says something like 23/30 chunks failed, it tells me
that the underlying baseline has probably changed too much for a simple
backport.  But if only 1/30 chunks fail or similar, I'll simply proceed
since the backport is viable and likely trivial.

Paul.
--

> 
> Independent from the answer to that question...
> 
> Running "git apply -p1" would by definition give you the same
> failure without --dry-run (because you know it already failed), no?
> Then you could ask for rejects or attempt to apply with reduced
> contexts to "git apply" all without having to say --dry-run, as
> unapplicable change will not be applied.
> 
