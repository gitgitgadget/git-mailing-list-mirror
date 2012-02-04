From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] verify-tag: check sig of all tags to given object
Date: Fri, 3 Feb 2012 21:08:18 -0800
Message-ID: <20120204050818.GA2477@tgrennan-laptop>
References: <7v8vkjl24d.fsf@alter.siamese.dyndns.org>
 <D140688E-B86C-4A67-9AD6-56160C26884D@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com, tomg.grennan@ericsson.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:08:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtXrT-00035R-Lx
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 06:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab2BDFI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 00:08:27 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36343 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab2BDFI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 00:08:26 -0500
Received: by vcge1 with SMTP id e1so3046480vcg.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 21:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NcrTF3iHBm5lFGwHXZaQbOcAkgkg5CXfcbr9+upwXnU=;
        b=aPRZ/iCHrzF1dQGzkqLpMUv1P7wxMwIP2FpWjGpDRudNBsmOogTZUQg/bWi0d0FAAF
         4/uC9eFaVynz6w6RSgDrWsy7xhlmxLGgMArMVqGp4sCoFTF9pJotcAkmnDKEUQxSHwaC
         RzSGOwRz/TLGAh7uF71aN7M46cbEXkokf4fNk=
Received: by 10.52.176.130 with SMTP id ci2mr4715936vdc.33.1328332104270;
        Fri, 03 Feb 2012 21:08:24 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id bj13sm5170874vdc.15.2012.02.03.21.08.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 21:08:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <D140688E-B86C-4A67-9AD6-56160C26884D@ericsson.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189842>

Junio C Hamano <gitster@pobox.com<mailto:gitster@pobox.com>> writes:
>Tom Grennan <tom.grennan@ericsson.com<mailto:tom.grennan@ericsson.com>> writes:
>>
>>If the command argument is a non-tag object, scan and verify all tags to
>>the given object; for example:
>>
>>john$ git tag -s -m "I approve" john-README master:README
>>...
>>john$ git tag -s -m "I recommend" john-HEAD HEAD
>>...
>>john$ git push <url> tag john-README
>>john$ git push <url> tag john-HEAD
>>
>>jane$ git fetch --tags <url>
>>jane$ git tag -s -m "I also approve" jane-README master:README
>>...
>>jane$ git push <url> tag jane-README
>>
>>jeff$ git fetch --tags <url>
>>jeff$ git verify-tag master:README
>>tag john-README: OK
>>tag jane-README: OK
>>jeff$ git verify-tag HEAD
>>tag john-HEAD: OK
>>
>>Signed-off-by: Tom Grennan <tom.grennan@ericsson.com<mailto:tom.grennan@ericsson.com>>
>
>You did not describe what problem you are trying to solve, but the above
>tells me that the design of this feature has a lot of room to be improved
>to be useful for even a single trivial use scenario I can think of off the
>top of my head.
>
>Let's say after tagging v1.7.10, for some reason (as I do not know what
>problem you are trying to solve), I decided to ask my back-up maintainers,
>let's call them Shawn and Jeff, to sign that tag.  Shawn is expected to do
>this:
>
>   spearce$ git fetch tag v1.7.10
>   spearce$ git tag -s -m "This tag is Gitster's" v1.7.10-spearce v1.7.10
>   spearce$ git push http://example.com/spearce/git tags/v1.7.10-spearce
>
>Jeff will do the same, and I'll fetch v1.7.10-spearce and v1.7.10-peff
>tags from them.
>
>It is natural for me to be able to ask "I want to verify all tags that
>point at the object I asked to be signed, namely, v1.7.10" from this
>feature.
>
>But
>
>   gitster$ git verify-tag v1.7.10
>
>would not be a way to do so, as that would check my signature in v1.7.10
>tag itself.
>
>It gets even worse.  Suppose Jeff does this instead by mistake:
>
>   peff$ git fetch v1.7.10
>   peff$ git tag v1.7.10-peff v1.7.10
>   peff$ git push http://example.com/peff/git tags/v1.7.10-peff
>
>Even if you added "git verify-tag --pointed v1.7.10" to disambiguate the
>request to use the new feature, the result is unusable, as I would see:
>
>   gitster$ git verify-tag --pointed v1.7.10
>   v1.7.10-spearce: OK
>   v1.7.10-peff: OK
>
>v1.7.10-spearce and v1.7.10-peff both resolve to my v1.7.10, and they both
>are signed by known key, but v1.7.10-peff is a lightweight tag that points
>directly at my v1.7.10 and I would be seeing a signature of my own as "OK".

Sorry for messing up this thread. I had remote access trouble with work.

Wouldn't you want Shawn and Jeff to tag the object (commit, tree, or
blob) that you had tagged?

   spearce$ git fetch tag v1.7.10
   spearce$ eval $(git verify-tag -v v1.7.10 | sed -n '1s/ /=/p')
   spearce$ git tag -s -m "This tag is Gitster's" v1.7.10-spearce $object
   spearce$ git push http://example.com/spearce/git tags/v1.7.10-spearce

Or,

   spearce$ git fetch tag v1.7.10
   spearce$ git tag -s -m "This tag is Gitster's" v1.7.10-spearce --pointed v1.7.10
   spearce$ git push http://example.com/spearce/git tags/v1.7.10-spearce

Then,

   gitster$ git verify-tag $object
   tag v1.7.10: OK
   tag v1.7.10-spearce: OK

Or,

   gitster$ git verify-tag --pointed v1.7.10
   tag v1.7.10: OK
   tag v1.7.10-spearce: OK

I hadn't thought of tagging a tag.  As you indicate, this would be
tricky to disambiguate.

So, I intended this to verify all tags of the non-tag object that one
asked to be signed; no sign, no record.

BTW, it may also be convenient to use auto-generated tag names for the
secondary sign-offs, perhaps using the tag SHA as it's refs/tags/SHA.

   spearce$ git tag -s -m "This is Gitster's v1.7.10" -- --pointed v1.7.10

   peff$ git tag -s -m "This is Gitster's v1.7.10" -- --pointed v1.7.10

   gitster$ git verify-tag --pointed v1.7.10
   tag v1.7.10: OK
   tag XXX....XXX: OK
   tag YYY....YYY: OK

`git tag -l` could then ignore refs/tags/SHA with content SHA.

-- 
TomG
