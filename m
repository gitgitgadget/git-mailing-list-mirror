From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH updated] Fallback on _NSGetExecutablePath to get the
 executable path if using argv[0] fails
Date: Mon, 29 Nov 2010 12:49:29 -0600
Message-ID: <20101129184929.GA9441@burratino>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
 <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
 <20101129171211.GL8037@burratino>
 <DD9829B7-8851-41CF-BCC6-2676B6015028@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@apple.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 19:49:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN8nJ-0006N3-IL
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 19:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab0K2Stl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 13:49:41 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:48923 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0K2Stk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 13:49:40 -0500
Received: by vws15 with SMTP id 15so408496vws.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 10:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M2/J3wnpCNa+Xtcw9qDZtRXvotb4C61javmQAbU/AAE=;
        b=IoiqKRajGkG4xuTZr1z34viQ05OfDtPKVQLhuAVfAdgUlfE1hdgPjRssRaWReXLYOj
         S1y1y/vNy1yVAzpFaRNlruCPbLZgHpLJv7rv4mB4Us6zEFEVNghewXjDnhQ5lpyD96jT
         6QeG9/4ggVoeivpXtO0oFke7JYTLbJydex0q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pTu2SLy7+AvR1y0vdDlEreVGx+dUSK1sC2bMZ00bxCmXW6bvt510E3fiPJBwAhhrCs
         ZWetsSCmmgfsDALiNqdCZmj/gwE4cy9NJcSdP2ZGlO6Eaet+isH90UhF04gaWROqXf1Z
         Qn76W5rljOHGiLVjqy5OVbERyGGmX116TpCfs=
Received: by 10.220.200.140 with SMTP id ew12mr1676148vcb.81.1291056579515;
        Mon, 29 Nov 2010 10:49:39 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id w30sm727372vcr.40.2010.11.29.10.49.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 10:49:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <DD9829B7-8851-41CF-BCC6-2676B6015028@apple.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162413>

Jeremy Huddleston wrote:

> This adds better support for RUNTIME_PREFIX on Mac OS X.  The previous codepath
> would only work if argv[0] contained the full path to the executable or $PATH
> already contained /path/to/libexec/git-core.  We use _NSGetExecutablePath here
> to find the full path (and thus prepend the correct libexec/git-core to $PATH)
> in the case where argv[0] does not contain the full path to the executable.

Closer.  But that is perhaps too much at the level of code rather than
the user:

	Subject: MacOSX: Use _NSGetExecutablePath to get full argv[0] path

	When RUNTIME_PREFIX support is enabled (which is common on Mac OS X)
	the exec-path is derived from the program invocation path.
	Unfortunately, usual Unix semantics are for argv[0] to contain
	the path used to invoke a program rather than the path to the
	executable.  So usual invocations of git would not result in
	helpers from exec-path being found correctly:

		$ git fast-import
		... example output here ...

	So in the spirit of v1.6.0-rc1~21 (Windows: make sure argv[0]
	has a path, 2008-07-21), use _NSGetExecutablePath to find the full
	path to the git binary, avoiding such trouble.

> --- a/exec_cmd.c
> +++ b/exec_cmd.c
[...]
> @@ -53,6 +57,19 @@ const char *git_extract_argv0_path(const char *argv0)
>  	if (slash >= argv0) {
>  		argv0_path = xstrndup(argv0, slash - argv0);
>  		return slash + 1;
> +#if defined(__APPLE__)
> +	} else {
> +		char new_argv0[PATH_MAX];
> +		uint32_t new_argv0_s = PATH_MAX;
> +		if(_NSGetExecutablePath(new_argv0, &new_argv0_s) == 0) {
> +			slash = new_argv0 + strlen(new_argv0);
> +			while (new_argv0 <= slash && !is_dir_sep(*slash))
> +		                slash--;
> +
> +			if (slash >= new_argv0)
> +				argv0_path = xstrndup(new_argv0, slash - new_argv0);
> +		}
> +#endif

Can't this ifdef be avoided?  The ideal is for such code to be
abstracted away into helper functions in git-compat-util.h and compat/*.c.

Jonathan
