From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug: `gitsubmodule` does not list modules with unicode characters
Date: Sat, 8 Jun 2013 02:18:36 -0700
Message-ID: <20130608091836.GA2925@elie.Belkin>
References: <loom.20130323T171809-46@post.gmane.org>
 <51500B34.30801@web.de>
 <20130608010556.GA28819@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ilya Kulakov <kulakov.ilya@gmail.com>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 11:18:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlFIQ-0000Ld-00
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 11:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab3FHJSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 05:18:46 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:64723 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab3FHJSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 05:18:44 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so2297777pad.2
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+w4L0+WxOpBAVIK8MsCH5qaKDCHJscm55YmzL6XwPEQ=;
        b=pjPauVbXM/PcFfiaGBKvm+vwO4RCMK8HoRlGVd0aWrZNA28ZgzrX9kbZY9FFJkXM4/
         RNX6m0Iq1GuTRuXT+7q6NyWXhjV+ZqtxfYESRJ4oMxSs+PYhE86A+fi3INSOQ0SuoDZM
         M7KYA8iNIfMBxen0PhX3pXV7wCAwLEBX+czv3+W3EbVVsB6313DFPyoyUE//P8bx8B8j
         k0vsg5EkTUhYkF7qeZkVtcTJVwqGyQn6xkG2OhYESfWndcgVRUaufTxUd5sytZSHtjQU
         TKdjywKTTmiQqvHEcRRrByMN3FqmN04ra+M+cjvbFtSX5zdQW6mudcbuigi/mnkqeE29
         U+GA==
X-Received: by 10.66.250.131 with SMTP id zc3mr6233859pac.157.1370683124422;
        Sat, 08 Jun 2013 02:18:44 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id xu10sm6907736pab.3.2013.06.08.02.18.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 02:18:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130608010556.GA28819@paksenarrion.iveqy.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226791>

Fredrik Gustafsson wrote:

> I've looked into this a bit.

Thanks for investigating.

[...]
> Why don't we always print names quoted? IMHO the choose of line
> termination should not do anything else than alter the line termination.
>
> However, an other solution would be to use git ls-files -z in
> git-submodule.sh and then rewrite the perl-code to handle \0 instead
> of \n.

The whole point of "-z" is that by using a terminator that is guaranteed
not to appear in filenames, it avoids the need to quote filenames.
Otherwise at least \n would need to be quoted.

How about something like this patch?

-- >8 --
Subject: ls-files doc: clarify purpose of "-z" option

The purpose of the "-z" option is to avoid quoting issues by using a
delimiter that implies a binary-clean parser and cannot appear in
filenames, and in that spirit, "-z" turns off C-style quoting.  But
without looking carefully through the entire manpage, it is too easy
to miss that.

Reported-by: Fredrik Gustafsson <iveqy@iveqy.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-ls-files.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index c0856a6e..753c223f 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -75,7 +75,9 @@ OPTIONS
 	succeed.
 
 -z::
-	\0 line termination on output.
+	Terminate lines with NUL instead of LF.
+	This avoids the need to quote filenames; see the Output section
+	below for details.
 
 -x <pattern>::
 --exclude=<pattern>::
-- 
1.8.3
