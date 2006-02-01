From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport.perl: fix for 'arg list too long...'
Date: Wed, 01 Feb 2006 14:50:53 -0800
Message-ID: <7v3bj27kxe.fsf@assigned-by-dhcp.cox.net>
References: <20060201155331.GE18078@sashak.voltaire.com>
	<7v64nybz9m.fsf@assigned-by-dhcp.cox.net>
	<20060201215454.GB31711@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:53:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4QoU-0003l8-OL
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 23:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422995AbWBAWu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 17:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWBAWuz
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 17:50:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:32473 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1422995AbWBAWuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 17:50:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201224827.HQCK26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 17:48:27 -0500
To: Sasha Khapyorsky <sashak@voltaire.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15459>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> On 12:27 Wed 01 Feb     , Junio C Hamano wrote:
>> Sasha Khapyorsky <sashak@voltaire.com> writes:
>> 
>> > This fixes 'arg list too long..' problem with git-ls-files.
>> 
>> I wonder if feeding the list into a pipe to 'update-index --stdin' 
>> would be an option.
>
> This can be option for git-update-index, but my problem was with
> git-ls-files, git-update-index was ok (arg list processing were splitted
> already).

I was commenting on the "while (@o1)" loop that splices at 50
when the list has more than 55 items to feed update-index.  You
could accumulate output from multiple invocations of ls-files
and feed everything to a single "update-index --stdin" after the
"while (@old)" loop is done.  Batch of 50 vs a single batch may
not matter though [*1*].

But you are right; that git-ls-files can get too many arguments
unless you split like that.

A casual skimming over the rest of the code tells me that this
fixes the last instance of such a command invocation with too
many arguments.  Good catch.

Smurf, I do not have problems with Sasha's patch.  Are you OK
if I apply it?


-- >8 --

*1* I do not think this makes much of a difference but here is what
I mean.

diff --git a/git-svnimport.perl b/git-svnimport.perl
index b6799d8..d76a595 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -546,7 +546,8 @@ sub commit {
 			}
 		}
 
-		while(@old) {
+		my @u = ();
+		while (@old) {
 			my @o1;
 			if(@old > 55) {
 				@o1 = splice(@old,0,50);
@@ -555,26 +556,19 @@ sub commit {
 				@old = ();
 			}
 			open my $F, "-|", "git-ls-files", "-z", @o1 or die $!;
-			@o1 = ();
 			local $/ = "\0";
 			while(<$F>) {
 				chomp;
-				push(@o1,$_);
+				push(@u,$_);
 			}
 			close($F);
-
-			while(@o1) {
-				my @o2;
-				if(@o1 > 55) {
-					@o2 = splice(@o1,0,50);
-				} else {
-					@o2 = @o1;
-					@o1 = ();
-				}
-				system("git-update-index","--force-remove","--",@o2);
-				die "Cannot remove files: $?\n" if $?;
-			}
 		}
+		open my $F, "|-",
+			qw(git-update-index --force-remove -z --stdin)
+				or die $!;
+		print $F "$_\0" for @u;
+		close $F or die $!;
+
 		while(@new) {
 			my @n2;
 			if(@new > 12) {
