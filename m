From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] am -i, git-svn: use "git var GIT_PAGER"
Date: Fri, 30 Oct 2009 20:43:19 -0500
Message-ID: <20091031014319.GG5160@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42q3-00069o-S7
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933136AbZJaBc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 21:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933098AbZJaBc6
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:32:58 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:36968 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933093AbZJaBc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 21:32:57 -0400
Received: by gxk4 with SMTP id 4so2455511gxk.8
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=p7ZqaJlSvxGAeRdf+yHthrMDu0KtdWPeD5Sx2nyZztI=;
        b=JmwWP592fLvq0UTMRXBdRDxdyZrYMXq772uOkegMAZGrJ63YnoPzXBeZ9eRSQoIkfI
         pEk4ms2OqOdB+M89kN+ZaTchpaairigouKKGxM1NDK422lw/BoPcXfuV7MhBhZLeQYp5
         FpvPpd0f0udrrziRp48Swu9iZGMxY5SQS5DEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WBE+3DqxbF+epo0hMQHStpQ013bov9HpE7gjA7WDdWHbvgXtqRmaP13ocgibRIJW1H
         Y6m5ikuLxkjsDdtH15BxuDjMvhy8kg66rQH/zbA949C6frQ503G+mpqdo2RLCB/Hd0rn
         87qGQcx6SIj7UmCoJeMeQNtmDr7B09twclCDg=
Received: by 10.150.61.3 with SMTP id j3mr4315033yba.76.1256952782454;
        Fri, 30 Oct 2009 18:33:02 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm579302gxk.5.2009.10.30.18.33.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 18:33:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031012050.GA5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131819>

Use the new "git var GIT_PAGER" command to ask what pager to use.

Without this change, the core.pager configuration is ignored by
these commands.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
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
