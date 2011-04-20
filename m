From: Joe Perches <joe@perches.com>
Subject: [RFC PATCH] git-send-email: Validate recipient_cmd (to-cmd,
 cc-cmd) addresses
Date: Wed, 20 Apr 2011 14:50:53 -0700
Message-ID: <1303336253.24766.34.camel@Joe-Laptop>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
	 <20110419215239.GA22632@elie> <1303268630.24766.9.camel@Joe-Laptop>
	 <BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:51:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCfIZ-0002yy-TT
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 23:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab1DTVuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 17:50:54 -0400
Received: from mail.perches.com ([173.55.12.10]:4855 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab1DTVuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 17:50:54 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 3A34524368;
	Wed, 20 Apr 2011 14:50:51 -0700 (PDT)
In-Reply-To: <BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171876>

On Wed, 2011-04-20 at 12:45 -0300, Thiago Farina wrote:
> On Wed, Apr 20, 2011 at 12:03 AM, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2011-04-19 at 16:52 -0500, Jonathan Nieder wrote:
> >> Thiago Farina wrote:
> >> > when I run:
> >> > $ git send-email --to linux-kernel@vger.kernel.org --cc-cmd
> >> > scripts/get_maintainer.pl foo
> >> > I'm getting some lines like:
> >> > Use of uninitialized value $cc in string eq at
> >> > /home/tfarina/libexec/git-core/git-send-email line 964.
> >> Yes, sounds like a bug.  Cc-ing some send-email people for tips.

Perhaps some patch like this.

Validate the address(es) returned from recipient_cmd.
Die if the output contains an invalid address.

Signed-off-by: Joe Perches <joe@perches.com>
---
 git-send-email.perl |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 76565de..9273cf2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -870,10 +870,14 @@ sub is_rfc2047_quoted {
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address {
 	my ($recipient) = @_;
-	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
+	my ($recipient_name, $recipient_addr) = ($recipient =~ /^\s*(.*?)\s*(<[^>]+>)/);
 
 	if (not $recipient_name) {
-		return $recipient;
+		return $recipient_addr if ($recipient_addr);
+		if ($recipient =~ /^\s*(.+\@\S*).*$/) {
+			return $1;
+		}
+		return "";
 	}
 
 	# if recipient_name is already quoted, do nothing
@@ -1343,11 +1347,13 @@ sub recipients_cmd {
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
-		$address = sanitize_address($address);
-		next if ($address eq $sanitized_sender and $suppress_from);
-		push @addresses, $address;
+		my $sanitized_address = sanitize_address($address);
+		next if ($sanitized_address eq $sanitized_sender and $suppress_from);
+		die "($prefix) '$cmd' returned invalid address: '$address'\n"
+			if ($address =~ /.*${sanitized_address}.+/);
+		push @addresses, $sanitized_address;
 		printf("($prefix) Adding %s: %s from: '%s'\n",
-		       $what, $address, $cmd) unless $quiet;
+		       $what, $sanitized_address, $cmd) unless $quiet;
 		}
 	close $fh
 	    or die "($prefix) failed to close pipe to '$cmd'";
