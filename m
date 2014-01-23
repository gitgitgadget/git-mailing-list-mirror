From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 12:12:23 -0800
Message-ID: <20140123201223.GX18964@google.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123195206.GU18964@google.com>
 <20140123200311.GA31920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:12:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Qdd-0004lX-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbaAWUMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:12:30 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:40343 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbaAWUM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:12:29 -0500
Received: by mail-bk0-f47.google.com with SMTP id d7so633329bkh.34
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 12:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0L3n3Q/Yebm4q8HkzacbMInbnXF0uZZ4WgaHzaS6I5I=;
        b=uj6UIP1DPHlzwAyw+w9m2rjOF5IYZSPgn7mWYcnRRoIlxxTMUpTSF0br+mVkWYjSyV
         6jo+C0ttSv/gl8USN1HC+T8Dw7YDqHhI4cmtnL4A5LfxHzwU/Pf+c3yJQ4jYsXr5DFkQ
         hbUFXv1ruGHRMhPOWzGpSaG0gK7zje3EjA9zpoKsYsBhmrsdBa5BH6RN9ZIEk3pEgENc
         22i8CzIDdyzsLm0vEzIZ5jNd8apJwWaXd+DtShjDtAZGnwzEZh2tgiihAXLhbrAGupb2
         d65MK1syWCvOi+aBa+SsYUHeFaErrYAp3qX1u1VqbusUGNFEps1EuC3lkuZBwfz2qpLj
         +1fA==
X-Received: by 10.204.121.133 with SMTP id h5mr1625309bkr.118.1390507948102;
        Thu, 23 Jan 2014 12:12:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id rf10sm159760bkb.3.2014.01.23.12.12.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 12:12:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123200311.GA31920@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240941>

Jeff King wrote:
> On Thu, Jan 23, 2014 at 11:52:06AM -0800, Jonathan Nieder wrote:

>> My main worry about the patches is that they will probably run into
>> an analagous problem to the one that v1.7.12-rc0~1^2~2
[...]
> I think this probably works in practice because align_ntohl is inlined,
> and any sane compiler will never actually load the variable.

I don't think that's safe to rely on.  The example named above didn't
pose any problems except on one platform.  All the relevant functions
were static and easy to inline.  GCC just followed the standard
literally and chose to break by reading one word at a time, just like
in this case it could break e.g. by copying one word at a time in
__builtin_memcpy (which seems perfectly reasonable to me ---
optimization involves a lot of constraint solving, and if you can't
trust your constraints then there's not much you can do).
