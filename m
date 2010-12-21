From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t0050: fix printf format strings for portability
Date: Tue, 21 Dec 2010 14:27:55 -0600
Message-ID: <20101221202755.GA27214@burratino>
References: <4D1105B5.5070703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: prohaska@zib.de, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 21 21:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV8ou-0000bn-PF
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 21:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006Ab0LUU2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 15:28:18 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49670 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab0LUU2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 15:28:17 -0500
Received: by wwa36 with SMTP id 36so4559418wwa.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CIhJGvaDAbJStm+2uv5xDa0IH+F2qsXaCCjlq8sjco8=;
        b=dsCdC652VWbgjApvDa/ze+j/ReEe4fzPWgRypJjGg5rdLbitW9BVw9rKdnK7J8M1j5
         WljQbfJTJ9s0CsJCesh0zl61kyexBQ1AkC35ND39ipfKM01CESCsjttyxR2JmSLSOAvx
         fhBPBU1GyB2y/aAS4UnYPjs2WCv7HJfbbnoBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nibjzF6VbbS4FRvfyj7IIHpWiI0KA9aLRrxVNWgIYMUItp4c0Q0sywz5pqD9ysDfVP
         anilv7DXclk++5MeP6J59PezI4KNmcsJ32iqtdgCk2jwogG0s6/BZLVyt6NWHoC3pB46
         gyZWdde7cKN6IEO+6ldJr8IPbGFRzBWtPi+SM=
Received: by 10.216.239.9 with SMTP id b9mr6488708wer.24.1292963296405;
        Tue, 21 Dec 2010 12:28:16 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id r38sm2724315weq.23.2010.12.21.12.28.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Dec 2010 12:28:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D1105B5.5070703@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164054>

Unlike bash and ksh, dash passes through hexadecimal \xcc escapes.
So when run with dash, these tests *pass* (since '\xcc' is a perfectly
reasonable filename) but they are not testing what was intended.

Use octal escapes instead, in the spirit of v1.6.1-rc1~55^2
(2008-11-09).

Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Ramsay Jones wrote:

> I noticed recently that the unicode tests, when run by the dash shell,
> have not been working as designed. (The tests *pass*, but they are
> *not* testing what was intended)
> 
> In order to demonstrate, I added an "false &&" line after the touch in
> test #8, so that (on Ubuntu):
> 
>     $ ./t0050-filesystem -i
[...]
>     $ ls trash\ directory.t0050-filesystem/unicode/
>     \x61\xcc\x88

Good point.  POSIX printf is not required to support \x escape
sequences.

 t/t0050-filesystem.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 057c97c..1542cf6 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -4,8 +4,8 @@ test_description='Various filesystem issues'
 
 . ./test-lib.sh
 
-auml=`printf '\xc3\xa4'`
-aumlcdiar=`printf '\x61\xcc\x88'`
+auml=$(printf '\303\244')
+aumlcdiar=$(printf '\141\314\210')
 
 case_insensitive=
 unibad=
-- 
1.7.2.3.554.gc9b5c.dirty
