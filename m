From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] am -i, git-svn: use "git var GIT_PAGER"
Date: Wed, 11 Nov 2009 18:03:04 -0600
Message-ID: <20091112000303.GH1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:52:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Mzg-0000Kv-Jr
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbZKKXwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 18:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbZKKXwp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:52:45 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:37862 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbZKKXwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:52:45 -0500
Received: by ywh6 with SMTP id 6so1463214ywh.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c/vG0HoNdA4cGXnV5dU5JtNSfC7f09LnT25PrwT8FCA=;
        b=DXR1UFgUo6/k+zzlnzejOF3PltyXZ1T1eeI+HZQc0CD2W8pfVDP69Ja2nJ9oPGRf43
         +vOtyqwOAbL6duZl9y6Z+SRlHmCkhui8ifuGjj7ouuJvaMo6io/9m7JCu1gyxgBtijwh
         czdOPbwj6WqEUFtrl8PdPdNWOzZh7dAqYqSEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E4w31V6ramgGlTje7cfon8KAWuLvIntI8JnKNdGF755poTogsAyf9KIhYTLfJVVNpJ
         hSgsuQG0k48QEcMdMH9RBJ56D8HoXseVqakONneuk8bW+N+9/6vQAxu39DVvmsmnvShV
         NSCpnjvNRHhFnu2TTNraChdyGtKJWyW7AVV5Y=
Received: by 10.90.222.1 with SMTP id u1mr3262320agg.103.1257983570740;
        Wed, 11 Nov 2009 15:52:50 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1029437yxe.57.2009.11.11.15.52.49
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:52:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111235100.GA1140@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132728>

Use the new "git var GIT_PAGER" command to ask what pager to use.

Without this change, the core.pager configuration is ignored by
these commands.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Unchanged.

 git-am.sh    |    5 ++++-
 git-svn.perl |    6 ++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c132f50..2649487 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -649,7 +649,10 @@ do
 		[eE]*) git_editor "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
-		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
+		       : ${GIT_PAGER=$(git var GIT_PAGER)}
+		       : ${LESS=-FRSX}
+		       export LESS
+		       $GIT_PAGER "$dotest/patch" ;;
 		*)     action=again ;;
 		esac
 	    done
diff --git a/git-svn.perl b/git-svn.perl
index 42c9a72..c4ca548 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5171,10 +5171,8 @@ sub git_svn_log_cmd {
 
 # adapted from pager.c
 sub config_pager {
-	$pager ||= $ENV{GIT_PAGER} || $ENV{PAGER};
-	if (!defined $pager) {
-		$pager = 'less';
-	} elsif (length $pager == 0 || $pager eq 'cat') {
+	chomp(my $pager = command_oneline(qw(var GIT_PAGER)));
+	if ($pager eq 'cat') {
 		$pager = undef;
 	}
 	$ENV{GIT_PAGER_IN_USE} = defined($pager);
-- 
1.6.5.2
