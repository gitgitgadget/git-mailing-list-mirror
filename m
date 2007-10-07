From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sat, 6 Oct 2007 20:13:31 -0500
Message-ID: <20071007011331.GC5642@mediacenter.austin.rr.com>
References: <11917040461528-git-send-email-shawn.bohrer@gmail.com> <20071006215253.GX31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Oct 07 06:55:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeKhT-0000c7-IW
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 03:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbXJGBM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 21:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbXJGBM3
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 21:12:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:47768 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbXJGBM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 21:12:28 -0400
Received: by wx-out-0506.google.com with SMTP id h31so893166wxd
        for <git@vger.kernel.org>; Sat, 06 Oct 2007 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=QHMmfcebatp/OfmwXVeKFQzAIVhROiJXn3+tDv+y1GA=;
        b=JTiCHOgV7P/JgCD4UryTxlHSWUKBLHh6m6Wr1LUyeE8B8/R26+Btnfm4fH7ZwsoP3vIH2cbHA3qdnXnaZ8xgUaSqs5GxIASWOR9Slb6rsqh81jvBDucnFc3Gx8q0TAQIcXgvIVvHPvvvTz0kjD+c41g/n4Md5VjqdDn0ewfV1kY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Vs8VHRSrAgZL3BfOUd3sPu87Bv08t0bBD5reo4WxwKq/YF2R2zEXlVTaSiyzhAtBNq9WBcbSzhxRifpS1h02Eoki7Mh7CDkLgBNMydvyWX7APR00wZLRDljx4M6i9/I9Pif/ywA4brvJxtSwDWPvSI2k6zIT6fx0yguGSsZVrFU=
Received: by 10.70.6.8 with SMTP id 8mr3835915wxf.1191719547731;
        Sat, 06 Oct 2007 18:12:27 -0700 (PDT)
Received: from mediacenter.austin.rr.com ( [70.112.123.114])
        by mx.google.com with ESMTPS id 26sm5700797wra.2007.10.06.18.12.25
        (version=SSLv3 cipher=OTHER);
        Sat, 06 Oct 2007 18:12:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071006215253.GX31659@planck.djpig.de>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60168>

On Sat, Oct 06, 2007 at 11:52:53PM +0200, Frank Lichtenheld wrote:
> On Sat, Oct 06, 2007 at 03:54:06PM -0500, Shawn Bohrer wrote:
> > +static int remove_directory(const char *path)
> > +{
> > +	DIR *d;
> > +	struct dirent *dir;
> > +	d = opendir(path);
> > +	if (d) {
> > +		chdir(path);
> > +		while ((dir = readdir(d)) != NULL) {
> > +			if(strcmp( dir->d_name, ".") == 0 ||
> > +			   strcmp( dir->d_name, ".." ) == 0 )
> > +				continue;
> > +			if (dir->d_type == DT_DIR)
> > +				remove_directory(dir->d_name);
> > +			else
> > +				unlink(dir->d_name);
> > +		}
> > +	}
> > +	closedir(d);
> > +	chdir("..");
> > +	return rmdir(path);
> > +}
> 
> The unconditional chdir(..) after the conditional chdir(path) seems like
> asking for trouble to me...

Agreed, I'm not sure what I was thinking there.

> > +	while (fgets(path, sizeof(path), cmd_fout) != NULL) {
> > +		struct stat st;
> > +		char *p;
> > +		p = strrchr(path, '\n');
> > +		if ( p != NULL )
> > +			*p = '\0';
> 
> What happens in case p == NULL? It simply tries to remove the partial
> path?

If p == NULL then the path didn't have a EOL character.  This shouldn't
ever really happen since fgets() leaves the EOL character as part of the
string, and it is processing the output of git-ls-files which will
provide one path per line.  If it does happen for some reason then
either we will happily remove the file/directory, or if the path is
garbage then we will simply fail to remove anything.

> > +	fclose(cmd_fout);
> > +	finish_command(&cmd);
> > +	if (!ignored && !access(git_path("info/exclude"), F_OK))
> > +		free(buf);
> 
> There is a race condition here of the value of access() changes between
> the two calls. Not one likely to trigger but it should be easy to avoid
> alltogether.

Yes, though unlikely I agree this wasn't very smart in the first place
so I fixed it and will send reworked patch soon.

--
Shawn
