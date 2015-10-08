From: James McCoy <vega.james@gmail.com>
Subject: Re: [PATCH] filter-branch: strip pgp signature in commit messages
Date: Thu, 8 Oct 2015 07:36:15 -0400
Message-ID: <20151008113614.GM16087@freya.jamessan.com>
References: <20151008050122.GA21369@freya.jamessan.com>
 <56162634.2010800@drmicha.warpmail.net>
 <56162C96.80108@drmicha.warpmail.net>
 <56163ED6.2030403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 08 13:36:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk9Ug-0003SL-UZ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 13:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbbJHLgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 07:36:16 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36539 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643AbbJHLgN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 07:36:13 -0400
Received: by qkht68 with SMTP id t68so17536914qkh.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=N9EHVKwhBjI0w3uj+4g1eivxRzKtCVqT41E+Id7chpU=;
        b=zXjU6581I5EkDLCtheyv4YCx7SSy0jb9279PYigyDqVzJONlAyOiEzHS6WIFD6mmYG
         0Oyn4AmxcEgiPKQJ58UfX2KhIbm+VCZ9TR/XYYPSBsPvQLMoetXimzFZe36MZ1pnxNOK
         DpiTrvkCyqNkCci6q1ANlfuDSCSBmZIcX09fkGg0VNZf7hccuX2rSG0O54xjq+hu6a4o
         j6EKK0uOvfObvJBUnYjjc90gy98hOrLjACT6gnb72n19tOv7vNQSUy8hN/a2qLf+GHAs
         G2NDQ0ChKJ0YuGiHnPl/Q0s9i54UlPaBjHDJoyDTRJm+YO0cfiDUnbHwzmYs0o1jgYQP
         S15A==
X-Received: by 10.55.209.147 with SMTP id o19mr7308159qkl.61.1444304172727;
        Thu, 08 Oct 2015 04:36:12 -0700 (PDT)
Received: from freya.jamessan.com (pool-71-162-119-45.bstnma.fios.verizon.net. [71.162.119.45])
        by smtp.gmail.com with ESMTPSA id 69sm18304496qhx.28.2015.10.08.04.36.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2015 04:36:11 -0700 (PDT)
Received: from jamessan by freya.jamessan.com with local (Exim 4.86)
	(envelope-from <vega.james@gmail.com>)
	id 1Zk9Ud-0001ei-4T; Thu, 08 Oct 2015 07:36:15 -0400
Content-Disposition: inline
In-Reply-To: <56163ED6.2030403@drmicha.warpmail.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279237>

On Thu, Oct 08, 2015 at 12:00:54PM +0200, Michael J Gruber wrote:
> Michael J Gruber venit, vidit, dixit 08.10.2015 10:43:
> > Michael J Gruber venit, vidit, dixit 08.10.2015 10:15:
> >> James McCoy venit, vidit, dixit 08.10.2015 07:01:
> > ...
> >> [No, this does not alleviate my dislike for the commit signature
> >> implementation, and I have not checked the patch - the test looks good
> >> to me, though.]
> > 
> > OK, now grumpy ol' Mike actually tested the patch with all our tests
> > that filter-branch something. All is good, and the new test catches the
> > regression when run without the patch.
> > 
> > I do think that the parser still has a problem that it had before
> > already: it does not distinguish between an empty line and an all white
> > space line (or else we didn't have a problem here at all).
> > 
> > In that sense, the patch is wrong, it does not correct the parser
> > deficiency. But it alleviates it for the special case of embedded
> > signatures, which currently is the only exceptional case that I am aware
> > of. It's not guaranteed to stay like that, of course. So maybe, one
> > should amend the commit message by saying that.
> > 
> > Michael
> > 
> 
> ... or do the right thing:

Indeed.  This fixes the actual problem of not consuming the entire
header, rather than the specific instance of the problem I encountered.

> diff --git i/git-filter-branch.sh w/git-filter-branch.sh
> index 5777947..27c9c54 100755
> --- i/git-filter-branch.sh
> +++ w/git-filter-branch.sh
> @@ -377,7 +377,7 @@ while read commit parents; do
>  	fi
> 
>  	{
> -		while read -r header_line && test -n "$header_line"
> +		while IFS='' read -r header_line && test -n "$header_line"
>  		do
>  			# skip header lines...
>  			:;
> 
> 
> Not tested for POSIX etc., maybe we need a bare IFS inside a {} block
> instead. In any case, we need to tell read not to split by words.

As far as I can tell, this should be fine in terms of POSIX.

Cheers,
-- 
James
GPG Key: 4096R/331BA3DB 2011-12-05 James McCoy <vega.james@gmail.com>
