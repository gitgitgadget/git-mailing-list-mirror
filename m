From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Fri, 20 Feb 2015 23:11:17 +0100
Message-ID: <54E7B105.8020100@web.de>
References: <54BD3D14.90309@web.de> <20150122200702.GA96498@vauxhall.crustytoothpaste.net> <54C17429.1090403@web.de> <20150122234117.GD96498@vauxhall.crustytoothpaste.net> <xmqqtwyj2hdk.fsf@gitster.dls.corp.google.com> <54E61285.5070600@web.de> <xmqq386123df.fsf@gitster.dls.corp.google.com> <20150219194050.GA5021@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
X-From: git-owner@vger.kernel.org Fri Feb 20 23:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOvnY-0006Ih-FR
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 23:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517AbbBTWLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 17:11:44 -0500
Received: from mout.web.de ([212.227.17.12]:59682 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089AbbBTWLn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 17:11:43 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MWSBi-1Y4bvl1hr0-00XZRH; Fri, 20 Feb 2015 23:11:23
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150219194050.GA5021@vauxhall.crustytoothpaste.net>
X-Provags-ID: V03:K0:7P34pEHOw9JbHhMRcc0EuFvFUFTYKcJj1BGgCqZ7HiCFi+XXhsV
 zG0Hz4sNAgLWVlElLnn7Y1C3JnEYVC7jinxPrp0aMw9yKQqY1ZrhTCT+BBihmJyncUSIJRg
 Mh8VtzOZIQRARshMB/LYcSxeZRDG24XDk/VW5Hm0GR211PiJ2DdrHL5D20wlQIF/WiyNj85
 f8Zt4DmJOgyImTMzrLuZg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264190>

On 2015-02-19 20.40, brian m. carlson wrote:
> On Thu, Feb 19, 2015 at 09:54:52AM -0800, Junio C Hamano wrote:
>> I can see that you do not agree with the "If we accept it" part
>> (where "it" refers to "allowing [...] was a bug.")---past acceptance
>> was not a bug for you.
Do we talk about the same thing here ?

The support for the ssh://host/path was introduced 2005, I think here:
commit 2386d65822c912f0889ac600b1698b0659190133
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Jul 13 18:46:20 2005 -0700

    Add first cut at "git protocol" connect logic.
------------

It happily accepted everything for host, including 
 ssh://bmc@2001:470:1f05:79::1/git/bmc/homedir.git/

And this was the only way to connect to a server using a literal IPV6
address, the support for [] came in later.

Today, in 2015, we can declare this syntax as deprecated, no problem.

The parser we have in git.master does not handle URLs like
ssh://bmc@[2001:470:1f05:79::1]/git/bmc/homedir.git/ correctly.

Instead of this,
ssh://[bmc@2001:470:1f05:79::1]/git/bmc/homedir.git/
needs to be used, and this is the main purpose of the series.
(If we ignore updates of the test cases, which I think are good
to prevent regressions)


I could probably shorten the commit message of [1/3] to read like this: 

  Improve the parsing to handle URLs which have a user name and a literal
    IPV6 like "ssh://user@[2001:db8::1]/repo.git".
    (Thanks to Christian Taube <lists@hcf.yourweb.de> for reporting this long
    standing issue)


>>
>> Brian is for that "If we accept it", and sees it as a bug.
>>
>> So let's see what he comes up with as a follow-up to the "we should
>> explicitly document it" part.
> 
> Here's what I propose:
> 
> -- >8 --
> Subject: [PATCH] Documentation: note deprecated syntax for IPv6 SSH URLs
> 
> We have historically accepted some invalid syntax for SSH URLs
> containing IPv6 literals.  Older versions of Git accepted URLs missing
> the brackets required by RFC 2732.  Note that this behavior is
> deprecated and that other protocol handlers will not accept this syntax.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> Documentation/urls.txt | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 9ccb246..2c1a84f 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -38,6 +38,10 @@ The ssh and git protocols additionally support ~username expansion:
> - git://host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
> - {startsb}user@{endsb}host.xz:/~{startsb}user{endsb}/path/to/repo.git/
> 
> +For backwards compatibility reasons, Git, when using ssh URLs, accepts
> +some URLs containing IPv6 literals that are missing the brackets. This
> +syntax is deprecated, and other protocol handlers do not permit this.
> +
> For local repositories, also supported by Git natively, the following
> syntaxes may be used:
> 
