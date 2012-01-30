From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5.5 1/5] gitweb: prepare git_get_projects_list for use outside 'forks'.
Date: Mon, 30 Jan 2012 16:40:34 +0100
Message-ID: <201201301640.35843.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <201201301442.06707.jnareb@gmail.com> <20120130145538.GA2162@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Mon Jan 30 16:40:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrtL1-0006T7-46
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 16:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab2A3PkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 10:40:05 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42222 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab2A3PkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 10:40:04 -0500
Received: by eekc14 with SMTP id c14so1475325eek.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 07:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=o3D3D8VPBrB2KWaAt7X92GwxtPVJSE4ugbF1YViGkGk=;
        b=ds93DmFnFrK+y1D2dD5mPFZ9coIja/3K3cmwUlEcsWSF3DOUnvrl4ApKm6Sik7S/qc
         DVYHx68HLXH//x+odtjvcanB/fsWfy9Z3oj3+INN6zoBi1XxxCTILe6/8XIMVZSqMnor
         hgEbuwTjib7U02i7OpooafAO9rqO+yj0BkJ+Q=
Received: by 10.14.33.218 with SMTP id q66mr3323096eea.67.1327938002114;
        Mon, 30 Jan 2012 07:40:02 -0800 (PST)
Received: from [192.168.1.13] (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id o49sm25279602eeb.7.2012.01.30.07.40.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 07:40:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120130145538.GA2162@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189368>

On Mon, 30 Jul 2012, Bernhard R. Link wrote:

> Use of the filter option of git_get_projects_list is currently
> limited to forks. It hard codes removal of ".git" suffixes from
> the filter and assumes the project belonging to the filter directory
> was already validated to be visible in the project list.
> 
> To make it more generic move the .git suffix removal to the callers
> and add an optional argument to denote visibility verification is
> still needed.

Even better for patch readability would be to split this patch further,
with the first part just moving removal of ".git" suffix from said
function to callers.
 
> If there is a projects list file (GITWEB_LIST) only projects from
> this list are returned anyway, so no more checks needed.
> 
> If there is no projects list file and the caller requests strict
> checking (GITWEB_STRICT_EXPORT), do not jump directly to the
> given directory but instead do a normal search and filter the
> results instead.
> 
> The only (hopefully non-existing) effect of GITWEB_STRICT_EXPORT
> without GITWEB_LIST is to make sure no project can be viewed without
> also be found starting from project root. git_get_projects_list without
> this patch does not enforce this but all callers only call it with
> a filter already checked this way. With this parameter a caller
> can request this check if the filter cannot be checked this way.

O.K. now I see where the "paranoid mode" might make difference: if
one of intermediate directories in $project_filter subdirectory has
search/access permission ('x' bit) but is not readable ('r' bit),
then gitweb would show nothing in $strict_export mode, but scan from
"$projects_list/$project_filter" in non-strict mode.

Perhaps there are other cases...
 
> @@ -2841,7 +2840,7 @@ sub git_get_projects_list {
>  		my $pfxlen = length("$dir");
>  		my $pfxdepth = ($dir =~ tr!/!!);
>  		# when filtering, search only given subdirectory
> -		if ($filter) {
> +		if ($filter and not $paranoid) {

Hmmmm... ($filter and !$paranoid) or ($filter && !$paranoid)?
Which would be more Perl-ish and fit current code style better...

-- 
Jakub Narebski
Poland
