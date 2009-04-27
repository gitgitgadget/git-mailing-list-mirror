From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Method ignores results of InputStream.skip()
Date: Mon, 27 Apr 2009 16:21:12 -0700
Message-ID: <20090427232112.GN23604@spearce.org>
References: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7E9@dewdfe18.wdf.sap.corp> <366BBB1215D0AB4B8A153AF047A2878002FCE7EA@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Sohn, Matthias" <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lya8W-00005O-BN
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbZD0XVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbZD0XVN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:21:13 -0400
Received: from george.spearce.org ([209.20.77.23]:39135 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbZD0XVM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 19:21:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 65CDC38215; Mon, 27 Apr 2009 23:21:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <366BBB1215D0AB4B8A153AF047A2878002FCE7EA@dewdfe18.wdf.sap.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117737>

"Sohn, Matthias" <matthias.sohn@sap.com> wrote:
> This method ignores the return value of java.io.InputStream.skip()

Doh.  In theory the skip should always succeed because the buffer
held the entire block we want to skip over due to the mark/reset
usage around this region.  But I agree, a skipFully() pattern is
better here.
 
> @@ -139,12 +140,23 @@ private String readLine(final byte[] hdrbuf)
> throws IOException {
>  		while (lf < cnt && hdrbuf[lf] != '\n')
>  			lf++;
>  		bin.reset();
> -		bin.skip(lf);
> +		skipFully(bin, lf);
>  		if (lf < cnt && hdrbuf[lf] == '\n')
> -			bin.skip(1);
> +			skipFully(bin, 1);
>  		return RawParseUtils.decode(Constants.CHARSET, hdrbuf,
> 0, lf);
>  	}
>  
> +	// skip given number of bytes on InputStream respecting return
> value of InputStream.skip()
> +	static private void skipFully(InputStream in, long nBytes)

We already have this method; see NB.skipFully().

NB also has readFully() and a few other useful functions for
dealing with common IO related patterns.

Please respin by calling NB.skipFully above rather than creating
a new package level method, and fix the line wrapping issue so we
can more easily apply it.  :-)

-- 
Shawn.
