From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] gitweb: new cgi parameter: option
Date: Thu, 12 Jul 2007 01:00:38 +0200
Message-ID: <20070711230038.GN19386@genesis.frugalware.org>
References: <20070708013543.GD29994@genesis.frugalware.org> <f73hhc$uo1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 12 01:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8lB2-00012W-9H
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 01:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761589AbXGKXAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 19:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbXGKXAx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 19:00:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:42488 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757919AbXGKXAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 19:00:52 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1I8lAr-00029E-3D
	from <vmiklos@frugalware.org>; Thu, 12 Jul 2007 01:00:48 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E3F0D18681D4; Thu, 12 Jul 2007 01:00:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f73hhc$uo1$1@sea.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -0.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-0.4 required=5.9 tests=BAYES_20,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-0.5 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1133]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52220>

Currently the only supported value is '--no-merges' for the 'rss', 'atom',
'log', 'shortlog' and 'history' actions, but it can be easily extended to allow
other parameters for other actions.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Na Wed, Jul 11, 2007 at 11:19:41PM +0200, Jakub Narebski <jnareb@gmail.com> pisal(a):
> Miklos Vajna wrote:
>
> > +((defined $filter and $filter == "nomerges") ? ("--no-merges") : ()),
>
> Shouldn't it be '$filter eq "nomerges"' instead?

Yes, that works too (I'm not a perl addict :) )

> Besides, I'd rather have generalized way to provide additional options
> to git commands, like '--no-merges' for RSS and Atom feeds, log, shortlog
> and history views, '-C' for commitdiff view, '--remove-empty' for history
> view for a file, perhaps even '-c' or '--cc' for commitdiff for merges
> instead of abusing 'hp' argument for that.
>
> But that doesn't mean that this patch should be not applied... it doesn't
> mean it should be applied neither ;-)

What about this one?

 gitweb/gitweb.perl |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dc609f4..f3530ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -383,6 +383,20 @@ if (defined $hash_base) {
 	}
 }
 
+my %options = (
+	"--no-merges" => [('rss', 'atom', 'log', 'shortlog', 'history')],
+);
+
+our $option = $cgi->param('option');
+if (defined $option) {
+	if (not grep(/^$option$/, keys %options)) {
+		die_error(undef, "Invalid option parameter");
+	}
+	if (not grep(/^$action$/, @{$options{$option}})) {
+		die_error(undef, "Invalid option parameter for this action");
+	}
+}
+
 our $hash_parent_base = $cgi->param('hpb');
 if (defined $hash_parent_base) {
 	if (!validate_refname($hash_parent_base)) {
@@ -534,6 +548,7 @@ sub href(%) {
 		action => "a",
 		file_name => "f",
 		file_parent => "fp",
+		option => "option",
 		hash => "h",
 		hash_parent => "hp",
 		hash_base => "hb",
@@ -1770,6 +1785,7 @@ sub parse_commits {
 		($arg ? ($arg) : ()),
 		("--max-count=" . $maxcount),
 		("--skip=" . $skip),
+		((defined $option) ? ($option) : ()),
 		$commit_id,
 		"--",
 		($filename ? ($filename) : ())
-- 
1.5.3.rc0.39.g46f7-dirty
