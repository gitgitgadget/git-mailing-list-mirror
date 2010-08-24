From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-notes: Run partial expensive test everywhere
Date: Tue, 24 Aug 2010 02:14:53 -0500
Message-ID: <20100824071453.GA3064@burratino>
References: <1281470164-27008-1-git-send-email-avarab@gmail.com>
 <1281483468-24388-1-git-send-email-avarab@gmail.com>
 <AANLkTikfwbtKt2WrxzRyKHnP3ySGtBF33=z_rJwjPx5Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 09:16:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnnkR-0003Fp-EN
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 09:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab0HXHQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 03:16:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48580 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab0HXHQg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 03:16:36 -0400
Received: by iwn5 with SMTP id 5so4285935iwn.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ra5JqF4m+8ITW1g9EMYW3i3N5hWodYJY6oxjtTzKfJo=;
        b=ReDGjqwDL98CZIxzOsSXuqVuCm2C234a+lnypGtkV+PoHfIjOYYJFNVt5JOGJreA+8
         ifpiRqIWG4HlqU9AnyeQyYJVfG+hcjRV19k7+Tir1jfNwKpiBjvfIWfFKSKGrNH9ldae
         ysn/14FquspsWO0lmhFSojEhlO9HdxYz1xNEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hH2HWVdvAcmSaHbraT3QSVmo86sLBdnc2RgbLufIxwBLRnAo1wGIWfqrClTF7+6FgF
         +zUV4K5Jm+xa+8a9WDScM5yU9jxkW7M4LyARt70QyTPIpEhKwVwymX1w1fhOpyt1TZkL
         GbLT28uAfE/w4O0kidELXMR/S3PsmeIt8lpgM=
Received: by 10.231.174.136 with SMTP id t8mr7995948ibz.158.1282634195786;
        Tue, 24 Aug 2010 00:16:35 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm7087498ibe.23.2010.08.24.00.16.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 00:16:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikfwbtKt2WrxzRyKHnP3ySGtBF33=z_rJwjPx5Y@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154301>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It turns out that this fails on Solaris because its /usr/bin/time is =
different.

Odd.  Different how?  As far as I can tell, all that test asks
of time is to execv() its arguments and pass on a 0 exit status.

Ah, maybe this is it: perhaps /usr/bin/time sh runs /bin/sh.  Does the
following help?

Patch is against next.  Untested except on Linux where it wouldn't
make a difference.
-- 8< --
Subject: t3302 (notes): Port to Solaris

The time_notes script, which uses POSIX shell features, is
currently sometimes run with a non-POSIX /bin/sh.

Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-exp=
ensive.sh
index 7c08e99..e35d781 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -96,7 +96,7 @@ time_notes () {
 	for mode in no-notes notes
 	do
 		echo $mode
-		/usr/bin/time sh ../time_notes $mode $1
+		/usr/bin/time "$SHELL_PATH" ../time_notes $mode $1
 	done
 }
=20
--=20
