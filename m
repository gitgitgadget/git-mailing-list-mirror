From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] gitweb: allow configurations that change with each
 request
Date: Fri, 30 Jul 2010 22:01:59 -0500
Message-ID: <20100731030159.GD906@burratino>
References: <4C4D152A.7050505@gmail.com>
 <AANLkTinAO8R6mg967XeqFgMHInT4pMlxODz29Jovfki1@mail.gmail.com>
 <4C4D932A.1010101@gmail.com>
 <201007261623.05850.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julio.lajara@alum.rpi.edu,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 05:03:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of2M2-0005vo-4u
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 05:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab0GaDDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 23:03:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62832 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0GaDDL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 23:03:11 -0400
Received: by yxg6 with SMTP id 6so856922yxg.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qqnYHbjz/CwfMQEcbYemvz4VwPXAI1grbNvuYkjN23Y=;
        b=UpBiwG6Je3evGsOvA2E+DBnDEHKH3FWxsXq2f0CGWxgW7iBI68UQtyv1J69fz4Slav
         KpMauQv3E9HtNpa/GHOgh4J4CLZzSynJwSFI1MBl4EUto4C7c9U9yFzEYuTNUSHOq5ce
         kT3NnxbQEFiXFvv07btSpaAa1zzFw1aOKqdJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ar2lX36SYmUCrSlaM9tOARXxXdipZmIR1nVGJnHyikltM6Dw12P7auhQLT7M6qf1jP
         HRtUZ1/A5HLzXxMiT9EJH7nau5N/Nq0mk5vvyDRQPL40p9ec60FfGlVxBGC0n1bVApun
         hPH1ovNc/XQCZkfq242wUO6wB1d5kUWwj7dmk=
Received: by 10.150.242.24 with SMTP id p24mr4007485ybh.380.1280545390533;
        Fri, 30 Jul 2010 20:03:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 36sm1566564ybr.20.2010.07.30.20.03.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 20:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007261623.05850.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152292>

gitolite's contrib/gitweb/gitweb.conf includes:

	$ENV{GL_USER} = $cgi->remote_user || "gitweb";

which is useful for setups where a user has to be authenticated
to access certain repos.  Perhaps other typical configurations
change per session in other ways, too.

v1.7.2-rc2~6 (gitweb: Move evaluate_gitweb_config out of run_request,
2010-07-05) broke such configurations for a speedup, by loading
the configuration once per FastCGI process.

Probably in the end there should be a way to specify in the
configuration whether a particular installation wants the speedup or
the flexibility.  But for now it is easier to just undo the relevant
change.

This partially reverts commit 869d58813b24c74e84c9388041eafcef40cb51e4.

Reported-by: Julio Lajara <julio.lajara@alum.rpi.edu>
Analysis-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jakub Narebski wrote:

> I wonder if it would be possible to 
> re-enable this feature (which I think is needed to be able to use
> $cgi->remote_user) but without having all pay the [slight] performance
> penalty of including (and I think parsing) config file once per each
> request.

I dunno.  Maybe this would be a good place to start.

 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e0e9532..300c4b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1060,8 +1060,12 @@ sub run_request {
 	reset_timer();
 
 	evaluate_uri();
+	evaluate_gitweb_config();
 	check_loadavg();
 
+	# $projectroot and $projects_list might be set in gitweb config file
+	$projects_list ||= $projectroot;
+
 	evaluate_query_params();
 	evaluate_path_info();
 	evaluate_and_validate_params();
@@ -1109,12 +1113,8 @@ sub evaluate_argv {
 
 sub run {
 	evaluate_argv();
-	evaluate_gitweb_config();
 	evaluate_git_version();
 
-	# $projectroot and $projects_list might be set in gitweb config file
-	$projects_list ||= $projectroot;
-
 	$pre_listen_hook->()
 		if $pre_listen_hook;
 
-- 
1.7.2.1.544.ga752d.dirty
