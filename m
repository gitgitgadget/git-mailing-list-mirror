From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/5] Makefile: fix generation of assembler listings
Date: Wed, 6 Jan 2010 02:02:16 -0600
Message-ID: <20100106080216.GA7298@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113709.GD10059@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:02:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSQqU-0001kW-Ln
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab0AFICS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 03:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010Ab0AFICS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:02:18 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:47130 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab0AFICR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 03:02:17 -0500
Received: by ywh6 with SMTP id 6so17235952ywh.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 00:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JRUmRkNBQeKqLwat9CdgwZSSAkkGuq4DRRR5YnsDx94=;
        b=QhYRUi7njuj2k6dp0bvuQYiRsFV5CQnicRj44aF3k13SmmtUx+4eUpGt9wHzN7IALr
         03/UuQpAUwhtPXBEASNBB3gi0BzQqEeFyI+h0pE8Dh3CXoFsv4wE53sokBizFqyZfB2A
         b22d6F/98bKVkCGFTQf9ZXQKiZJgWWkGtqMDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=I/jW0IFkoRoIQwyOJokd02e0BgU5lpjxKaeM81eGK7ot1xaEcgar/398R/+4n2+e4u
         rHifprNASKdPXnAa5SkBC1ggUPwMXLdP+5YFHUbAeENydyX0xiVLivL66m2EiBabkwVu
         FjbKTni8+y5WWX/RCiT7GKQT6unuku2h7uTK8=
Received: by 10.150.251.41 with SMTP id y41mr11425465ybh.247.1262764936803;
        Wed, 06 Jan 2010 00:02:16 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm19244960iwn.7.2010.01.06.00.02.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 00:02:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091128113709.GD10059@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136244>

Jonathan Nieder wrote:

> This adds yet another phony .FORCE-foo target.  Wouldn=E2=80=99t it b=
e simpler
> to use a single target called .FORCE, or is there something I am
> missing that that would break?

I didn=E2=80=99t hear any screams when I suggested this about a month a=
go, so
let=E2=80=99s try it out.

Patch 1 fixes a problem I noticed when tweaking the Makefile to
automatically generate dependencies for the %.o targets.  The problem
is that the dependencies for the corresponding %.s (code listing)
targets are not included in the Makefile at all, automatically or not.
Thus the command "make var.s var.o && touch cache.h && make var.s var.o=
"
produces the output

CC var.s
CC var.o
CC var.o

not regenerating var.s to reflect potential changes in cache.h.

"make git.s" previously did not work at all; patches 2-3 fix that.

Jonathan Nieder (5):
  Makefile: regenerate assembler listings when asked
  Makefile: use target-specific variable to pass flags to cc
  Makefile: learn to generate listings for targets requiring special
    flags
  Makefile: consolidate .FORCE-* targets
  git-gui/Makefile: consolidate .FORCE-* targets

 Documentation/Makefile |    4 +-
 Makefile               |   56 ++++++++++++++++++++--------------------=
-------
 git-gui/Makefile       |    7 ++---
 3 files changed, 29 insertions(+), 38 deletions(-)
