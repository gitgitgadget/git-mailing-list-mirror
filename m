From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-gui: Adapt discovery of oguilib to execdir
	'libexec/git-core'
Date: Tue, 29 Jul 2008 22:25:17 -0700
Message-ID: <20080730052517.GF7225@spearce.org>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de> <20080727212405.GA10075@spearce.org> <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:26:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO4Cf-0001uj-Fh
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbYG3FZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbYG3FZT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:25:19 -0400
Received: from george.spearce.org ([209.20.77.23]:43884 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYG3FZR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:25:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4A78C383A4; Wed, 30 Jul 2008 05:25:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90744>

Steffen Prohaska <prohaska@zib.de> wrote:
> Isn't only the computation of sharedir based on gitexecdir wrong?
>
>> ifndef sharedir
>> 	sharedir := $(dir $(gitexecdir))share
>
> and could be replaced with this (instead of your patch):
>
>  ifndef sharedir
> +ifeq (git-core,$(notdir $(gitexecdir)))
> +       sharedir := $(dir $(patsubst %/,%,$(dir $(gitexecdir))))share
> +else
>         sharedir := $(dir $(gitexecdir))share
>  endif
> +endif

Oh, damn good catch.  Thanks.

How about this then?  Its your patch above, my message, and me
forging your SOB...

--8<--
From: Steffen Prohaska <prohaska@zib.de>
Subject: git-gui: Correct installation of library to be $prefix/share

We always wanted the library for git-gui to install into the
$prefix/share directory, not $prefix/libexec/share.  All of
the files in our library are platform independent and may
be reused across systems, like any other content stored in
the share directory.

Our computation of where our library should install to was broken
when git itself started installing to $prefix/libexec/git-core,
which was one level down from where we expected it to be.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b19fb2d..c9d67fe 100644
--- a/Makefile
+++ b/Makefile
@@ -34,8 +34,12 @@ ifndef gitexecdir
 endif
 
 ifndef sharedir
+ifeq (git-core,$(notdir $(gitexecdir)))
+	sharedir := $(dir $(patsubst %/,%,$(dir $(gitexecdir))))share
+else
 	sharedir := $(dir $(gitexecdir))share
 endif
+endif
 
 ifndef INSTALL
 	INSTALL = install
-- 
1.6.0.rc1.166.gbbfa8


-- 
Shawn.
