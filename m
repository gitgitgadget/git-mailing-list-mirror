From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] submodule add: improve message when resolving a relative
 url fails
Date: Wed, 27 Jul 2011 15:00:53 -0400
Message-ID: <4E306065.2010002@cisco.com>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE548C4.2010600@web.de> <4DE5561C.3010200@xiplink.com> <4DE565DF.7050207@cisco.com> <4DE660E2.9080500@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 21:01:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm9Lo-0005C7-GM
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 21:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab1G0TA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 15:00:56 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:36376 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab1G0TAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 15:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2216; q=dns/txt;
  s=iport; t=1311793254; x=1313002854;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=964b+Nyqv0VVHmuskKsmZbMKDs8FkhOccMPgEabaBMg=;
  b=Ca4WIEfpmJUxJOEqjRYGEB6OO+ZiDTOhgwI2a39OeDJ2oIp/q87nhm3c
   1Iwub8AuoQ3vQrAZpYZwAcQa2KbNXyKN42aMn36hr/BpJVw4q9Dky46y0
   DTCT9I4I+ji2s+jYNO76VCW3t0Wz28bvJOT8xAM7ikPn8QFzoeZEAi2BK
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAFAJVfME6tJV2Z/2dsb2JhbAA1AQEBAQMUARRbAREMGAICBSILAgIJAwIBAgECUQcOAQ4BAR+EL6J1d6wpjSORSYErhAaBDwSSdYUHi3c
X-IronPort-AV: E=Sophos;i="4.67,278,1309737600"; 
   d="scan'208";a="7103915"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-5.cisco.com with ESMTP; 27 Jul 2011 19:00:54 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p6RJ0rWJ030625;
	Wed, 27 Jul 2011 19:00:53 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <4DE660E2.9080500@xiplink.com>
X-TagToolbar-Keys: D20110727150053553
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177994>

On 06/01/2011 11:55 AM, Marc Branchaud wrote:
> On 11-05-31 06:04 PM, Phil Hord wrote:
>> On 05/31/2011 04:57 PM, Marc Branchaud wrote:
>>>  - The current code rewrites the URL so that any relative path is either
>>>    rejected or munged into an absolute remote URL.
>> I don't see the URL getting munged away from being relative.  Can you
>> point to an example?
> I reached this conclusion because if I go into my clone of git.git and do
>
> 	git submodule add ../MyThing
>
> where ../MyThing is a regular git repo, I get
>
> Cloning into MyThing...
> fatal: The remote end hung up unexpectedly
> Clone of 'git://git.kernel.org/pub/scm/git/MyThing' into submodule path
> 'MyThing' failed
>
> So it seemed the relative URL became an absolute URL.
>
> Looking more closely at a working example, I can see that (as you show below)
> the URL in the super-repo's .gitmodules file retains the relative path, but
> the submodule's remote.origin.url is an absolute path.
>
> In any case, "submodule add" isn't doing what I expected: make my local
> MyThing repo a submodule of my git.git clone.

I thought I understood this workflow better than I actually did.  I
think I understand more now, and I'm somewhat disappointed.  But I also
failed to pick up the ball on this old discussion.

If you do this, I think it will work like you were hoping:

    :: ( mkdir MyThing && cd MyThing && git init )
    Initialized empty Git repository in /opc/git/MyThing/.git/
    :: git submodule add ../MyThing
    Adding existing repo at 'MyThing' to the index

I haven't examined the code, but I think this is how it works.  'git
submodule add' takes a URL and a local path.  When you omit the local
path, git infers one from the URL.  So these two commands are equivalent:
    :: git submodule add ../MyThing
    :: git submodule add ../MyThing MyThing


If the path you provide (explicitly or implicitly) already contains a
git repo, it is assumed to be "the" submodule repo and git uses it.  If
it does not contain a git repo, git attempts to clone it from the
(remote) URL.

Furthermore, the relative path only works for URLs.  It does not work
for local filesystems.

Phil
