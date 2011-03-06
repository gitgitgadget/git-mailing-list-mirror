From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/10] vcs-svn: save marks for imported commits
Date: Sun, 6 Mar 2011 05:15:24 -0600
Message-ID: <20110306111524.GA12761@elie>
References: <20101210102007.GA26298@burratino>
 <20101210102216.GB26331@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 12:15:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwBwD-0007jA-0Q
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 12:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab1CFLPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 06:15:34 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58018 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab1CFLPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 06:15:33 -0500
Received: by iwn34 with SMTP id 34so3160949iwn.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 03:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=cHcgvidnFkvONSxHd3EQYgbrN+FICsoEiiiA3Bcco5Y=;
        b=WKuCRXUinMnjsHmty3DaCsyaYe5Mh1VlVB/W6fhfJnbBADm6X+bQKFMDL3UHFIIwpw
         ftwta4fZupx9K0foRdgxMQTxcROkpe+5Qxqj7wxxZcPh0OA3YQLinFDlrKENn9vJQmbR
         JbSU3Bdkt+X/9RK9G9lS0rrXiVclVtUppaqn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=X2ha4SYO5F7h1hGvGdpQ/OLZZabZdlhPwAaeEnLS3JJMPeq12kz5YVUbZsaDng4eVv
         ap5N+wnk5oma6dAVjx3VxEveFZuCVj2PGZM+KC/8ewF/zJdnVJO8vE2cLdGjGvm8IvyT
         5tXqnfo/BGBmIzotwze7rBaiOoKXvMZpMc4g0=
Received: by 10.42.175.200 with SMTP id bb8mr3458504icb.37.1299410132443;
        Sun, 06 Mar 2011 03:15:32 -0800 (PST)
Received: from elie (adsl-69-209-74-158.dsl.chcgil.ameritech.net [69.209.74.158])
        by mx.google.com with ESMTPS id ye16sm1443282icb.9.2011.03.06.03.15.28
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 03:15:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102216.GB26331@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168514>

(pruned cc because reviving an old thread)
Hi,

Jonathan Nieder wrote:

> [Subject: vcs-svn: save marks for imported commits]
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

That's a lousy commit message.  A version committed later (that
eventually found its way to David's repository) explains:

	This way, a person can use

		svnadmin dump $path |
		svn-fe |
		git fast-import --relative-marks --export-marks=svn-revs

	to get a list of what commit corresponds to each svn revision (plus
	some irrelevant blob names) in .git/info/fast-import/svn-revs.

In other words, this is the first half of a two-way mapping between
svn and git commit names.

It should be possible to build a mapping the other way like so:

	awk '
	BEGIN {
		print "commit refs/notes/svn-id";
		printf "committer ";
		system("git var GIT_COMMITTER_IDENT");
		print "data <<EOT";
		print "Automatically generated commits-to-revs mapping.";
		print "EOT";
	}
	{
		num = 0 + substr($1, 2);
		commitname = $2;
		if (num < 1024 * 1024 * 1024) {
			print "N inline " commitname
			print "data <<EOT";
			print "r" num;
			print "EOT";
		}
	}
	' .git/info/fast-import/svn-revs |
	git fast-import
