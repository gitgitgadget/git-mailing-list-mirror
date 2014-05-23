From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE
 costruct
Date: Fri, 23 May 2014 11:44:05 -0700
Message-ID: <20140523184405.GE12314@google.com>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
 <xmqqmwe8jr44.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	tboegi@web.de, dak@gnu.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:44:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnuS4-0008RO-2a
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 20:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbaEWSoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 14:44:11 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:32796 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbaEWSoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 14:44:09 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so4565240pbc.1
        for <git@vger.kernel.org>; Fri, 23 May 2014 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OCl1mH8hFcbrjKd1f64EpcgAANMT3rh6HuSm6uoioX4=;
        b=mjmsMCo4E/O2xFwFi3mg/lGJKFqSJTqZ65YQ9YHR9uEpCxfx8fbYLBq1ABm+KfAuWH
         AxR5reekG0KXYBdInN4avHIbSLeqc50UrWYKx3eE4y4eLTL4wgoXJjk8IBM2ujYPqmrB
         F9SAfyfNCN5LotpmhArGgYqnj9Q/g3saRNDm9W1OIouRmQmzY3XkKhjiUbU90K1XFAc9
         CFNLn8lNcHnb1kCXnoqQIsjVROxCPjvfFfOOUzK1srKdsqKxosrONbSLzgdvnG7WJuBH
         JvUYwWocE1kKuK9ycofzbguOKASmuTxks7JVPNbgysI+F8KLRN12B0LdkwsOheMOFV5j
         kgew==
X-Received: by 10.68.102.34 with SMTP id fl2mr8397084pbb.2.1400870648344;
        Fri, 23 May 2014 11:44:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id se3sm5754571pbb.80.2014.05.23.11.44.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 11:44:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmwe8jr44.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250012>

Junio C Hamano wrote:
> Elia Pinto <gitter.spiros@gmail.com> writes:

>> Found by check-non-portable-shell.pl
>
> Thanks.
>
> Makes me wonder why these two were missed, though.

Good catch.  check-non-portable-shell.pl uses an anchored regex:

	/^\s*export\s+[^=]*=/

Perhaps something like

	/\bexport\s+[A-Za-z0-9_]*=/

without anchoring would work better.

-- >8 --
Subject: test-lint: find unportable sed, echo, test, and export usage after &&

Instead of anchoring these checks with "^\s*", just check that the
usage is preceded by a word boundary.  So now we can catch

	test $cond && export foo=bar

just like we already catch

	test $cond &&
	export foo=bar

As a side effect, this will detect usage of "sed -i", "echo -n", "test
a == b", and "export a=b" in comments.  That is not ideal but it's
potentially useful because people sometimes copy code from comments so
it can be good to also avoid nonportable patterns there.

To avoid false positives, keep the checks for 'declare' and 'which'
anchored.  Those are frequently used words in normal English-language
comments.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/check-non-portable-shell.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git i/t/check-non-portable-shell.pl w/t/check-non-portable-shell.pl
index 45971f4..b170cbc 100755
--- i/t/check-non-portable-shell.pl
+++ w/t/check-non-portable-shell.pl
@@ -16,12 +16,12 @@ sub err {
 
 while (<>) {
 	chomp;
-	/^\s*sed\s+-i/ and err 'sed -i is not portable';
-	/^\s*echo\s+-n/ and err 'echo -n is not portable (please use printf)';
+	/\bsed\s+-i/ and err 'sed -i is not portable';
+	/\becho\s+-n/ and err 'echo -n is not portable (please use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
-	/test\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
-	/^\s*export\s+[^=]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
+	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
+	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
 	# this resets our $. for each file
 	close ARGV if eof;
 }
