From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: working with a large repository and git svn
Date: Fri, 14 Jan 2011 13:35:57 +0530
Message-ID: <20110114080554.GA1735@kytes>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
 <201101120830.47016.wjl@icecavern.net>
 <20110113032300.GB9184@burratino>
 <AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Joe Corneli <holtzermann17@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 09:05:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdef3-0000u5-VU
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 09:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab1ANIFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 03:05:13 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35303 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab1ANIFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 03:05:11 -0500
Received: by iwn9 with SMTP id 9so2327862iwn.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 00:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YqNua04q5xf/Itrw4XC9v+8+CcnP45kTMziLoQeiVl8=;
        b=A82TVAx5s3Td858JYPopbxQdM2vUX+YhMARNJuId3zXuWqMo214/ryU10PgXPVBQSO
         hx4XB1vzjPhvU/f8ejXpVCvwGn4Xu68pCq7J2dayYkcFuVmdFRGK/ag7PG50+9lFvqu/
         4i/pJBqoLXIe4Bj2Q33mBS2OcIpMr1f0mdmWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R7cpb4sAacH2WRWHQHXLj4HfIDES/nVeYfAGBVHukryBHrxaawOfeBY26muI94jbGD
         QujzKPQGcIEsAjMDGYQzNVlVR4050BidzYWnSPz5yuwq/2cEY3kd5XRmhm/eq0yfikLv
         JNNXDgoNKebRovHiKsODh6zAo3Ny3HL5Vtpps=
Received: by 10.42.166.74 with SMTP id n10mr464351icy.512.1294992311045;
        Fri, 14 Jan 2011 00:05:11 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id k42sm650006ick.20.2011.01.14.00.05.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 00:05:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165077>

Hi Joe,

Joe Corneli writes:
> > I think the state of the art is currently git2svn
> 
> Thanks, that did indeed work, though, for the record it uses committer
> name and email in the log that it generates, not author name and
> email, but no worries!

That should be easy enough to fix with something like this (warning:
untested). A more elegant solution would actually use some sort of
user-configurable mapping from Git authors/ committers to SVN authors
though.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
--8<--
diff --git a/git2svn b/git2svn
index 2380775..3856696 100755
--- a/git2svn
+++ b/git2svn
@@ -261,12 +261,8 @@ COMMAND: while (!eof(IN)) {
 	    $commit{Mark} = $1;
 	    $next = next_line($IN);
 	}
-	if ($next =~ m/author +(.*)/) {
-	    $commit{Author} = $1;
-	    $next = next_line($IN);
-	}
-	unless ($next =~ m/committer +(.+) +<([^>]+)> +(\d+) +[+-](\d+)$/) {
-	    die "missing comitter: $_";
+	unless ($next =~ m/author +(.+) +<([^>]+)> +(\d+) +[+-](\d+)$/) {
+	    die "missing author: $_";
 	}
 
 	$commit{CommitterName} = $1;
@@ -275,6 +271,9 @@ COMMAND: while (!eof(IN)) {
 	$commit{CommitterTZ} = $4;
 
 	$next = next_line($IN);
+	if ($next =~ m/committer +(.*)/) {
+	    $next = next_line($IN);
+	}
 	my $log = read_data($IN, $next);
 
 	$next = next_line($IN);
