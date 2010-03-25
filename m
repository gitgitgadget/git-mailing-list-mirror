From: hachi <hachi@kuiki.net>
Subject: Re: asciidoc problem, and a possible fix
Date: Thu, 25 Mar 2010 02:15:21 -0700
Message-ID: <167EA641-2D5F-4553-909C-DF5D050CEDFB@kuiki.net>
References: <4ABB29E2-6DB1-4712-A3E8-CD524983FB0B@kuiki.net> <7vljdhjk9r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 10:15:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NujA7-0000UE-3c
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 10:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab0CYJP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 05:15:29 -0400
Received: from sachiko.kuiki.net ([80.68.89.100]:42294 "EHLO sachiko.kuiki.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab0CYJP2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 05:15:28 -0400
Received: from sf-mbp-hachi.harrison.succub.us (unknown [76.14.55.252])
	by sachiko.kuiki.net (Postfix) with ESMTP id 2D9EAC027;
	Thu, 25 Mar 2010 09:15:25 +0000 (UTC)
In-Reply-To: <7vljdhjk9r.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143173>

Junio,

The short version:

>From asciidoc 8.4.1 to 8.5.0 nested inline passthrough (like +++ inside ``) cannot be used because the internal markers (\x07, BEL) will be emitted in the output.

asciidoc >= 8.4.2 will warn, and >= 8.5.0 will warn and do the right thing.

The +++ inside the `` that I'm getting rid of appear to be extraneous (I tested on an old 8.2.7 asciidoc).

I suggest applying my patch because it seems to be the right thing overall. More gory details follow.


The long version:

Thanks for telling me what this feature was called, now the changelog makes sense about this.

I'm running asciidoc 8.4.1, and in that version:

* Backtick quoting for monospaced text is now implemented as an inline literal passthrough. This makes more sense since monospace text is usually intended to be rendered literally.

which means that the line I'm on has a nested inline passthrough, of which a warning was added in asciidoc 8.4.2 (a quick test on a more modern distro shows):

asciidoc: WARNING: git-filter-branch.txt: line 391: nested inline passthrough

And then nested inline was fixed, in addition to the warning, in 8.5.0:

* FIXED: Only the first occurrence of passthrough macro was substituted. Patch submitted by Peter Johnson. See http://groups.google.com/group/asciidoc/browse_frm/thread/1269dc2feb1a482c


End conclusion:

* Option 1

My patch is correct because nested inline passthrough doesn't do anything other than confuse the asciidoc parser. However, this means that prior to asciidoc 8.4.1 the inside of backtick strings are not inline passthrough. I have no idea if this is a bad thing, but it seems to not actually matter in my test using asciidoc 8.2.6.

I do suggest applying my patch, actually. Let me know if I need to submit it a different way.

* Option 2

Consider enabling the asciidoc -a no-inline-literal option. This seems like it's a way to go back to the pre 8.4.1 behavior, but I can't tell if that's even right, and this seems to be a bad thing overall.

Thanks for reading, but I did tell you this was the long version down here ;)

--hachi

On Mar 24, 2010, at 5:51 PM, Junio C Hamano wrote:

> hachi <hachi@kuiki.net> writes:
> 
>> I had an issue building git on some centos 5 machines today, and in trying to interpret the error message I formed the attached patch.
>> 
>> The errors were:
>> xmlto: input does not validate (status 1)
>> /home/hachi/rpm/BUILD/git-1.7.0.3/Documentation/git-filter-branch.xml:463: parser error : PCDATA invalid Char value 7
>> Clone it with <literal>git clone +++0+++</literal>.  The clone
>>                                    ^
> 
> A shot in the dark without sufficient information I could try to make is
> that you are trying to use an ancient AsciiDoc, perhaps pre-7.1.2?
> 
> I am guessing that the following entry from their ChangeLog:
> 
>    Version 7.1.2 (2006-03-07)
>    --------------------------
>    .Additions and changes
>     ...
>    - An 'inline passthrough' mechanism has been implemented.
> 
> refers to this "triple-plus" passthrough, documented in:
> 
>    http://www.methods.co.nz/asciidoc/userguide.html#X77
> 
> As the use of feature is isolated to only the documentation for filter-branch,
> I am personally Ok with replacing that passthru with a simpler formatting
> element that is supported by an ancient version of AsciiDoc (but I didn't
> look at your patch in the attachment).
> 
> 
