From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/13] Use an external program to implement fetching with
 curl
Date: Thu, 06 Aug 2009 22:08:09 -0700
Message-ID: <7v63d06wjq.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908050053580.2147@iabervon.org>
 <alpine.DEB.1.00.0908051206460.8306@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0908051145250.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 07:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZHgo-0005JQ-2g
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 07:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbZHGFIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 01:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbZHGFIS
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 01:08:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbZHGFIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 01:08:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C50623572;
	Fri,  7 Aug 2009 01:08:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 78F6223571; Fri, 
 7 Aug 2009 01:08:11 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0908051145250.2147@iabervon.org> (Daniel
 Barkalow's message of "Wed\, 5 Aug 2009 11\:52\:22 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50B2F4B2-8310-11DE-9F23-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125177>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 5 Aug 2009, Johannes Schindelin wrote:
>
>> Ooops, I missed this part.  How about making git-remote-https and 
>> git-remote-ftp hardlinks to git-remote-http?
>
> Sure. Is "ln ... || ln -s ... || cp ..." the right way to do this 
> cross-platform?

I've queued the first three from this series to 'next' (and the rest to
'pu'), as I wanted to give wider testing to the smaller footprint git with
the libcurl-less-ness they bring in, with Linus's standalone SHA-1.

Since then two fix-ups (adding git-remote-* to .gitignore and the
dependency fix to git-http-fetch) were posted to the list, which I also
rebased in to the series, making the total number of patches merged to
'next' from the series 5.

If there are major changes/rewrites/redesign in the remaining part of the
series that are only in 'pu', please feel free to either send incrementals
or replacements.

I do not think I've seen any issues raised but unresolved against the part
from this series already in 'next', other than that this builds three
copies of git-remote-* programs based on libcurl.  I'll rebase a patch
like this in after the Makefile fixup ae209bd (http-fetch: Fix Makefile
dependancies, 2009-08-06) and queue the result to 'next'.

I suspect that the "install" target may need a patch similar to this one,
though...

-- >8 --
Subject: Makefile: do not link three copies of git-remote-* programs

Instead, link only one and make the rest hardlinks/copies, like we do for
the built-ins. 

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 2900057..38924f2 100644
--- a/Makefile
+++ b/Makefile
@@ -1256,6 +1256,7 @@ ifndef V
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
 	QUIET_GEN      = @echo '   ' GEN $@;
+	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -1494,10 +1495,16 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-remote-http$X git-remote-https$X git-remote-ftp$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+git-remote-http$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-remote-https$X git-remote-ftp$X: git-remote-http$X
+	$(QUIET_LNCP)$(RM) $@ && \
+	ln git-remote-http$X $@ 2>/dev/null || \
+	ln -s  git-remote-http$X $@ 2>/dev/null || \
+	cp git-remote-http$X $@
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
