From: John Keeping <john@keeping.me.uk>
Subject: Re: git 1.9.0 segfault
Date: Sat, 8 Mar 2014 18:12:18 +0000
Message-ID: <20140308181218.GG18371@serenity.lan>
References: <CAPn4x+oTTzYMSFzqUmJ8tOO0DdqR+HJJdoeXFZxhABu6B=QmBQ@mail.gmail.com>
 <20140308164651.GA32213@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Guillaume Gelin <contact@ramnes.eu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 19:12:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMLk0-0005gE-At
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 19:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbaCHSM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 13:12:26 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:48485 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbaCHSMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 13:12:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 3F931CDA591;
	Sat,  8 Mar 2014 18:12:25 +0000 (GMT)
X-Quarantine-ID: <yh7CgZ2S5bgl>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yh7CgZ2S5bgl; Sat,  8 Mar 2014 18:12:24 +0000 (GMT)
Received: from coyote.aluminati.org (coyote.aluminati.org [10.0.16.51])
	by jackal.aluminati.org (Postfix) with ESMTP id 899D8CDA566;
	Sat,  8 Mar 2014 18:12:24 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 58D626064A6;
	Sat,  8 Mar 2014 18:12:24 +0000 (GMT)
X-Quarantine-ID: <m7HRlwj8-df6>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m7HRlwj8-df6; Sat,  8 Mar 2014 18:12:23 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C60326064B8;
	Sat,  8 Mar 2014 18:12:20 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20140308164651.GA32213@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243678>

On Sat, Mar 08, 2014 at 04:46:51PM +0000, brian m. carlson wrote:
> On Sat, Mar 08, 2014 at 04:23:43PM +0000, Guillaume Gelin wrote:
> > Hi,
> >
> > http://pastebin.com/Np7L54ar
> We're failing to rename because we got an EFAULT, and then we try to
> print the failing filename, and we get a segfault right here:
> 
> 			if (rename(src, dst) < 0 && !ignore_errors)
> 				die_errno (_("renaming '%s' failed"), src);
> 
> I don't know yet if dst is also bad, but clearly src is.  I'm looking
> into it.

The problem seems to be that we change argc when we append nested
directories to the list and then continue looping over 'source' which
has been realloc'd to be larger.  But we do not realloc
submodule_gitfile at the same time so we start writing beyond the end of
the submodule_gitfile array.

The particular behaviour of glibc's malloc happens to mean (at least on
my system) that this starts overwriting 'src'.

This fixes it for me:

-- >8 --
diff --git a/builtin/mv.c b/builtin/mv.c
index 7e26eb5..23f119a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -180,6 +180,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 						modes = xrealloc(modes,
 								(argc + last - first)
 								* sizeof(enum update_mode));
+						submodule_gitfile = xrealloc(submodule_gitfile,
+								(argc + last - first)
+								* sizeof(char *));
 					}
 
 					dst = add_slash(dst);
