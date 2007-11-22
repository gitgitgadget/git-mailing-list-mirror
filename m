From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 3/5] Added config_default($key, $default) to Git.pm
Date: Thu, 22 Nov 2007 04:55:52 -0600
Message-ID: <20071122045552.30ca55c2@paradox.zwell.net>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAAW-0008U8-68
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbXKVLYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbXKVLYL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:24:11 -0500
Received: from gateway03.websitewelcome.com ([69.93.37.21]:60661 "HELO
	gateway03.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752002AbXKVLYJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 06:24:09 -0500
X-Greylist: delayed 1744 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2007 06:24:09 EST
Received: (qmail 29279 invoked from network); 22 Nov 2007 10:56:31 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway03.websitewelcome.com with SMTP; 22 Nov 2007 10:56:31 -0000
Received: from [143.44.70.185] (port=40113 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dzwell@zwell.net>)
	id 1Iv9j5-0000BS-VO; Thu, 22 Nov 2007 04:56:08 -0600
In-Reply-To: <20071110180109.34febc3f@paradox.zwell.net>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.12.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65797>

Method returns a configuration value if defined, or the default
value that was passed in, otherwise.

The main purpose of this method is to allow the empty string to
be a valid configuration option, and to replace the following
construct:

$val = $repo->config('my.key') || $default_val

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
 perl/Git.pm |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 6603762..7327300 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -549,6 +549,34 @@ sub config_bool {
 	};
 }
 
+=item config_default ( VARIABLE, DEFAULT )
+
+Fetches a configuration option C<VARIABLE>, returning its
+value if it is defined (it is valid to return the empty string,
+if that is its value). Otherwise, C<DEFAULT>, a default
+value, is returned. This method may be a replacement for
+
+	my $value = $repo->config('my.key') || 'default val';
+
+in situations where the empty string is an acceptable return value.
+This method may also be called in a vector context, when expecting
+multivars.
+
+	my @value = $repo->config_default('my.multivar', \@default_vals);
+
+=cut
+
+sub config_default {
+	my ($self, $var, $default) = @_;
+	if (wantarray) {
+		my @value = $self->config($var);
+		return @value ? @value : @$default;
+	}
+	else {
+		my $value = $self->config($var);
+		return (defined $value) ? $value : $default;
+	}
+}
 
 =item ident ( TYPE | IDENTSTR )
 
-- 
1.5.3.5.565.gf0b83-dirty
