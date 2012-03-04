From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix fixed string (non-regexp) project
 search
Date: Sun, 04 Mar 2012 15:08:20 -0800
Message-ID: <7vaa3w55i3.fsf@alter.siamese.dyndns.org>
References: <20120228183919.26435.86795.stgit@localhost.localdomain>
 <201203022334.25544.jnareb@gmail.com>
 <7vwr72a6m6.fsf@alter.siamese.dyndns.org>
 <201203031156.00948.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:08:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4KXT-0006Iv-J7
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 00:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab2CDXIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 18:08:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755708Ab2CDXIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 18:08:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D433608D;
	Sun,  4 Mar 2012 18:08:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Q1icLi7IzYKKpa2Ojd38VYMI0Ak=; b=Yr9wi378F8jMMWA5qmRD
	eI4Tqvho919pxeZH49wfKcYOh8pvf2+2HrfqlhgieiG97WfOp7dB9lfMfE/wjdVm
	j5LKfPw396VKItbRNeasFY11y4/sEg2Wy2ThfYJBoJppd8E/0zrkgdf7DBmuMvG4
	5OoJbQiJP6sFujjAfCE9HiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HYzOhBOL7rSARRMViq7a3sfBlo27wTvU7u8jw961GSyxLz
	P+LvttQ3c/uDcO93txP2MX1iBbl6amkkXc0uDxmNOOjZNvsqwh/Z1YQFYWrekSwh
	1D2d7FSM973URr31aBWWKz+w36xKz59LxCzF+6RGIUON0gKT1XReO/QMPZULg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3526E608C;
	Sun,  4 Mar 2012 18:08:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9826608A; Sun,  4 Mar 2012
 18:08:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFFE6B9A-664E-11E1-8E08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192179>

Jakub Narebski <jnareb@gmail.com> writes:

> ....  The fix is about adding new code and should
> apply cleanly to 'maint' and even to older versions; the only trouble
> with older version might be whitespace issue related to refactoring
> code into subroutines.

OK, so the global $searchtext is what came from form submit from the end
user, while the global $search_regexp is what the code should be using
for matching throughout the program, prepared by eval-and-validate-params.

Here is a hand-ported version of your patch that should apply to 1.7.6.6;
does it look sane?

 gitweb/gitweb.perl |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 50a835a..d1698b7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2905,10 +2905,10 @@ sub filter_forks_from_projects_list {
 sub search_projects_list {
 	my ($projlist, %opts) = @_;
 	my $tagfilter  = $opts{'tagfilter'};
-	my $searchtext = $opts{'searchtext'};
+	my $search_re = $opts{'search_regexp'};
 
 	return @$projlist
-		unless ($tagfilter || $searchtext);
+		unless ($tagfilter || $search_re);
 
 	my @projects;
  PROJECT:
@@ -2920,10 +2920,10 @@ sub search_projects_list {
 				grep { lc($_) eq lc($tagfilter) } keys %{$pr->{'ctags'}};
 		}
 
-		if ($searchtext) {
+		if ($search_re) {
 			next unless
-				$pr->{'path'} =~ /$searchtext/ ||
-				$pr->{'descr_long'} =~ /$searchtext/;
+				$pr->{'path'} =~ /$search_re/ ||
+				$pr->{'descr_long'} =~ /$search_re/;
 		}
 
 		push @projects, $pr;
@@ -5097,7 +5097,7 @@ sub git_project_list_body {
 	@projects = fill_project_list_info(\@projects);
 	# searching projects require filling to be run before it
 	@projects = search_projects_list(\@projects,
-	                                 'searchtext' => $searchtext,
+	                                 'search_regexp' => $search_regexp,
 	                                 'tagfilter'  => $tagfilter)
 		if ($tagfilter || $searchtext);
 
