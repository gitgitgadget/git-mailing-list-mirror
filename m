From: Luke Lu <git@vicaya.com>
Subject: [PATCH] gitweb: Speed up get_projects_list for large source trees
Date: Tue, 16 Oct 2007 02:04:14 -0700
Message-ID: <3A2DCEC6-953A-41B0-AB9E-7374EEB625E8@vicaya.com>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz> <vpqlka3sdka.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 11:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhiMJ-0002TK-ND
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbXJPJEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755020AbXJPJEv
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:04:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:51931 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbXJPJEt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:04:49 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1161438nze
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:in-reply-to:references:content-type:message-id:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=WouA3ou4361kSMPo7JR0OwMtC5+fYBqt6Lis3FrwIwk=;
        b=teOgY6WUonX/q4lnVponCedeZR9ZpNi/8/5Mur4haV22KuqaPaLdPmzqdD0jW0ZBNOfRac6Zsg690ILzZk9G2MrMICuWLUAsrRvWuryOxXzbhZz7dNh4Sg+LUUExJ6L2dM1T2vOmNnn/4i26s6mNBdk2n2bzXSyha3Asf3Jda8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:in-reply-to:references:content-type:message-id:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=e59HpDrOG0jFi2phLTWxNF4+Q+7HqItw5FyA4NWyBYNShhUhHKf+5ePOjFZX6KTAF1QVqeq61tbpu90Y7wTR4WF4CS3+4WxMe3vLmJwrYDWuAK3AU3GaTJA7n/Ke6gSW7feFGzHuv0uqRCr5qWgJqmqMlwWbQZDl1IPvXyLOA/E=
Received: by 10.115.15.1 with SMTP id s1mr8195396wai.1192525487825;
        Tue, 16 Oct 2007 02:04:47 -0700 (PDT)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id m27sm10225976wag.2007.10.16.02.04.44
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2007 02:04:45 -0700 (PDT)
In-Reply-To: <vpqlka3sdka.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61124>

Hi, I've been using git for a month now and loving it. This is my  
first ever patch for git using git. I spent sometime to find out why  
the project listing is taking 200s, everytime! I guess that gitweb is  
mostly used to serve bare repositories, which would never encounter  
such problems. It takes .2s, after the patch on my laptop. That's  
1000x improvement for me (on Mac OS X 1.4.10.)

__Luke

Signed-off-by: Luke Lu <git@vicaya.com>
---
gitweb/gitweb.perl |    4 ++++
1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3064298..a30eef9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1509,16 +1509,20 @@ sub git_get_projects_list {
		# remove the trailing "/"
		$dir =~ s!/+$!!;
		my $pfxlen = length("$dir");
+		my $pfxdepth = ($dir =~ tr!/!!);
		File::Find::find({
			follow_fast => 1, # follow symbolic links
			follow_skip => 2, # ignore duplicates
+			no_chdir => 1, # don't chdir into every directory
			dangling_symlinks => 0, # ignore dangling symlinks, silently
			wanted => sub {
				# skip project-list toplevel, if we get it.
				return if (m!^[/.]$!);
				# only directories can be git repositories
				return unless (-d $_);
+				# don't traverse too deep (Find is super slow on os x)
+				return if tr!/!! - $pfxdepth > 2 && ($File::Find::prune = 1);
				my $subdir = substr($File::Find::name, $pfxlen + 1);
				# we check related file in $projectroot
--
1.5.3.4
