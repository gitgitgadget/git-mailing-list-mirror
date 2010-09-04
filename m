From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Sat, 4 Sep 2010 03:25:09 -0500
Message-ID: <20100904082509.GC10140@burratino>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 10:27:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oro5g-000405-33
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 10:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab0IDI1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 04:27:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47526 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0IDI1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 04:27:01 -0400
Received: by iwn5 with SMTP id 5so2275180iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BXa9k68pPhDwQVgt2jD03EPxq6/iLTPvXzpg4NvS9YU=;
        b=mZd0FqQMmnQWAPKBxmQNPYVuMoUNxDfAqM1ha7HqQVDXBw66hmKUaVXvm7wtdV0nLr
         4Ofqe6eNCGVXkxGHhMwERINQ5IQuYOQQH0Gs8GVFK7gd6Y9Vg6TXlaaOK0lOynpvxODd
         w63LP+oZ0dwMoMEDhl2eC0AXcPug1ptSTihvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w2+nif8l3QKlBwnXEgR1ioCZo73i08Xw4LN2HDTZUTq6ouYVkQkLHrk4X91IJEgzGa
         5U8MW1VDb4Z3ryfFsQy5bAk27H3Tc5wBRLzV7rUtnps1Vt51aYi14t/FbJEeU/tUg914
         gRZrI2b6VaE7RLn1QBEeHLSatxgNGGvu+JmEw=
Received: by 10.231.15.9 with SMTP id i9mr2261071iba.58.1283588820569;
        Sat, 04 Sep 2010 01:27:00 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm3033521ibk.21.2010.09.04.01.26.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 01:26:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155312>

If you try this:

 1. Install Git for Windows (from the msysgit project)
 2. Put

	[core]
		autocrlf = false
		eol = native

    in your .gitconfig.
 3. Clone a project with

	*.txt text

    in its .gitattributes.

Then with current git, any text files checked out have LF line
endings, instead of the expected CRLF.

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Eyvind Bernhardsen wrote:

> Introduce a new configuration variable, "core.eol", that allows the user
> to set which line endings to use for end-of-line-normalized files in the
> working directory.  It defaults to "native", which means CRLF on Windows
> and LF everywhere else.

The following fixup has been sitting in my tree (but not tested on
Windows) for a couple of weeks.  Sensible?

I don't know what the right choice for Cygwin is; probably LF unless
there is some way to detect the systemwide setting at run time.

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 40fbcae..ba08051 100644
--- a/Makefile
+++ b/Makefile
@@ -1125,6 +1125,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 		compat/win32/pthread.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
+	NATIVE_CRLF = YesPlease
 	X = .exe
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	htmldir=doc/git/html/
-- 
1.7.2.3
