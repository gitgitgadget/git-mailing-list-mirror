From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 30 Jul 2008 07:35:19 +0200
Message-ID: <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de>
References: <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org> <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:36:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO4MA-00044h-LZ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYG3FfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYG3FfN
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:35:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:33606 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbYG3FfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:35:12 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6U5YxW1008728;
	Wed, 30 Jul 2008 07:35:04 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db97607.pool.einsundeins.de [77.185.118.7])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6U5YvUS010208
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 30 Jul 2008 07:34:57 +0200 (MEST)
In-Reply-To: <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90745>


On Jul 29, 2008, at 11:17 PM, Eyvind Bernhardsen wrote:

>>> As you say, the reason I want the setting to be per-repository is  
>>> that
>>> I don't think the cost is worthwhile for every repository.
>>
>> Side note: Personally, I am not very concerned about this cost, but  
>> some
>> people are...
>
> Yeah :)
>
> I think the real penalty is that with autocrlf enabled, Git no  
> longer stores exactly what I committed.

Git does *never* exactly store what you committed.  Git compresses
your data and creates packs containing many of your individual
files in a single pack.

What matters is that git gives you exactly back what you committed.  It
does so with core.autocrlf=true, unless you check out with a different
setting for autocrlf.  There is a small chance that git decides that
a file is text even though it should be binary and that the content of
this file does not allow for reversible CRLF-conversion.  In this case
git warns about the irreversible conversion and the user gets a chance
to correct git's choice.

We accept this slight chance of irreversible conversion because we do
want to handle line-endings of text files for cross-platform use.  For
this, the goal of "giving you *exactly* back what you committed" is
modified.  Instead, we want to give you exactly back what you committed,
except for line-endings (in text files), which should be converted to
the platform-dependent line-endings (LF or CRLF), depending on the  
user's
setting.

Because of a design choice we made, CRLF must be converted on Windows.
We decided that the token that git uses *internally* to represent
a line-ending in a text file is LF.  We made this choice because git
originally supported only Unix and so we chose the Unix line-ending for
representing line-endings internally.  Now, Windows uses CRLF to
indicate line-endings but git internally uses LF, so we must convert
them.  Note that if we had users that completely ignored their native
Windows environment and only used well-selected tools, all configured to
*never* write native Windows line-ending, for these users we could set
autocrlf=false and the repository would nonetheless only contain LFs.
Those exceptional super-expert users could manually modify their
settings.  The average user (including me) will not be able to guarantee
that he will never create CRLF in text files on Windows.  Those users
simply accept that they work on Windows and use the native line-endings
(CRLF) and because we care about these average users we set  
autocrlf=true.

In contrast, setting autocrlf=input on Unix is only a safety valve.  The
average user who is only working on Unix will most likely *never* create
CRLF line-endings.  In a Unix-only environment it is actually very hard
to create CRLF line-endings.  Thus, the current default (autocrlf unset)
assumes that all text files on Unix contain only LF, and git wants LF
internally, which means we do not need to convert the line-endings.  In
cross-platform environments however, our assumption that all files on
Unix contain only LFs probably no longer holds.  In a cross-platform
environment you can easily copy files from Windows to Unix and thus
*easily* create files on Unix that contains CRLF.  In this case
autocrlf=input can save you, by correcting the line-endings for you.  In
this case, git *does not* give you exactly back what you committed, but
gives you back the very same text you committed however with the native
LF line-endings.

Personally I believe that our assumption that it is virtually impossible
to unintentionally create CRLF line-endings on Unix is wrong; but the
prevailing opinion on the list is different.  Personally, I believe that
autocrlf=input should be the default on Unix to shield the repository
from CRLFs.  I am using autocrlf=input for some time now and it has
already saved me several times.  Note that I am not working in a
Unix-only environment, but in a mixed Unix/Mac/Windows environment, so
unintentionally creating CRLFs is quite easy.

Another valid concern is speed.  But the timings that Dmitry presented
indicate that the overhead of autocrlf is so small that it is hard to
measure in practice.  I think we should stop raising this concern unless
someone comes up with timings that indicate a larger overhead than
measured by Dmitry.

	Steffen
