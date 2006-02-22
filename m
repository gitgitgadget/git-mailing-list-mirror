From: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: [PATCH] Prevent git-upload-pack segfault if object cannot be found
Date: Wed, 22 Feb 2006 10:17:58 -0800
Message-ID: <20060222181758.GH3355@andrew-vasquezs-powerbook-g4-15.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 22 19:18:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FByZ1-0008M3-3k
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 19:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWBVSSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 13:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWBVSSH
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 13:18:07 -0500
Received: from pat.qlogic.com ([198.70.193.2]:54182 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S1751386AbWBVSSG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2006 13:18:06 -0500
Received: from plap.qlogic.com ([10.1.7.214]) by avexch02.qlogic.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 22 Feb 2006 10:18:00 -0800
Received: by plap.qlogic.com (Postfix, from userid 501)
	id 163F72E9C04; Wed, 22 Feb 2006 10:17:58 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 22 Feb 2006 18:18:00.0705 (UTC) FILETIME=[505A0F10:01C637DC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16603>


Commit:

	b5b16990f8b074bd0481ced047b8f8bf66eee6dc
	Prevent git-upload-pack segfault if object cannot be found

is causing some really annoying noise being sent to stderr on some of
my older non-packed repositories:

	$ git status
	# On branch refs/heads/b4
	unable to open object pack directory: .git/objects/pack: No such file or directory
	nothing to commit

	$ git-rev-list --pretty=oneline v8.01.04b3..
	unable to open object pack directory: .git/objects/pack: No such file or directory
	a7401b7109fb2cba7de41a0e30dfe6aa41690ea8 No ZIO.
	...


Here's the relevant hunk:

> diff --git a/sha1_file.c b/sha1_file.c
> index 3d11a9b..f08b1d6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -551,8 +551,10 @@ static void prepare_packed_git_one(char 
>  	sprintf(path, "%s/pack", objdir);
>  	len = strlen(path);
>  	dir = opendir(path);
> -	if (!dir)
> +	if (!dir) {
> +		fprintf(stderr, "unable to open object pack directory: %s: %s\n", path, strerror(errno));
>  		return;
> +	}
>  	path[len++] = '/';
>  	while ((de = readdir(dir)) != NULL) {
>  		int namelen = strlen(de->d_name);


Could we drop this fprintf to stderr?

Thanks,
Andrew
