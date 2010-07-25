From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/7] Makefile: Add coverage-report-cover-db target
Date: Sun, 25 Jul 2010 12:13:31 -0500
Message-ID: <20100725171331.GA8604@burratino>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
 <1280068861-17701-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 19:22:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od4ts-0007MH-Sw
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab0GYRWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 13:22:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41941 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab0GYRWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:22:01 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jul 2010 13:22:01 EDT
Received: by ywh1 with SMTP id 1so243035ywh.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HecDzcEIXR9eItLPGXrXD8YVXVfg9aLj1N4eQEX1EE8=;
        b=IZSiVLkoTwEC1SOcBCGJJrn2ZGfALHr2Z9ntAELqkgArBMmM3TQW7GzHe5Ms9yQG0C
         Fy4KhVWRhol736wbFnebyijOytBwWrcURx3IgNFldEOTSCgwgBnZi5s6qZO7RFoWG08Q
         DsFwQOtXo2g/f1dbf8Gwlq7qe2KDP1jbw3bSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EIh1Zq9kkIcnR7MF+8bRd8IWieseecmr5ZupNiR3wmbFvISzMFoRATivmqSZ6zgKCO
         X0EQ3akzime5ejIrGF6nTAB0qz1IiUhdyjtUny5qqosAyb2CHq79uLInJ4wZLdV1USWl
         7qwKXgRizLagIuFY+bJ93Q2S0L7Xu1XaN7M5k=
Received: by 10.150.69.3 with SMTP id r3mr7775536yba.105.1280078077106;
        Sun, 25 Jul 2010 10:14:37 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id q31sm4842005ybk.13.2010.07.25.10.14.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:14:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280068861-17701-5-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151764>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> +++ b/Makefile
> @@ -2303,3 +2303,7 @@ coverage-untested-functions: coverage-report
>  	grep '^function.*called 0 ' *.c.gcov \
>  		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/'=
 \
>  		| tee coverage-untested-functions
> +
> +coverage-report-cover-db: coverage-report
> +	gcov2perl -db cover_db *.gcov
> +
> --=20

nitpick: trailing newline.

This target is not included in .PHONY and it does not seem to be
phony after all, anyway.  Why not use something like the following?

 cover_db: coverage-report
	gcov2perl...

It seems more intuitive to me, and once the makefile learns to track
how long a coverage-report remains valid it would allow avoiding a
rebuild of the cover_db.

diff --git i/Makefile w/Makefile
index f2c680d..c59740c 100644
--- i/Makefile
+++ w/Makefile
@@ -2282,6 +2282,7 @@ coverage:
=20
 object_dirs :=3D $(sort $(dir $(OBJECTS)))
 coverage-clean:
+	$(RM) cover_db
 	$(RM) $(addsuffix *.gcov,$(object_dirs))
 	$(RM) $(addsuffix *.gcda,$(object_dirs))
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
@@ -2304,6 +2305,5 @@ coverage-untested-functions: coverage-report
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
=20
-coverage-report-cover-db: coverage-report
+cover_db: coverage-report
 	gcov2perl -db cover_db *.gcov
-
--=20
