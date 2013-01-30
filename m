From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
Subject: [PATCH 3/7] perl/Git.pm: fix _cmd_close on Windows
Date: Wed, 30 Jan 2013 15:22:59 -0200
Message-ID: <1359566583-19654-4-git-send-email-gnustavo@cpan.org>
References: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 18:30:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bUE-0001ZC-Kk
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab3A3R3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:29:53 -0500
Received: from mail-gg0-f171.google.com ([209.85.161.171]:37999 "EHLO
	mail-gg0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab3A3R3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:29:51 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2013 12:29:51 EST
Received: by mail-gg0-f171.google.com with SMTP id j1so303253ggn.30
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-gm-message-state;
        bh=togXhC+nJg7HAKLE4uT8UpyATsGw3UiNn7rRf0MsNqA=;
        b=R+IG+kBc3fcPt7ogLE3Vf7c8oIdTrAb2BF3NRxhzSyImR9z8nJRtZpn6Towo8Qs9Nd
         EQBDS0r9yK2qbI/qKZtnQtNPUQ+32j8zQzaniaONK1DHdksg9hhB+nPvjwTfwrjWwxtz
         s7ZGaHUbsruRLcSK2OGrqibBzm/zKI5YxOyZDr6aMxhgmVNrtDmI0G4uuXfn+B/73iB7
         pTj4GFsTqakbc0ggTzquVaCZ378HVbdfUR3lkHywZ0namNQi9Ue8jNbhmJX2C0MmjmHS
         a1yAOVKmfoH0GW2JckYS3dzjzfbLw4NZgsesYybA7d2HTbyPgmsAiaabfRWZHXs+iJzl
         i1lQ==
X-Received: by 10.236.149.74 with SMTP id w50mr6584243yhj.129.1359566593528;
        Wed, 30 Jan 2013 09:23:13 -0800 (PST)
Received: from gnu.cpqd.com.br (fw-cpqd.cpqd.com.br. [189.112.183.66])
        by mx.google.com with ESMTPS id q11sm1689802anp.13.2013.01.30.09.23.11
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 09:23:12 -0800 (PST)
X-Mailer: git-send-email 1.7.12.464.g83379df.dirty
In-Reply-To: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
X-Gm-Message-State: ALoCoQncs2Xa0YavAN1bbE7/1tFGJJvl103H+ie8rkbgkZL/tZaIpL8ktzS2ZApHFpsXjs9Ic5KG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215039>

From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>

The Git::activestate_pipe::CLOSE routine wasn't explicitly returning
anything. This means that on Windows the routine _cmd_close wasn't
checking correctly the external command's exit code.

Now we store the command's exit code on the object created by
Git::activestate_pipe::TIEHANDLE and return a sensible value on
Git::activestate_pipe::CLOSE to _cmd_close.

Signed-off-by: Gustavo L. de M. Chaves <gnustavo@cpan.org>
---
 perl/Git.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index e14b41a..ef3134b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1404,7 +1404,7 @@ sub TIEHANDLE {
 	# Let's just hope ActiveState Perl does at least the quoting
 	# correctly.
 	my @data = qx{git @params};
-	bless { i => 0, data => \@data }, $class;
+	bless { i => 0, data => \@data, exit => $? }, $class;
 }
 
 sub READLINE {
@@ -1425,6 +1425,7 @@ sub CLOSE {
 	my $self = shift;
 	delete $self->{data};
 	delete $self->{i};
+	return $self->{exit} == 0;
 }
 
 sub EOF {
-- 
1.7.12.464.g83379df.dirty
