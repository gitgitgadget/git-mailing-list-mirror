From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 20:59:46 +0100
Message-ID: <E8DD3CE1-F59A-457F-B6D4-23DF7AEAF962@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:00:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKcY-00062L-GM
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbYAHT7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 14:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbYAHT7y
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 14:59:54 -0500
Received: from mailer.zib.de ([130.73.108.11]:43813 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbYAHT7x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 14:59:53 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m08JwfGL029873;
	Tue, 8 Jan 2008 20:58:41 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m08Jwfm3004860
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 8 Jan 2008 20:58:41 +0100 (MET)
In-Reply-To: <20080108190952.GK22155@fieldses.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69908>


On Jan 8, 2008, at 8:09 PM, J. Bruce Fields wrote:

> On Tue, Jan 08, 2008 at 07:58:57PM +0100, Steffen Prohaska wrote:
>>
>> On Jan 8, 2008, at 7:07 PM, Junio C Hamano wrote:
>>
>>>
>>>
>>> Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:
>>>
>>>> msysgit installs plain git.  core.autocrlf is unset.  Whatever  
>>>> plain
>>>> git's default is, this is msysgit's default, too.
>>>
>>> That sounds like a mistake if you are installing a port to a
>>> platform whose native line ending convention is different from
>>> where plain git natively runs on (i.e. UNIX).
>>
>> We failed to agree on a better default and as the lengthy
>> discussion documents, the best default isn't obvious.
>>
>> I don't think a solution will be found by declaring one platform
>> native (UNIX) and all other platform non-native.  The question to
>> answer is how to support cross-platform projects.  A valid
>> solution should never corrupt data unless the user explicitly
>> told git to do so.
>
> My only suggestion is that we consider allowing the user that
> "explicitly told git to do so" be the project maintainer.  So if you
>
> 	echo * autodetectcrlf >.gitattributes
> 	git add .gitattributes
> 	git commit
>
> then users that clone your repo will get that default without  
> having to
> be told to do something magic on clone.
>
> (And ideally I'd've hoped you could do that using the existing crlf
> attribute rather than having to invent something new, but maybe that
> doesn't work.)

I like this idea.

I think we need the following:
  - if "autodetectcrlf" is set, git should guarantee that files in
    the repository will always have LF-only.  Otherwise the automatic
    conversion can't work.
  - git needs to support a way to select the preferred type of
    line endings based on the OS.  Unix users want to see LF,
    while Windows users want to see CRLF for the same file.

And we could implement it as follows:
  - We add a configuration variable that sets the preferred
    autocrlf conversion, for example core.defaultautocrlf.
  - We add a new string value "defaultauto" for crlf in .gitattributes.
    crlf=defaultauto is similar to setting crlf to "Unspecified", but
    also forces git to act as if core.autocrlf is set to
    $(core.defaultautocrlf).  That means if the content looks like text
    it will be converted according to the local settings.
  - On Unix, core.defaultautocrlf defaults to "input".
  - On Windows, core.defaultautocrlf defaults to "crlf".

This added layer of indirection gives us what we need:  The
file .gitattributes tells git to convert line endings; but the
details of the conversion depend on the environment (OS or
configuration).

	Steffen
