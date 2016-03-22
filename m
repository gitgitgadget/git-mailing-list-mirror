From: Jeff King <peff@peff.net>
Subject: [PATCH] git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
Date: Tue, 22 Mar 2016 15:50:51 -0400
Message-ID: <20160322195051.GA20563@sigill.intra.peff.net>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
 <20160322185628.GA19993@google.com>
 <20160322192309.GA9782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:51:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiSKd-0005Gi-VB
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 20:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbcCVTu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 15:50:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:36097 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752247AbcCVTuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 15:50:54 -0400
Received: (qmail 15483 invoked by uid 102); 22 Mar 2016 19:50:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Mar 2016 15:50:53 -0400
Received: (qmail 17364 invoked by uid 107); 22 Mar 2016 19:51:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Mar 2016 15:51:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2016 15:50:51 -0400
Content-Disposition: inline
In-Reply-To: <20160322192309.GA9782@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289551>

On Tue, Mar 22, 2016 at 03:23:09PM -0400, Jeff King wrote:

> On Tue, Mar 22, 2016 at 11:56:28AM -0700, Jonathan Nieder wrote:
> 
> > This is failing for me when I use "git submodule add" with a remote
> > helper I whitelisted with GIT_ALLOW_PROTOCOL, with current "next":
> > 
> >  $ bin-wrappers/git submodule add persistent-https://kernel.googlesource.com/pub/scm/git/git sm
> >  Cloning into 'sm'...
> >  error: bogus format in GIT_CONFIG_PARAMETERS
> >  fatal: unable to parse command-line config
> >  fatal: clone of 'persistent-https://kernel.googlesource.com/pub/scm/git/git' into submodule path 'sm' failed
> > 
> > sq_dequote_to_argv doesn't like the space at the beginning of
> > $GIT_CONFIG_PARAMETERS.  Reverting 14111fc4 fixes it.  Known
> > problem?
> 
> It's known that the parsing end is excessively picky, but not this
> particular bug. I found the problem; I'll have a patch out in a few
> minute after I write a test.

Here it is.

Obviously another option would be to make the parsing side more liberal
(which has the added effect that if anybody _else_ ever wants to
generate $GIT_CONFIG_PARAMETERS, they will not get annoyed). But I took
this route for now because it's the simplest way to fix the regression.
And even if we do later make the parser more liberal, it's still a good
idea to keep the output from the generating side as clean as possible.

-- >8 --
Subject: git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS

The "git -c var=value" option stuffs the config value into
$GIT_CONFIG_PARAMETERS, so that sub-processes can see it.
When the config is later read via git_config() or similar,
we parse it back out of that variable.  The parsing end is a
little bit picky; it assumes that each entry was generated
with sq_quote_buf(), and that there is no extraneous
whitespace.

On the generating end, we are careful to append to an
existing $GIT_CONFIG_PARAMETERS variable if it exists.
However, our test for "should we add a space separator" is
too liberal: it will add one even if the environment
variable exists but is empty. As a result, you might end up
with:

   GIT_CONFIG_PARAMETERS=" 'core.foo=bar'"

which the parser will choke on.

This was hard to trigger in older versions of git, since we
only set the variable when we had something to put into it
(though you could certainly trigger it manually). But since
14111fc (git: submodule honor -c credential.* from command
line, 2016-02-29), the submodule code will unconditionally
put the $GIT_CONFIG_PARAMETERS variable into the environment
of any operation in the submodule, whether it is empty or
not. So any of those operations which themselves use "git
-c" will generate the unparseable value and fail.

We can easily fix it by catching this case on the generating
side. While we're adding a test, let's also check that
multiple layers of "git -c" work, which was previously not
tested at all.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I just did this on master, and it is standalone. But for the reasons
above I think it would also be fine to stick on the tip of the
jk/submodule-c-credential topic.

 config.c               |  2 +-
 t/t1300-repo-config.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 9ba40bc..8f66519 100644
--- a/config.c
+++ b/config.c
@@ -162,7 +162,7 @@ void git_config_push_parameter(const char *text)
 {
 	struct strbuf env = STRBUF_INIT;
 	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
-	if (old) {
+	if (old && *old) {
 		strbuf_addstr(&env, old);
 		strbuf_addch(&env, ' ');
 	}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 8867ce1..2b58312 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1091,6 +1091,20 @@ test_expect_success 'git -c complains about empty key and value' '
 	test_must_fail git -c "" rev-parse
 '
 
+test_expect_success 'multiple git -c appends config' '
+	test_config alias.x "!git -c x.two=2 config --get-regexp ^x\.*" &&
+	cat >expect <<-\EOF &&
+	x.one 1
+	x.two 2
+	EOF
+	git -c x.one=1 x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git -c is not confused by empty environment' '
+	GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=yes >expect &&
-- 
2.8.0.rc4.388.gdee5eca
