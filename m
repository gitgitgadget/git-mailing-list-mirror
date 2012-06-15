From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] perl/Makefile: move "mkdir -p" to module installation loop
 for maintainability
Date: Fri, 15 Jun 2012 18:02:34 -0500
Message-ID: <20120615230234.GA3547@burratino>
References: <1339781427-10568-1-git-send-email-adam@roben.org>
 <20120615180505.GH10752@burratino>
 <7vwr388dyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <adam@roben.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 01:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SffXU-0005CZ-10
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jun 2012 01:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758480Ab2FOXCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 19:02:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63836 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758184Ab2FOXCm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 19:02:42 -0400
Received: by yhmm54 with SMTP id m54so2927187yhm.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GEFZTUonx0t7jPp3j0CsPAhkxLqdD/dcYRXSzGn/EDk=;
        b=pgx8elRy+XzjLeA9RCeEoW7mfcU7YMpUJsmIiEoEOsMJ9xeXkfRCbhrW05cNs3H5D4
         YGqpTRVNnFLro7wakZF9vJX9/w5/WMXfxwxXWQLKoLfp2Ol/pkE3WrRxtHTHXUkbj0Gw
         VX7PqLHRAZxX+sRuxT3ebugiZGet6Ho6KWjzw9hkwMSaKbYTs/6c9m65VaVq4ALXbrQR
         Sb/B4BUrmE4h1Lt9QY5bAGf6Y2wb65APY164TtaKehHYGCfgdeigZMvezK0XHG1JJx7k
         URZJrv9H3h33ULkqt5egOW4hE9Trdo4Gjt9U7B2qbW4oXjJxVaT2KE4ajbZCBlEvlv7t
         SPlw==
Received: by 10.50.40.193 with SMTP id z1mr269106igk.0.1339801361500;
        Fri, 15 Jun 2012 16:02:41 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id k5sm2504561igq.12.2012.06.15.16.02.40
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 16:02:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwr388dyp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200105>

In the NO_PERL_MAKEMAKER=YesPlease fallback case, make the directory
that will contain each module when installing it (simulating "install
-D") instead of hardcoding "Git/SVN/Memoize is the deepest level".
This should make this codepath which is not used often on development
machines a little easier to maintain.

Requested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jun 15, 2012 at 02:25:34PM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	echo '	mkdir -p blib/lib/Git/SVN/Memoize' >> $@
>
> Wouldn't it be much less error prone to maintain if you did not
> hardcode the "blib/lib/Git/SVN/Memoize is the deepest level" here,
> and run the "mkdir -p blib/lib/$$(basename $$i)" or something in the
> loop instead?

Yes, I think so.

Wasn't sure if "install -D" or "dirname" is portable, so this
patch avoids them.

 perl/Makefile |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index fe7a4864..2e8f9804 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -34,22 +34,34 @@ modules += Git/SVN/Ra
 
 $(makfile): ../GIT-CFLAGS Makefile
 	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
-	echo '	mkdir -p blib/lib/Git/SVN/Memoize' >> $@
 	set -e; \
 	for i in $(modules); \
 	do \
+		if test $$i = $${i%/*}; \
+		then \
+			subdir=; \
+		else \
+			subdir=/$${i%/*}; \
+		fi; \
 		echo '	$(RM) blib/lib/'$$i'.pm' >> $@; \
+		echo '	mkdir -p blib/lib'$$subdir >> $@; \
 		echo '	cp '$$i'.pm blib/lib/'$$i'.pm' >> $@; \
 	done
 	echo '	$(RM) blib/lib/Error.pm' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
-	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git/SVN/Memoize"' >> $@
 	set -e; \
 	for i in $(modules); \
 	do \
+		if test $$i = $${i%/*}; \
+		then \
+			subdir=; \
+		else \
+			subdir=/$${i%/*}; \
+		fi; \
 		echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
+		echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)'$$subdir >> $@; \
 		echo '	cp '$$i'.pm "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
 	done
 	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
-- 
1.7.10.4
