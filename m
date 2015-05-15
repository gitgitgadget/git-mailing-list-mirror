From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] sha1_file: pass empty buffer to index empty file
Date: Fri, 15 May 2015 11:01:34 -0700
Message-ID: <xmqqlhgphg8x.fsf@gitster.dls.corp.google.com>
References: <xmqqbnhnknio.fsf@gitster.dls.corp.google.com>
	<1431645434-11790-1-git-send-email-gjthill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:01:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtJva-0001sg-Bb
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 20:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275AbbEOSBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 14:01:37 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35278 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbbEOSBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 14:01:36 -0400
Received: by iesa3 with SMTP id a3so34752233ies.2
        for <git@vger.kernel.org>; Fri, 15 May 2015 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=niGuMmZAmsdInnBQ9N6HxBYkEm9UQ6fJwyTqh448Fmc=;
        b=fXR5mZ79aDnuFvL1cfQQtYLmJl+uQ/W4vzujsGvYX9EvZAZRYuY5PcO6nmbbrpaXef
         14bITEzYR7czwP4A+GNj4xWG9z6YMviG4s3otylV1swQXamB9wMwYC+1iyMXCaTv7J5g
         dHKdtq346+yvSNdgP7pU48p9PVY675/zfQS8YMRD4hWSfK0gvkpV01GTeltkgdO4vwYJ
         b9h6amNW0OhoBrSvBc8tfNwEv9Ayb6wUo84St+F+C3n5t9DiH3G6CQRMuNN+Tz9q87uL
         jrl7LcKVeQIpmPYquy51JIGMLvfoMlLYpS0GeQCt7yOJpvskxuoq+eQCQUnzxz2EJPcN
         m9oQ==
X-Received: by 10.107.155.81 with SMTP id d78mr14416960ioe.29.1431712896096;
        Fri, 15 May 2015 11:01:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id d4sm1926505igl.1.2015.05.15.11.01.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 11:01:35 -0700 (PDT)
In-Reply-To: <1431645434-11790-1-git-send-email-gjthill@gmail.com> (Jim Hill's
	message of "Thu, 14 May 2015 16:17:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269162>

Jim Hill <gjthill@gmail.com> writes:

>> check that 'err' does not contain the copy-fd error
>
> Implemented this out of necessity, because the add works and returns
> success despite the complaints to stderr.

That would mean that you found _another_ bug, wouldn't it?  If
copy-fd failed to read input to feed the external filter with, it
must have returned an error to its caller, and somebody in the
callchain is not paying attention to that error and pretending
as if everything went well.  That's a separate issue, though.

In any case, I think the following patch may make the test better
(apply on top of yours).

 * A failure to run the filter with the right contents can be caught
   by examining the outcome.  I tweaked the filter to prepend an
   extra header line to the contents; if copy-fd failed to drive the
   filter, we wouldn't see the cleaned output to match that extra
   header line (and nothing else---as the contents we are feeding is
   an empty blob).

 * There is no need to create an extra commit; an uncommitted
   .gitattributes from the working tree would work just fine.

 * The "grep" is gone, with use of -i (questionable why it is
   needed), -q (generally, we do not squelch error output in
   individual tests, which is unnecessary and running tests with -v
   option less useful) and -s (same, withquestionable portability).

Thanks.

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 5986bb0..a72d265 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -216,15 +216,17 @@ test_expect_success EXPENSIVE 'filter large file' '
 	! test -s err
 '
 
-test_expect_success "filtering empty file should not produce complaints" '
-	echo "emptyfile filter=cat" >>.gitattributes &&
-	git config filter.cat.clean cat &&
-	git config filter.cat.smudge cat &&
-	git add . &&
-	git commit -m "cat filter for emptyfile" &&
-	> emptyfile &&
-	git add emptyfile 2>err &&
-	! grep -Fiqs "bad file descriptor" err
+test_expect_success "filtering empty file should work correctly" '
+	write_script filter-clean.sh <<-EOF &&
+	echo "Extra Head" && cat
+	EOF
+	echo "emptyfile filter=check" >>.gitattributes &&
+	git config filter.check.clean "sh ./filter-clean.sh" &&
+	>emptyfile &&
+	git add emptyfile &&
+	echo "Extra Head" >expect &&
+	git cat-file blob :emptyfile >actual &&
+	test_cmp expect actual
 '
 
 test_done
