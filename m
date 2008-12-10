From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Wed, 10 Dec 2008 16:15:54 +0100
Message-ID: <200812101615.55340.jnareb@gmail.com>
References: <182871.96175.qm@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 16:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAQoQ-00080T-Mj
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 16:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbYLJPQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbYLJPQA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 10:16:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:59882 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbYLJPP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 10:15:59 -0500
Received: by fg-out-1718.google.com with SMTP id 19so244407fgg.17
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6ZQcHhxmn4lA7DPtKVZAIjsX5Jfd5V3KAGqNC6uWu48=;
        b=gR+kjP4QQktw/lKp88J+rBrxRWnCIDBW7e5u2rpjv5Gx/7GnvMy73P3NxxiTNXdQjv
         FVJ4IHYKtzNzbejuviH4G7+czuWUmITlfWIdmrDXuWzM7DzYXjj2Gz9D4Wj8WqE4m/51
         T6g8hVZqNP+O27jBM9azwDF3xFKQsQIDju+ZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iyMKocvKBI4u5hor+h3Yc3WfRzwLhgZaFDFxvnqNpYwcv41xTzpSOjQXfvj8t8SvCr
         QpK0cm7GWZov12ohlTvMeL5taLCS6L5Wb0+60zh9QB0k3um50Hgmo7f8EApHrXyPYwn5
         zqnvQzFuBRTs9CRPqrHJwLozLz+wRubrKBWgQ=
Received: by 10.86.72.3 with SMTP id u3mr749353fga.1.1228922157387;
        Wed, 10 Dec 2008 07:15:57 -0800 (PST)
Received: from ?192.168.1.11? (abxf60.neoplus.adsl.tpnet.pl [83.8.255.60])
        by mx.google.com with ESMTPS id 4sm2526525fge.50.2008.12.10.07.15.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 07:15:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <182871.96175.qm@web31804.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102692>

On Wed, 10 Dec 2008, Luben Tuikov wrote:
> --- On Tue, 12/9/08, Jakub Narebski <jnareb@gmail.com> wrote:

> > This patch attempts to migitate issue [of performance] a bit by
> > caching $parent_commit info in %metainfo, which makes gitweb to
> > call git-rev-parse only once per unique commit in blame output.
> 
> Have you tested this patch that it gives the same commit chain
> as before it?

The only difference between precious version and this patch is that
now, if you calculate sha-1 of $long_rev^, it is stored in 
$metainfo{$long_rev}{'parent'} and not calculated second time.

But I have checked that (at least for single example file) the blame
output is identical for before and after this patch.


> > That is what I have noticed during browsing git_blame()
> > code.
> 
> What?

What I have noticed? I have noticed this inefficiency.
Why I was browsing git_blame? To write git_blame_incremental...

See also my reply to Nanako Shiraishi with simple benchmark.

> > We can change it to even more effective implementation
> > (like the ones proposed above in the commit message) later.
> 
> Where?

jn> Unfortunately the implementation in 244a70e used one call for
jn> git-rev-parse to find parent revision per line in file, instead of
jn> using long lived "git cat-file --batch-check" (which might not existed
jn> then), or changing validate_refname to validate_revision and made it
jn> accept <rev>^, <rev>^^, <rev>^^^ etc. syntax.

One solution mentioned there is to open bidi pipe (like in Git::Repo
in gitweb caching by Lea Wiemann) to "git cat-file --batch-check"
(the '--batch-check' option was added to git-cat-file by Adam Roben
on Apr 23, 2008 in v1.5.6-rc0~8^2~9), feed it $long_rev^, and parse
its output of the form:

  926b07e694599d86cec668475071b32147c95034 commit 637

see manpage for git-cat-file(1). Unfortunately it seems like 
command_bidi_pipe doesn't work as _I_ expected...


Another solution mentioned there is to change validate_refname to
validate_revision when checking script parameters (CGI query or
path_info), with validate_revision being something like:

  sub validate_revision {
  	my $rev = shift;
	return validate_refname(strip_rev_suffixes($rev));
  }

or something like that, so we don't need to calculate $long_rev^,
but can pass "$long_rev^" as 'hb' parameter ($long_rev can in turn
also end in '^').

-- 
Jakub Narebski
Poland
