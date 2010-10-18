From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] svn-fe: Use the cat-blob command to apply deltas
Date: Mon, 18 Oct 2010 17:48:28 +0530
Message-ID: <20101018121822.GG22376@kytes>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-6-git-send-email-david.barr@cordelta.com>
 <20101018065657.GE22376@kytes>
 <20101018092418.GB5425@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 14:20:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7ohV-0002mY-Ew
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 14:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab0JRMUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 08:20:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63713 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab0JRMUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 08:20:09 -0400
Received: by gyg13 with SMTP id 13so304912gyg.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 05:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0XGLU0UMfe/RalcrE5oT2TqU9/07AkseGdDKvz0w62E=;
        b=aWEKNbbqRsh64B+kOcTOO2t3aNXFdnjB6Mec2v4Zw48b4TiQSy6sTXTWsiZUKPKZ4S
         LAWBk2SCe3nE0zQSNF1OV7vzdvUUXqWv2pA7l8VRWbd8B/UjKZlGs+mxz+49pZdT3lpX
         fX8gTe29zhmfcWHYp+W3Ufdi9mgAOVNff8fH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FxF8W4xtywCmUzMofRgZYllOSueXvSS7y1T6OGFF2R4DLIdIuhpVWzTRGQDm/ZI4Gh
         eqmlv1GX3wHBXuYRQl9+6Oef5qShzM6SLAQYK18LFX+Wj9jhcuUy7QZtSz8nJoznV52P
         Tt/nnQCrq/1xJYS1Ot/jerlzOyu0HXPFcCdbE=
Received: by 10.100.138.15 with SMTP id l15mr2749517and.125.1287404355930;
        Mon, 18 Oct 2010 05:19:15 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 3sm8692142ano.21.2010.10.18.05.19.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 05:19:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018092418.GB5425@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159255>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > David Barr writes:
> 
> >> +	if (!backchannel.infile)
> >> +		backchannel.infile = fdopen(REPORT_FILENO, "r");
> >> +	if (!backchannel.infile)
> >> +		return error("Could not open backchannel fd: %d", REPORT_FILENO);
> >
> > REPORT_FILENO = 3 is hard-coded. Is this intended? Maybe a
> > command-line option to specify the fd?
> 
> fast-import gets the --cat-file-fd parameter to choose between stdout,
> stdin-as-socket, stderr, or another fd (not necessarily 3 because it
> might have to compete with other similar features some day).
> 
> For svn-fe, it is just like another stdin.  stdin is always fd 0,
> so...
> 
> For callers other than svn-fe, it would be especially useful to
> make it configurable, yes.

Right, got it.

> >> +	tail = buffer_read_line(&backchannel);
> >> +	if (!tail)
> >> +		return 1;
> >
> > Could you clarify when exactly will this happen?
> 
> buffer_read_line() returns NULL on error and when data is exhausted
> without the trailing newline appearing.  The input here is supposed to
> be just a single newline (trimmed to an empty string).

Thanks for the clarification.

> >> +	long preimage_len = 0;
> >> +
> >> +	if (delta) {
> >> +		if (!preimage.infile)
> >> +			preimage.infile = tmpfile();
> >
> > Didn't you later decide against this and use one tmpfile instead?
> 
> This is a single tempfile (because static).  Or am I missing
> something?

Er, sorry about that. When I saw this code, it immediately reminded me
of one of David's commits that used several temporary files- a later
one made it a global variable. I didn't notice the static here.

> >> +		if (!preimage.infile)
> >> +			die("Unable to open temp file for blob retrieval");
> >> +		if (srcMark) {
> >> +			printf("cat-blob :%"PRIu32"\n", srcMark);
> >> +			fflush(stdout);
> >> +			if (srcMode == REPO_MODE_LNK)
> >> +				fwrite("link ", 1, 5, preimage.infile);
> >
> > Special handling for symbolic links. Perhaps you should mention it in
> > a comment here?
> 
> Or better yet, a comment in the commit message. :)

*nod*

> >> +			if (fast_export_save_blob(preimage.infile))
> >> +				die("Failed to retrieve blob for delta application");
> >> +		}
> >> +		preimage_len = ftell(preimage.infile);
> >> +		fseek(preimage.infile, 0, SEEK_SET);
> >> +		if (!postimage.infile)
> >> +			postimage.infile = tmpfile();
> >
> > One tmpfile?
> 
> Do you mean letting the preimage and postimage share a file?

No :)

> [...]
> >>  	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
> >> -	buffer_copy_bytes(input, stdout, len);
> >> +	if (!delta)
> >> +		buffer_copy_bytes(input, stdout, len);
> >> +	else
> >> +		buffer_copy_bytes(&postimage, stdout, len);
> >>  	fputc('\n', stdout);
> >
> > I should have asked this a long time ago: why the extra newline?
> 
> From the fast-import manual:
> 
> 	The LF after <raw> is optional (it used to be required)
> 	but recommended. Always including it makes debugging a
> 	fast-import stream easier as the next command always
> 	starts in column 0 of the next line, even if <raw> did
> 	not end with an LF.

Thanks for the explanation. I really should have looked this up
earlier, but I suppose it's not a biggie.

-- Ram
