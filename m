From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Sun, 13 Oct 2013 22:29:29 +0200
Message-ID: <877gdg7w46.fsf@linux-k42r.v.cablecom.net>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 22:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVSIT-0005w7-Er
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 22:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab3JMU3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 16:29:42 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:51731 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755242Ab3JMU3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 16:29:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id BD8954D6531;
	Sun, 13 Oct 2013 22:29:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dsHQMGqdxXMo; Sun, 13 Oct 2013 22:29:30 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D90374D64C1;
	Sun, 13 Oct 2013 22:29:29 +0200 (CEST)
In-Reply-To: <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> (Yoshioka
	Tsuneo's message of "Sat, 12 Oct 2013 23:48:16 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236080>

Hi,

Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:

> "git diff -M --stat" can detect rename and show renamed file name like
> "foofoofoo => barbarbar", but if destination filename is long the line
> is shortened like "...barbarbar" so there is no way to know whether the
> file is renamed or existed in the source commit.

Thanks for your patch!  I think this is indeed something that should be
fixed.

Can you explain the algorithm chosen in the commit message or a block
comment in the code?  I find it much easier to follow large code blocks
(like the one you added) with a prior notion of what it tries to do.

  [As an aside, Documentation/SubmittingPatches says

    The body should provide a meaningful commit message, which:

      . explains the problem the change tries to solve, iow, what is wrong
        with the current code without the change.

      . justifies the way the change solves the problem, iow, why the
        result with the change is better.

      . alternate solutions considered but discarded, if any.

  Observe that you explained the first item very well, but not the
  others.]

> This commit makes it visible like "...foo => ...bar".

Also, you should rewrite this to be in the imperative mood:

  Make sure there is always an arrow, e.g., "...foo => ...bar".

or some such.

  [Again from SubmittingPatches:

    Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
    instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
    to do frotz", as if you are giving orders to the codebase to change
    its behaviour.]

> Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
> ---
>  diff.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 7 deletions(-)

Can you add a test?  Perhaps like the one below.  (You can squash it
into your commit if you like it.)

Note that in the test, the generated line looks like this:

 {..._does_not_fit_in_a_single_line => .../path1                          | 0

I don't want to go all bikesheddey, but I think it's somewhat
unfortunate that the elided parts do not correspond to each other.  In
particular, I think the closing brace should not be omitted.  Perhaps
something like this would be ideal (making it up on the spot, don't
count characters):

 {...a_single_line => ..._as_the_first}/path1                          | 0

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2f327b7..03d6371 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -156,4 +156,16 @@ test_expect_success 'rename pretty print common prefix and suffix overlap' '
 	test_i18ngrep " d/f/{ => f}/e " output
 '
 
+test_expect_success 'rename of very long path shows =>' '
+	mkdir long_dirname_that_does_not_fit_in_a_single_line &&
+	mkdir another_extremely_long_path_but_not_the_same_as_the_first &&
+	cp path1 long_dirname*/ &&
+	git add long_dirname*/path1 &&
+	test_commit add_long_pathname &&
+	git mv long_dirname*/path1 another_extremely_*/ &&
+	test_commit move_long_pathname &&
+	git diff -M --stat HEAD^ HEAD >output &&
+	test_i18ngrep "=>.*path1" output
+'
+
 test_done

-- 
Thomas Rast
tr@thomasrast.ch
