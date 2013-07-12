From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/7] cat-file: disable object/refname ambiguity check
 for batch mode
Date: Fri, 12 Jul 2013 10:47:46 +0200
Message-ID: <51DFC2B2.3080300@alum.mit.edu>
References: <20130712061533.GA11297@sigill.intra.peff.net> <20130712062004.GA15572@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 10:48:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxZ1C-0003JT-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 10:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397Ab3GLIrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 04:47:53 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59397 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757292Ab3GLIru (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 04:47:50 -0400
X-AuditID: 12074412-b7f656d00000102f-6c-51dfc2b5dbf4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 55.44.04143.5B2CFD15; Fri, 12 Jul 2013 04:47:49 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6C8llD6030778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Jul 2013 04:47:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130712062004.GA15572@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqLv10P1Ag70tmhZdV7qZLLqnvGW0
	+NHSw+zA7LFz1l12j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOWLryEUvBcvmKiSsPsTcw
	3pXoYuTkkBAwkWhfMJsVwhaTuHBvPVsXIxeHkMBlRomz25YyQTjXmCRmLfvKCFLFK6AtMfvE
	RjYQm0VAVeLo3Vdg3WwCuhKLepqBGjg4RAXCJK78VoUoF5Q4OfMJC4gtIiAr8f3wRrAxzAIZ
	EsdfzwGLCwtESXzasApspJBApsTHlbeZQGxOAWuJ0407wEYyC6hLrJ8nBNEqL7H97RzmCYwC
	s5BsmIVQNQtJ1QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYIYErtINx
	/Um5Q4wCHIxKPLwFJ+4FCrEmlhVX5h5ilORgUhLlrT5wP1CILyk/pTIjsTgjvqg0J7X4EKME
	B7OSCO9NM6Acb0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKYrAwHh5IE75qDQI2C
	RanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoCiNLwbGKUiKB2ivHMhNvMUFiblAUYjW
	U4zGHJPPbnnPyHHgB5AUYsnLz0uVEuddBLJJAKQ0ozQPbhEsZb1iFAf6W5iXA5jAhHiA6Q5u
	3iugVUxAq26vAltVkoiQkmpgVN2pda3PviiSgY9xU35u1+ucddtXu0uzB0zsftTx9V5c/2LV
	eY6Z3+/UBE/NfeHwpUnjf+efnX82bjv+oGujR4D6/LILf3ZmS/3s5uF96Cke/dBn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230185>

On 07/12/2013 08:20 AM, Jeff King wrote:
> A common use of "cat-file --batch-check" is to feed a list
> of objects from "rev-list --objects" or a similar command.
> In this instance, all of our input objects are 40-byte sha1
> ids. However, cat-file has always allowed arbitrary revision
> specifiers, and feeds the result to get_sha1().
> 
> Fortunately, get_sha1() recognizes a 40-byte sha1 before
> doing any hard work trying to look up refs, meaning this
> scenario should end up spending very little time converting
> the input into an object sha1. However, since 798c35f
> (get_sha1: warn about full or short object names that look
> like refs, 2013-05-29), when we encounter this case, we
> spend the extra effort to do a refname lookup anyway, just
> to print a warning. This is further exacerbated by ca91993
> (get_packed_ref_cache: reload packed-refs file when it
> changes, 2013-06-20), which makes individual ref lookup more
> expensive by requiring a stat() of the packed-refs file for
> each missing ref.
> 
> With no patches, this is the time it takes to run:
> 
>   $ git rev-list --objects --all >objects
>   $ time git cat-file --batch-check='%(objectname)' <objects
> 
> on the linux.git repository:
> 
>   real    1m13.494s
>   user    0m25.924s
>   sys     0m47.532s
> 
> If we revert ca91993, the packed-refs up-to-date check, it
> gets a little better:
> 
>   real    0m54.697s
>   user    0m21.692s
>   sys     0m32.916s
> 
> but we are still spending quite a bit of time on ref lookup
> (and we would not want to revert that patch, anyway, which
> has correctness issues).  If we revert 798c35f, disabling
> the warning entirely, we get a much more reasonable time:
> 
>   real    0m7.452s
>   user    0m6.836s
>   sys     0m0.608s
> 
> This patch does the moral equivalent of this final case (and
> gets similar speedups). We introduce a global flag that
> callers of get_sha1() can use to avoid paying the price for
> the warning.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The solution feels a little hacky, but I'm not sure there is a better
> one short of reverting the warning entirely.
> 
> We could also tie it to warn_ambiguous_refs (or add another config
> variable), but I don't think that makes sense. It is not about "do I
> care about ambiguities in this repository", but rather "I am going to
> do a really large number of sha1 resolutions, and I do not want to pay
> the price in this particular code path for the warning").
> 
> There may be other sites that resolve a large number of refs and run
> into this, but I couldn't think of any. Doing for_each_ref would not
> have the same problem, as we already know they are refs there.

ISTM that callers of --batch-check would usually know whether they are
feeding it SHA-1s or arbitrary object specifiers.  (And in most cases
when there are a large number of them, they are probably all SHA-1s).

So instead of framing this change as "skip object refname ambiguity
check" (i.e., sacrifice some correctness for performance), perhaps it
would be less hacky to offer the following new feature:

To cat-file we could add an option like "--sha1-only" or "--literal" or
"--no-dwim" (... better names are failing me) which would skip *all*
dwimming of 40-character strings.  It would also assume that any shorter
strings are abbreviated SHA-1s and fail if they are not.  This would be
a nice feature by itself ("these are object names, dammit, and don't try
to tell me differently!") and would have the additional small advantage
of speeding up lookups of abbreviated SHA-1s, which (regardless of your
patch) otherwise go through the whole DWIM process.

I understand that such an option alone would leave some old scripts
suffering the performance regression caused by the check, but in most
cases it would be easy to fix them.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
