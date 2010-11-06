From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/8] Remove various dependencies from wrapper.o
Date: Sat, 6 Nov 2010 06:39:05 -0500
Message-ID: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:40:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEh81-0008CI-T8
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab0KFLkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:40:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45757 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab0KFLkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:40:01 -0400
Received: by iwn41 with SMTP id 41so1923330iwn.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=vTAqHAbVTyEjuxWqY3lsWrsSfK0AiwOHFLs2AyEE7GU=;
        b=dS1jA+/3ga1pDxhbEDSvDt0j01UboR14X/hgMwKGjmttWiE9CTxSwgZDmdUlTOSdQy
         O56Nj155UWkn4HxugocpAr5hGo3c2MpSWfSAypOKf7OEQc8g5dr0zY3Vpuh0Z5XSVKgG
         CHNMNYUV1mvHVzaRQMPeNlBsZ6NGuFCQrAxQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=FHiqmAx77yrKdJTBW2xDt6Ex/Zqmkh3eo0xg36W0fxoVuFat3Gpi9HiaKqLZ1tt9zk
         B1SQGLy6cOGZTgexjr91E8V5l2TIHvcfNwnUx6GkFO98xLGhV17+VPws+yp8uwgE3Btd
         aH1N8/h9byAU7trwHywffc9T8xUFNKqfpqfKA=
Received: by 10.42.240.71 with SMTP id kz7mr2137533icb.0.1289043599833;
        Sat, 06 Nov 2010 04:39:59 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id i16sm807566ibl.6.2010.11.06.04.39.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:39:58 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160842>

Hi,

Ram noticed that using any function from strbuf.c results in a larger
binary that requires -lz to link, which is pretty far from ideal.
This patch series moves code around to make that no longer the case.

Vaguely inspired by [1].

After applying these patches, you can write:

	#define SHA1_HEADER "block-sha1/sha1.h"
	#include "cache.h"
	int main(void)
	{
		volatile char *p = xmalloc(5);
		return 0;
	}

and build it with

	cc -Wall -W test.c wrapper.o usage.o

-- no libz needed, no sha1 library, no environment.c, small binary.

Of course, making the linker happy tends to make the code clearer,
too.

Patch 1 moves xmmap to sha1_file.c, where release_pack_memory()
is defined.  If xmmap were used by tiny programs, maybe it would
make sense to replace release_pack_memory() with a callback,
but this is simpler.

Patch 2 moves odb_mkstemp and odb_pack_keep to environment.c,
were they have access to the cached value of $GIT_OBJECT_DIRECTORY.

Patch 3 moves git_mkstemps_mode et al from path.c to wrapper.c,
so xmkstemp_mode does not have to depend on path.c.

Patch 4 moves some refname-related functions from strbuf.c to
sha1_name.c.

Patch 5 moves git_inflate et al to a new zlib.c, so wrapper.o does
not have to depend directly on libz.

Patch 6 is a missing "static" keyword.  It probably doesn't belong
in this series, but it fits okay.

Patch 7 moves try_to_free_builtin to sha1_file.c and adds a
declaration for it to git-compat-util.h.

Patch 8 stops referring to try_to_free_builtin from wrapper.c,
completing the project.

Thoughts?  Improvements?  Benchmarks?

[1] http://thread.gmane.org/gmane.comp.version-control.git/137686/focus=137737

Jonathan Nieder (8):
  wrapper: move xmmap() to sha1_file.c
  wrapper: move odb_* to environment.c
  path helpers: move git_mkstemp* to wrapper.c
  strbuf: move strbuf_branchname to sha1_name.c
  wrapper: give zlib wrappers their own translation unit
  pack-objects: mark file-local variable static
  wrapper: expose try_to_free_pack_memory()
  Remove pack file handling dependency from wrapper.o

 Makefile                                  |    1 +
 builtin/pack-objects.c                    |    2 +-
 check-racy.c                              |    1 +
 contrib/convert-objects/convert-objects.c |    1 +
 daemon.c                                  |    1 +
 environment.c                             |   37 ++++++
 fast-import.c                             |    1 +
 git-compat-util.h                         |    2 +
 git.c                                     |    2 +
 http-backend.c                            |    1 +
 http-fetch.c                              |    1 +
 http-push.c                               |    1 +
 imap-send.c                               |    1 +
 path.c                                    |  113 ----------------
 remote-curl.c                             |    1 +
 sha1_file.c                               |   20 +++
 sha1_name.c                               |   16 +++
 strbuf.c                                  |   16 ---
 test-dump-cache-tree.c                    |    4 +-
 test-match-trees.c                        |    1 +
 upload-pack.c                             |    1 +
 wrapper.c                                 |  198 ++++++++++++++--------------
 zlib.c                                    |   61 +++++++++
 23 files changed, 253 insertions(+), 230 deletions(-)
 create mode 100644 zlib.c

-- 
1.7.2.3.557.gab647.dirty
