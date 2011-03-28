From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git svn mkdirs" is very slow
Date: Mon, 28 Mar 2011 10:44:15 -0700
Message-ID: <7vhbanywb4.fsf@alter.siamese.dyndns.org>
References: <4D90A3AA.3050601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:44:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4GUR-0008RO-JE
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab1C1Ro0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 13:44:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab1C1RoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 13:44:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1AF5649E4;
	Mon, 28 Mar 2011 13:46:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KaBjzyfO2to+gEGWPKBHzpckCc0=; b=VeBSQl
	Cz8AZqa2ITq29jPRrXVtDgfH/dRLbVY+gnMKgGAnV+E/PFPYANH4XirOLGLnFWsI
	D2YGSH//Z72HZri7eb+Qb0w1igcAiCVBXvP+bo7Itwn76K6eYT+b8yB4zU3xXpQx
	K0JCUfV/HWtlEPeeeKzi3A0qxfBXzgQmrRpfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vJTNw4hqu3YD6hOnlrt6ZGiyVd56hhxi
	oQS6WBZkJtZ1iU35LHCv7Am9JYJbrCGOaqdq9H0U50qU8FLPQZMUAsS20ogpsMMh
	E8ps93U/I7D9wKCGMBK5WeYqPtM/gTUc/Qjj5Znn2cPkKzaVWlSrqUJ4PeNEQ63y
	RNMFGsw0vcg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EDA0149E3;
	Mon, 28 Mar 2011 13:46:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E8EC349E2; Mon, 28 Mar 2011
 13:46:03 -0400 (EDT)
In-Reply-To: <4D90A3AA.3050601@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 28 Mar 2011 17:05:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 423B51CE-5963-11E0-AB79-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170165>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> So I
> wanted to implement the following feature:
>
> 1. An svn.autoMkdirs / svn-remote.<name>.autoMkdirs configuration
> variable.  The value should default to true for backwards compatibility.
>
> 2. Only call mkemptydirs() if this variable is set to true.
>
> 3. Make an exception for "git svn mkdirs", which should do its thing
> regardless of how this configuration option is set.
>
> I think it should only be about a 10-line change, plus documentation and
> tests.  Unfortunately, my perl-foo is very limited, and it will take me
> a while to figure out how option parsing and handling works in git-svn.
>
> Would this feature be welcome?
>
> Is there anybody willing to make the Perl changes?  I would be willing
> to work on the documentation and test suite changes.

Sounds like a sensible thing to do, but I wonder if we also want a command
line option --automkdirs (or --auto-create-empty-directories) in %fc_opts
to make it overridable from the command line.  Perhaps it is not worth it.

A completely untested patch is here.

 git-svn.perl |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a5857c1..fe4c716 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -781,6 +781,16 @@ sub cmd_find_rev {
 	print "$result\n" if $result;
 }
 
+sub auto_create_empty_directories {
+	my ($gs) = @_;
+	my $var = eval { command_oneline('config', '--get', '--bool',
+					 "svn-remote.$gs->{repo_id}.automkdirs") };
+	# By default, create empty directories by consulting the unhandled log,
+	# but allow setting it to 'false' to skip it.  I wonder if the variable
+	# should be "skip create empty directories", though...
+	return !($var && $var eq 'false');
+}
+
 sub cmd_rebase {
 	command_noisy(qw/update-index --refresh/);
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
@@ -804,7 +814,9 @@ sub cmd_rebase {
 		$_fetch_all ? $gs->fetch_all : $gs->fetch;
 	}
 	command_noisy(rebase_cmd(), $gs->refname);
-	$gs->mkemptydirs;
+	if (auto_create_empty_directories($gs)) {
+		$gs->mkemptydirs;
+	}
 }
 
 sub cmd_show_ignore {
@@ -1242,7 +1254,9 @@ sub post_fetch_checkout {
 	command_noisy(qw/read-tree -m -u -v HEAD HEAD/);
 	print STDERR "Checked out HEAD:\n  ",
 	             $gs->full_url, " r", $gs->last_rev, "\n";
-	$gs->mkemptydirs($gs->last_rev);
+	if (auto_create_empty_directories($gs)) {
+		$gs->mkemptydirs($gs->last_rev);
+	}
 }
 
 sub complete_svn_url {
