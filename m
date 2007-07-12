From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] gitweb: new cgi parameter: opt
Date: Thu, 12 Jul 2007 20:39:27 +0200
Message-ID: <20070712183927.GS19386@genesis.frugalware.org>
References: <20070708013543.GD29994@genesis.frugalware.org> <f73hhc$uo1$1@sea.gmane.org> <20070711230038.GN19386@genesis.frugalware.org> <200707121211.32813.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93Zm-00025S-F7
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbXGLSji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755999AbXGLSji
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:39:38 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59434 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991AbXGLSjh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:39:37 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1I93Ze-0003NX-1y
	from <vmiklos@frugalware.org>; Thu, 12 Jul 2007 20:39:34 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E31F216A80A0; Thu, 12 Jul 2007 20:39:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200707121211.32813.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52315>

Currently the only supported value is '--no-merges' for the 'rss', 'atom',
'log', 'shortlog' and 'history' actions, but it can be easily extended to allow
other parameters for other actions.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Hello,

Na Thu, Jul 12, 2007 at 12:11:32PM +0200, Jakub Narebski <jnareb@gmail.com> pisal(a):
> 'log', 'shortlog' and 'history' actions, but it can be easily extended to allow
> Micronit: it is unwritten (as of yet) requirement to word wrap commit
> message at 80 columns or less.

OK, though I think 79 is valid for "80 or less" :-)

> By the way, there is t9500-gitweb-standalone-no-errors.sh test script to
> check if gitweb doesn't give any Perl warnings or errors. Please try to
> use it; it should at least find errors about undefined values and such.
> But it has the disadvantage of requiring git to be build (compiled),
> even if theoretically testing gitweb doesn't require it.
>
> You would see something like
>
>   Argument "nomerges" isn't numeric in numeric eq (==)
>
> when running this test with --debug, I think.

As far as i see the test passes without any such warning ATM.

> First, you don't need inner () parentheses to delimit/create list, as
> anonymous array reference constructor [] works like it. So it could be
> written simply as
>
>   +my %options = (
>   +   "--no-merges" => ['rss', 'atom', 'log', 'shortlog', 'history'],
>   +);
>
> Second, instead of quoting each word by hand, we can use handy Perl
> quoting operator, qw(), i.e. 'word list' operator, like below.
> See perlop(1), "Quote and Quote-like Operators" subsection
>
>   +my %options = (
>   +   "--no-merges" => [ qw(rss atom log shortlog history) ],
>   +);

Fixed.

> history view. So I'd use
>
>   +our @options = $cgi->param('option');
>
> instead. This would make option validation bit harder, but I think not that
> harder. But it would also make using extra options easier: just @options
> instead of (defined $option ? $option : ()).

Done.

> I'd also use @extra_options, or @act_opts instead of @options as
> a variable name to be more descriptive.

Changed. Also renamed %options to %allowed_options.

> I'm also not sure if invalid option parameter for action should return
> error, or be simply ignored. This allow to hand-edit URL, changing for
> example action from 'commitdiff' to 'commit', not worrying about spurious
> parameters.

I did this way because gitweb also dies for invalid actions but it can
be removed if you don't like it.

> By the way, gitweb uses shortened names for paramaters. Perhaps 'opt'
> or 'op' instead of 'options' here and in href subroutine (below)?

Changed to 'opt'.

 gitweb/gitweb.perl |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 27580b5..13134fe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -386,6 +386,23 @@ if (defined $hash_base) {
 	}
 }
 
+my %allowed_options = (
+	"--no-merges" => [ qw(rss atom log shortlog history) ],
+);
+
+our @extra_options = $cgi->param('opt');
+if (defined @extra_options) {
+	foreach(@extra_options)
+	{
+		if (not grep(/^$_$/, keys %allowed_options)) {
+			die_error(undef, "Invalid option parameter");
+		}
+		if (not grep(/^$action$/, @{$allowed_options{$_}})) {
+			die_error(undef, "Invalid option parameter for this action");
+		}
+	}
+}
+
 our $hash_parent_base = $cgi->param('hpb');
 if (defined $hash_parent_base) {
 	if (!validate_refname($hash_parent_base)) {
@@ -537,6 +554,7 @@ sub href(%) {
 		action => "a",
 		file_name => "f",
 		file_parent => "fp",
+		extra_options => "opt",
 		hash => "h",
 		hash_parent => "hp",
 		hash_base => "hb",
@@ -1773,6 +1791,7 @@ sub parse_commits {
 		($arg ? ($arg) : ()),
 		("--max-count=" . $maxcount),
 		("--skip=" . $skip),
+		@extra_options,
 		$commit_id,
 		"--",
 		($filename ? ($filename) : ())
-- 
1.5.3.rc0.39.g46f7-dirty
