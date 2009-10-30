From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool 
	option
Date: Thu, 29 Oct 2009 20:47:08 -0400
Message-ID: <76718490910291747l165baf49tab781727d010610a@mail.gmail.com>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
	 <20091027230043.GA11607@hashpling.org>
	 <20091028090022.GA90780@gmail.com>
	 <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com>
	 <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
	 <20091029221234.GB32590@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 01:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3feJ-0000GN-J1
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 01:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbZJ3ArK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 20:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbZJ3ArI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 20:47:08 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:52325 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbZJ3ArE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 20:47:04 -0400
Received: by iwn10 with SMTP id 10so1801397iwn.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 17:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=bQfrMqFMqjYUBrMipv0UNWK2lweJmBMGL9Cn73bb5aw=;
        b=C6HTTE42Gc/MscWuJso+X+nC1C5HOrC/uCDZC8HUw24AjjxS1IQ/2brLZX5whR2DTv
         nhS+bJoNBgC5rEk/4W1n+qb3ktPSdp0L5oPz9dDvHcE1jyjkBhLAOHT+MqyEqoe9aEqr
         duEk+A2IiH0AFh+OFTVEL8TJGOy5+JCwbbNN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AlRWnnq8Rv77cKQnjxnnRBf9/v191/oXXk4VJ9aq/sGd8ueSHdnQLp8Fk1EEA2NJTC
         yNo1AXIkTmy8pbj4LnuMvne/6iMcgMJT1naM2yB01fwEQKuZmwHPzhHNAd+XrK2eXoVe
         gYqbUj92pWL4RM8JbqG/2qIqljcgASLrKRlcc=
Received: by 10.231.20.230 with SMTP id g38mr71465ibb.49.1256863628581; Thu, 
	29 Oct 2009 17:47:08 -0700 (PDT)
In-Reply-To: <20091029221234.GB32590@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131667>

On Thu, Oct 29, 2009 at 6:12 PM, Charles Bailey <charles@hashpling.org> wrote:
> I'm not sure I understand why only p4merge on Mac OS X is special, we
> don't seem to treat any other mergetool specially and we don't seem to
> need absolute paths anywhere else.

On other platforms, the merge tool is very likely to be in your PATH.

On OS X, p4merge is going to be installed as part of an application
bundle (/Applications/p4merge.app or $HOME/Applications/p4merge.app).
This is virtually never going to be in a user's PATH.

So in order to provide equivalent behavior for OS X as Linux (i.e., so
that you can just specify p4merge as the mergetool without having to
provide it's path), we need to look in these additional locations.

> If it's a Mac OS X only thing, can we (and should we) avoid special
> treatment for p4merge on other platforms?

It is a Mac OS X only thing. Yes, we could avoid looking in these
locations on other platforms, but why? Using type to look for the
executable is virtually no cost. The alternative (calling uname to
determine the platform) requires running a separate process.

> The only other question I have is what are the merits of using
> /dev/null as the base vs. a second copy of the local version in the
> baseless merge case? It's the only other difference between the two
> p4merge patches that I noticed.

p4merge's argument handling is stupid, you need to pass it a dummy
argument in some cases. A second copy of the local version is probably
better than /dev/null. Actually, I think just passing it an empty
argument ("") works too.

> Perhaps we could consider having both p4merge and launchp4merge as
> separate options?

I think that would be over-engineered. Decide on one or the other.
They have slightly different semantics as I've previously described.
Personally I think calling launchp4merge provides a more Mac-like
behavior, but honestly it doesn't make much difference.

j.
