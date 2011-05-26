From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 1/2] t7508: demonstrate status's failure to use --porcelain
 format with -z
Date: Thu, 26 May 2011 17:51:26 -0500
Message-ID: <oxsohkXWsdC5MeWOTaXZMEPAVeHglxeXSUXEWJ6xA_rmLcm2iqjtpg@cipher.nrlssc.navy.mil>
References: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil> <7v4o4hw2zm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 00:51:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPjP7-0002xs-7D
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638Ab1EZWvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 18:51:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60748 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210Ab1EZWvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:51:40 -0400
Received: by mail.nrlssc.navy.mil id p4QMpR7D003142; Thu, 26 May 2011 17:51:27 -0500
In-Reply-To: <7v4o4hw2zm.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 26 May 2011 22:51:26.0927 (UTC) FILETIME=[71EF1DF0:01CC1BF7]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174591>

On 05/26/2011 04:45 PM, Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> When 'git status' is supplied the -z switch, and no output format has been
>> selected, it is supposed to use the --porcelain format.  This does not
>> happen.  Instead, the standard long format is used.  Add a test to
>> demonstrate this failure.
>>
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> 
> I didn't even know we attempted to default to porcelain when -z is given,
> even though it is a logical thing to do in the sense that nobody sane
> would want to read a NUL-terminated human readable format.

The behavior is derived from your original behavior where -z was
supposed to imply --short (see 173e6c8).  You even documented
it: 9e4b7ab :)  Later, Jeff added --porcelain (6f15787), and
updated the documentation:

   -z::
  -       Terminate entries with NUL, instead of LF.  This implies `-s`
  -       (short status) output format.
  +       Terminate entries with NUL, instead of LF.  This implies
  +       the `--porcelain` output format if no other format is given.

> I'll rewrite the test to avoid hardcoded and context dependent
> test vector, like this:
> 
>     test_expect_failure 'status -z implies porcelain' '
>            git status --porcelain |
>            perl -pe "s/\012/\000/g" >expect

Missing '&&' here.

>            git status -z >output &&
>            test_cmp expect output
>     '
> 
> as the only thing you are interested in is the two output to match
> identically modulo the record termination.

Thanks.

> By the way, don't we however also want to make sure -z does not kick in
> automatically when other options like "short" or "normal" is given?

It seems it was intended to be able to do

   git status -z --short

and since -z implies --porcelain if --short is not given, it is not
possible to produce "normal" long format and NUL termination at
the same time.

So, building on your modified test above, we could add something like:

     test_expect_failure 'status -z with -s works correctly' '
            git status -s |
            perl -pe "s/\012/\000/g" >expect &&
            git status -s -z >output &&
            test_cmp expect output
     '

Hopefully, the existing tests for status, without -z, will notice
if NUL termination kicks in when it is not supposed to.

-Brandon
