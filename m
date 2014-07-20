From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 0/4] getcwd without PATH_MAX
Date: Sun, 20 Jul 2014 18:46:47 +0200
Message-ID: <53CBF277.3090101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 18:47:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8uGb-0002I3-8a
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 18:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbaGTQrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 12:47:13 -0400
Received: from mout.web.de ([212.227.15.3]:62431 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbaGTQrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 12:47:12 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MYNof-1X474P0imX-00V9SO; Sun, 20 Jul 2014 18:47:08
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:xQib3zzqjrcY3tPGGN+i6TyZaQRM8Z6MlqI069VIXOSTjJEZl0T
 B/xuDky0yDjgu3GlYWEBG1EiSns95hRMwkTffdCylp/IFiBP3gF/auN4kEpST1NHyDFD1fe
 32613aoOcagETbUSsHgFUEY2oc5EarAEkCMByFA2o5i4GpI2HvcEZpeopX/4nJL5HFJwsjp
 rQOApYYN6HhN4xpZ/+u8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253930>

Paths longer than PATH_MAX can be created and used on at least on some
file systems.  Currently we use getcwd() generally with a PATH_MAX-
sized buffer.  This series adds two functions, strbuf_getcwd() and
xgetcwd(), then uses them to reduce the number of fixed-sized buffers
and to allow us to handle longer working directory paths.

Not all getcwd() calls are replaced, however.  I hope that at least
some of the remaining ones can be avoided altogether.  If that turns
out to be too optimistic then we can use the added function to convert
the rest.

Changes in v2:
  * strbuf_getcwd() instead of strbuf_add_cwd(), because the former is
    simpler and sufficient for now; based on a suggestion by Duy
  * added patch 2 as an example for strbuf_getcwd() usage, suggested
    by Duy
  * made sure strbuf_getcwd() leaves the strbuf intact, no matter
    what getcwd() does
  * converted an easy getcwd() call in setup.c

Ren=C3=A9 Scharfe (4):
  strbuf: add strbuf_getcwd()
  use strbuf_getcwd() to get the current working directory without
    fixed-sized buffers
  wrapper: add xgetcwd()
  use xgetcwd() get the current directory or die

 Documentation/technical/api-strbuf.txt |  4 ++++
 builtin/init-db.c                      | 25 ++++++++++++-------------
 builtin/rev-parse.c                    |  6 +++---
 dir.c                                  | 12 ++++++++----
 git-compat-util.h                      |  1 +
 git.c                                  |  6 ++++--
 setup.c                                |  6 +++---
 strbuf.c                               | 21 +++++++++++++++++++++
 strbuf.h                               |  1 +
 trace.c                                |  7 ++++---
 wrapper.c                              |  8 ++++++++
 11 files changed, 69 insertions(+), 28 deletions(-)

--=20
2.0.2
