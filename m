From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 3/2] Refactor Git::config_*
Date: Mon, 17 Oct 2011 23:47:41 +0200
Message-ID: <201110172347.42568.jnareb@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr> <201110072317.17436.jnareb@gmail.com> <7vsjmrl4ur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 23:47:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFv2J-0001Zv-Dc
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 23:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab1JQVrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 17:47:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50955 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab1JQVru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 17:47:50 -0400
Received: by bkbzt19 with SMTP id zt19so4163962bkb.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=4pDd3vCNFkvusxpGPwQ9zM3U6NHaDSbx35BJX6HfUBQ=;
        b=lyDhnxeh1qSB/kZU6EmJu6Vv7KOHUuTmErtzQakt4Y4/f4d5Mh4td7L90YWT33CP65
         4F2Qk5H1148GyiblG4E3hX3Gb2KNasZyuEfHH9lPt+P0n+KyR7oGQSdj4YEkmmDy5kjr
         gqfxmQerOn3+Pk85cpWs0NCxn3ThLE+rb3DiU=
Received: by 10.223.7.14 with SMTP id b14mr27733861fab.10.1318888068695;
        Mon, 17 Oct 2011 14:47:48 -0700 (PDT)
Received: from [192.168.1.13] (absh126.neoplus.adsl.tpnet.pl. [83.8.127.126])
        by mx.google.com with ESMTPS id v19sm7784635faa.13.2011.10.17.14.47.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 14:47:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjmrl4ur.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183827>

On Mon, 17 Oct 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > This is version which has fixed style to be more Perl-ish, and which
> > actually works (i.e. t9700 passes).
> >
> > I have also moved _config_common() after commands that use it, just like
> > it is done with other "private" methods (methods with names starting with
> > '_'), and excluded this private detail of implementation from docs.
> 
> It seems that this breaks many tests in t9xxx series for me, especially
> the 9100 series that cover git-svn.

Sorry about that, I have ran only t9700-perl-git.sh, which runs all right.

The problem was with duplicated _maybe_self(@_), which should be run only
once.  t9700-perl-git.sh passed because it uses only (recommended) object
form, and not procedural form like git-svn.

The following amend fixes the issue for me:

-- >8 --
diff --git i/perl/Git.pm w/perl/Git.pm
index 8e52290..32f6533 100644
--- i/perl/Git.pm
+++ w/perl/Git.pm
@@ -653,7 +653,7 @@ sub config_int {
 # Common subroutine to implement bulk of what the config* family of methods
 # do. This wraps command('config') so it is not so fast.
 sub _config_common {
-	my ($self, $var, $opts) = _maybe_self(@_);
+	my ($self, $var, $opts) = @_;
 
 	try {
 		my @cmd = ('config', $opts->{'kind'} ? $opts->{'kind'} : ());
-- 8< --

I'll resend amended commit.
-- 
Jakub Narebski
Poland
