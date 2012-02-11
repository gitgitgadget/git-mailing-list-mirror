From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/8] gitweb: Highlight interesting parts of diff
Date: Sat, 11 Feb 2012 10:32:12 -0800 (PST)
Message-ID: <m31uq1te51.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 19:32:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwHkB-0000BK-Pz
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 19:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab2BKScP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 13:32:15 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60970 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab2BKScO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 13:32:14 -0500
Received: by eekc14 with SMTP id c14so1316916eek.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 10:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=AXbP5FKQb1JxJDkN/Stiu18XISBWZz3JbzeGaD2mDDc=;
        b=yGt4H2MgBMtPP346ZPcWduMtUGamFq4l9aiZwVI1QobN5TAxA+CcXNHMWP9c8i9EKf
         LYxh8ApX+N8GlWHaxtMXGqEL2ayXAbWzvt2iJv4LTQnuSKhlQecY2uOnG18qUmSZUPMu
         ShJ6lIzbDS+lBLdE4fOWOjj3y50FfRn3JIoKg=
Received: by 10.14.120.74 with SMTP id o50mr629276eeh.18.1328985133533;
        Sat, 11 Feb 2012 10:32:13 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id z47sm38357446eeh.9.2012.02.11.10.32.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 10:32:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1BIWC90017776;
	Sat, 11 Feb 2012 19:32:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1BIWBCf017773;
	Sat, 11 Feb 2012 19:32:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190527>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:


>   gitweb: Use print_diff_chunk() for both side-by-side and inline dif=
fs
>   gitweb: Move HTML-formatting diff line back to process_diff_line()
>   gitweb: Push formatting diff lines to print_diff_chunk()
>   gitweb: Format diff lines just before printing

Those patshes are expected to not change gitweb output.  Did you check
that gitweb after those changes handles incomplete line marker
correctly?  print_sidebyside_diff_chunk() ealt with 'incomplete' class
in slightly hacky way, assuming side-by-side output.

Namely, does gitweb after those patches print incomplete line marker
correctly, i.e. only once for "inline" output while it prints it for
both sides in "side-by-side" output, and using 'incomplete' class?

You have to treat correctly all the following situations:

* removing end of line at end of file (eol-at-eof):

  diff --git a/a b/b
  index 257cc56..1910281 100644
  --- a/a
  +++ b/b
  @@ -1 +1 @@
  -foo
  +foo
  \ No newline at end of file

* adding eol-at-eof:

  diff --git b/b a/a
  index 1910281..257cc56 100644
  --- b/b
  +++ a/a
  @@ -1 +1 @@
  -foo
  \ No newline at end of file
  +foo

* removing from end of file, preserving lack of eol-at-eof:

  diff --git b/c a/a
  index a5d4a2f..257cc56 100644
  --- b/c
  +++ a/a
  @@ -1,2 +1 @@
   foo
  -foo
  \ No newline at end of file

* change at the end of file, preserving lack of eol-at-eof:

  diff --git a/b b/d
  index 1910281..ba0e162 100644
  --- a/b
  +++ b/d
  @@ -1 +1 @@
  -foo
  \ No newline at end of file
  +bar
  \ No newline at end of file

* change near the end of file, with incomplete line marker in context

  diff --git b/c a/b
  index a5d4a2f..1910281 100644
  --- b/c
  +++ a/b
  @@ -1,2 +1 @@
  -foo
   foo
  \ No newline at end of file


--=20
Jakub Nar=EAbski
