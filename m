From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Mon, 30 Jan 2012 12:34:08 -0800
Message-ID: <7v39axaq0v.fsf@alter.siamese.dyndns.org>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrxvd-0007Kh-03
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab2A3UeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:34:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab2A3UeL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:34:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4193688D;
	Mon, 30 Jan 2012 15:34:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I65soKsYkRTptC965RvjgVOm0bY=; b=vogkO2
	U3LoTurLEibHBbOyV9krh3KJ6WWNM3Ko1PlAOMLP2U0vAKNHaPHFxy4B2tIod/dU
	CxypLSOYS/n6XcVSBel9/Nh9PB5u5vDwlebUaXMcJWTGoAo8CGNlQZwr39DTEe90
	p9F2k0SUyjRIb1/dLhP87GGM54ljajtfEfrK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gkvXbhRnu2vgaLctazo4sl+gp44mE6rm
	fqenyScoak8/DvoAahaT2aTD25npW+NDmGkXyADikpRvIS+A2xpPZK+OFuGPuEYO
	jGu4HYxhcpwrcn8PysL0PN4/4CNMWptnR6h5f7tYCjVLAGlSV9H0B6tPVdAA+ljS
	nYM68WtPIs8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB24A688B;
	Mon, 30 Jan 2012 15:34:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 323B0688A; Mon, 30 Jan 2012
 15:34:10 -0500 (EST)
In-Reply-To: <20120130200355.GA2584@server.brlink.eu> (Bernhard R. Link's
 message of "Mon, 30 Jan 2012 21:03:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C39752DE-4B81-11E1-BB96-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189418>

"Bernhard R. Link" <brl@mail.brlink.eu> writes:

> I'll resend the series as replies to this mail.

Thanks; I'll queue them in 'pu' for now (if Jakub wants to Ack the pieces,
I'll amend them).

Regarding the first patch in the series, while it may be a valid perl to
introduce a new variable, assign to it and then munge its contents with
s///, all inside a parameter list of a function call, it is doing a bit
too much and makes it hard to see if the variable may or may not later be
used in the same scope (in this case, it is not).

I am tempted to squash the following in.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b764d51..f215eaa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6003,7 +6003,8 @@ sub git_forks {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
+	my ($filter = $project) =~ s/\.git$//;
+	my @list = git_get_projects_list($filter);
 	if (!@list) {
 		die_error(404, "No forks found");
 	}
@@ -6062,7 +6063,8 @@ sub git_summary {
 
 	if ($check_forks) {
 		# find forks of a project
-		@forklist = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
+		my ($filter = $project) =~ s/\.git$//;
+		@forklist = git_get_projects_list($filter);
 		# filter out forks of forks
 		@forklist = filter_forks_from_projects_list(\@forklist)
 			if (@forklist);
-- 
1.7.9.154.g413bff
