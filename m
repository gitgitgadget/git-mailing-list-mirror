From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sat, 6 Oct 2007 23:52:53 +0200
Message-ID: <20071006215253.GX31659@planck.djpig.de>
References: <11917040461528-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 23:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeHbF-00068R-4I
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 23:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbXJFVxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 17:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbXJFVxG
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 17:53:06 -0400
Received: from planck.djpig.de ([85.10.192.180]:1286 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbXJFVxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 17:53:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 312BD88231;
	Sat,  6 Oct 2007 23:53:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIqIT7TKO8ae; Sat,  6 Oct 2007 23:52:53 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 925A088232; Sat,  6 Oct 2007 23:52:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11917040461528-git-send-email-shawn.bohrer@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60159>

On Sat, Oct 06, 2007 at 03:54:06PM -0500, Shawn Bohrer wrote:
> +static int remove_directory(const char *path)
> +{
> +	DIR *d;
> +	struct dirent *dir;
> +	d = opendir(path);
> +	if (d) {
> +		chdir(path);
> +		while ((dir = readdir(d)) != NULL) {
> +			if(strcmp( dir->d_name, ".") == 0 ||
> +			   strcmp( dir->d_name, ".." ) == 0 )
> +				continue;
> +			if (dir->d_type == DT_DIR)
> +				remove_directory(dir->d_name);
> +			else
> +				unlink(dir->d_name);
> +		}
> +	}
> +	closedir(d);
> +	chdir("..");
> +	return rmdir(path);
> +}

The unconditional chdir(..) after the conditional chdir(path) seems like
asking for trouble to me...

> +	while (fgets(path, sizeof(path), cmd_fout) != NULL) {
> +		struct stat st;
> +		char *p;
> +		p = strrchr(path, '\n');
> +		if ( p != NULL )
> +			*p = '\0';

What happens in case p == NULL? It simply tries to remove the partial
path?

> +	fclose(cmd_fout);
> +	finish_command(&cmd);
> +	if (!ignored && !access(git_path("info/exclude"), F_OK))
> +		free(buf);

There is a race condition here of the value of access() changes between
the two calls. Not one likely to trigger but it should be easy to avoid
alltogether.

> +	free(argv_ls_files);
> +	return 0;
> +}

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
