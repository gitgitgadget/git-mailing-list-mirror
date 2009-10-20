From: Joe Perches <joe@perches.com>
Subject: Re: git-send-email.perl defect: address missing trailing > accepted
Date: Tue, 20 Oct 2009 15:48:37 -0700
Message-ID: <1256078917.2029.77.camel@Joe-Laptop.home>
References: <1256076767.2029.59.camel@Joe-Laptop.home>
	 <40aa078e0910201529m338ef3d1o4fa1a31c3dcc2a20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 21 01:04:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0NVW-0002zu-04
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbZJTWse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 18:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZJTWse
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:48:34 -0400
Received: from mail.perches.com ([173.55.12.10]:2286 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbZJTWsd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 18:48:33 -0400
Received: from [192.168.1.151] (Joe-Laptop.home [192.168.1.151])
	by mail.perches.com (Postfix) with ESMTP id 61A9724368;
	Tue, 20 Oct 2009 15:48:34 -0700 (PDT)
In-Reply-To: <40aa078e0910201529m338ef3d1o4fa1a31c3dcc2a20@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130863>

On Wed, 2009-10-21 at 00:29 +0200, Erik Faye-Lund wrote:
> On Wed, Oct 21, 2009 at 12:12 AM, Joe Perches <joe@perches.com> wrote:
> > I typo cut/pasted an invalid email address,
> > neglecting to copy the trailing ">".
> > was:    "Name <addr.org"
> > needed: "Name <addr.org>"
> > Anyone have suggestions on how to get
> > git-send-email.perl to notify and abort
> > sending on more invalid address styles?
> 
> Something along these lines? Of course, the error message is, uhm,
> less than helpful :)
> 
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -787,6 +787,10 @@ sub is_rfc2047_quoted {
>  sub sanitize_address
>  {
>  	my ($recipient) = @_;
> +	if ($recipient =~ m/.*<[^>]*$/) {
> +		die "EEK!"
> +	}
> +


Maybe this?  Seems to work.

diff --git a/git-send-email.perl b/git-send-email.perl
index a0279de..52ddd9e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -374,15 +374,18 @@ my ($repoauthor, $repocommitter);
 # Verify the user input
 
 foreach my $entry (@to) {
-	die "Comma in --to entry: $entry'\n" unless $entry !~ m/,/;
+	die "Comma in --to entry: '$entry'\n" unless $entry !~ m/,/;
+	die "Invalid --to entry: '$entry'\n"  unless $entry !~ m/.*<[^>]*$/;
 }
 
 foreach my $entry (@initial_cc) {
-	die "Comma in --cc entry: $entry'\n" unless $entry !~ m/,/;
+	die "Comma in --cc entry: '$entry'\n" unless $entry !~ m/,/;
+	die "Invalid --cc entry: '$entry'\n" unless $entry !~ m/.*<[^>]*$/;
 }
 
 foreach my $entry (@bcclist) {
-	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
+	die "Comma in --bcclist entry: '$entry'\n" unless $entry !~ m/,/;
+	die "Invalid --bcclist entry: '$entry'\n" unless $entry !~ m/.*<[^>]*$/;
 }
 
 sub parse_address_line {
