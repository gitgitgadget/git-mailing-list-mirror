From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK) v2 4/4] gitk: Implement batch lookup and caching of encoding attrs.
Date: Sat, 11 Oct 2008 13:28:50 +0400
Organization: HOME
Message-ID: <200810111328.50951.angavrilov@gmail.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com> <bb6f213e0810100522v653507d6r75cc4c64b57aa459@mail.gmail.com> <18671.62417.328489.317909@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 11:31:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoapB-0002FY-3i
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 11:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYJKJae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 05:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYJKJae
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 05:30:34 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:10468 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbYJKJac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 05:30:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so775887fkq.5
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MSYDOiCEggNYI/+y5XRXZfgX7QJ3picc/W7nMAYu0CM=;
        b=fUsEiVP306xvMfBt5ZykdhJOYDUZGkAPm98pTN2V3cx7mtKlv3+L/DUsuL81N0eSPd
         9yzrjhhWDIqATjrB5eA7MGyDJQbF01iHkCQSrgC017oxZeIWIXmIXn6M+SMROYSYcQo+
         1+VWIfvMWzavNy3t3L0O8EvF81pDbwRcT+9tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gMM9xmw6Bmnm0akF5aEeGuGjaGm6iJE8vFGoFozOP5tPGJX7xzc329v789nM+45UPG
         DPZjQrzSWEIvVq/KFYhOjEEtPOzAb1ascIQP+n9jrZv1uUsOMZ5gZ+LADrbHRyxm2aay
         U0ZAzA1EWK1xCe3seOVkfQee/OJVxGbiivxk8=
Received: by 10.181.25.18 with SMTP id c18mr2755136bkj.52.1223717430921;
        Sat, 11 Oct 2008 02:30:30 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm3498096fkt.3.2008.10.11.02.30.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Oct 2008 02:30:29 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.5-45.fc9.i686; KDE/4.1.1; i686; ; )
In-Reply-To: <18671.62417.328489.317909@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97967>

On Saturday 11 October 2008 04:31:13 Paul Mackerras wrote:
> > > Also, I wonder why we now have two levels of caching of the encoding
> > > attribute.  Your patch 1/4 introduced path_encoding_cache, which was
> > > fine, but now we have path_attr_cache as well, which seems to me to
> > > serve exactly the same function since the encoding is the only
> > > attribute we ever ask about.  Surely we don't need both caches?
> > 
> > If the (git-gui) patch that reimplements the tcl_encoding procedure is
> > applied, we may drop the path_encoding_cache. Current implementation
> > is too slow for batch lookup, especially if the encoding is actually
> > not supported, and without the cache the lookup would be done on every
> > loading of a diff.
> 
> I was thinking more in terms of dropping the path_attr_cache actually.

Since gitattr is a general-purpose function that can read any attribute,
I decided that it should use its own cache.

Basically, all this double-caching issue is fallout from my failure to
anticipate the need of batch attribute lookup from the beginning...

> Actually, if [tcl_encoding] is slow, then why is $gui_encoding the
> untranslated version, so that we do [tcl_encoding $gui_encoding] on
> each call to get_path_encoding?  Why don't we do the tcl_encoding call
> once and have $gui_encoding be the result of that?  In fact
> $gui_encoding should be the result of this code (from
> get_path_encoding):
> 
> 	set tcl_enc [tcl_encoding $gui_encoding]
> 	if {$tcl_enc eq {}} {
> 		set tcl_enc [encoding system]
> 	}

Well, that code was copied from git-gui, where it looks like this:

set tcl_enc [tcl_encoding [get_config gui.encoding]]

I.e. there is no "$gui_encoding" variable, although get_config does use a cache.

> And if [tcl_encoding] is slow, then it should have a cache.  There's
> only likely to be at most 2 or 3 values it gets called for, and it's
> a constant function.

In git-gui the slowdown appeared during the construction of the menu
listing all available encodings, so a simple cache would not have helped. 
I  reimplemented it using a lookup table to resolve aliases (constructed
on the first run). But it can be thought of as a precalculated cache.

> At this point, what I think I might do is apply your set of patches
> (but with 2/4 and 3/4 folded into a single patch) and then go through
> and do another commit that addresses the concerns I've raised.  OK?

Maybe I should resend the patches, scrapping path_encoding_cache,
and adding the optimized version of tcl_encoding?

Alexander
