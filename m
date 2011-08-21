From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: don't convert utf16 files.
Date: Sun, 21 Aug 2011 11:21:56 -0400
Message-ID: <20110821152156.GA30299@arf.padd.com>
References: <CANeU7QmGJTr4V-tWzuPnP2P=9eQbGDgQxv2phAVbGXjU5tqYPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eberhard Beilharz <eb1@sil.org>,
	Jordan Zimmerman <jzimmerman@netflix.com>,
	Mike Crowe <mac@mcrowe.com>
To: Chris Li <christ.li@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 17:22:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv9qk-0007Ce-C1
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 17:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab1HUPWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 11:22:03 -0400
Received: from honk.padd.com ([74.3.171.149]:36258 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430Ab1HUPWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 11:22:00 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 55B6C4C1A;
	Sun, 21 Aug 2011 08:21:59 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9F93A31448; Sun, 21 Aug 2011 11:21:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmGJTr4V-tWzuPnP2P=9eQbGDgQxv2phAVbGXjU5tqYPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179804>

christ.li@gmail.com wrote on Fri, 19 Aug 2011 15:50 -0700:
> Some repository has some utf16 files git-p4 don't know
> how to convert. For those files, git-p4 just write the utf8
> files. That is wrong, because git get different file than
> perforce does, causing some windows resource file fail
> to compile.
> 
> Using the "p4 print -o tmpfile depotfile" can avoid this
> convertion (and possible failure) all together.

This isn't contrib/fast-import/git-p4.  Searching around, I
discovered a 2009 fork of git-p4 that is fairly active.  CC-ing
some of the names I found on github.

Here's one such repo:

    http://github.com/ermshiperete/git-p4

Git's git-p4 doesn't try to do anything special with utf-16.  It
does \r\n mangling, but not $Keyword$ removal, then just streams
it to disk however p4 sends it.  That's close to what you're
trying to do here.

		-- Pete

> Signed-off-by: Chris Li <git@chrisli.org>
> 
> ---
>  git-p4 |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/git-p4 b/git-p4
> index 672b0c2..0c6a5cc 100755
> --- a/git-p4
> +++ b/git-p4
> @@ -755,12 +755,11 @@ class P4FileReader:
>                      break
> 
>              if header['type'].startswith('utf16'):
> -                try:
> -                    text = textBuffer.getvalue().encode('utf_16')
> -                except UnicodeDecodeError:
> -                    # File checked in to Perforce has an error. Try
> without encoding
> -                    print "Corrupt UTF-16 file in Perforce: %s" %
> header['depotFile']
> -                    text = textBuffer.getvalue()
> +                # Don't even try to convert utf16. Ask p4 to write
> the file directly.
> +                tmpFile = tempfile.NamedTemporaryFile()
> +                P4Helper().p4_system("print -o %s %s"%(tmpFile.name,
> header['depotFile']))
> +                text = open(tmpFile.name).read()
> +      	        tmpFile.close()
>              else:
>                  text = textBuffer.getvalue()
>              textBuffer.close()
> -- 
> 1.7.6
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
