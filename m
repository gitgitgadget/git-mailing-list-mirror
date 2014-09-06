From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC PATCH 1/2] Makefile: add check-headers target
Date: Sat, 6 Sep 2014 15:57:39 -0700
Message-ID: <20140906225738.GA15039@gmail.com>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com>
 <540B7AA0.4050208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 07 00:58:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQOvn-0003lp-11
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 00:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbaIFW5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Sep 2014 18:57:53 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:42095 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbaIFW5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 18:57:52 -0400
Received: by mail-pa0-f41.google.com with SMTP id lf10so2691471pab.14
        for <git@vger.kernel.org>; Sat, 06 Sep 2014 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G5ivzpjjtFuv4tezPSAzihrfiVci6dualEp4F5ios9k=;
        b=d4PbN9k3yMltt9ZcHMbOFM7FAUI9Jc5KIjXs+E1HmMlZzLuIyyZBoTwCeaETVka6sQ
         ZLUL7EorHzwaZOjmsRuD+yv8BGNGI3Hajxethl1SJ9SGsSkUEd3nHehigJKPuLZLSGeY
         2uNKPZn7NpiE7XKO8F03NMuP+XWQ3IqG5Cwl0iYm/8XZZR35O6Zh6RJtkJzCoDYrEWvg
         8QD/O88EBEbg/PU94Ae4HySDvezMZv0Y8gD5mMDdKa4JusS/1LOTQ4e1KxB613pqXnYG
         cI6L/wMuB3PfDjoWrvWeYXEu7fV2HjAVVut1KXBnNGB622G9/uv/6rjG0gGJN/qFpRdq
         r3pg==
X-Received: by 10.66.90.162 with SMTP id bx2mr33627524pab.39.1410044271810;
        Sat, 06 Sep 2014 15:57:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id iq3sm5125693pbb.71.2014.09.06.15.57.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Sep 2014 15:57:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540B7AA0.4050208@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256605>

On Sat, Sep 06, 2014 at 11:20:32PM +0200, Ren=C3=A9 Scharfe wrote:
> Am 06.09.2014 um 21:20 schrieb David Aguilar:
> >This allows us to ensure that each header can be included
> >individually without needing to include other headers first.
>=20
> Sounds like a good objective.
>=20
> >Signed-off-by: David Aguilar <davvid@gmail.com>
> >---
> >This patch demonstrates how to verify PATCH 2/2.
> >
> >  Makefile         |  6 ++++++
> >  check-headers.sh | 26 ++++++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >  create mode 100755 check-headers.sh
> >
> >diff --git a/Makefile b/Makefile
> >index 30cc622..bc54024 100644
> >--- a/Makefile
> >+++ b/Makefile
> >@@ -2591,6 +2591,12 @@ check-docs::
> >  check-builtins::
> >  	./check-builtins.sh
> >
> >+### Make sure headers include their dependencies
> >+#
> >+check-headers::
> >+	./check-headers.sh $(CC) $(ALL_CFLAGS)
> >+
> >+
> >  ### Test suite coverage testing
> >  #
> >  .PHONY: coverage coverage-clean coverage-compile coverage-test cov=
erage-report
> >diff --git a/check-headers.sh b/check-headers.sh
> >new file mode 100755
> >index 0000000..bf85c41
> >--- /dev/null
> >+++ b/check-headers.sh
> >@@ -0,0 +1,26 @@
> >+#!/bin/sh
> >+
> >+exit_code=3D0
> >+
> >+maybe_exit () {
> >+	status=3D"$1"
> >+	if test "$status" !=3D 0
> >+	then
> >+		exit_code=3D"$status"
> >+		if test -n "$CHECK_HEADERS_STOP"
> >+		then
> >+			exit "$status"
> >+		fi
> >+	fi
> >+}
> >+
> >+git ls-files *.h |
>=20
> This checks all .h files in the top directory.  Would it be better
> to check all files in LIB_H instead?  Or even all .h files in the
> tree (using "git ls-files '*.h'")?  The latter might be difficult
> because some of the files in compat/ #include system-specific
> headers.

Ah, I hadn't thought of using LIB_H; that might be the most
practical solution.

Changing it to quoted '*.h' finds compat/ files which seemed
like too much trouble.  OTOH blindly using all *.h files (i.e.
not using git ls-files) picks up the generated common-cmds.h
which would require changing generate-cmdlist.h, and that seemed
like it might be out of scope for this patch.

I'd certainly be interested in improving this part, so I'll see if
we can reformulate this patch to use LIB_H.

I'll also fixup the unneeded strbuf.h addition in the reroll.

>=20
> >+while read header
> >+do
> >+	echo "HEADER $header" &&
> >+	"$@" -Wno-unused -x c -c -o "$header".bin - <"$header" &&
> >+	rm "$header".bin ||
> >+	maybe_exit $?
> >+done
> >+
> >+exit $exit_code
> >
>=20

--=20
David
