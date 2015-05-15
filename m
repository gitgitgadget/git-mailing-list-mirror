From: Jim Hill <gjthill@gmail.com>
Subject: Re: [PATCH v2] sha1_file: pass empty buffer to index empty file
Date: Fri, 15 May 2015 16:31:53 -0700
Message-ID: <20150515233153.GA4157@gadabout.domain.actdsltmp>
References: <xmqqbnhnknio.fsf@gitster.dls.corp.google.com>
 <1431645434-11790-1-git-send-email-gjthill@gmail.com>
 <xmqqlhgphg8x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 01:32:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtP5j-0004fA-33
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 01:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992710AbbEOXcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 19:32:24 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38536 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993493AbbEOXcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 19:32:04 -0400
Received: by igcau1 with SMTP id au1so9974314igc.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qb1qWbOeOH1tVby3PknY4MhWJvfdxlIxQZEPPPBdX4Q=;
        b=Ycx1fSUZ3DPCJHK0yNEMPtOB8a5GXqHqPVQ7sipFRuHz017DsZe1HorT5pggrmpOa4
         MH7CeGELRMCAcOrgcAHHTqUoAKAfISUf4ZsxCN/c9rtX5jiNYEZTgUk0GtbA+J10IYY4
         qDEraME6SqyXoueRYzlf/BExZo0gLsOhK4c0zI6HIBaZfRLMLbT2co9S/ZUWSpJC6l/S
         WGMTDZ6hqrrHmgZmbdBIPy2reC8RuLUTBD8Sz/c2SBgz6kYAiGp5byfxR1FR3pA9zf54
         YfO6Mn0ChIIb411MWNra8+zC90k8RRJBo3EU6H9n8/ALIvxbpM1MIwMihe8Gdz60NLWn
         UdEA==
X-Received: by 10.50.79.232 with SMTP id m8mr1400067igx.6.1431732724210;
        Fri, 15 May 2015 16:32:04 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id y124sm2235066iod.13.2015.05.15.16.32.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 16:32:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqlhgphg8x.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269191>

On Fri, May 15, 2015 at 11:01:34AM -0700, Junio C Hamano wrote:
> That would mean that you found _another_ bug, wouldn't it?  If
> copy-fd failed to read input to feed the external filter with, it
> must have returned an error to its caller, and somebody in the
> callchain is not paying attention to that error and pretending
> as if everything went well.  That's a separate issue, though.

as you say, separate ... I think I stumbled over more than one:

setup:
	~/sandbox/40$ git grl
	core.autocrlf false
	core.whitespace cr-at-eof
	core.repositoryformatversion 0
	core.filemode true
	core.bare false
	core.logallrefupdates true
	filter.cat.smudge cat
	filter.cat.clean echo Kilroy was here && cat
	filter.cat.required true
	~/sandbox/40$ git rm --cached -f --ignore-unmatch emptyfile
	rm 'emptyfile'

with required filter:
	~/sandbox/40$ cat emptyfile
	~/sandbox/40$ git add emptyfile
	~/sandbox/40$ git show :emptyfile
	Kilroy was here
	~/sandbox/40$ git config --unset filter.cat.required

then with not-required filter:
	~/sandbox/40$ git rm --cached -f --ignore-unmatch emptyfile
	error: copy-fd: read returned Bad file descriptor
	error: cannot feed the input to external filter echo Kilroy was here && cat
	error: external filter echo Kilroy was here && cat failed
	rm 'emptyfile'
	~/sandbox/40$ git show :emptyfile
	fatal: Path 'emptyfile' exists on disk, but not in the index.
	~/sandbox/40$ git add emptyfile
	error: copy-fd: read returned Bad file descriptor
	error: cannot feed the input to external filter echo Kilroy was here && cat
	error: external filter echo Kilroy was here && cat failed
	~/sandbox/40$ git show :emptyfile
	~/sandbox/40$ git rm --cached emptyfile
	rm 'emptyfile'
	~/sandbox/40$ git add emptyfile
	error: copy-fd: read returned Bad file descriptor
	error: cannot feed the input to external filter echo Kilroy was here && cat
	error: external filter echo Kilroy was here && cat failed
	~/sandbox/40$ git rm --cached -f --ignore-unmatch emptyfile
	rm 'emptyfile'
	~/sandbox/40$ 

===

I don't understand rm's choices of when to run the filter, and the
apparently entirely separate code path for required filters is just
bothersome.

>  * A failure to run the filter with the right contents can be caught
>    by examining the outcome.

agreed. That's better anyway -- my few git greps didn't find any
empty-file filter tests anyway.

>  * There is no need to create an extra commit; an uncommitted
>    .gitattributes from the working tree would work just fine.

Done.

>  * The "grep" is gone, with use of -i (questionable why it is
>    needed), 

Yah, I was bad-thinking strerror results might be a bit unpredictable, I
should have checked for a string under git's control instead.  I'd just
assumed the 0 return was because non-required filters are allowed to
fail, got the above transcript while checking the assumption.

=== 

So, so long as we're testing empty-file filters, I figured I'd add real
empty-file filter tests, I think that covers it.

So is this better instead?

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 5986bb0..fc2c644 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -216,15 +216,33 @@ test_expect_success EXPENSIVE 'filter large file' '
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
+test_expect_success "filter: clean empty file" '
+	header=---in-repo-header--- &&
+	git config filter.in-repo-header.clean  "echo $header && cat" &&
+	git config filter.in-repo-header.smudge "sed 1d" &&
+
+	echo "empty-in-worktree    filter=in-repo-header" >>.gitattributes &&
+	> empty-in-worktree &&
+
+	echo $header              > expected &&
+	git add empty-in-worktree            &&
+	git show :empty-in-worktree > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success "filter: smudge empty file" '
+	git config filter.empty-in-repo.smudge "echo smudge added line && cat" &&
+	git config filter.empty-in-repo.clean   true &&
+
+	echo "empty-in-repo      filter=empty-in-repo"  >>.gitattributes &&
+
+	echo dead data walking > empty-in-repo &&
+	git add empty-in-repo &&
+
+	:			> expected &&
+	git show :empty-in-repo	> actual &&
+	test_cmp expected actual
 '
 
 test_done
+
