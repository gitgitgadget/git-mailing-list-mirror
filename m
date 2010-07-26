From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Possible bug with `export-subst' attribute
Date: Mon, 26 Jul 2010 14:04:48 -0500
Message-ID: <20100726190448.GA32367@burratino>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino>
 <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 21:06:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdT07-0004ny-On
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 21:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab0GZTGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 15:06:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33515 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab0GZTGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 15:06:06 -0400
Received: by wwj40 with SMTP id 40so514704wwj.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LJSr5aeh6W0865qAXm9cyq+olxsN5eITZ0CltfrYY7g=;
        b=FqFaBwmuWNje1bIkBQcmS7Iqw0mFl8UF3g7gEIAfJG2E+1fDYLGDDW88IWkn5h535w
         Jec+kWUnde2rhvMIP4u03BPrKmAWJd8VBkTnocOHat7xkhKhaZFBj7Fxam3CNBQw18RR
         zdKtzT486N3A7ndpYJQFEbR7bO6utG8iRn0Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hXDQGYKGREhz1l/ohzB7DnHzVSxvFlbWBNBQxjeg/ViZxUmFU+uc0rFf9sIcq/f8AA
         7kzvHD8MHyYeWo8ywjLKnBFvcPTW871rRdPjqIMxqY7wC2EpUruqc09hRmqvUx/iTV/A
         BUTE291PAA3cEjXajRklC3QKouJ7gmUjfVeqw=
Received: by 10.227.136.146 with SMTP id r18mr7772014wbt.53.1280171159465;
        Mon, 26 Jul 2010 12:05:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p52sm2162915weq.20.2010.07.26.12.05.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 12:05:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151884>

Junio C Hamano wrote:

> The ones to archive and checkout I understand, but what effect does the
> one to commit.c::print_summary() have?

Currently commit.c::print_summary() does this:

	struct strbuf format = STRBUF_INIT;
	...

	strbuf_addstr(&format, "format:%h] %s");
	[+ other bits for the commit notice]

	rev.abbrev = 0;
	rev.diff = 1;
	...
	get_commit_format(format.buf, &rev)
	...

	printf("[%s%s ",
			[branch name " (root-commit)"]);

	if (!log_tree_commit(&rev, commit)) {
		...

In other words, it imbues rev with a format including %h and uses that
to print a commit summary.

That code is as old as builtin commit (v1.5.4-rc0~78^2~30,
2007-11-08) and was meant to imitate a diff-tree invocation (which
is plumbing).

-- %< --
Subject: examples/commit: use --abbrev for commit summary

After v1.7.1.1~17^2~3 (pretty: Respect --abbrev option, 2010-05-03),
plumbing users do not abbreviate %h hashes by default any more.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 If this seems to be a problem elsewhere, we will have to decouple
 the remembered --abbrev setting for %h from that for --raw output.

diff --git i/contrib/examples/git-commit.sh w/contrib/examples/git-commit.sh
index 5c72f65..23ffb02 100755
--- i/contrib/examples/git-commit.sh
+++ w/contrib/examples/git-commit.sh
@@ -631,7 +631,7 @@ then
 	if test -z "$quiet"
 	then
 		commit=`git diff-tree --always --shortstat --pretty="format:%h: %s"\
-		       --summary --root HEAD --`
+		       --abbrev --summary --root HEAD --`
 		echo "Created${initial_commit:+ initial} commit $commit"
 	fi
 fi
-- 
