From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 08:06:29 +0200
Message-ID: <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de> <20080723114022.GP2925@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 08:08:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLtzc-0003AX-Q0
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 08:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbYGXGG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 02:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbYGXGG7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 02:06:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:52795 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbYGXGG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 02:06:58 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6O667Yp001203;
	Thu, 24 Jul 2008 08:06:12 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db912b9.pool.einsundeins.de [77.185.18.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6O665B9003815
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 24 Jul 2008 08:06:06 +0200 (MEST)
In-Reply-To: <20080723114022.GP2925@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89838>


On Jul 23, 2008, at 1:40 PM, Dmitry Potapov wrote:

> On Wed, Jul 23, 2008 at 07:49:20AM +0200, Steffen Prohaska wrote:
>>
>> On Jul 23, 2008, at 3:31 AM, Johannes Schindelin wrote:
>>
>>>
>>> -	if ((action == CRLF_BINARY) || !auto_crlf || !len)
>>> +	if ((action == CRLF_BINARY) || (!auto_crlf && action < 0) || !len)
>>
>> I think we should strictly follow the documentation, so this should  
>> read
>>
>> +       if ((action == CRLF_BINARY) || (!auto_crlf && action !=
>> CRLF_INPUT) || !len)
>
> Well, your expression is correct if we choose to strictly follow to  
> what
> the current documentation says, but it is not well written in this  
> place,
> and, more importantly, I don't see any use case where you would want  
> to
> set crlf=input in .gitattributes, because it is shared among users on
> different platforms. What you want to specify in it is whether a  
> file is
> text or binary. If crlf is set, it means a text file; if unset, it  
> is a
> binary file. Regardless of what autocrlf value, I don't see why a text
> file should be checked in with CRs. So, Dscho's patch makes more sense
> to me.  This requires correction to the documentation though:

Ok, this and Dscho's earlier mail convinced me.  My patch does not
make sense at all.  I should have had thought a bit harder ;-)

I have however a related question:

Dscho,
Is the following your use case?

  "I am the maintainer of this project.  I know that this project needs
   crlf conversion, because it is a cross-platform project.  Therefore,
   I want to force crlf conversion for this specific project, even if
   the user did not configure core.autocrlf=input on Unix."

Your patch provides a solution, though not a very comfortable one.  With
your patch applied, you could explicitly list all files (or filetypes)
that are text and mark them with 'crlf'.  Git would not let CRLFs enter
the repository for these files.  You could also specify 'crlf=input',
but I don't understand why you want to specify this.  Anyway, you would
need to explicitly list all text filetypes and explicitly *not list* the
binary filetypes because they must not be converted.  This is no very
comfortable, no?

I think what you really want to do is to tell git that the *automatic*
crlf detection shall be used for all files of your specific project,
even if the user did not configure core.autocrlf=input.  This would
avoid listing each filetype separately.

Maybe we could allow 'crlf=guess' in .gitattributes with the following
documentation:

-- 8< --
Set to string value "guess"::

	Setting `guess` tells git to apply conversion upon checkin
         if the file content looks like text.  On checkout, however,
         git applies the conversion specified in `core.autocrlf`.
         Setting `guess` can be useful to force automatic file type
         detection for a specific project.
-- >8 --


> diff --git a/Documentation/gitattributes.txt b/Documentation/ 
> gitattributes.txt
> index d7b4114..448857b 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -99,9 +99,9 @@ This attribute controls the line-ending convention.
> Set::
>
> 	Setting the `crlf` attribute on a path is meant to mark
> -	the path as a "text" file.  'core.autocrlf' conversion
> -	takes place without guessing the content type by
> -	inspection.
> +	the path as a "text" file. Line endings in a text file
> +	are converted to LF upon checkin, and if 'core.autocrlf'
> +	is true then to CRLF upon checkout.
>
> Unset::

Makes sense.

	Steffen
