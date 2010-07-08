From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG/RFC] Raw diff output format (git-diff-tree) and --relative[=<path>] option
Date: Thu, 8 Jul 2010 14:11:13 +0200
Message-ID: <201007081411.14843.jnareb@gmail.com>
References: <201007051015.26995.jnareb@gmail.com> <201007081300.18712.jnareb@gmail.com> <20100708114125.GA2427@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 14:11:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWpx6-0003Va-0X
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 14:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab0GHMLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 08:11:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57420 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab0GHMLc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 08:11:32 -0400
Received: by bwz1 with SMTP id 1so387275bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Uh3yVFDq53FeqqdO3wkEsMrzimXdz6ovsb29LteX8FA=;
        b=AH0NeYUZW1uwXTDqfVjNqBOB8shAHcAmasBZozK1Lj4VrLe1n456hglg12ZFdHGz+6
         NqxPJweOxxBY1MKsRHn1w2vXGGOqHGnN05NVkt150QnliExZksTq0GzamjiLyITyaQ6P
         u2v+/W/oJ9GqFo5u9rPrQtfjbJ/sIatZHuAZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uRMmPv4jVQGmiV44BMUZSsN6eGAXwg/QNdpPK/Jzk0n+AXSJ/Ls1lOS5lKDlTi1IO+
         VFWAFxSUGqr4NUD+iFuJGRg4PWeRCdnEn0gFgqmlAbV8SePbegO7WenTcg2nO2r4D1zG
         il00PPyVGziL20hUGlpbRa3g4Wb7dW1S9Kxt0=
Received: by 10.204.45.213 with SMTP id g21mr6165537bkf.11.1278591084130;
        Thu, 08 Jul 2010 05:11:24 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id x19sm32765857bkv.9.2010.07.08.05.11.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 05:11:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100708114125.GA2427@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150567>

On Thu, 8 Jul 2010, Jeff King wrote:
> On Thu, Jul 08, 2010 at 01:00:17PM +0200, Jakub Narebski wrote:
> 
> > Last there is filename munging, done using strip_prefix function.
> > This is done using prefix_length only, and that is the cause of
> > the bug:
> >   $ git diff-tree --abbrev -r --raw HEAD --relative=sub
> >   a3a8425fe5496c61921010cb1e7b455a1f52bb86
> >   :100644 100644 d90bda0... cefcae0... M	/quux
> > 
> > if one uses '--relative=sub' instead of '--relative=sub/'.
> 
> Is that a bug or a feature? You need to say "sub/" to get what you want,
> which is annoying. But it means you can also you "--relative=su" to get
> "b/quux". In that example, it's probably useless, but consider a set of
> filenames "foo-1" through "foo-5". You don't always want to break on a
> directory boundary.
> 
> I believe "git-archive --prefix" has the same behavior for the same
> reason.

It is called --relative=<path>, *not* --relative=<prefix>.  I also
think that it was meant to be the opposite of --directory=<root> of
git-am and git-apply.

"git archive --prefix" is IMVHO a bit of horse of different color.

Nevertheless in current situation it would be good to have the
following applied.
-- >8 --
diff --git i/Documentation/diff-options.txt w/Documentation/diff-options.txt
index 2371262..bc837cd 100644
--- i/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -278,7 +278,7 @@ ifndef::git-format-patch[]
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
 
---relative[=<path>]::
+--relative[=<path>/]::
 	When run from a subdirectory of the project, it can be
 	told to exclude changes outside the directory and show
 	pathnames relative to it with this option.  When you are
-- 8< --

-- 
Jakub Narebski
Poland
