From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] send-email: address expansion for common mailers
Date: Sat, 25 Mar 2006 18:44:16 -0800
Message-ID: <20060326024416.GA14234@localdomain>
References: <20060325235017.GN26071@mythryan2.michonline.com> <11433354063582-git-send-email-normalperson@yhbt.net> <7vlkuyt2ku.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 04:44:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNLFJ-0007sS-BO
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 04:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWCZCoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 21:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWCZCoq
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 21:44:46 -0500
Received: from hand.yhbt.net ([66.150.188.102]:7567 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751337AbWCZCoq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 21:44:46 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BD9102DC033;
	Sat, 25 Mar 2006 18:44:43 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 25 Mar 2006 18:44:16 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkuyt2ku.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18020>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Two git repo-config keys are required for this
> > (as suggested by Ryan Anderson):
> >
> > 	sendemail.aliasesfile = <filename of aliases file>
> > 	sendemail.aliasfiletype = (mutt|gnus|pine|mailrc)
> >
> > I was initially working on auto-detection, but mailrc and mutt formats
> > tend to throw each other off (they're alike, but handle multiple
> > addresses per-alias differently).
> 
> I think specifying the type explicitly is probably not too much
> hassle for the end user, so that is fine.  Now, do we want to
> support more than one aliases file?

If they're different types, probably not.  But if it's the same type,
it's pretty easy and I don't see why not.  This patch applies on top
of the previous one.

Subject: [PATCH] send-email: allow more than one alias file to be used

The aliasfiletype must be the same for all aliasesfiles, though.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

16306f761b34505672a04bff333d6342724756c8
diff --git a/git-send-email.perl b/git-send-email.perl
index d3e1768..5d1e95c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -90,7 +90,7 @@ my ($author) = gitvar_ident('GIT_AUTHOR_
 my ($committer) = gitvar_ident('GIT_COMMITTER_IDENT');
 
 my %aliases;
-chomp(my $aliases_file = `git-repo-config sendemail.aliasesfile`);
+chomp(my @alias_files = `git-repo-config --get-all sendemail.aliasesfile`);
 chomp(my $aliasfiletype = `git-repo-config sendemail.aliasfiletype`);
 my %parse_alias = (
 	# multiline formats can be supported in the future
@@ -116,10 +116,12 @@ my %parse_alias = (
 		}}}
 );
 
-if ($aliases_file && defined $parse_alias{$aliasfiletype}) {
-	open my $fh, '<', $aliases_file or die "opening $aliases_file: $!\n";
-	$parse_alias{$aliasfiletype}->($fh);
-	close $fh;
+if (@alias_files && defined $parse_alias{$aliasfiletype}) {
+	foreach my $file (@alias_files) {
+		open my $fh, '<', $file or die "opening $file: $!\n";
+		$parse_alias{$aliasfiletype}->($fh);
+		close $fh;
+	}
 }
 
 my $prompting = 0;
-- 
1.2.4.gb622a
