From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/11] Building up the delta parser
Date: Wed, 13 Oct 2010 04:17:14 -0500
Message-ID: <20101013091714.GA32608@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 11:20:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xVu-0004A5-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab0JMJUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:20:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44695 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab0JMJUk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:20:40 -0400
Received: by gyg13 with SMTP id 13so15764gyg.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ribcyaYMZb0zXHn98+tBmYG7P+qxScMjXHgx7p6KzBk=;
        b=SmcZaa+XdsI6j79hsDeefxtZVmHyH7Co58UnlvHIaPCz6OYEOQ+B86Pnl7+04L6wOQ
         UQ+BWxZqkbXtnYWrw2REzpXwZJLRbAM47+yv9bAAbGCLPdEZEDCHhguhsuRPYW+e6PNq
         3n+km29pmPvPlqkiTTwgvSOCA+OmMdyiAWQfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=r+CwAcf56Fgv4Yd1R934ZxGqUHSJ6YczpULd1lN9QGk+CU2RIUKej2MW0Jt8Ml2MB0
         +ZMWazG7NnEHf2o5R3vzeYVCHdwdTAlDmsomD1zoMD6b4W7n56derurqQsliMUhNN+v+
         wee5rtvxS8Pmv/FbQ7iyB8KQoqb7DiFNXeUXg=
Received: by 10.150.135.17 with SMTP id i17mr680727ybd.119.1286961639792;
        Wed, 13 Oct 2010 02:20:39 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id p30sm7845535ybk.20.2010.10.13.02.20.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:20:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011040140.GC5649@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158913>

Jonathan Nieder wrote:

> Implement an svndiff 0 interpreter

I hear that was nigh unreadable, so here's a reroll.  Less
cargo-cult support for broken deltas, more readability and tests.
Patches apply on top of "[PATCH 15/16] t9010 (svn-fe): Eliminate
dependency on svn perl bindings".  As before, the end result
includes a 'test-svn-fe -d' command that can apply svndiff0-format
deltas, meaning less binary garbage to worry about as you puzzle
over that confusing "svnrdump dump" output in debugging sessions.

Questions?  Improvements?  Bugs?

Patch 1 is a fixup to the variable-length integer parsing code, to
report unexpected EOF (i.e., declared content length too long)
correctly when it occurs in the middle of such an integer.

Patch 2 is the svndiff0 interpreter in broad strokes: read window,
read window, read window, ....  The patch doesn't encode any
knowledge about what actually goes _in_ a window aside from the
header, so it will error out for nonempty windows.

Patch 3 teaches the nacent interpreter to keep the appropriate
piece of the preimage in memory.  This is probably earlier in the
series than it ought to be, but I wanted to try out the sliding
window code.

With patches 4 and 5, the interpreter learns to read the "data"
and "instructions" section of a window.  The effect is observable
because it finds the beginning of the next window correctly.

Patch 6 is an example instruction (copyfrom_data).

Patches 7-8 introduce some sanity checks.

Patches 9 and 10 are another instruction (copyfrom_target) and
another sanity check.

Patch 11 is the last instruction (copyfrom_source).  That's it.
You can apply deltas now!

If anything seems unclear, please don't spend time puzzling it
out --- just yell at me, so the code or documentation can be
cleaned up.  Happy reading.
