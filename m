From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Add failing test for fetching from multiple packs over
 dumb httpd
Date: Tue, 27 Jan 2015 18:29:39 +0000
Message-ID: <20150127182939.GA18236@hashpling.org>
References: <1422372041-16474-1-git-send-email-charles@hashpling.org>
 <20150127181220.GA17067@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:29:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGAtY-00015o-0q
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 19:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759260AbbA0S3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 13:29:43 -0500
Received: from avasout05.plus.net ([84.93.230.250]:33357 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbbA0S3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 13:29:42 -0500
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id l6Vf1p0022iA9hg016Vgcc; Tue, 27 Jan 2015 18:29:41 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K8ysHkmI c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=YNv0rlydsVwA:10 a=BNFp--SqAAAA:8 a=JqWvZ6SbcGFL_5ICQGQA:9
 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1YGAtP-000656-Jv; Tue, 27 Jan 2015 18:29:39 +0000
Content-Disposition: inline
In-Reply-To: <20150127181220.GA17067@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263082>

On Tue, Jan 27, 2015 at 01:12:21PM -0500, Jeff King wrote:
> On Tue, Jan 27, 2015 at 03:20:41PM +0000, Charles Bailey wrote:
> 
> > From: Charles Bailey <cbailey32@bloomberg.net>
> > 
> > When objects are spread across multiple packs, if an initial fetch does
> > require all pack files, a subsequent fetch for objects in packs not
> > retrieved in the initial fetch will fail.
> 
> s/does/does not/, I think?

Yes, that's definitely what I meant to write.

[...]
> It looks like the culprit is 7b64469 (Allow parse_pack_index on
> temporary files, 2010-04-19). It added a new "idx_path" parameter to
> parse_pack_index, which we pass as NULL.  That causes its call to
> check_packed_git_idx to fail (because it has no idea what file we are
> talking about!).

That change looks like it went into 1.7.1.1. I cannot confirm this
working before then but we've definitely seen the bug in 1.7.12.3 and
more recent versions.

> This seems to fix it:
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 30995e6..eda4d90 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1149,6 +1149,9 @@ struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
>  	const char *path = sha1_pack_name(sha1);
>  	struct packed_git *p = alloc_packed_git(strlen(path) + 1);
>  
> +	if (!idx_path)
> +		idx_path = sha1_pack_index_name(sha1);
> +
>  	strcpy(p->pack_name, path);
>  	hashcpy(p->sha1, sha1);
>  	if (check_packed_git_idx(idx_path, p)) {

It certainly fixes my test script and I can give this patch a test in
the 'real' world.
