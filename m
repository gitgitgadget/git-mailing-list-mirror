From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git
 config' access
Date: Tue, 07 Apr 2009 10:50:59 +1200
Message-ID: <1239058276.31863.19.camel@maia.lan>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
	  <20090406092942.GW17706@mail-vs.djpig.de>
Mime-Version: 1.0
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 01:01:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqxoj-0006Eo-6i
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 01:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758177AbZDFW7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 18:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbZDFW7v
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 18:59:51 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:45514 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754886AbZDFW7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 18:59:50 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2009 18:59:50 EDT
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 8768A21C50A; Tue,  7 Apr 2009 10:53:37 +1200 (NZST)
In-Reply-To: <20090406092942.GW17706@mail-vs.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115890>

On Mon, 2009-04-06 at 11:29 +0200, Frank Lichtenheld wrote:
> On Mon, Apr 06, 2009 at 11:46:15AM +1200, Sam Vilain wrote:
> > +	my ($fh, $c) = $git->command_output_pipe(
> > +		'config', ( $which ? ("--$which") : () ),
> > +		'--list',
> > +	       );
> Any reason why you don't use --null here? The output of --list without --null
> is not reliably parsable, since people can put newlines in values.

No particularly good reason :-)

Subject: [PATCH] perl: make Git::Config use --null

Use the form of 'git-config' designed for parsing by modules like
this for safety with values containing embedded line feeds.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 perl/Git/Config.pm |    6 ++++--
 t/t9700/config.t   |    4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/perl/Git/Config.pm b/perl/Git/Config.pm
index a0a6a41..a35d9f3 100644
--- a/perl/Git/Config.pm
+++ b/perl/Git/Config.pm
@@ -179,12 +179,14 @@ sub read {
 
 	my ($fh, $c) = $git->command_output_pipe(
 		'config', ( $which ? ("--$which") : () ),
-		'--list',
+		 '--null', '--list',
 	       );
 	my $read_state = {};
 
+	local($/)="\0";
 	while (<$fh>) {
-		my ($item, $value) = m{(.*?)=(.*)};
+		my ($item, $value) = m{(.*?)\n((?s:.*))\0}
+			or die "failed to parse it; \$_='$_'";
 		my $sl = \( $read_state->{$item} );
 		if (!defined $$sl) {
 			$$sl = $value;
diff --git a/t/t9700/config.t b/t/t9700/config.t
index 395a5c9..f0f7d2d 100644
--- a/t/t9700/config.t
+++ b/t/t9700/config.t
@@ -16,6 +16,7 @@ in_empty_repo sub {
 	$git->command_oneline("config", "foo.intval", "12g");
 	$git->command_oneline("config", "foo.false.val", "false");
 	$git->command_oneline("config", "foo.true.val", "yes");
+	$git->command_oneline("config", "multiline.val", "hello\nmultiline.val=world");
 
 	my $conf = Git::Config->new();
 	ok($conf, "constructed a new Git::Config");
@@ -92,6 +93,9 @@ in_empty_repo sub {
 	is($unset, undef,
 	   "boolean thaw - not present");
 
+	like($conf->config("multiline.val"), qr{\n},
+	     "parsing multi-line values");
+
 	$git->command_oneline("config", "foo.intval", "12g");
 	$git->command_oneline("config", "foo.falseval", "false");
 	$git->command_oneline("config", "foo.trueval", "on");
-- 
debian.1.5.6.1
