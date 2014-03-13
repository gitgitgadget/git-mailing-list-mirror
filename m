From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Fix possible buffer overflow in remove_subtree()
Date: Thu, 13 Mar 2014 10:19:06 +0100
Message-ID: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 10:26:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO1uC-0000D1-IW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 10:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbaCMJ0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 05:26:19 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52548 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753893AbaCMJ0R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2014 05:26:17 -0400
X-AuditID: 1207440c-f79656d000003eba-86-5321781266b4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 37.DC.16058.21871235; Thu, 13 Mar 2014 05:19:14 -0400 (EDT)
Received: from michael.fritz.box (p57A24737.dip0.t-ipconnect.de [87.162.71.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2D9JA4Q018940
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 13 Mar 2014 05:19:12 -0400
X-Mailer: git-send-email 1.9.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqCtUoRhsMPWQlEXXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zA6vH3/cfmDx2zrrL7vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGcsvvmbuaCRu+LTumOsDYxPOLoYOTgkBEwkjl6x72LkBDLFJC7cW88GYgsJXGaU+PMp
	uIuRC8g+ziTRPO0lC0iCTUBXYlFPMxOILSKgJjGx7RALSBGzwD5Gie0H1zGCJIQFXCUmPZoB
	VsQioCqxePkfMJtXwFniyIW5rBDb5CSm/F7APoGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8
	vNQiXUO93MwSvdSU0k2MkBDh2cH4bZ3MIUYBDkYlHt6VyxWChVgTy4orcw8xSnIwKYny6pQr
	BgvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4TUvAMrxpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeW
	pGanphakFsFkZTg4lCR4s0uBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBgR5f
	DAx1kBQP0F4PkJt4iwsSc4GiEK2nGBWlxHlVyoASAiCJjNI8uLGwyH/FKA70pTBvEEg7DzBp
	wHW/AhrMBDT4R4A8yOCSRISUVAPjjGL1YwqJqz2rsrylfBQuhaxcsafk965frDYxYos6zmxY
	8ZSx+IVstlRal2OZ2dHsurVieYL+vrk9m5R6Ntj88cjL6oqLD5vv9ptj59eFSyLX5ogksc87
	V/tGKK7Nm4fFvqsr79Gd0F1H5y5wFw1PX7wxRz5fdkHbq3vdMmY7szq1rA99eqTE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244025>

These patches are proposed for maint (but also apply cleanly to
master).

I presume that this is exploitable via Git commands, though I haven't
verified it explicitly [1].

I *think* that the rest of the file is OK.  open_output_fd() initially
looks suspicious, because it strcpy()s a string onto the end of its
path argument.  But that is only done when to_tempfile is set, which
in turn is handled consistently up the callstack up to the point where
it is initially set in checkout_entry() if topath is not NULL.  So as
long as the caller obeys checkout_entry()'s docstring and passes a
long enough buffer for topath, I think everything is OK.  In any case,
the string appended in open_output_fd() is not under the control of
the user, so even if there were a bug in this code path it shouldn't
be exploitable.

[1] For example, it is conceivable that there are some checks when
    writing a tree that prevent files with such long names from being
    written by Git.  But even if so, it is clearly a bug that could be
    hit locally on any filesystem where PATH_MAX is not a hard limit.

Michael Haggerty (2):
  checkout_entry(): use the strbuf throughout the function
  entry.c: fix possible buffer overflow in remove_subtree()

 entry.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

-- 
1.9.0
