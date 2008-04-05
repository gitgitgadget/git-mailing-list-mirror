From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix "Use of uninitialized value" error in 'history' view
Date: Sat, 5 Apr 2008 18:16:11 +0100
Message-ID: <200804051916.14568.jnareb@gmail.com>
References: <200804041623.44595.jnareb@gmail.com> <20080405164303.30566.qmail@47fa24fd520dbf.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 19:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiC0n-0003lS-Ln
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 19:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbYDERQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 13:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYDERQU
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 13:16:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:14727 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbYDERQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 13:16:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so276394nfb.21
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=4skktZG9uDDYPk8CF/SpQesUmlm4s/w1y8DxGT8dCew=;
        b=dSmTYKVMCfLDKGTsEuDO1rVgQzx1YstSwMFjOSYTWn2jSsK/0QzLn7oCd1IyZ+qURFHagv6G9WJ7YWYMUglmDO0Sq6bu4u9aYlfTSzNF+1vcKw+IeBlrYB/VCB+oKX02ZMHYLMg6cB5yRXV1Y26So03ZdTFk+hCe9CSSZEHo2bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DRAL+dqiUBZmcHAqn/1A7uz/rSo6vBgUiVRMdHeS1/tRNECOdbNyewC4kczvJH8R88p2LaUJ+Zm9ijh713x9rsNLVNcPbJnc3/aZ9+O7oRhiEAdf8IWAazw3QLl+yGjAF5K0jMEb0R+ZCrm9VGdnyrfusuDdPeuRiXG9fS5pDX0=
Received: by 10.78.175.14 with SMTP id x14mr1782304hue.80.1207415778334;
        Sat, 05 Apr 2008 10:16:18 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.198.110])
        by mx.google.com with ESMTPS id f6sm13267794nfh.21.2008.04.05.10.16.15
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Apr 2008 10:16:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080405164303.30566.qmail@47fa24fd520dbf.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78853>

On Sat, 5 Apr 2008, Gerrit Pape wrote:
> On Fri, Apr 04, 2008 at 03:23:42PM +0100, Jakub Narebski wrote:

> > When asked for history of a file with no $hash ('h') parameter set,
> > and which file is not present in current branch ("HEAD" or given by
> > $hash_hase ('hb') parameter), but is present deeper in the full
> > history of a branch, gitweb would spew multiple of "Use of
> > uninitialized value" warnings, and some links would be missing.
> > This commit fixes this bug.
> > 
> > This bug occurs in the rare cases when "git log -- <path>" is empty
> > and "git log --full-history -- <path>" is not.  Gitweb tried to get
> > file type (it means if it is 'tree' or 'blob' or even 'commit', as
> > 'history' view is for single path which can be any of given types)
> > from the commit we start searching from, and not among found commits.
> 
> Do you know whether this fixes http://bugs.debian.org/469083 too?  I
> took a short look back then to fix it, but didn't manage it in a
> reasonable amount of time.

No it does not.


I have found what causes this bug.  When adding is_deleted() subroutine
I have forgot about old/legacy URL support[1], where gitweb doesn't have
enough information to get raw diff info, and gitweb has to generate
required info itself, i.e. the part in git_blobdiff(), around

	# old/legacy style URI
	if (!%diffinfo && # if new style URI failed
	    defined $hash && defined $hash_parent) {
		# fake git-diff-tree raw output
		$diffinfo{'from_mode'} = $diffinfo{'to_mode'} = "blob";
		$diffinfo{'from_id'} = $hash_parent;
		$diffinfo{'to_id'}   = $hash;

This code does not, and cannot, fill 'status_str' ('status' is faked).
I'd send in a bit patch fixing this bug (making is_deleted() more
robust).

Footnotes:
==========
[1] Note that example URL in http://bugs.debian.org/469083 does not
    have 'hpb' ($hash_parent_base) parameter set... and that is what
    causes this bug.

P.S. Gerrit, are you maintainer of git-core debian package?
-- 
Jakub Narebski
Poland
