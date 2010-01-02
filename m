From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sat, 2 Jan 2010 18:50:42 +0700
Message-ID: <20100102115041.GA32381@do>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com> <7v637nzky0.fsf@alter.siamese.dyndns.org> <7vzl4zy5z3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 12:52:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR2Ws-00079m-Lv
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 12:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab0ABLva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 06:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616Ab0ABLva
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 06:51:30 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60938 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab0ABLv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 06:51:29 -0500
Received: by pwj9 with SMTP id 9so8676215pwj.21
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=4U5cH6fv9kLroIxtpDH7JhRyRlqBs66Z4C9m64bQ7OU=;
        b=j/reeKcXe8tvc7jsfGFqlQcn7ZY0LCoDtJRiekRl+7Nj2h+lSi7a9Y2MoDj6Q2o/FB
         9uaP0DuyNTov4vnxNdjICwpqP1eVlgeR5rwVmdo7kliWicuOk8kmnDSUkuOqc8G6QLM2
         yPjIu1kMGKjsjHT4OUlH/T/OtSymokuiNhWa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VImAQu9pDlt6MRTinJ9XNvIcdRzEg+Uha4AWhGf3m49hgc1cstOZ1cSSuVpIJWF2Yf
         Ipg1Vzb8nfLcpWrCF0gFdDkinoJR6L3W2JVHM/3tvqdFOMpWnr9Ybc4xytAz0u6acrzs
         SETivJxuPZSx6zwmIi7tuyB/zLuVcWhPRiPSQ=
Received: by 10.140.252.8 with SMTP id z8mr15367612rvh.118.1262433089328;
        Sat, 02 Jan 2010 03:51:29 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 20sm16111584pzk.9.2010.01.02.03.51.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 03:51:27 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat,  2 Jan 2010 18:50:42 +0700
Content-Disposition: inline
In-Reply-To: <7vzl4zy5z3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136027>

On Wed, Dec 30, 2009 at 11:09:52PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > This looks a bit wrong for a couple of reasons:
> >
> >  - external_grep() is designed to return negative without running external
> >    grep when it shouldn't be used (see the beginning of the function for
> >    how it refuses to run when opt->extended is set and other conditions).
> >    The new logic seems to belong there, i.e. "in addition to the existing
> >    case we decline, if ce_skip_worktree() entry exists in the cache, we
> >    decline";
> 
> IOW, something like this instead of your patch.  You would want to tests
> to demonstrate the original breakage, perhaps?

Your patch works great. By the way I think we should move "cached"
check from grep_cache() into external_grep() too, for consistency.

I thought of tests when I wrote the patch, but it was hard to find a
reliable way to detect if a git build supports external grep. Perhaps
this on top of yours? The way to check for external grep support isn't
nice, but it works.


diff --git a/builtin-grep.c b/builtin-grep.c
index f093b60..bc4500a 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -222,6 +222,7 @@ static int exec_grep(int argc, const char **argv)
 	int status;
 
 	argv[argc] = NULL;
+	trace_argv_printf(argv, "trace: grep:");
 	pid = fork();
 	if (pid < 0)
 		return pid;
@@ -371,7 +372,7 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 	struct grep_pat *p;
 
 	if (opt->extended || (opt->relative && opt->prefix_length)
-	    || has_skip_worktree_entry(opt, paths))
+	    || cached || has_skip_worktree_entry(opt, paths))
 		return -1;
 	len = nr = 0;
 	push_arg("grep");
@@ -509,7 +510,7 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached,
 	 * we grep through the checked-out files. It tends to
 	 * be a lot more optimized
 	 */
-	if (!cached && external_grep_allowed) {
+	if (external_grep_allowed) {
 		hit = external_grep(opt, paths, cached);
 		if (hit >= 0)
 			return hit;
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index abd14bf..f77970c 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -8,6 +8,14 @@ test_description='git grep various.
 
 . ./test-lib.sh
 
+support_external_grep() {
+	case "$(git grep -h 2>&1 >/dev/null|grep -e --ext-grep)" in
+	*"(default)"*)  return 0;;
+	*"(ignored by this build)"*) return 1;;
+	*) test_expect_success 'External grep check is broken' 'false';;
+	esac
+}
+
 cat >hello.c <<EOF
 #include <stdio.h>
 int main(int argc, const char **argv)
@@ -426,4 +434,20 @@ test_expect_success 'grep -Fi' '
 	test_cmp expected actual
 '
 
+if support_external_grep; then
+
+test_expect_success 'external grep' '
+	GIT_TRACE=2 git grep foo >/dev/null 2>actual &&
+	grep "trace: grep:.*foo" actual >/dev/null
+'
+test_expect_success 'no external grep when skip-worktree entries exist' '
+	git update-index --skip-worktree file &&
+	GIT_TRACE=2 git grep foo >/dev/null 2>actual &&
+	! grep "trace: grep:" actual >/dev/null &&
+	git update-index --no-skip-worktree file
+'
+
+else
+	say "External grep tests skipped"
+fi
 test_done

-- 
Duy
