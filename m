From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: Re: [JGIT] maven build fails on OS X
Date: Fri, 6 Feb 2009 21:12:29 +0000
Message-ID: <320075ff0902061312i1b2d960ax34bb992d8ba85fc5@mail.gmail.com>
References: <320075ff0902060708m5ec566b9g755829c25c7727d8@mail.gmail.com>
	 <20090206153155.GL26880@spearce.org>
	 <200902062154.34997.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 22:14:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVY1Q-0004g7-Ic
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 22:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbZBFVMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 16:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbZBFVMb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 16:12:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:56640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbZBFVMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 16:12:30 -0500
Received: by fg-out-1718.google.com with SMTP id 16so620861fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 13:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=agt0qT+a5hw3JyWSuFx1qsaLoK93i2YfyDFdgJv7wbg=;
        b=hcFPRi8LE/9P8hlA/DpjKO9kheyX63e3gOuc3V1kPf610b1ZYdZVWrALYu80Inwu+I
         4cNz5tg+K78arc29bxf13+wbH+ZfFnrixwbneh1GuKZrRQY8i2v3Ay8DwlDdMc/NG7io
         m4BbT/U5gmknDblMULPCx7+dND6DV8Nw5PuqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ns1Jsn5+qoL76huofEFqibUZUM4mVRDqpda03eo8hGRZ/2CbarKz5o01ZifgQkTKwf
         xChscUaQZVoOaTHvWzUKzsR1XBnECwTkaGzSafa152JITjYxwIhhFdy+XskKx1wXSQRj
         Fm7WIBSQOXxKI3e18Xt53ePcirHYoc5ImcUjw=
Received: by 10.103.161.16 with SMTP id n16mr944601muo.79.1233954750139; Fri, 
	06 Feb 2009 13:12:30 -0800 (PST)
In-Reply-To: <200902062154.34997.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108786>

> Here we intend to feed the dequote an ISO-Latin encoded string. Our decoder
> will first try to decode it as UTF-8, which should fail, then we try to decode it
> as the platform default (Linear A, Hieroglyphs, MacRoman or something not
> known to living mankind). A problem is that Git *forces* us to guess the encoding,
> and in some situations you'd need human intelligence to figure it out. Software
> with a little more hindsight recognize this and declare UTF-8 to be the one
> and only encoding. JGit always encodes things as UTF-8 for this reason, but
> we cannot trust the input. These test cases are supposed to prove that we
> can guess things correctly at least some of the time.. Using "platform
> default" may be the wrong thing if it does not match what a C Git user on
> this platform would encounter.
>

I got your reply exaclty as I found the same thing :-). I'm not sure
that this is the common cause of all test failures, but it is for
testGetText_DiffCc :-

When it parses the first string in extractFileLines, it passes to
RawParseUtils.decode which, as you outlined, does a "Try UTF-8, Try
caller suggestion, try Charset.defaultCharset(), then finally back out
to ISO-8859-1.

On most platforms, this is Try UTF-8 (fail), caller suggestion (also
UTF-8, skip), try default (UTF-8, skip) - finally parse ISO-8859-1.

On the mac, this is Try UTF-8 (fail), caller suggestion (UTF-8, skip),
try default (MacRoman) --> succeed.

I'm less clear on what the right way to fix it is (or if it's just the
tests that need to somehow force the system file.encoding?
