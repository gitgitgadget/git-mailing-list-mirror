From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 13/10] vcs-svn: use mark from previous import for parent
 commit
Date: Sun, 12 Dec 2010 11:06:29 -0600
Message-ID: <20101212170629.GA18847@burratino>
References: <20101210102007.GA26298@burratino>
 <11EEDD77-214C-44DB-AC7B-C1A086E35E4C@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 18:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRpNn-0003JI-QH
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 18:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825Ab0LLRGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 12:06:42 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55962 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab0LLRGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 12:06:40 -0500
Received: by gyb11 with SMTP id 11so2624530gyb.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rrYeGIq56pMtoqK2zfPwsuL6mepVr4qzIlU1Li7/aMU=;
        b=v7UhpaCP91uTG3rCg0Rn36aAWvPlrB6LIkEPQXqFMyqBEcq+AdUA3T/G8fSvo/2c9M
         60iXshhkQ52ORVUVyerJd1FmsopQaq0D3s2s9Xxw43ZkKZ0DDKTLR50N5Jlrjdrusebw
         hYtHecIV++DK6/fEaErm+lxwKQkVCwQYYEQmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WQJoxkZqtHjcC9wY2YXhjAQcyc94YtJsikczzDAfGb4Pk8aqMi0LX7CAF7ZPkafvfx
         1xgxEX/Xq+RDii9bXKFVY+mSyAAxbo6qP55vihX3OANjp7rS+xFbdneWuTuNi3CZcrUV
         hW1tXFoNKg1S+NTKbRubdDqYReXJ9OfuvQgLI=
Received: by 10.90.18.40 with SMTP id 40mr3892273agr.7.1292173600326;
        Sun, 12 Dec 2010 09:06:40 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id c7sm6201097ana.37.2010.12.12.09.06.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 09:06:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <11EEDD77-214C-44DB-AC7B-C1A086E35E4C@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163485>

David Michael Barr wrote:

> Subject: [PATCH] vcs-svn: use mark from previous import for parent commit
[...]
> +++ b/vcs-svn/fast_export.c
> @@ -77,7 +77,7 @@ void fast_export_begin_commit(uint32_t revision, uint32_t
>                    log, gitsvnline);
>         if (!first_commit_done) {
>                 if (revision > 1)
> -                       printf("from refs/heads/master^0\n");
> +                       printf("from :%"PRIu32"\n", revision - 1);

This deals more sanely with attempts to continue an import starting at
the wrong revision.

Example: if I try

	import () {
		rm -f backflow
		mkfifo backflow

		svn-fe 3<backflow |
		git fast-import --cat-blob-fd=3 \
			--relative-marks \
			${1+--import-marks=svnrevs} \
			--export-marks=svnrevs \
			3>backflow
	}

	svnrdump -r0:100 $url | import
	svnrdump -r100:200 $url | import continue

then svn-fe should correctly re-import r100 the second time, instead
of trying to apply the same deltas twice.  If I try

	svnrdump -r0:100 $url | import
	svnrdump -r102:200 $url | import continue

then the second command should error out.

Thanks, queued.
